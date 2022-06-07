function [output, scale_factor] = mean_shifter_quantize(x,n_out_channel,n_coeff)

q_coeff = -[0:n_coeff-1];
nx = numel(x);
nx_per_channel = nx / n_out_channel;

scale_factor = zeros(n_out_channel,1);

output = zeros(numel(x),1);

for i = 1:n_out_channel
    cur_channel = x((i-1)*nx_per_channel+1:i*nx_per_channel);

    cur_mean = mean(abs(cur_channel(:)));
    scale_factor(i) = cur_mean;
    
    for j = 1:nx_per_channel
        if cur_channel(j) > 0
            expo_factor = round(log2(cur_channel(j) / cur_mean));
            if (expo_factor > q_coeff(1))
                expo_factor = q_coeff(1);
            elseif (expo_factor < q_coeff(end))
                expo_factor = q_coeff(n_coeff);
            end
            output((i-1)*nx_per_channel+j) = 2^expo_factor / 2^q_coeff(end);
        else
            expo_factor = round(log2(-cur_channel(j) / cur_mean));
            if (expo_factor > q_coeff(1))
                expo_factor = q_coeff(1);
            elseif (expo_factor < q_coeff(end))
                expo_factor = q_coeff(n_coeff);
            end
            output((i-1)*nx_per_channel+j) = -2^expo_factor / 2^q_coeff(end);
        end
    end
end