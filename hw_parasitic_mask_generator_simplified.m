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
%-------preparing--------
clear;
close all;
clc;

addpath('func/');
addpath('arch/');

% _USER_DEFINE_------------------------------------------------------------------------------------------------------------------------
%--------options---------
% support dynamic fixed-point for scales and biases
OPTION_AUTO_FORMAT_SCALES = 0;
OPTION_AUTO_FORMAT_BIASES = 0;

core_name = 'arch/idag_40K_ch32';

% core_prefix = 'model/idag/idag_40K_ch32.backup_layer_';

% agents_name = 'arch/IDAG_mask/idag_agents';
% agents_prefix = {'', ...
%                 'model/IDAG_policy_net/agent_1_conv_', ...
%                 'model/IDAG_policy_net/agent_2_conv_', ...
%                 'model/IDAG_policy_net/agent_3_conv_', ...
%                 'model/IDAG_policy_net/agent_4_conv_', ...
%                 'model/IDAG_policy_net/agent_5_conv_', ...
%                 'model/IDAG_policy_net/agent_6_conv_', ...
%                 '', ...
%                 '', ...
%                 '', ...
%                 };

core_prefix = 'model/idag_3301/core';

% agents_name = 'arch/IDAG_mask/idag_agents_v0';
% agents_prefix = {'', ...
%                 'model/idag_3301_mask_v0/agent_1_', ...
%                 'model/idag_3301_mask_v0/agent_2_', ...
%                 'model/idag_3301_mask_v0/agent_3_', ...
%                 'model/idag_3301_mask_v0/agent_4_', ...
%                 'model/idag_3301_mask_v0/agent_5_', ...
%                 'model/idag_3301_mask_v0/agent_6_', ...
%                 '', ...
%                 '', ...
%                 '', ...
%                 };

agents_name = 'arch/IDAG_mask/idag_agents';
agents_prefix = {'', ...
                'model/idag_3301_mask_v1/agent_1_', ...
                'model/idag_3301_mask_v1/agent_2_', ...
                'model/idag_3301_mask_v1/agent_3_', ...
                'model/idag_3301_mask_v1/agent_4_', ...
                'model/idag_3301_mask_v1/agent_5_', ...
                'model/idag_3301_mask_v1/agent_6_', ...
                '', ...
                '', ...
                '', ...
                };

image_set = {
%         'D:/matlab/yolov3_hw_v2/test_images/set5/baby_GT.bmp';
%         'D:/matlab/yolov3_hw_v2/test_images/set5/bird_GT.bmp';
%         'D:/matlab/yolov3_hw_v2/test_images/set5/butterfly_GT.bmp';
%         'D:/matlab/yolov3_hw_v2/test_images/set5/head_GT.bmp';
%         'D:/matlab/yolov3_hw_v2/test_images/set5/woman_GT.bmp';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/baboon.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/barbara.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/bridge.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/coastguard.png';
        'D:/matlab/yolov3_hw_v2/test_images/set14/comic.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/face.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/flowers.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/foreman.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/lenna.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/man.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/monarch.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/pepper.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/ppt3.png';
%         'D:/matlab/yolov3_hw_v2/test_images/set14/zebra.png';
    };

% additional definition, pretty much similar to import in python
run('load_preset');
run(core_name)
run(agents_name)

input_input_channels = 1; %sr lp_sres

rescale_first_layer = 1;
core = Network(architecture, input_input_channels, core_prefix, rescale_first_layer, OPTION_AUTO_FORMAT_SCALES, OPTION_AUTO_FORMAT_BIASES);
% for j = 1:length(core.weights)
%     core.weights{j}(abs(core.weights{j}) < 0.01) = 0;
%     sum(core.weights{j}(:) == 0) / numel(core.weights{j}(:))
% end

