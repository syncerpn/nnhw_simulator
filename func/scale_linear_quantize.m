function [output, scale_factor] = scale_linear_quantize(x,n_out_channel,n_coeff)

nx = numel(x);
nx_per_channel = nx / n_out_channel;

scale_factor = zeros(n_out_channel,1);

output = zeros(numel(x),1);

for i = 1:n_out_channel
    cur_channel = x((i-1)*nx_per_channel+1:i*nx_per_channel);

    cur_max = max(abs(cur_channel(:)));
    scale_factor(i) = cur_max;
    
    for j = 1:nx_per_channel
        if cur_channel(j) > 0
            qtz_value = round(cur_channel(j) / cur_max * n_coeff + 0.5) - 0.5;
            if (qtz_value < 0.5)
                qtz_value = 0.5;
            elseif (qtz_value > n_coeff-0.5)
                qtz_value = n_coeff-0.5;
            end
            output((i-1)*nx_per_channel+j) = qtz_value*2;
        else
            qtz_value = round(-cur_channel(j) / cur_max * n_coeff + 0.5) - 0.5;
            if (qtz_value < 0.5)
                qtz_value = 0.5;
            elseif (qtz_value > n_coeff-0.5)
                qtz_value = n_coeff-0.5;
            end
            output((i-1)*nx_per_channel+j) = -qtz_value*2;
        end
    end
end