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

%-----specification------
% class_file = 'imagenet.shortnames.list';
% class_file = 'coco.names'; 
% class_file = 'voc.names';
% base_color = [[1 0 1]; [0 0 1]; [0 1 1]; [0 1 0]; [1 1 0]; [1 0 0]]; % detection base color

arch_name = 'opt5';

% model_prefix = 'model/svdsr10_2x/svdsr10_2x.backup_layer_';
model_prefix = 'model/opt5/opt5_';

image_name = 'D:/matlab/yolov3_hw_v2/test_images/set14/barbara.png';
net_w = 360;
net_h = 288;
% net_w = 250;
% net_h = 240;

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
% run('load_class_list');

run(arch_name)

% input_input_channels = 3; % rgb images
input_input_channels = 1; % vdsr

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
input = input_img * 255;

%vdsr
input_clone = rgb2ycbcr(uint8(input_img * 255));
input = double(input_clone(:,:,1));

OUTPUT.all_classifications = cell(STAT.n_classification_layer, 2);
dc = 0;

OUTPUT.all_detections = cell(STAT.n_detection_layer, 3);
di = 0;

OUTPUT.all_sres = cell(STAT.n_sres, 2);
ds = 0;

OUTPUT.all_lp_sres = cell(STAT.n_lp_sres, 2);
dlp = 0;

fprintf('[ INFO ] forwarding\n');
run_upto = inf;

input_0 = input / 255.;

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
% classification
if STAT.n_classification_layer > 0
    for i = 1:STAT.n_classification_layer
        fprintf('Classification #%2d\n', i);
        scores = softmax(OUTPUT.all_classifications{i,2}(:)/2^output_fbit(OUTPUT.all_classifications{i,1}));
        [sorted_scores, indices] = sort(scores, 'descend');
        for j = 1:5
            fprintf('-- %s (%3.2f)\n', class_list{indices(j)}, sorted_scores(j) * 100);
        end
    end
end

