function [activations, activations_store] = hwu_leakz_quantize(x, step, nbit, biases_shift)
%assymmetric uniform quantization (zero included)
pos_end = 2 ^ (nbit-1) - 1;
neg_end = -pos_end - 1;

activations_store = x;
activations_store(x >= 0) = floor(x(x >= 0)/(2^biases_shift*(step)));
activations_store(x < 0) = floor(x(x < 0)/(2^(biases_shift+3)*(step)));

activations_store(activations_store > pos_end) = pos_end;
activations_store(activations_store < neg_end) = neg_end;

activations = activations_store;