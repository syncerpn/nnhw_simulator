function [activations, activations_store] = hwu_linear_quantize(x, step, nbit, biases_shift)

pos_end = 2 ^ (nbit-1) - 1;
neg_end = -pos_end - 1;

activations_store = round(x/(2^biases_shift*(step)));

activations_store(activations_store > pos_end) = pos_end;
activations_store(activations_store < neg_end) = neg_end;
activations = activations_store;