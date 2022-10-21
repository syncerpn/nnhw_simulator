%SVDSR10_2x_4bw
architecture = { ...
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_7_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_7_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    1
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_7_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    2
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_7_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    3
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_8_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    4
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_9_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    5
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_9_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    6
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_10_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    7
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_11_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    8
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_linear_0_0_0, ps.wts_uniform_zero_8_7_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    9
    {'sr_flat'};
    {'lp_sres'};
};