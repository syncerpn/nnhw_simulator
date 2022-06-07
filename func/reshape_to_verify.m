function all_kerns = reshape_to_verify(x, h,w,c,n)
assert(h*w*c*n == numel(x), 'Number of elements mismatched!');
all_kerns = cell(c, 1);

y = reshape(x, [h,w,c,n]);

for ic = 1:c
    for ih = 1:h
        for iw = 1:w
            tmp = y(ih,iw,ic,:);
            all_kerns{ic,1} = [all_kerns{ic,1}; tmp(:)'];
        end
    end
end