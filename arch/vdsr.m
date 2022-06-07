
% vdsr
architecture = { ...
    {'upsample'}; ...                                                                                                           %    0
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    1
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    2
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    3
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    4
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    5
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    6
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    7
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    8
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    9
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    10
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    11
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    12
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    13
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    14
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    15
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    16
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    17
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    18
    {'conv', 0, ps.conv_f3_p2_s1,   64,    ps.act_relu_16_8_0, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    19
    {'conv', 0, ps.conv_f3_p2_s1,    1,    ps.act_lineq_8_0_1, ps.wts_uniform_16_14_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    20
    {'res', 0, 'linear'};   
    {'sres'};
    };