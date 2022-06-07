function [fbit, sign] = hwu_auto_format(params, nbit)
for i = 1:numel(params)
    if min(params) < 0
        sign = 1;
    else
        sign = 0;
    end
end

if sign
    for i = nbit-1:-1:1
        p_max = max(params);
        p_min = min(params);
        pos_end = p_max * 2^i;
        neg_end = p_min * 2^i;
        if pos_end <= 2^(nbit-1)-1 && neg_end >= -2^(nbit-1)
            fbit = i;
            break;
        end
     end
else
    for i = nbit:-1:1
        p_max = max(params);
        pos_end = p_max * 2^i;
        if pos_end <= 2^nbit-1
            fbit = i;
            break;
        end 
    end
        
end    
