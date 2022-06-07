%mix version
% agents_arch = {{}, ...
%     { ... %agent 1
%     {'conv', 0, ps.conv_f1_p0_s1,    4,   ps.act_relu_8_4_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     }, ...
%     { ... %agent 2
%     {'conv', 0, ps.conv_f1_p0_s1,    4,   ps.act_relu_8_6_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,   ps.act_relu_8_3_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 3
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_6_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_relu_8_3_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 4
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_6_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_relu_8_4_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 5
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_6_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_relu_8_4_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 6
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_5_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     {}, {}, {}, ...
% };
%mix version
% agents_arch = {{}, ...
%     { ... %agent 1
%     {'conv', 0, ps.conv_f1_p0_s1,    4,   ps.act_relu_8_3_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     }, ...
%     { ... %agent 2
%     {'conv', 0, ps.conv_f1_p0_s1,    4,   ps.act_relu_8_5_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,   ps.act_relu_8_3_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 3
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_5_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_relu_8_3_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 4
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_5_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_relu_8_4_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 5
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_5_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_relu_8_4_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    1
%     {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     { ... %agent 6
%     {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_relu_8_4_0, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    0
%     {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_lineq_8_8_1, ps.wts_scale_linear_8, ps.scales_16_6_1, ps.biases_16_6_1}; ... %    2
%     }, ...
%     {}, {}, {}, ...
% };
%float version
agents_arch = {{}, ...
    { ... %agent 1
    {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
    }, ...
    { ... %agent 2
    {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2
    }, ...
    { ... %agent 3
    {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2
    }, ...
    { ... %agent 4
    {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2
    }, ...
    { ... %agent 5
    {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    {'conv', 0, ps.conv_f3_p2_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
    {'conv', 0, ps.conv_f1_p0_s1,   32,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2
    }, ...
    { ... %agent 6
    {'conv', 0, ps.conv_f1_p0_s1,    4,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    {'conv', 0, ps.conv_f1_p0_s1,   64,  ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2
    }, ...
    {}, {}, {}, ...
};