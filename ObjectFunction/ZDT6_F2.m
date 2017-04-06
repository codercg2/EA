function [ output ] = ZDT6_F2( x )
%ZDT6_F2 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(x);
g = 1 + 9 * (sum(x(2:n)) / (n - 1)) ^ 0.25;
output = g * (1 - (ZDT6_F1(x) / g) ^ 2);
end

