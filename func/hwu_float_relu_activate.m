function output = hwu_float_relu_activate(x)
output = x;
output(output < 0) = 0;