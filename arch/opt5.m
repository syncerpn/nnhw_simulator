
% 
% self.last_partS = nn.Conv2d(d, num_channels*4, kernel_size=5, stride=1, padding=5//2)
% self.up = nn.Upsample(scale_factor = scale_factor, mode='nearest')
% 
% self.ps = nn.PixelShuffle(2)

architecture = { ...
    % self.first_part = nn.Sequential(
    %     nn.Conv2d(num_channels, d, kernel_size=3, padding=3//2),
    %     nn.ReLU(d)
    % )
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    0
    %x here
    
    % self.mid_partS = [nn.Conv2d(d, s, kernel_size=1), nn.ReLU(s)]
    % for _ in range(m):
    %     self.mid_partS.extend([nn.Conv2d(s , s, kernel_size=3, padding=3//2), nn.ReLU(s)])
    %     self.mid_partS.extend([nn.Conv2d(s, d, kernel_size=1), nn.ReLU(d)])
    % self.mid_partS = nn.Sequential(*self.mid_partS)
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    1
    
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    2
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    3
    
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    4
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    5
    
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    6
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    7
    
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    8
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    9
    
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    10
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    11
    
    {'conv', 0, ps.conv_f3_p2_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    12
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    13
    %x_mid here
    
    %concat x, x_mid, input
    {'route', 0, 13, -1}
    
    % self.sq_partS = [nn.Conv2d(s + s + 1 , s, kernel_size=1), nn.ReLU(s)]
    % self.sq_partS = nn.Sequential(*self.sq_partS)
    {'conv', 0, ps.conv_f1_p0_s1,   16,  ps.act_float_relu, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    15
    
    % self.last_partS = nn.Conv2d(s, num_channels*4, kernel_size=5, stride=1, padding=5//2)
    {'conv', 0, ps.conv_f5_p4_s1,   4, ps.act_linear_0_0_0, ps.wts_none, ps.scales_float, ps.biases_float}; ... %    16
    {'sr_flat'};
    {'sres'};
};