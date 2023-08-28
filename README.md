# nnhw_simulator
 neural network asic/fpga simulation

## flow
0. network architecture specification
1. input image quantization + constraining
2. network params quantization + constraining

## important func list
0. hwu_parse_input_channels
1. hwu_parse_and_create_buffer
2. hwu_calculate_bit_shift
3. create_yolo_input

### hwu_parse_input_channels
auto calculate the number of channels of input tensor fed into each layer

### hwu_parse_and_create_buffer
analyze branching in the network and create variables that hold specific layers' outputs

### hwu_calculate_bit_shift
auto calculate the number of bits (integer + fractional part) for fixed-point numbers

### create_yolo_input
load and pre-process input image

## CONV (@) ops modified formula

output = scale * (input @ weight) + bias
y = s * (x @ w) + b

for normal conv, scale = 1

scale will be more meaningful with quantization and/or batch normalization

## quantization scheme for weights
0. uniform_quantize
1. scale_linear_quantize
2. mean_shifter_quantize

## fixed-point bit calculation

before adding two fixed-point numbers, make sure they have the same number of fractional bits

c = si.sf * xi.xf * wi.wf

y = ci.cf + bi.bf

bit shift for c is xf + wf + sf - cf, meaning that you need to remove this number of bits
from the intermediate result before adding with bias

1.0 * 3.5 * 1.5 = 5.25