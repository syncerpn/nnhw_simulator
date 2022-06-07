function class_list = parse_class_name_file(file)

fid = fopen(file, 'r');
line = fgetl(fid);

class_list = {};

while(line ~= -1)
    class_list = [class_list line];
    line = fgetl(fid);
end

end