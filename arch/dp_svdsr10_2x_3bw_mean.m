%SVDSR10_2x_4bw
architecture = { ...
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_7_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_5_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    1
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_6_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    2
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_4_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    3
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_5_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    4
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_3_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    5
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_5_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    6
    {'dcnv', 0, ps.conv_f3_p2_s1,	    ps.act_lineq_8_4_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    7
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_5_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    8
    {'dcnv', 0, ps.conv_f3_p2_s1,	    ps.act_lineq_8_4_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    9
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_6_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    10
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_5_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    11
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_7_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    12
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_6_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    13
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_8_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    14
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_6_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    15
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_9_0, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    16
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_lineq_8_9_1, ps.wts_mean_shifter_3, ps.scales_16_10_1, ps.biases_16_8_1}; ... %  17
    {'sr_flat'};
    {'lp_sres'};
};