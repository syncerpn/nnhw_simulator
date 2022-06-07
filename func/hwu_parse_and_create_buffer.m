function [STAT, output_buffer] = hwu_parse_and_create_buffer(architecture)
n_layer = numel(architecture);

output_buffer = cell(n_layer, 2);
STAT.n_classification_layer = 0;
STAT.n_detection_layer = 0;
STAT.n_sres = 0;
STAT.n_lp_sres = 0;

for i = 1:n_layer
    output_buffer{i,1} = 0;
    switch architecture{i}{1}
        case 'conv'
        case 'dcnv'
        case 'upsample'
        case 'sr_flat'
        case 'res'
            layer_id = architecture{i}{2} + 1;
            output_buffer{layer_id,1} = 1;
        case 'softmax'
            STAT.n_classification_layer = STAT.n_classification_layer + 1;
        case 'maxpool'
        case 'avgpool'
        case 'route'
            n_input_layer = numel(architecture{i}) - 1;
            for j = 1:n_input_layer
                layer_id = architecture{i}{j+1}+1;
                if layer_id > 0 %nghiant: if layer_id == 0 (or set -1 in architecture), this is input image; no need buffering
                    output_buffer{layer_id,1} = 1;
                end
            end
        case 'yolo'
            STAT.n_detection_layer = STAT.n_detection_layer + 1;
        case 'sres'
            STAT.n_sres = STAT.n_sres + 1;
        case 'lp_sres'
            STAT.n_lp_sres = STAT.n_lp_sres + 1;
        otherwise
            fprintf('[FAILED] unknown layer type\n');
            break;
    end
end