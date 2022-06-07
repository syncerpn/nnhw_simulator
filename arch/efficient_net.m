architecture = { ...
    {'conv', 1, ps.conv_f3_p1_s2,   32,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    ... % block 0
    {'conv', 1, ps.conv_f3_p2_s1,   96,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    1
    {'conv', 1, ps.conv_f1_p0_s1,   24,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    2
    ... % block 1
    {'conv', 1, ps.conv_f3_p2_s1,  192,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    3
    {'conv', 1, ps.conv_f3_p1_s2,   32,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    4
    ... % block 2
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    5
    {'conv', 1, ps.conv_f1_p0_s1,   32,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    6
    {'res',  4, 'linear'};
    ... % block 3
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    8
    {'conv', 1, ps.conv_f1_p0_s2,   48,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    9
    ... % block 4
    {'conv', 1, ps.conv_f3_p2_s1,  384,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   10
    {'conv', 1, ps.conv_f1_p0_s1,   48,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   11
    {'res',  9, 'linear'};
    ... % block 5
    {'conv', 1, ps.conv_f3_p2_s1,  384,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   13
    {'conv', 1, ps.conv_f1_p0_s1,   48,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   14
    {'res',  12, 'linear'};
    ... % block 6
    {'conv', 1, ps.conv_f3_p2_s1,  384,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   16
    {'conv', 1, ps.conv_f1_p0_s1,   48,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   17
    {'res',  15, 'linear'};
    ... % block 7
    {'conv', 1, ps.conv_f1_p0_s1,  384,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   19
    {'dcnv', 1, ps.conv_f5_p3_s2,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   20
    {'conv', 1, ps.conv_f1_p0_s1,   96,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   21
    ... % block 8
    {'conv', 1, ps.conv_f1_p0_s1,  768,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   22
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   23
    {'conv', 1, ps.conv_f1_p0_s1,   96,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   24
    {'res',  21, 'linear'};
    ... % block 9
    {'conv', 1, ps.conv_f1_p0_s1,  768,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   26
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   27
    {'conv', 1, ps.conv_f1_p0_s1,   96,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   28
    {'res',  25, 'linear'};
    ... % block 10
    {'conv', 1, ps.conv_f1_p0_s1,  768,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   30
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   31
    {'conv', 1, ps.conv_f1_p0_s1,   96,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   32
    {'res',  29, 'linear'};
    ... % block 11
    {'conv', 1, ps.conv_f1_p0_s1,  768,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   34
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   35
    {'conv', 1, ps.conv_f1_p0_s1,   96,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   36
    {'res',  33, 'linear'};
    ... % block 12
    {'conv', 1, ps.conv_f1_p0_s1,  768,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   38
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   39
    {'conv', 1, ps.conv_f1_p0_s1,  144,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   40
    ... % block 13
    {'conv', 1, ps.conv_f1_p0_s1, 1152,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   41
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   42
    {'conv', 1, ps.conv_f1_p0_s1,  144,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   43
    {'res',  40, 'linear'};
    ... % block 14
    {'conv', 1, ps.conv_f1_p0_s1, 1152,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   45
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   46
    {'conv', 1, ps.conv_f1_p0_s1,  144,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   47
    {'res',  44, 'linear'};
    ... % block 15
    {'conv', 1, ps.conv_f1_p0_s1, 1152,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   49
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   50
    {'conv', 1, ps.conv_f1_p0_s1,  144,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   51
    {'res',  48, 'linear'};
    ... % block 16
    {'conv', 1, ps.conv_f1_p0_s1, 1152,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   53
    {'dcnv', 1, ps.conv_f5_p3_s2,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   54
    {'conv', 1, ps.conv_f1_p0_s1,  192,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   55
    ... % block 17
    {'conv', 1, ps.conv_f1_p0_s1, 1536,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   56
    {'dcnv', 1, ps.conv_f5_p4_s1,         ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   57
    {'conv', 1, ps.conv_f1_p0_s1,  192,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   58
    {'res',  55, 'linear'};
    ... % block 18
    {'conv', 1, ps.conv_f1_p0_s1, 1280,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   60
    {'avgpool'};                                                                                                         ... %   61
    {'conv', 0, ps.conv_f1_p0_s1, 1000, ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   62
    {'softmax'};                                                                                                         ... %   63
    };