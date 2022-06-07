function percentage = iou(a, b)
l1 = a(3) - a(5)/2;
l2 = b(3) - b(5)/2;
if l1 > l2
    left = l1;
else
    left = l2;
end

r1 = a(3) + a(5)/2;
r2 = b(3) + b(5)/2;
if r1 < r2
    right = r1;
else
    right = r2;
end

t1 = a(4) - a(6)/2;
t2 = b(4) - b(6)/2;
if t1 > t2
    top = t1;
else
    top = t2;
end

b1 = a(4) + a(6)/2;
b2 = b(4) + b(6)/2;
if b1 < b2
    bottom = b1;
else
    bottom = b2;
end

intersection = (bottom - top) * (right - left);
union = a(5) * a(6) + b(5) * b(6) - intersection;
percentage = intersection/union;