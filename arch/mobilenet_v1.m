architecture = { ...
    {'conv', 1, ps.conv_f3_p1_s2,   32,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0 --downsample--
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    1
    {'conv', 1, ps.conv_f1_p0_s1,   64,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    2
    {'dcnv', 1, ps.conv_f3_p1_s2,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    3 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,  128,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    4
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    5
    {'conv', 1, ps.conv_f1_p0_s1,  128,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    6
    {'dcnv', 1, ps.conv_f3_p1_s2,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    7 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,  256,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    8
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    9
    {'conv', 1, ps.conv_f1_p0_s1,  256,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   10
    {'dcnv', 1, ps.conv_f3_p1_s2,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   11 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   12
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   13
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   14
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   15
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   16
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   17
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   18
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   19
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   20
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   21
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   22
    {'dcnv', 1, ps.conv_f3_p1_s2,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   23 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   24
    {'dcnv', 1, ps.conv_f3_p2_s1,        ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   25
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_leakz_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   26
    {'avgpool'};                                                                                                         ... %   27
    {'conv', 0, ps.conv_f1_p0_s1, 1000, ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %   28
    {'softmax'};                                                                                                         ... %   29
    };