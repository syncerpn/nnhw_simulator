% darknet on HW simulation: new version 20200224
% define your own things inside _USER_DEFINE_ and _USER_DEFINE_END_ field
% compulsory:
%       model_prefix
%       architecture
% optional:
%       preset
%-------preparing--------
clear;
close all;
clc;

addpath('func/');
addpath('arch/');

% _USER_DEFINE_------------------------------------------------------------------------------------------------------------------------
%--------options---------
% support dynamic fixed-point for scales and biases
OPTION_AUTO_FORMAT_SCALES = 1;
OPTION_AUTO_FORMAT_BIASES = 1;

arch_name = 'opt5';
model_prefix = 'model/opt5/opt5_';

image_name = 'D:/matlab/yolov3_hw_v2/test_images/set14/barbara.png';
net_w = 360;
net_h = 288;

% predefined presets from file
% please define new presets in this file as well
% update 20200320: all presets are inside struct 'ps'; please replace 'ps_'
% by 'ps.' in your code

%------architecture-------
% structure
% {'conv', batchnorm, convol_preset, output_channels, activation_preset, wts_preset, scales_preset, biases_preset};
% {'dcnv', batchnorm, convol_preset,                  activation_preset, wts_preset, scales_preset, biases_preset}; % output_channels is not necessary
% {'res', shortcut_layer, activation};
% {'maxpool', kernel_size, stride};
% {'avgpool'};
% {'route', layer_id, ...};
% {'upsample'};
% {'yolo', anchor_box_x, anchor_box_y, ...};
% {'softmax'};
% {'sres'};
% {'sr_flat'}
% {'lp_sres'};

% additional definition, pretty much similar to import in python
run('load_preset');
run(arch_name)
input_input_channels = 1; % sr y-channel image

%_USER_DEFINE_END_--------------------------------------------------------------------------------------------------------------------

%----preprocessing----
all_input_channels = hwu_parse_input_channels(architecture, input_input_channels);

%------buffering------
fprintf('[ INFO ] parse and create output buffers\n');
[STAT, output_buffer] = hwu_parse_and_create_buffer(architecture);

%--------param--------
fprintf('[ INFO ] parse and load params\n');
n_layer = numel(architecture);
weights = cell(n_layer, 1);
scales = cell(n_layer, 1);
biases = cell(n_layer, 1);

