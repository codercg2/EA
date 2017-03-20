function [ pop ] = crossover_and_mutation( pop )
%CROSSOVER_AND_MUTATION 此处显示有关此函数的摘要
%   此处显示详细说明
s = size(pop);
N = s(1) / 2;
n = s(2) - 4;
k = N + 1;
while(k <= 2 * N)
    a = randi(N);
    b = randi(N);
    while(a == b)
        b = randi(N);
    end
    c = rand() * 2 - 0.5;
    pop(k,1:n) = pop(a,1:n) * c + pop(b,1:n) * (1-c);
    k = k + 1;
end
end

