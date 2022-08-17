input_input_channels = 1;

architecture = { ...
    {'conv', 0, ps.conv_f3_p2_s1,   64,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
    
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2a
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2b
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2c
    
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    3a
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    3b
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    3c
    
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    4a
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    4b
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    4c
    
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    5a
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    5b
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    5c
    
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    6
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    7
    
    {'sr_flat'};
    {'lp_sres'};
};