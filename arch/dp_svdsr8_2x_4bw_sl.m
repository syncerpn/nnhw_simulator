% %SVDSR10_2x_4bw
architecture = { ...
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_relu_8_7_0, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    0
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_5_1, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    1
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_6_0, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    2
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_5_1, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    3
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_6_0, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    4
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_4_1, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    5
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_5_0, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    6
    {'dcnv', 0, ps.conv_f3_p2_s1,	    ps.act_lineq_8_4_1, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    7
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_5_0, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    8
    {'dcnv', 0, ps.conv_f3_p2_s1,	    ps.act_lineq_8_5_1, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    9
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_6_0, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    10
    {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_lineq_8_6_1, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    11
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_relu_8_9_0, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    12    
    {'conv', 0, ps.conv_f3_p2_s1,    4, ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_1_1, ps.biases_16_8_1}; ... %    13
    {'sr_flat'};
    {'lp_sres'};
};

%SVDSR10_2x_4bw
% architecture = { ...
%     {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_float_relu, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    0
%     {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_linear_0_0_0, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    1
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_float_relu, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    2
%     {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_linear_0_0_0, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    3
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_float_relu, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    4
%     {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_linear_0_0_0, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    5
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_float_relu, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    6
%     {'dcnv', 0, ps.conv_f3_p2_s1,	    ps.act_linear_0_0_0, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    7
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_float_relu, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    8
%     {'dcnv', 0, ps.conv_f3_p2_s1,	    ps.act_linear_0_0_0, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    9
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_float_relu, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    10
%     {'dcnv', 0, ps.conv_f3_p2_s1,       ps.act_linear_0_0_0, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    11
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_float_relu, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    12    
%     {'conv', 0, ps.conv_f3_p2_s1,    4, ps.act_linear_0_0_0, ps.wts_scale_linear_8_float, ps.scales_float, ps.biases_float}; ... %    13
%     {'sr_flat'};
%     {'lp_sres'};
% };