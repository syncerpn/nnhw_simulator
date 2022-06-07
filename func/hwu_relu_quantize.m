function [activations, activations_store] = hwu_relu_quantize(x, step, nbit, biases_shift)

pos_end = 2 ^ nbit - 1;

activations_store = x;
activations_store(x >= 0) = round(x(x >= 0)/(2^biases_shift*(step)));
activations_store(x < 0) = 0;

activations_store(activations_store > pos_end) = pos_end;
activations = activations_store;