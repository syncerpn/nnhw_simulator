function out = maxpool(in,f,s)
w = size(in,1);
h = size(in,2);
c = size(in,3);
w_o = ceil(w/s);
h_o = ceil(h/s);
c_o = c;

out = zeros(w_o,h_o,c_o);
for i = 1:c
    tmph = [];
    j = 1;
    while (j <= w)
        valid_w = min(j+f-1,w);
        
        tmpw = [];
        k = 1;
        while (k <= h)
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