for i = 1:n_layer
    switch architecture{i}{1}
        case 'conv'
            [batchnorm, convol_settings, output_channels, ~, weights_settings] = architecture{i}{2:6};
            [kernel_size, ~, ~] = convol_settings{:};
            wts_scheme = weights_settings{1};
            
            input_channels = all_input_channels(i);
            param_file = [model_prefix num2str(i-1)];
            
            [weightx, bias, scale, rolling_mean, rolling_var] = read_conv_param_module(param_file, kernel_size, input_channels, output_channels, batchnorm);
            if strcmp(wts_scheme, 'none')
                weight = weightx;
                w_bonus_scale_factor = ones(output_channels,1);
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
            elseif strcmp(wts_scheme, 'scale_linear_float')
                wts_nlevel = 2^weights_settings{2};
                [weight, w_bonus_scale_factor] = scale_linear_quantize_float(weightx, output_channels, wts_nlevel/2);
            end
            
            weights{i} = permute(reshape(weight, kernel_size, kernel_size, input_channels, output_channels), [2, 1, 3, 4]);
            if (batchnorm)
                scales_new = w_bonus_scale_factor .* scale ./ sqrt(rolling_var + 0.00001);
                if (i == 1)
                    scales_new = scales_new / 255.;
                end
                biases_new = bias - scale .* rolling_mean ./ sqrt(rolling_var + 0.00001);
            else
                scales_new = w_bonus_scale_factor .* ones(output_channels, 1);
                if (i == 1)
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
                    architecture{i}{7} = {scales_nbit scales_nbit-fbit sign};
                end
            end
            if biases_nbit > 0
                if OPTION_AUTO_FORMAT_BIASES
                    [fbit, sign] = hwu_auto_format(biases_new, biases_nbit);
                    architecture{i}{8} = {biases_nbit biases_nbit-fbit sign};
                end
            end
            
            [scales_settings, biases_settings] = architecture{i}{7:8};
            [scales_ibit, scales_sign] = scales_settings{2:3};
            [biases_ibit, biases_sign] = biases_settings{2:3};

            if scales_nbit > 0
                scales{i} = quantize_and_constrain2(scales_new, scales_nbit, scales_ibit, scales_sign, 0, 0);
            else
                scales{i} = scales_new;
            end
            if biases_nbit > 0
                biases{i} = quantize_and_constrain2(biases_new, biases_nbit, biases_ibit, biases_sign, 0, 0);
            else
                biases{i} = biases_new;
            end
        %===============================================================================
        case 'dcnv'
            [batchnorm, convol_settings, ~, weights_settings] = architecture{i}{2:5};
            [kernel_size, ~, ~] = convol_settings{:};
            wts_scheme = weights_settings{1};
            
            input_channels = all_input_channels(i);
            param_file = [model_prefix num2str(i-1)];
            
            [weightx, bias, scale, rolling_mean, rolling_var] = read_dw_conv_param_module(param_file, kernel_size, input_channels, batchnorm);
            if strcmp(wts_scheme, 'none')
                weight = weightx;
                w_bonus_scale_factor = ones(output_channels,1);
            elseif strcmp(wts_scheme, 'uniform')
                [wts_nbit, wts_fbit, ~] = weights_settings{2:end};
                wts_step = 2^-wts_fbit;
                [weight, ~] = uniform_quantize(weightx, wts_step, wts_nbit);
                w_bonus_scale_factor = ones(input_channels,1);
            elseif strcmp(wts_scheme, 'mean_shifter')
                wts_nlevel = 2^weights_settings{2};
                [weight, w_bonus_scale_factor] = mean_shifter_quantize(weightx, input_channels, wts_nlevel/2);
            elseif strcmp(wts_scheme, 'scale_linear')
                wts_nlevel = 2^weights_settings{2};
                [weight, w_bonus_scale_factor] = scale_linear_quantize(weightx, input_channels, wts_nlevel/2);
            elseif strcmp(wts_scheme, 'mean_shifter_float')
                wts_nlevel = 2^weights_settings{2};
                [weight, w_bonus_scale_factor] = mean_shifter_quantize_float(weightx, output_channels, wts_nlevel/2);
            elseif strcmp(wts_scheme, 'scale_linear_float')
                wts_nlevel = 2^weights_settings{2};
                [weight, w_bonus_scale_factor] = scale_linear_quantize_float(weightx, output_channels, wts_nlevel/2);
            end
            
            weights{i} = permute(reshape(weight, kernel_size, kernel_size, input_channels, 1), [2, 1, 3, 4]);
            if (batchnorm)
                scales_new = w_bonus_scale_factor .* scale ./ sqrt(rolling_var + 0.00001);
                if (i == 1)
                    scales_new = scales_new / 255.;
                end
                biases_new = bias - scale .* rolling_mean ./ sqrt(rolling_var + 0.00001);
            else
                scales_new = w_bonus_scale_factor .* ones(input_channels, 1);
                if (i == 1)
                    scales_new = scales_new / 255.;
                end
                biases_new = bias;
            end
            
            [scales_settings, biases_settings] = architecture{i}{6:7};
            scales_nbit = scales_settings{1};
            biases_nbit = biases_settings{1};
                
            if scales_nbit > 0
                if OPTION_AUTO_FORMAT_SCALES
                    [fbit, sign] = hwu_auto_format(scales_new, scales_nbit);
                    architecture{i}{6} = {scales_nbit scales_nbit-fbit sign};
                end
            end
            if biases_nbit > 0
                if OPTION_AUTO_FORMAT_BIASES
                    [fbit, sign] = hwu_auto_format(biases_new, biases_nbit);
                    architecture{i}{7} = {biases_nbit biases_nbit-fbit sign};
                end
            end
            
            [scales_settings, biases_settings] = architecture{i}{6:7};
            [scales_ibit, scales_sign] = scales_settings{2:3};
            [biases_ibit, biases_sign] = biases_settings{2:3};
            
            if scales_nbit > 0
                scales{i} = quantize_and_constrain2(scales_new, scales_nbit, scales_ibit, scales_sign, 0, 0);
            else
                scales{i} = scales_new;
            end
            if biases_nbit > 0
                biases{i} = quantize_and_constrain2(biases_new, biases_nbit, biases_ibit, biases_sign, 0, 0);
            else
                biases{i} = biases_new;
            end
        %===============================================================================
        case 'upsample'
        case 'res'
        case 'maxpool'
        case 'avgpool'
        case 'softmax'
        case 'route'
        case 'yolo'
        case 'sres'
        case 'sr_flat'
        case 'lp_sres'
        otherwise
            fprintf('[FAILED] unknown layer type\n');
            break;
    end
