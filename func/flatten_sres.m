function [y, u] = flatten_sres(x)

[h, w, c] = size(x);

u = sqrt(c);
assert(u == floor(u)); %check if valid

y = zeros(h*u, w*u, 1);

for ih = 0:h-1
    for iw = 0:w-1
        for ic = 0:c-1
            jh = ih * u + floor(ic / u) + 1;
            jw = iw * u + mod(ic, u) + 1;
            y(jh, jw, 1) = x(ih+1, iw+1, ic+1);
        end
    end
end