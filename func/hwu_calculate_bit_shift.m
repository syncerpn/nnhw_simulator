function [bit_shift, output_fbit] = hwu_calculate_bit_shift(architecture, input_ibit, input_fbit)

n_layer = numel(architecture);
bit_shift = zeros(n_layer, 1);
output_fbit = zeros(n_layer, 1);

for i = 1:n_layer
    switch architecture{i}{1}
        case 'conv'
            [act_settings, weights_settings, scales_settings, biases_settings] = architecture{i}{5:8};
            wts_scheme = weights_settings{:};
            [scales_nbit, scales_ibit, ~] = scales_settings{:};
            [biases_nbit, biases_ibit, ~] = biases_settings{:};
            activation = act_settings{1};
            
            if strcmp(wts_scheme, 'none')
                wts_fbit = 0;
            elseif strcmp(wts_scheme, 'uniform')
                wts_fbit = weights_settings{3} + 1;
            elseif strcmp(wts_scheme, 'mean_shifter')
                wts_fbit = 2^(weights_settings{2}-1) - 1;
            elseif strcmp(wts_scheme, 'scale_linear')
                wts_fbit = weights_settings{2};
            elseif strcmp(wts_scheme, 'mean_shifter_float')
                wts_fbit = 0;
            elseif strcmp(wts_scheme, 'scale_linear_float')
                wts_fbit = 0;
            end
            
            scales_fbit = scales_nbit - scales_ibit;
            biases_fbit = biases_nbit - biases_ibit;
            
            bit_shift(i) = input_fbit + wts_fbit + scales_fbit - biases_fbit;
            
            if strcmp(activation, 'float_relu')
                act_fbit = biases_fbit;
            elseif strcmp(activation, 'leaky')
                act_fbit = act_settings{3};
                act_fbit = act_fbit + 1;
            elseif strcmp(activation, 'linear')
                act_fbit = biases_fbit;
            else
                act_fbit = act_settings{3};
            end
            
            output_fbit(i) = act_fbit;
            input_fbit = act_fbit;
        case 'dcnv'
            [act_settings, weights_settings, scales_settings, biases_settings] = architecture{i}{4:7};
            wts_scheme = weights_settings{:};
            [scales_nbit, scales_ibit, ~] = scales_settings{:};
            [biases_nbit, biases_ibit, ~] = biases_settings{:};
            activation = act_settings{1};
            
            if strcmp(wts_scheme, 'none')
                wts_fbit = 0;
            elseif strcmp(wts_scheme, 'uniform')
                wts_fbit = weights_settings{3} + 1;
            elseif strcmp(wts_scheme, 'mean_shifter')
                wts_fbit = 2^(weights_settings{2}-1) - 1;
            elseif strcmp(wts_scheme, 'scale_linear')
                wts_fbit = weights_settings{2};
            elseif strcmp(wts_scheme, 'mean_shifter_float')
                wts_fbit = 0;
            elseif strcmp(wts_scheme, 'scale_linear_float')
                wts_fbit = 0;
            end
            
            scales_fbit = scales_nbit - scales_ibit;
            biases_fbit = biases_nbit - biases_ibit;
            
            bit_shift(i) = input_fbit + wts_fbit + scales_fbit - biases_fbit;
            
            if strcmp(activation, 'float_relu')
                act_fbit = biases_fbit;
            elseif strcmp(activation, 'leaky')
                act_fbit = act_settings{3};
                act_fbit = act_fbit + 1;
            elseif strcmp(activation, 'linear')
                act_fbit = biases_fbit;
            else
                act_fbit = act_settings{3};
            end
            
            output_fbit(i) = act_fbit;
            input_fbit = act_fbit;
        case 'upsample'
            output_fbit(i) = input_fbit;
        case 'res'
            assert(input_fbit == output_fbit(architecture{i}{2}+1), '[FAILED] RES layers fbit mismatched\n');
            output_fbit(i) = input_fbit;
        case 'maxpool'
            output_fbit(i) = input_fbit;
        case 'avgpool'
            output_fbit(i) = input_fbit;
        case 'softmax'
        case 'route'
            n_input_layer = numel(architecture{i}) - 1;
            input_fbit = output_fbit(architecture{i}{2}+1);
            for j = 2:n_input_layer
                if architecture{i}{j+1}+1 > 0
                    assert(input_fbit == output_fbit(architecture{i}{j+1}+1), '[FAILED] ROUTE layers fbit mismatched\n');
                end
            end
            
            output_fbit(i) = input_fbit;
        case 'yolo'
        case 'sres'
        case 'sr_flat'
            output_fbit(i) = input_fbit;
        case 'lp_sres'
        otherwise
            fprintf('[FAILED] unknown layer type\n');
            break;
    end
end