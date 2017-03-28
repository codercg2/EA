function [ output ] = ZDT4_F2( x )
%ZDT4_F2 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(x);
g = 1 + 10 * (n - 1) + sum(x(2:n).^2 - 10 * cos(4*pi*x(2:n)));
output = g * (1 - sqrt(x(1) / g));
end

