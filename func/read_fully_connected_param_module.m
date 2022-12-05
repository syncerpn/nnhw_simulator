function [weights, biases] = read_fully_connected_param_module(file, input_channels, output_channels)
fid = fopen(file, 'rb');
biases = fread(fid, output_channels, 'float');
weights = fread(fid, input_channels * output_channels, 'float');
fclose(fid);