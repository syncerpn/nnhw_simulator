function out = softmax(x)
ex = exp(x);
out = ex ./ sum(ex(:));