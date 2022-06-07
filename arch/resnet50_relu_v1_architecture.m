% resnet50_relu_v1
architecture = { ...
    {'conv', 1, ps.conv_f3_p2_s1,   32,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f3_p1_s2,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    1 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,   32,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    2
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    3
    {'res',  1, 'linear'};                                   															... %    4
    {'conv', 1, ps.conv_f3_p1_s2,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    5 --downsample--
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    6
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    7
    {'conv', 1, ps.conv_f1_p0_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    8
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %    9
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   10
    {'res',  7, 'linear'};                                   															... %   11
    {'conv', 1, ps.conv_f1_p0_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   12
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   13
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   14
    {'res', 11, 'linear'};                                   															... %   15
    {'conv', 1, ps.conv_f3_p1_s2,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   16 --downsample--
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   17
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   18
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   19
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   20
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   21
    {'res', 18, 'linear'};                                   															... %   22
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   23
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   24
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   25
    {'res', 22, 'linear'};                                   															... %   26
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   27
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   28
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   29
    {'res', 26, 'linear'};                                   															... %   30
    {'conv', 1, ps.conv_f3_p1_s2,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   31 --downsample--
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   32
    {'conv', 1, ps.conv_f1_p0_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   33
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   34
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   35
    {'conv', 1, ps.conv_f1_p0_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   36
    {'res', 33, 'linear'};                                   															... %   37
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   38
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   39
    {'conv', 1, ps.conv_f1_p0_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   40
    {'res', 37, 'linear'};                                   															... %   41
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   42
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   43
    {'conv', 1, ps.conv_f1_p0_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   44
    {'res', 41, 'linear'};                                   															... %   45
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   46
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   47
    {'conv', 1, ps.conv_f1_p0_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   48
    {'res', 45, 'linear'};                                   															... %   49
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   50
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   51
    {'conv', 1, ps.conv_f1_p0_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   52
    {'res', 49, 'linear'};                                   															... %   53
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   54
    {'conv', 1, ps.conv_f3_p1_s2,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   55 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1, 2048,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   56
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   57
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   58
    {'conv', 1, ps.conv_f1_p0_s1, 2048,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   59
    {'res', 56, 'linear'};                                   															... %   60
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   61
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   62
    {'conv', 1, ps.conv_f1_p0_s1, 2048,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   63
    {'res', 60, 'linear'};                                   															... %   64
    {'avgpool'};                                             															... %   65
    {'conv', 0, ps.conv_f1_p0_s1, 1000, ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_6_1, ps.biases_16_8_1}; ... %   66
    {'softmax'};                                             															... %   67
    };