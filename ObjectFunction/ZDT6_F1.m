function [ output ] = ZDT6_F1( x )
%ZDT6_F1 此处显示有关此函数的摘要
%   此处显示详细说明
output = 1 - exp(-4 * x(1)) * (sin(6 * pi * x(1))) ^ 6;
end

