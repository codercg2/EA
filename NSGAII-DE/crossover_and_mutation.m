function [ pop ] = crossover_and_mutation( pop,e,F1,F2,F,cr )
%CROSSOVER_AND_MUTATION 此处显示有关此函数的摘要
%   此处显示详细说明
s = size(pop);

N = s(1) / 2;
n = s(2) - 4;
L = e(1,:);
U = e(2,:);

k = N + 1;
failtimes = 0;      %找到一个新的个体的失败次数
while(k <= 2 * N)
    rp = randperm(N);
    rp = rp(1:3);
    
    a = rp(1);
    b = rp(2);
    c = rp(3);
    
    H = pop(a,:) + F * (pop(b,:) - pop(c,:)); 

    b = rand(1,n + 4) < cr;
    V = pop(a,:);
    V(b) = H(b);
    pop(k,1:n) = V(1:n);
    out_of_range = sum(pop(k,1:n) < L) || sum(pop(k,1:n) > U);
    if(out_of_range)
        continue;
    end
    pop(k,n + 1) = -F1(pop(k,1:n));
    pop(k,n + 2) = -F2(pop(k,1:n));
    if(dominate(pop(a,:),pop(k,:)))
        continue;
    end
    k = k + 1;
    if(k > 2 * N)
        break;
    end
end
end

