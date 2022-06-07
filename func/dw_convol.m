function out = dw_convol(img,kernel,s,p)
h = size(img,1);
w = size(img,2);
c = size(img,3);
pad_img = zeros(h+p,w+p,c);
st_p = ceil(p/2);
pad_img(1+st_p:st_p+h,1+st_p:st_p+w,:) = img;

f = size(kernel,1);
c_out = size(kernel,3);

w_out = floor((w - f + p) / s + 1);
h_out = floor((h - f + p) / s + 1);

out = zeros(h_out,w_out,c_out);

for i = 1:h_out
    for j = 1:w_out
        scalar = kernel .* pad_img(1+(i-1)*s:1+(i-1)*s+f-1, 1+(j-1)*s:1+(j-1)*s+f-1, :);
        out(i,j,:) = sum(sum(scalar));
    end
end