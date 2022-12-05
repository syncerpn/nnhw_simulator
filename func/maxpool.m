function out = maxpool(in,f,s)
[h,w,c] = size(in);
h_o = floor((h - f) / s + 1);
w_o = floor((w - f) / s + 1);
c_o = c;

out = zeros(w_o,h_o,c_o);
for i = 1:c    
    tmph = [];
    j = 1;
    while (size(tmph, 1) < h_o)
        valid_w = min(j+f-1,w);
        
        tmpw = [];
        k = 1;
        while (size(tmpw, 2) < w_o)
            valid_h = min(k+f-1,h);
            
            field = in(j:valid_w,k:valid_h,i);
            tmpw = [tmpw max(field(:))];
            k = k+s;
        end
        tmph = [tmph; tmpw];
        j=j+s;
    end
    out(:,:,i) = tmph;
end