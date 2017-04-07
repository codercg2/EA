function [ I ] = crowding_distance_assignment( I )
%CROWDING_DISTANCE_ASSIGNMENT 此处显示有关此函数的摘要
%   此处显示详细说明
s = size(I);
len = s(1);
c = s(2);
n = c - 4;
I(:,c) = 0;
for i = 1:2
    I = sortrows(I,-(n + i));
    I(1,c) = inf;
    I(len,c) = inf;
    for j = 2:len - 1
        I(j,c) = I(j,c) + (I(j + 1,n + i) - I(j - 1,n + i)) / (I(len, n + i) - I(1, n + i));
    end
end
I = sortrows(I,-(n + 4));
end

