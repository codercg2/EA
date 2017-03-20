function [ output ] = f31( x )
%f31 此处显示有关此函数的摘要
%   此处显示详细说明
A1 = 0.5 * sin(1) - 2 * cos(1) + sin(2) - 1.5 * cos(2);
A2 = 1.5 * sin(1) - cos(1) + 2 * sin(2) - 0.5 * cos(2);
B1 = 0.5 * sin(x(1)) - 2 * cos(x(1)) + sin(x(2)) - 1.5 * cos(x(2));
B2 = 1.5 * sin(x(1)) - cos(x(1)) + 2 * sin(x(2)) - 0.5 * cos(x(2));
output = 1 + (A1 - B1)^2 + (A2 - B2)^2;
end

