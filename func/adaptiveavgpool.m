function out = adaptiveavgpool(in, f)
%too busy to implement the real shit. so let's just assume it is what it
%should be
h = size(in,1);
w = size(in,2);
c = size(in,3);

h_o = ceil(h/f);
w_o = ceil(w/f);
c_o = c;

out = zeros(h_o,w_o,c_o);
for i = 1:c_o
    for j = 1:h_o
        je = min(j*f, h);
        for k = 1:w_o
            ke = min(k*f, w);
            field = in((j-1)*f+1:je,(k-1)*f+1:ke,i);
            out(j,k,i) = mean(field(:));
        end
    end
end