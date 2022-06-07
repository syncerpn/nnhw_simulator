function [out, out_string] = quantize_and_constrain2(in, nbit, ibit, sign, do_write_to_file, type)
qfactor = 2^(nbit-ibit);
nfactor = 2^nbit;

if sign
%     assert(ibit >= 1, 'ibit should be at least 1 if output is signed');
    max = nfactor/2 - 1;
    min = max - nfactor + 1;
else
    max = nfactor - 1;
    min = 0;
end

out = (round(in * qfactor)); %20200109: change from floor to round to match syndn framework implementation
out(out > max) = max;
out(out < min) = min;

out_string = [];

if (do_write_to_file)
    switch(type)
        case 1
            tmp = out';
            out_string = tmp(:);
        case 2
            tmp = out';
            out_string = tmp(:);
        case 3
            rp_out = out';
            for i = 1:numel(rp_out)
                if (sign && (rp_out(i) < 0))
                    rp_out(i) = nfactor + rp_out(i);
                end
                out_string = [out_string; dec2hex(rp_out(i),ceil(nbit/4))];
            end
    end
end