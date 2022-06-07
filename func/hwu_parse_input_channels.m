function [all_input_channels, all_output_channels] = hwu_parse_input_channels(architecture, input_channel)
n_layers = numel(architecture);
all_input_channels = zeros(n_layers, 1);
all_output_channels = zeros(n_layers, 1);

all_input_channels(1) = input_channel;
switch architecture{1}{1}
    case 'conv'
        all_output_channels(1) = architecture{1}{4};
    case 'dcnv'
        all_output_channels(1) = input_channel;
    case 'upsample'
        all_output_channels(1) = input_channel;
    case 'sr_flat'
        all_output_channels(1) = 1;
end

for i = 2:n_layers    
    switch architecture{i}{1}
        case 'conv'
            all_output_channels(i) = architecture{i}{4};
            all_input_channels(i) = all_output_channels(i-1);
        case 'dcnv'
            all_output_channels(i) = all_output_channels(i-1);
            all_input_channels(i) = all_output_channels(i-1);
        case 'res'
            shortcut_id = architecture{i}{2}+1;
            all_output_channels(i) = max(all_output_channels(shortcut_id), all_output_channels(i-1));
            all_input_channels(i) = all_output_channels(shortcut_id);
        case 'route'
            all_input_channels(i) = 0;
            n_input_layer = numel(architecture{i}) - 1;
            for j = 1:n_input_layer
                layer_id = architecture{i}{j+1}+1;
                if (layer_id == 0) %nghiant_220328: support concat with input
                    all_output_channels(i) = all_output_channels(i) + input_channel;
                else
                    all_output_channels(i) = all_output_channels(i) + all_output_channels(layer_id);
                end
            end
        case 'upsample'
            all_input_channels(i) = all_output_channels(i-1);
            all_output_channels(i) = all_input_channels(i);
        case 'sr_flat'
            all_input_channels(i) = all_output_channels(i-1);
            all_output_channels(i) = 1;
        case 'maxpool'
            all_input_channels(i) = all_output_channels(i-1);
            all_output_channels(i) = all_input_channels(i);
        case 'avgpool'
            all_input_channels(i) = all_output_channels(i-1);
            all_output_channels(i) = all_input_channels(i);
        case 'yolo'
        case 'softmax'
        case 'sres'
        case 'lp_sres'
        otherwise
            fprintf('[FAILED] unknown layer type\n');
            break;
    end
end