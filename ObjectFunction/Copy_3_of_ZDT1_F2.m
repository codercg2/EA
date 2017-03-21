function [ output ] = ZDT1_F2( x )
%ZDT1_F2 此处显示有关此函数的摘要
%   此处显示详细说明
n = length(x);
g = 1 + 9 * sum(x(2:n)) / (n - 1);
output = g * (1 - sqrt(x(1) / g));
end

