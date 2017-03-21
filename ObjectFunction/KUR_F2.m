function [ output ] = KUR_F2( x )
%KUR_F2 此处显示有关此函数的摘要
%   此处显示详细说明
output = sum(abs(x).^0.8 + 5 * sin(x.^3));
end

