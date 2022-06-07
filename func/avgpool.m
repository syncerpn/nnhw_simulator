function out = avgpool(in)
h = size(in,1);
w = size(in,2);
c = size(in,3);
h_o = 1;
w_o = 1;
c_o = c;

out = zeros(h_o,w_o,c_o);
for i = 1:c
    field = in(:,:,i);
    out(:,:,i) = floor(sum(field(:)) / (w*h));
end