input_input_channels = 1;

architecture = { ...
    {'conv', 0, ps.conv_f3_p2_s1,   48,  ps.act_relu_8_7_0, ps.wts_uniform_8_6_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
    {'conv', 0, ps.conv_f1_p0_s1,   24,  ps.act_relu_8_7_0, ps.wts_uniform_8_7_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_relu_8_7_0, ps.wts_uniform_8_7_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
    {'conv', 0, ps.conv_f3_p2_s1,   24,  ps.act_relu_8_7_0, ps.wts_uniform_8_6_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    3
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_relu_8_7_0, ps.wts_uniform_8_7_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    4
    {'conv', 0, ps.conv_f3_p2_s1,   24,  ps.act_relu_8_7_0, ps.wts_uniform_8_7_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    5
    {'conv', 0, ps.conv_f1_p0_s1,   48,  ps.act_relu_8_7_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    6
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_lineq_8_8_1, ps.wts_uniform_8_6_1, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    7
    {'sr_flat'};
    {'lp_sres'};
};

% architecture = { ...
%     {'conv', 0, ps.conv_f3_p2_s1,   48,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
%     {'conv', 0, ps.conv_f1_p0_s1,   24,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
%     {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2
%     {'conv', 0, ps.conv_f3_p2_s1,   24,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    3
%     {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    4
%     {'conv', 0, ps.conv_f3_p2_s1,   24,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    5
%     {'conv', 0, ps.conv_f1_p0_s1,   48,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    6
%     {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    7
%     {'sr_flat'};
%     {'lp_sres'};
% };