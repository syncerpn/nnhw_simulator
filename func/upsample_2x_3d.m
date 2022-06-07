function output = upsample_2x_3d(input)

[h, w, c] = size(input);

output = zeros(2*h, 2*w, c);
for i = 1:c
    output(:,:,i) = kron(input(:,:,i), ones(2));
end