
% yolov3_relu
architecture = { ...
    {'conv', 1, ps.conv_f3_p2_s1,   32,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    0
    {'conv', 1, ps.conv_f3_p1_s2,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    1 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,   32,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    2
    {'conv', 1, ps.conv_f3_p2_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    3
    {'res',  1, 'linear'};                                   			 												  ... %    4
    {'conv', 1, ps.conv_f3_p1_s2,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    5 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    6
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    7
    {'res',  5, 'linear'};                                   			 												  ... %    8
    {'conv', 1, ps.conv_f1_p0_s1,   64,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %    9
    {'conv', 1, ps.conv_f3_p2_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   10
    {'res',  8, 'linear'};                                   			 												  ... %   11
    {'conv', 1, ps.conv_f3_p1_s2,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   12 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   13
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   14
    {'res', 12, 'linear'};                                   			 												  ... %   15
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   16
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   17
    {'res', 15, 'linear'};                                             												  ... %   18
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   19
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   20
    {'res', 18, 'linear'};                                             												  ... %   21
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   22
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   23
    {'res', 21, 'linear'};                                             												  ... %   24
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   25
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   26
    {'res', 24, 'linear'};                                             												  ... %   27
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   28
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   29
    {'res', 27, 'linear'};                                             												  ... %   30
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   31
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   32
    {'res', 30, 'linear'};                                             												  ... %   33
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   34
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   35
    {'res', 33, 'linear'};                                             												  ... %   36
    {'conv', 1, ps.conv_f3_p1_s2,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   37 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   38
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   39
    {'res', 37, 'linear'};                                             												  ... %   40
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   41
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   42
    {'res', 40, 'linear'};                                             												  ... %   43
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   44
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   45
    {'res', 43, 'linear'};                                             												  ... %   46
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   47
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   48
    {'res', 46, 'linear'};                                             												  ... %   49
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   50
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   51
    {'res', 49, 'linear'};                                             												  ... %   52
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   53
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   54
    {'res', 52, 'linear'};                                             												  ... %   55
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   56
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   57
    {'res', 55, 'linear'};                                             												  ... %   58
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   59
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   60
    {'res', 58, 'linear'};                                             												  ... %   61
    {'conv', 1, ps.conv_f3_p1_s2, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   62 --downsample--
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   63
    {'conv', 1, ps.conv_f3_p2_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   64
    {'res', 62, 'linear'};                                             												  ... %   65
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   66
    {'conv', 1, ps.conv_f3_p2_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   67
    {'res', 65, 'linear'};                                             												  ... %   68
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   69
    {'conv', 1, ps.conv_f3_p2_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   70
    {'res', 68, 'linear'};                                             												  ... %   71
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   72
    {'conv', 1, ps.conv_f3_p2_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   73
    {'res', 71, 'linear'};                                             												  ... %   74
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   75
    {'conv', 1, ps.conv_f3_p2_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   76
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   77
    {'conv', 1, ps.conv_f3_p2_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   78
    {'conv', 1, ps.conv_f1_p0_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   79
    {'conv', 1, ps.conv_f3_p2_s1, 1024,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   80
    {'conv', 0, ps.conv_f1_p0_s1,  255, ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   81
    {'yolo', [116,  90, 156, 198, 373, 326]};                															  ... %   82
    {'route',  79};                                          															  ... %   83
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   84
    {'upsample'};                                            															  ... %   85
    {'route',  85,  61};                                     															  ... %   86
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   87
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   88
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   89
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   90
    {'conv', 1, ps.conv_f1_p0_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   91
    {'conv', 1, ps.conv_f3_p2_s1,  512,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   92
    {'conv', 0, ps.conv_f1_p0_s1,  255, ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   93
    {'yolo', [ 30,  61,  62,  45,  59, 119]};                															  ... %   94
    {'route',  91};                                          															  ... %   95
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   96
    {'upsample'};                                            															  ... %   97
    {'route',  97,  36};                                     															  ... %   98
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %   99
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %  100
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %  101
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %  102
    {'conv', 1, ps.conv_f1_p0_s1,  128,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %  103
    {'conv', 1, ps.conv_f3_p2_s1,  256,   ps.act_relu_8_4_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %  104
    {'conv', 0, ps.conv_f1_p0_s1,  255, ps.act_linear_0_0_0, ps.wts_uniform_8_8_1, ps.scales_16_4_1, ps.biases_16_8_1}; ... %  105
    {'yolo', [ 10,  13,  16,  30,  33,  23]};                															  ... %  106
    };