function [ I ] = crowding_distance_assignment1( I )
%CROWDING_DISTANCE_ASSIGNMENT1 此处显示有关此函数的摘要
%   此处显示详细说明
s = size(I);
len = s(1);
c = s(2);
n = c - 4;
I(:,c) = 0;
D = zeros(1,2);
for i = 1:2
    I = sortrows(I,-(n + i));
    I(1,c) = inf;
    I(len,c) = inf;
    D(i) = abs(I(len, n + i) - I(1, n + i));
    avg_d = D(i) / (len - 1) * 20;
    for j = 2:len - 1
        I(j,c) = I(j,c) - abs((abs(I(j + 1,n + i) - I(j - 1,n + i)) - avg_d));
    end
end
I = sortrows(I,-(n + 4));
end

