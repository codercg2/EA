function [ output ] = fun1( X )
%FUN1 计算向量X的目标函数值
%  X 为1 x n 维向量
n = length(X);
result = 1;
for i=1:n
    sum = 0;
    for j=1:5
        c = j * cos((j+1)*X(i) + j);
        sum = sum + c;        
    end
    result = result * sum;
end
output = result;
end

