function [input, image_ori, img_w, img_h, new_h, new_w] = create_yolo_input(image_name, net_w, net_h, do_write_to_file)
image_ori = imread(image_name);
img_h = size(image_ori, 1);
img_w = size(image_ori, 2);
img_c = size(image_ori, 3);

if (net_w / img_w) < (net_h / img_h)
    new_w = net_w;
    new_h = floor((img_h * net_w) / img_w);
    fill_size = floor((net_h - new_h) / 2);
    fill = 0;
else
    new_h = net_h;
    new_w = floor((img_w * net_h) / img_h);
    fill_size = floor((net_w - new_w) / 2);
    fill = 1;
end

img_resize = double(imresize(image_ori, [new_h, new_w])) / 255;

input = zeros(net_h, net_w, img_c);

if (fill == 1)
    input(:,1:fill_size,:) = 127/255;
    input(:,fill_size+1:fill_size+new_w,:) = img_resize;
    input(:,fill_size+new_w+1:net_w,:) = 127/255;
else
    input(1:fill_size,:,:) = 127/255;
    input(fill_size+1:fill_size+new_h,:,:) = img_resize;
    input(fill_size+new_h+1:net_h,:,:) = 127/255;
end

if (do_write_to_file)
    input_to_write = input * 255;
    input_file = fopen(strcat(image_name,'.txt'),'w');
    for i = 1:size(input_to_write,1)
        for j = 1:size(input_to_write,2)
            tmp = '';
            for k = size(input_to_write,3):-1:1
                tmp = strcat(tmp,dec2hex(input_to_write(i,j,k),2));
            end
            fprintf(input_file,'%s\n',tmp);
        end
    end
    fclose(input_file);
end