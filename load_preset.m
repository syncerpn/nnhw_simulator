%---------preset---------
% preset: scales_nbit_ibit_sign = [nbit ibit sign]
ps.scales_32_1_1  = {32  1 1};
ps.scales_16_1_1  = {16  1 1};
ps.scales_16_2_1  = {16  2 1};
ps.scales_16_3_1  = {16  3 1};
ps.scales_16_4_1  = {16  4 1};
ps.scales_16_5_1  = {16  5 1};
ps.scales_16_6_1  = {16  6 1};
ps.scales_16_7_1  = {16  7 1};
ps.scales_16_8_1  = {16  8 1};
ps.scales_16_1_0  = {16  1 0};
ps.scales_16_2_0  = {16  2 0};
ps.scales_16_3_0  = {16  3 0};
ps.scales_16_4_0  = {16  4 0};
ps.scales_16_5_0  = {16  5 0};
ps.scales_16_6_0  = {16  6 0};
ps.scales_16_7_0  = {16  7 0};
ps.scales_16_8_0  = {16  8 0};
ps.scales_16_10_1 = {16 10 1};
ps.scales_float = {0 0 0};

% preset: biases_nbit_ibit_sign = [nbit ibit sign]
ps.biases_16_6_1 = {16 6 1};
ps.biases_16_8_1 = {16 8 1};
ps.biases_float = {0 0 0};

% preset: convol_field_pad_stride = [field pad stride]
% currently support square convolutional spatial field
ps.conv_f3_p2_s1 = {3 2 1};
ps.conv_f3_p1_s2 = {3 1 2}; % downsample
ps.conv_f5_p4_s1 = {5 4 1};
ps.conv_f5_p3_s2 = {5 3 2}; % downsample
ps.conv_f7_p5_s2 = {7 5 2}; % downsample
ps.conv_f1_p0_s1 = {1 0 1};
ps.conv_f1_p0_s2 = {1 0 2}; % downsample

% preset: wts_none
ps.wts_none = {'none'};

% preset: wts_uniform_nbit_step = {'uniform' nbit fbit sign}
ps.wts_uniform_8_8_1 = {'uniform' 8 8 1};
ps.wts_uniform_8_7_1 = {'uniform' 8 7 1};
ps.wts_uniform_8_6_1 = {'uniform' 8 6 1};
ps.wts_uniform_16_14_1 = {'uniform' 16 14 1};

% preset: wts_uniformzero_nbit_step = {'uniform_zero' nbit fbit sign}
ps.wts_uniform_zero_8_8_1 = {'uniform_zero' 8 8 1};
ps.wts_uniform_zero_8_7_1 = {'uniform_zero' 8 7 1};
ps.wts_uniform_zero_8_6_1 = {'uniform_zero' 8 6 1};
ps.wts_uniform_zero_16_14_1 = {'uniform_zero' 16 14 1};

% preset: wts_meanshifter_nbit_step = {'scale_linear' nbit}
ps.wts_scale_linear_8 = {'scale_linear' 8};
ps.wts_scale_linear_4 = {'scale_linear' 4};
ps.wts_scale_linear_3 = {'scale_linear' 3};
ps.wts_scale_linear_2 = {'scale_linear' 2};
ps.wts_scale_linear_8_float = {'scale_linear_float' 8};

% preset: wts_meanshifter_nbit_step = {'mean_shifter' nbit}
ps.wts_mean_shifter_4 = {'mean_shifter' 4};
ps.wts_mean_shifter_3 = {'mean_shifter' 3};
ps.wts_mean_shifter_2 = {'mean_shifter' 2};
ps.wts_mean_shifter_4_float = {'mean_shifter_float' 4};

% preset: act_float_scheme
ps.act_float_relu = {'float_relu'};

% preset: act_scheme_nbit_step = {'scheme' nbit fbit sign}
ps.act_leaky_8_4_1 = {'leaky' 8 4 1};
ps.act_leakz_8_4_1 = {'leakz' 8 4 1};
ps.act_relu_8_1_0 = {'relu' 8 1 0};
ps.act_relu_8_2_0 = {'relu' 8 2 0};
ps.act_relu_8_3_0 = {'relu' 8 3 0};
ps.act_relu_8_4_0 = {'relu' 8 4 0};
ps.act_relu_8_5_0 = {'relu' 8 5 0};
ps.act_relu_8_6_0 = {'relu' 8 6 0};
ps.act_relu_8_7_0 = {'relu' 8 7 0};
ps.act_relu_8_8_0 = {'relu' 8 8 0};
ps.act_relu_8_9_0 = {'relu' 8 9 0};
ps.act_relu_8_10_0 = {'relu' 8 10 0};
ps.act_relu_8_11_0 = {'relu' 8 11 0};
ps.act_relu_16_7_0 = {'relu' 16 7 0};
ps.act_relu_16_8_0 = {'relu' 16 8 0};
ps.act_relu_16_9_0 = {'relu' 16 9 0};
ps.act_relu_16_10_0 = {'relu' 16 10 0};
ps.act_relu_16_8_0 = {'relu' 16 8 0};
ps.act_lineq_9_4_1 = {'line_q' 9 4 1};
ps.act_lineq_8_9_1 = {'line_q' 8 8 1};
ps.act_lineq_8_8_1 = {'line_q' 8 8 1};
ps.act_lineq_8_7_1 = {'line_q' 8 7 1};
ps.act_lineq_8_6_1 = {'line_q' 8 6 1};
ps.act_lineq_8_5_1 = {'line_q' 8 5 1};
ps.act_lineq_8_4_1 = {'line_q' 8 4 1};
ps.act_lineq_8_3_1 = {'line_q' 8 3 1};
ps.act_lineq_9_0_1 = {'line_q' 9 0 1};
ps.act_lineq_8_0_1 = {'line_q' 8 0 1};
ps.act_linear_0_0_0 = {'linear' 0 0 0};
ps.act_relu_rs_8_7_0 = {'relu_rs' 8 7 0};
ps.act_relu_rs_8_8_0 = {'relu_rs' 8 8 0};
ps.act_relu_rs_8_9_0 = {'relu_rs' 8 9 0};
ps.act_relu_rs_8_10_0 = {'relu_rs' 8 10 0};