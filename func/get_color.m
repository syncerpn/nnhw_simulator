function r = get_color(base_color, c, this_class, num_class)

offset = mod((this_class-1)*123457,num_class);
ratio = (offset)/num_class * 5;
i = floor(ratio);
j = ceil(ratio);
ratio = ratio - i;
r = (1-ratio) * base_color(i+1,c) + ratio * base_color(j+1,c);