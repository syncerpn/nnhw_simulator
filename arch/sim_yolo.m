%%YOLOV2
architecture = { ...
    {'conv', 1, ps.conv_f3_p2_s1,   32,  ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'maxpool', 2, 2};
    {'conv', 1, ps.conv_f3_p2_s1,   64,  ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'maxpool', 2, 2};
    {'conv', 1, ps.conv_f3_p2_s1,   128, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f1_p0_s1,   64,  ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f3_p2_s1,   128, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'maxpool', 2, 2};
    {'conv', 1, ps.conv_f3_p2_s1,   256, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f1_p0_s1,   128, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f3_p2_s1,   256, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'maxpool', 2, 2};
    {'conv', 1, ps.conv_f3_p2_s1,   512, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f1_p0_s1,   256, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f3_p2_s1,   512, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f1_p0_s1,   256, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f3_p2_s1,   512, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'maxpool', 2, 2};
    {'conv', 1, ps.conv_f3_p2_s1,  1024, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f1_p0_s1,   512, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f3_p2_s1,  1024, ps.act_leaky_8_4_1, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'conv', 0, ps.conv_f1_p0_s1,   125,ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_10_1, ps.biases_16_8_1}; ... %    0
    {'yolo', [1.3221, 1.73145, 3.19275, 4.00944, 5.05587, 8.09892, 9.47112, 4.84053, 11.2364, 10.0071]*32}
};

cutpoint = 8+1;