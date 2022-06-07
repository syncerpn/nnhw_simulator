function [weights, biases, scales, rolling_mean, rolling_var] = read_dw_conv_param_module(file, kernel_size, input_channels, batchnorm)
fid = fopen(file, 'rb');
biases = fread(fid, input_channels, 'float');

scales = [];
rolling_mean = [];
rolling_var = [];
if batchnorm
    scales = fread(fid, input_channels, 'float');
    rolling_mean = fread(fid, input_channels, 'float');
    rolling_var = fread(fid, input_channels, 'float');
end
weights = fread(fid, kernel_size * kernel_size * input_channels, 'float');
fclose(fid);