end

[bit_shift, output_fbit] = hwu_calculate_bit_shift(architecture, 8, 0);

%-------cleanup-------
clear wts_step wts_scheme wts_nbit wts_fbit weightx weights_settings weight weight_store ...
    scales_settings scales_nbit scales_ibit scales_sign scale scales_store scales_new ...
    rolling_mean rolling_var ...
    bias biases_settings biases_nbit biases_ibit biases_sign biases_new biases_store ...
    all_input_channels param_file ...
    convol_settings input_channels kernel_size pad stride ...
    output_channels layer_id n_input_layer i j batchnorm ...
    fbit sign

%--------input--------
[input_img, img_ori, img_w, img_h, new_h, new_w] = create_yolo_input(image_name, net_w, net_h, 0);

%-------forward-------
input_clone = rgb2ycbcr(uint8(input_img * 255));
input = double(input_clone(:,:,1));

OUTPUT.all_sres = cell(STAT.n_sres, 2);
ds = 0;

fprintf('[ INFO ] forwarding\n');
run_upto = inf;

input_0 = input / 255.; %nghiant_220328: for route and concat input

for i = 1:n_layer
    if i > run_upto
        break;
    end
    fprintf('[ INFO ] layer %3d (%8s)\n', i-1, architecture{i}{1});
    switch architecture{i}{1}
        case 'conv'
            [convol_settings, output_channels, act_settings, ~, scales_settings, biases_settings] = architecture{i}{3:8};
            [kernel_size, pad, stride] = convol_settings{:};
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
            
            fprintf('\b (scale %s%02d.%02d) (biases %s%02d.%02d)\n', scales_sign_str, scales_ibit-scales_sign, scales_fbit, biases_sign_str, biases_ibit-biases_sign, biases_fbit);
            %auto format info
            
            weight = weights{i};
            
            conv_out = convol2(input, weight, stride, pad);
            for j = 1:size(conv_out, 3)
                conv_out(:,:,j) = conv_out(:,:,j) .* scales{i}(j);
%                 conv_out(:,:,j) = floor(conv_out(:,:,j) / 2^bit_shift(i)); %if floating point is used, this line should be commented
                conv_out(:,:,j) = conv_out(:,:,j) + biases{i}(j);
            end
            
            if strcmp(activation, 'float_relu')
                output = hwu_float_relu_activate(conv_out);
            elseif strcmp(activation, 'leaky')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_leaky_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'leakz')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_leakz_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'relu')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_relu_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'relu_rs')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_relu_rs_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'line_q')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_linear_quantize(conv_out, act_step, act_nbit, biases_fbit);
            else
                output = conv_out;
            end
            input = output;
        %===============================================================================
        case 'dcnv'
            [convol_settings, act_settings, ~, scales_settings, biases_settings] = architecture{i}{3:7};
            [kernel_size, pad, stride] = convol_settings{:};
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
            
            fprintf('\b (scale %s%02d.%02d) (biases %s%02d.%02d)\n', scales_sign_str, scales_ibit-scales_sign, scales_fbit, biases_sign_str, biases_ibit-biases_sign, biases_fbit);
            %auto format info
            
            weight = weights{i};
            
            conv_out = dw_convol(input, weight, stride, pad);
            
            for j = 1:size(conv_out, 3)
                conv_out(:,:,j) = conv_out(:,:,j) .* scales{i}(j);
