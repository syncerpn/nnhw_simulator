classdef Network < handle
    properties
        architecture
        input_input_channels
        all_input_channels
        weights
        scales
        biases
        n_layer
        STAT
        output_buffer
        bit_shift
        output_fbit
        OUTPUT
        dlp
        last_output
        mode
        u
    end
    methods
        function obj = Network(architecture, input_input_channels, model_prefix, rescale_first_layer, OPTION_AUTO_FORMAT_SCALES, OPTION_AUTO_FORMAT_BIASES)
            obj.architecture = architecture;
            obj.n_layer = numel(obj.architecture);
            obj.input_input_channels = input_input_channels;
            obj.all_input_channels = hwu_parse_input_channels(obj.architecture, input_input_channels);
            [obj.STAT, obj.output_buffer] = hwu_parse_and_create_buffer(obj.architecture);
            
            obj.weights = cell(obj.n_layer, 1);
            obj.scales = cell(obj.n_layer, 1);
            obj.biases = cell(obj.n_layer, 1);
            
            obj.mode = 'quantize';
            
            for i = 1:obj.n_layer
                switch obj.architecture{i}{1}
                    case 'conv'
                        [batchnorm, convol_settings, output_channels, ~, weights_settings] = obj.architecture{i}{2:6};
                        [kernel_size, ~, ~] = convol_settings{:};
                        wts_scheme = weights_settings{1};

                        input_channels = obj.all_input_channels(i);
                        param_file = [model_prefix num2str(i-1)];

                        [weightx, bias, scale, rolling_mean, rolling_var] = read_conv_param_module(param_file, kernel_size, input_channels, output_channels, batchnorm);
                        if strcmp(wts_scheme, 'none')
                            weight = weightx;
                            w_bonus_scale_factor = ones(output_channels,1);
                            obj.mode = 'float';
                        elseif strcmp(wts_scheme, 'uniform')
                            [wts_nbit, wts_fbit, ~] = weights_settings{2:end};
                            wts_step = 2^-wts_fbit;
                            [weight, ~] = uniform_quantize(weightx, wts_step, wts_nbit);
                            w_bonus_scale_factor = ones(output_channels,1);
                        elseif strcmp(wts_scheme, 'mean_shifter')
                            wts_nlevel = 2^weights_settings{2};
                            [weight, w_bonus_scale_factor] = mean_shifter_quantize(weightx, output_channels, wts_nlevel/2);
                        elseif strcmp(wts_scheme, 'scale_linear')
                            wts_nlevel = 2^weights_settings{2};
                            [weight, w_bonus_scale_factor] = scale_linear_quantize(weightx, output_channels, wts_nlevel/2);
                        elseif strcmp(wts_scheme, 'mean_shifter_float')
                            wts_nlevel = 2^weights_settings{2};
                            [weight, w_bonus_scale_factor] = mean_shifter_quantize_float(weightx, output_channels, wts_nlevel/2);
                            obj.mode = 'float';
                        elseif strcmp(wts_scheme, 'scale_linear_float')
                            wts_nlevel = 2^weights_settings{2};
                            [weight, w_bonus_scale_factor] = scale_linear_quantize_float(weightx, output_channels, wts_nlevel/2);
                            obj.mode = 'float';
                        end

                        obj.weights{i} = permute(reshape(weight, kernel_size, kernel_size, input_channels, output_channels), [2, 1, 3, 4]);
                        if (batchnorm)
                            scales_new = w_bonus_scale_factor .* scale ./ sqrt(rolling_var + 0.00001);
                            if (rescale_first_layer) && (i==1)
                                scales_new = scales_new / 255.;
                            end
                            biases_new = bias - scale .* rolling_mean ./ sqrt(rolling_var + 0.00001);
                        else
                            scales_new = w_bonus_scale_factor .* ones(output_channels, 1);
                            if (rescale_first_layer) && (i==1)
                                scales_new = scales_new / 255.;
                            end
                            biases_new = bias;
                        end

                        [scales_settings, biases_settings] = architecture{i}{7:8};
                        scales_nbit = scales_settings{1};
                        biases_nbit = biases_settings{1};

                        if scales_nbit > 0
                            if OPTION_AUTO_FORMAT_SCALES
                                [fbit, sign] = hwu_auto_format(scales_new, scales_nbit);
                                obj.architecture{i}{7} = {scales_nbit scales_nbit-fbit sign};
                            end
                        end
                        if biases_nbit > 0
                            if OPTION_AUTO_FORMAT_BIASES
                                [fbit, sign] = hwu_auto_format(biases_new, biases_nbit);
                                obj.architecture{i}{8} = {biases_nbit biases_nbit-fbit sign};
                            end
                        end

                        [scales_settings, biases_settings] = architecture{i}{7:8};
                        [scales_ibit, scales_sign] = scales_settings{2:3};
                        [biases_ibit, biases_sign] = biases_settings{2:3};

                        if scales_nbit > 0
                            obj.scales{i} = quantize_and_constrain2(scales_new, scales_nbit, scales_ibit, scales_sign, 0, 0);
                        else
                            obj.scales{i} = scales_new;
                        end
                        if biases_nbit > 0
                            obj.biases{i} = quantize_and_constrain2(biases_new, biases_nbit, biases_ibit, biases_sign, 0, 0);
                        else
                            obj.biases{i} = biases_new;
                        end
                    %===============================================================================
                    case 'upsample'
                    case 'res'
                    case 'route'
                    case 'sr_flat'
                    case 'lp_sres'
                    otherwise
                        fprintf('[FAILED] unknown layer type\n');
                        break;
                end
            end
            
            [obj.bit_shift, obj.output_fbit] = hwu_calculate_bit_shift(obj.architecture, 8, 0);
            obj.OUTPUT.all_lp_sres = cell(obj.STAT.n_lp_sres, 2);
            obj.dlp = 0;
            obj.last_output = [];
            obj.u = 0;
        end
        
        function [] = forward_layer(obj, i, input)
            switch obj.architecture{i}{1}
                case 'conv'
                    [convol_settings, ~, act_settings, ~, scales_settings, biases_settings] = obj.architecture{i}{3:8};
                    [~, pad, stride] = convol_settings{:};
                    activation = act_settings{1};
                    [scales_nbit, scales_ibit, scales_sign] = scales_settings{:};
                    [biases_nbit, biases_ibit, biases_sign] = biases_settings{:};
                    scales_fbit = scales_nbit - scales_ibit;
                    biases_fbit = biases_nbit - biases_ibit;

                    %auto format info
                    scales_sign_str = '  ';
                    if scales_sign
                        scales_sign_str = '+-';
                    end
                    biases_sign_str = '  ';
                    if biases_sign
                        biases_sign_str = '+-';
                    end