% detection
if STAT.n_detection_layer > 0
    fprintf('Detection %2d layers\n', STAT.n_detection_layer);
    n_class = numel(class_list);
    prob_offset = 5;
    block_size = n_class + prob_offset;

    thresh = 0.5;
    filtered_boxes = [];

    for di = 1:STAT.n_detection_layer
        anchors = OUTPUT.all_detections{di,2};
        n_anchor = size(anchors, 1);

        dets = OUTPUT.all_detections{di,3};
        dets = dets / 2^output_fbit(OUTPUT.all_detections{di,1});
        tmp = zeros(size(dets));

        [oh, ow, ~] = size(dets);
        for n = 1:n_anchor
            tmp(:,:,(n-1)*block_size + 1:(n-1)*block_size + 2) = sigmoid(dets(:,:,(n-1)*block_size + 1:(n-1)*block_size + 2));
            tmp(:,:,(n-1)*block_size + 3) = exp(dets(:,:,(n-1)*block_size + 3)) * anchors(n, 1) / net_w;
            tmp(:,:,(n-1)*block_size + 4) = exp(dets(:,:,(n-1)*block_size + 4)) * anchors(n, 2) / net_h;
            tmp(:,:,(n-1)*block_size + 5) = sigmoid(dets(:,:,(n-1)*block_size + 5));
            tmp(:,:,(n-1)*block_size + prob_offset + 1:n*block_size) = sigmoid(dets(:,:,(n-1)*block_size + prob_offset + 1:n*block_size));
            for i = 1:oh
                for j = 1:ow
                    [cur_class_prob, cur_class] = max(tmp(i,j,(n-1)*block_size+prob_offset+1:n*block_size));
                    objectness = tmp(i,j,(n-1)*block_size + 5);
                    if objectness * cur_class_prob >= thresh
                        cur_x = (tmp(i,j,(n-1)*block_size + 1) + j-1) / ow;
                        cur_y = (tmp(i,j,(n-1)*block_size + 2) + i-1) / oh;
                        cur_w = tmp(i,j,(n-1)*block_size + 3);
                        cur_h = tmp(i,j,(n-1)*block_size + 4);
                        filtered_boxes = [filtered_boxes; [cur_class_prob * objectness cur_class cur_x cur_y cur_w cur_h]];
                    end
                end
            end
        end

    end

    nms_thresh = 0.3;
    
    if (~isempty(filtered_boxes))
        [~,order] = sort(filtered_boxes,1,'descend');
        sorted_boxes = filtered_boxes(order(:,1),:);

        filtered_boxes = do_nms(sorted_boxes, thresh, nms_thresh);
        img_box = filtered_boxes;

        if (~isempty(filtered_boxes))
            filtered_boxes(:,3) = (filtered_boxes(:,3) - (net_w - new_w)/(2*net_w)) ./ (new_w/net_w);
            filtered_boxes(:,4) = (filtered_boxes(:,4) - (net_h - new_h)/(2*net_h)) ./ (new_h/net_h);
            filtered_boxes(:,5) = (filtered_boxes(:,5) * net_w / new_w);
            filtered_boxes(:,6) = (filtered_boxes(:,6) * net_h / new_h);

            img_box(:,3) = max(round((filtered_boxes(:,3) - filtered_boxes(:,5)/2)*img_w),1);
            img_box(:,4) = max(round((filtered_boxes(:,4) - filtered_boxes(:,6)/2)*img_h),1);
            img_box(:,5) = min(round((filtered_boxes(:,3) + filtered_boxes(:,5)/2)*img_w),img_w) - img_box(:,3);
            img_box(:,6) = min(round((filtered_boxes(:,4) + filtered_boxes(:,6)/2)*img_h),img_h) - img_box(:,4);

            img_to_show = img_ori;
            for i = 1:size(img_box,1)
                color_to_use = [get_color(base_color, 3, img_box(i,2), n_class) get_color(base_color, 2, img_box(i,2), n_class) get_color(base_color, 1, img_box(i,2), n_class)];
                img_to_show = insertText(img_to_show,img_box(i,3:4),class_list{img_box(i,2)},'BoxColor',uint8(255*color_to_use),'BoxOpacity',1,'TextColor','black','FontSize',12);
                img_to_show = insertShape(img_to_show,'rectangle',img_box(i,3:6), 'Color', uint8(255*color_to_use), 'LineWidth',4);
                fprintf('#%2d %s (%3.2f)\n', i, class_list{img_box(i,2)}, img_box(i,1)*100);
            end
            
            imshow(img_to_show);
        else
            imshow(img_ori);
        end
    end
end

if STAT.n_sres > 0
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
%     
%     highres_img = uint8(255*imresize(input_img,2));
%     x_img = highres_img;
%     highres_img = rgb2ycbcr(highres_img);
%     highres_img(:,:,1) = uint8(255*OUTPUT.all_sres{1,2}); %nghiant_220328: 255 * output
%     highres_img = ycbcr2rgb(highres_img);
%     x_img = ycbcr2rgb(rgb2ycbcr(x_img));
%     imshow([highres_img,x_img]);
    
end
%%
if STAT.n_lp_sres > 0
    for i = 1:STAT.n_lp_sres
        highres_img = rgb2ycbcr(upsample_2x_3d(input_img));
        subplot(1,3,1);
        imshow(upsample_2x_3d(input_img));
        title('bicubic 2x');
        
        add_image = OUTPUT.all_lp_sres{i,2} / 2^output_fbit(OUTPUT.all_lp_sres{i,1});
        subplot(1,3,2);
        imshow(add_image);
        title('residual (CNN)');
        
        highres_img(:,:,1) = add_image + highres_img(:,:,1);
        
        x_img = im2double(imread(image_name));
        x_img = rgb2ycbcr(x_img);
        x_img = x_img(:,:,1);
        
        y_img = highres_img(:,:,1);
        [yh, yw, ~] = size(y_img);

        DEBUG.diff_img = (x_img - y_img).^2;
        DEBUG.diff_img = DEBUG.diff_img(u+1:yh-u,u+1:yw-u);
        PSNR = 20*log10(1/sqrt(mean(DEBUG.diff_img(:))))

        highres_img = ycbcr2rgb(highres_img);
        subplot(1,3,3);
        imshow(highres_img);
        title('CNN 2x');
    end
end