%                 conv_out(:,:,j) = floor(conv_out(:,:,j) / 2^bit_shift(i)); %if floating point is used, this line should be commented
                conv_out(:,:,j) = conv_out(:,:,j) + biases{i}(j);
            end
            
            if strcmp(activation, 'float_relu')
                output = hwu_float_relu_activate(conv_out);
            elseif strcmp(activation, 'leaky')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_leaky_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'leakz')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_leakz_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'relu')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_relu_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'relu_rs')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_relu_rs_quantize(conv_out, act_step, act_nbit, biases_fbit);
            elseif strcmp(activation, 'line_q')
                [act_nbit, act_fbit] = act_settings{2:3};
                act_step = 2^-act_fbit;
                [output, ~] = hwu_linear_quantize(conv_out, act_step, act_nbit, biases_fbit);
            else
                output = conv_out;
            end
            input = output;
        %===============================================================================
        case 'res'
            shortcut_id = architecture{i}{2}+1;
            activation = architecture{i}{3};
            output_shortcut = output_buffer{shortcut_id, 2};
            
            output = shortcut_compute(input, output_shortcut);
            if strcmp(activation, 'relu')
                output(output < 0) = 0;
            end
            ovf_mask = output > 255;
            if (sum(ovf_mask(:)) > 0)
                fprintf('[WRNING] RES layer overflow\n');
            end
            input = output;
        case 'route'
            n_input_layer = numel(architecture{i}) - 1;
            input = [];
            for j = 1:n_input_layer
                layer_id = architecture{i}{j+1}+1;
                if (layer_id == 0) %nghiant_220328: support concat with input image as well as layer output
                    input = cat(3, input, input_0);
                else
                    input = cat(3, input, output_buffer{layer_id, 2});
                end
            end
        case 'upsample'
            output = upsample_2x_3d(input);
            input = output;
        case 'maxpool'
            [kernel_size, stride] = architecture{i}{2:3};
            output = maxpool(input, kernel_size, stride);
            input = output;
        case 'avgpool'
            output = avgpool(input);
            input = output;
        case 'sr_flat'
            [output, u] = flatten_sres(input);
            input = output;
        case 'softmax'
            dc = dc + 1;
            OUTPUT.all_classifications{dc,1} = i-1;
            OUTPUT.all_classifications{dc,2} = input;
        case 'yolo'
            di = di + 1;
            OUTPUT.all_detections{di,1} = i-1;
            OUTPUT.all_detections{di,2} = (reshape(architecture{i}{2}, 2, []))';
            OUTPUT.all_detections{di,3} = input;
        case 'sres'
            ds = ds + 1;
            OUTPUT.all_sres{ds,1} = i-1;
            OUTPUT.all_sres{ds,2} = input;
        case 'lp_sres'
            dlp = dlp + 1;
            OUTPUT.all_lp_sres{dlp,1} = i-1;
            OUTPUT.all_lp_sres{dlp,2} = input;
        otherwise
            fprintf('[FAILED] unknown layer type\n');
            break;
    end
    
    % save output buffer
    if output_buffer{i, 1}
        output_buffer{i, 2} = output;
    end
end

assert(i == n_layer, ['[ STOP ] intended debugging, stopped at layer ' num2str(i)]);
    
%---post_processing---
x_img = rgb2ycbcr(im2double(img_ori));
x_img = x_img(:,:,1);
y_img = OUTPUT.all_sres{1,2};

diff_img = (x_img - y_img).^2;
diff_img = diff_img(u+1:end-u,u+1:end-u);
PSNR = 20*log10(1/sqrt(mean(diff_img(:))))

subplot(1,2,1);
imshow(upsample_2x_3d(input_img));
title('bicubic 2x');

subplot(1,2,2);
imshow(y_img);
title('CNN output');