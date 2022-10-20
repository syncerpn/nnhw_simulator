function [output, output_store] = uniform_zero_quantize(x,step,nbit)

pos_end = 2 ^ (nbit - 1) - 1;
neg_end = -2 ^ (nbit - 1);

output = round(x ./ step);
output(output > pos_end) = pos_end;
output(output < neg_end) = neg_end;

output_store = output;