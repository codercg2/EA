function [ output ] = KUR_F1( x )
%KUR_F1 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(x);
s = 0;
for i = 1:n-1
    s = s - 10 * exp(-0.2 * sqrt(x(i)^2 + x(i + 1)^2));
end
output = s;
end