%                     fprintf('\b (scale %s%02d.%02d) (biases %s%02d.%02d)\n', scales_sign_str, scales_ibit-scales_sign, scales_fbit, biases_sign_str, biases_ibit-biases_sign, biases_fbit);
                    %auto format info

                    weight = obj.weights{i};

                    conv_out = convol2(input, weight, stride, pad);
                    for j = 1:size(conv_out, 3)
                        conv_out(:,:,j) = conv_out(:,:,j) .* obj.scales{i}(j);
                        if ~strcmp(obj.mode, 'float')
                            conv_out(:,:,j) = floor(conv_out(:,:,j) / 2^obj.bit_shift(i)); %if floating point is used, this line should be commented
                        end
                        conv_out(:,:,j) = conv_out(:,:,j) + obj.biases{i}(j);
                    end
        

                    if strcmp(activation, 'float_relu')
                        obj.last_output = hwu_float_relu_activate(conv_out);
                    elseif strcmp(activation, 'leaky')
                        [act_nbit, act_fbit] = act_settings{2:3};
                        act_step = 2^-act_fbit;
                        [obj.last_output, ~] = hwu_leaky_quantize(conv_out, act_step, act_nbit, biases_fbit);
                    elseif strcmp(activation, 'leakz')
                        [act_nbit, act_fbit] = act_settings{2:3};
                        act_step = 2^-act_fbit;
                        [obj.last_output, ~] = hwu_leakz_quantize(conv_out, act_step, act_nbit, biases_fbit);
                    elseif strcmp(activation, 'relu')
                        [act_nbit, act_fbit] = act_settings{2:3};
                        act_step = 2^-act_fbit;
                        [obj.last_output, ~] = hwu_relu_quantize(conv_out, act_step, act_nbit, biases_fbit);
                    elseif strcmp(activation, 'relu_rs')
                        [act_nbit, act_fbit] = act_settings{2:3};
                        act_step = 2^-act_fbit;
                        [obj.last_output, ~] = hwu_relu_rs_quantize(conv_out, act_step, act_nbit, biases_fbit);
                    elseif strcmp(activation, 'line_q')
                        [act_nbit, act_fbit] = act_settings{2:3};
                        act_step = 2^-act_fbit;
                        [obj.last_output, ~] = hwu_linear_quantize(conv_out, act_step, act_nbit, biases_fbit);
                    else
                        obj.last_output = conv_out;
                    end
                %===============================================================================
                case 'res'
                    shortcut_id = obj.architecture{i}{2}+1;
                    activation = obj.architecture{i}{3};
                    output_shortcut = obj.output_buffer{shortcut_id, 2};

                    obj.last_output = shortcut_compute(input, output_shortcut);
                    if strcmp(activation, 'relu')
                        obj.last_output(obj.last_output < 0) = 0;
                    end
                    ovf_mask = obj.last_output > 255;
                    if (sum(ovf_mask(:)) > 0)
                        fprintf('[WRNING] RES layer overflow\n');
                    end
                case 'route'
                    n_input_layer = numel(obj.architecture{i}) - 1;
                    input = [];
                    for j = 1:n_input_layer
                        layer_id = obj.architecture{i}{j+1}+1;
                        input = cat(3, input, obj.output_buffer{layer_id, 2});
                    end
                case 'upsample'
                    obj.last_output = upsample_2x_3d(input);
                case 'sr_flat'
                    [obj.last_output, obj.u] = flatten_sres(input);
                case 'lp_sres'
                    obj.dlp = obj.dlp + 1;
                    obj.OUTPUT.all_lp_sres{obj.dlp,1} = i-1;
                    obj.OUTPUT.all_lp_sres{obj.dlp,2} = input;
                otherwise
                    fprintf('[FAILED] unknown layer type\n');
            end

            % save output buffer
            if obj.output_buffer{i, 1}
                obj.output_buffer{i, 2} = obj.last_output;
            end
        end
        
        function [] = reset(obj)
            fprintf('[ INFO ] network reset\n');
            obj.OUTPUT.all_lp_sres = cell(obj.STAT.n_lp_sres, 2);
            obj.dlp = 0;
            obj.last_output = [];
            obj.u = 0;
        end
    end
end