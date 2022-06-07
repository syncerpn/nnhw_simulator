function [output, output_store] = uniform_quantize(x,step,nbit)

pos_end = 2 ^ nbit - 1;
neg_end = -pos_end;

output = 2 * round(x./step + 0.5) - 1;
output(output > pos_end) = pos_end;
output(output < neg_end) = neg_end;

output_store = (output - 1) / 2;