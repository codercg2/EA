function [ output ] = f21( x )
%f21 此处显示有关此函数的摘要
%   此处显示详细说明
output = 1 - exp(-sum((x-1/sqrt(3)).^2));
end

