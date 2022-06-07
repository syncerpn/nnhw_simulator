function output = shortcut_compute(input, add)
[hi, wi, ci] = size(input);
[ha, wa, ca] = size(add);

output = input;
minh = min(hi, ha);
minw = min(wi, wa);
minc = min(ci, ca);

stride = wa/wi;
sample = wi/wa;
assert(stride == ha/hi);
assert(sample == hi/ha);

if stride < 1
    stride = 1;
end

if sample < 1
    sample = 1;
end

for ic = 1:minc
    for iw = 1:minw
        for ih = 1:minh
            output((ih-1)*sample+1, (iw-1)*sample+1, ic) = ...
            output((ih-1)*sample+1, (iw-1)*sample+1, ic) + add((ih-1)*stride+1, (iw-1)*stride+1, ic);
        end
    end
end