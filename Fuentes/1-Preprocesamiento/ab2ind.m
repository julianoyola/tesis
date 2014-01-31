function [ia, ib] = ab2ind(a, b)

lo_a = -100;
lo_b = -100;
hi_a = 100;
hi_b = 100;

Ma = hi_a - lo_a + 1;
Mb = hi_b - lo_b + 1;

% -100 -> 0
% 100 -> 200/201 < 1
normalized_a = (a - lo_a) / Ma;
normalized_b = (b - lo_b) / Mb;

% 0 -> 1
% casi 1 ->  casi 200 -> 200 -> 201
ia = round(normalized_a * (Ma-1)) + 1;
ib = round(normalized_b * (Mb-1)) + 1;

end