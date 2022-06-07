function [weights, biases, scales, rolling_mean, rolling_var] = read_conv_param_module(file, kernel_size, input_channels, output_channels, batchnorm)
fid = fopen(file, 'rb');
biases = fread(fid, output_channels, 'float');

scales = [];
rolling_mean = [];
rolling_var = [];
if batchnorm
    scales = fread(fid, output_channels, 'float');
    rolling_mean = fread(fid, output_channels, 'float');
    rolling_var = fread(fid, output_channels, 'float');
end
weights = fread(fid, kernel_size * kernel_size * input_channels * output_channels, 'float');
fclose(fid);