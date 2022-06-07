% resnet50_relu
architecture = { ...
    {'conv', 1, ps.conv_f7_p5_s2,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    0 --downsample--
    {'maxpool', 2, 2};                                       															... %    1 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    2
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    3
    {'conv', 1, ps.conv_f1_p0_s1,  256,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    4
    {'res',  1,   'relu'};                                   															... %    5
    {'conv', 1, ps.conv_f1_p0_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    6
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    7
    {'conv', 1, ps.conv_f1_p0_s1,  256,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    8
    {'res',  5,   'relu'};                                   															... %    9
    {'conv', 1, ps.conv_f1_p0_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   10
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   11
    {'conv', 1, ps.conv_f1_p0_s1,  256,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   12
    {'res',  9,   'relu'};                                   															... %   13
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   14
    {'conv', 1, ps.conv_f3_p1_s2,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   15 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   16
    {'res', 13,   'relu'};                                   															... %   17
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   18
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   19
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   20
    {'res', 17,   'relu'};                                   															... %   21
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   22
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   23
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   24
    {'res', 21,   'relu'};                                   															... %   25
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   26
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   27
    {'conv', 1, ps.conv_f1_p0_s1,  512,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   28
    {'res', 25,   'relu'};                                   															... %   29
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   30
    {'conv', 1, ps.conv_f3_p1_s2,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   31 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   32
    {'res', 29,   'relu'};                                   															... %   33
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   34
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   35
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   36
    {'res', 33,   'relu'};                                   															... %   37
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   38
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   39
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   40
    {'res', 37,   'relu'};                                   															... %   41
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   42
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   43
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   44
    {'res', 41,   'relu'};                                   															... %   45
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   46
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   47
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   48
    {'res', 45,   'relu'};                                   															... %   49
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   50
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   51
    {'conv', 1, ps.conv_f1_p0_s1, 1024,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   52
    {'res', 49,   'relu'};                                   															... %   53
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   54
    {'conv', 1, ps.conv_f3_p1_s2,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   55 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1, 2048,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   56
    {'res', 53,   'relu'};                                   															... %   57
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   58
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   59
    {'conv', 1, ps.conv_f1_p0_s1, 2048,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   60
    {'res', 57,   'relu'};                                   															... %   61
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   62
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   63
    {'conv', 1, ps.conv_f1_p0_s1, 2048,  ps.act_lineq_9_4_1, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   64
    {'res', 61,   'relu'};                                   															... %   65
    {'avgpool'};                                             															... %   66
    {'conv', 0, ps.conv_f1_p0_s1, 1000, ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   67
    {'softmax'};                                             															... %   68
    };