agents = {};
for i = 1:numel(agents_arch)
    if isempty(agents_arch{i})
        agents{i} = '';
    else
        rescale_first_layer = 0;
        agents{i} = Network(agents_arch{i}, core.all_input_channels(i), agents_prefix{i}, rescale_first_layer, OPTION_AUTO_FORMAT_SCALES, OPTION_AUTO_FORMAT_BIASES);
%         for j = 1:length(agents{i}.weights)
%             agents{i}.weights{j}(abs(agents{i}.weights{j}) < 0.001) = 0;
%             sum(agents{i}.weights{j}(:) == 0) / numel(agents{i}.weights{j}(:))
%         end
    end
end

% assert(0)

PSNRs = [];

for iii = 1:numel(image_set)
    core.reset()
    image_name = image_set{iii};
    im = imread(image_name);
    input_img =  modcrop(im, 2);
    input_img =  single(input_img)/255;
    input_img = imresize(input_img, 1/2, 'bicubic');
    if size(im,3) > 1
        im_ycbcr = rgb2ycbcr(im);
        im = im_ycbcr(:,:,1);
    end
    im_gnd = modcrop(im, 2);
    im_gnd = single(im_gnd)/255;
    im_l = imresize(im_gnd, 1/2, 'bicubic');

    input = floor(im_l(:,:,1) * 255);

    fprintf('[ INFO ] forwarding\n');
    run_upto = inf;
    for i = 1:core.n_layer
        mask = [];
        if ~isempty(agents{i}) % && (i == 2 || i == 7)
            fprintf('[ INFO ] -- mask_gen for layer %d\n', i-1);
            agent_input = input / 2^core.output_fbit(i-1);
            for j = 1:agents{i}.n_layer
                agents{i}.forward_layer(j, agent_input);
                agent_input = agents{i}.last_output;
                fprintf('[ INFO ] -- agent_act max min %f %f\n', max(agent_input(:)), min(agent_input(:)));
            end
            mask = agents{i}.last_output;
            mask(mask >  0) = 1;
            mask(mask <= 0) = 0;
            fprintf('[ INFO ] -- sp: %f\n', 1-sum(mask(:))/numel(mask));
        end
        if i > run_upto
            break;
        end
        fprintf('[ INFO ] layer %3d (%8s)\n', i-1, core.architecture{i}{1});
        core.forward_layer(i, input);
        if ~isempty(mask)% && (i > 2) && (i < 7)
            fprintf('[ INFO ] -- use mask\n');
            core.last_output = core.last_output .* mask;
        end
        input = core.last_output;
    end

    assert(i == core.n_layer, ['[ STOP ] intended debugging, stopped at layer ' num2str(i)]);
    %
    if core.STAT.n_lp_sres > 0
        for i = 1:core.STAT.n_lp_sres
            highres_img = rgb2ycbcr(upsample_2x_3d(input_img));
            subplot(1,3,1);
            imshow(upsample_2x_3d(input_img));
            title('bicubic 2x');

            add_image = core.OUTPUT.all_lp_sres{i,2} / 2^core.output_fbit(core.OUTPUT.all_lp_sres{i,1});
            subplot(1,3,2);
            imshow(add_image);
            title('residual (CNN)');

            highres_img(:,:,1) = add_image + highres_img(:,:,1);

            x_img = modcrop(im2double(imread(image_name)),2);
            x_img = rgb2ycbcr(x_img);
            x_img = x_img(:,:,1);

            y_img = highres_img(:,:,1);
            [yh, yw, ~] = size(y_img);

            DEBUG.diff_img = (x_img - y_img).^2;
            DEBUG.diff_img = DEBUG.diff_img(core.u+1:yh-core.u,core.u+1:yw-core.u);
            PSNR = 20*log10(1/sqrt(mean(DEBUG.diff_img(:))));

            highres_img = ycbcr2rgb(highres_img);
            subplot(1,3,3);
            imshow(highres_img);
            title('CNN 2x');
        end
    end
    PSNRs = [PSNRs PSNR];
    PSNR
end
mean_PSNR = mean(PSNRs);