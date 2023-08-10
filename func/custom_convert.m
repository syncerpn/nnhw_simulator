function t = custom_convert(z)
r = double(z(1));
g = double(z(2));
b = double(z(3));
y  =  16 +  65.738 * r / 256 + 129.057 * g / 256 +  25.064 * b / 256;
cb = 128 -  37.945 * r / 256 -  74.494 * g / 256 + 112.439 * b / 256;
cr = 128 + 112.439 * r / 256 -  94.154 * g / 256 -  18.285 * b / 256;

y = uint8(round(y));
cb = uint8(round(cb));
cr = uint8(round(cr));

t = [y, cb, cr];