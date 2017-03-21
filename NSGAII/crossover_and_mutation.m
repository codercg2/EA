function [ pop ] = crossover_and_mutation( pop,e )
%CROSSOVER_AND_MUTATION 此处显示有关此函数的摘要
%   此处显示详细说明
s = size(pop);

N = s(1) / 2;
n = s(2) - 4;
L = e(1);
U = e(2);

k = N + 1;
while(k <= 2 * N)
    a = randi(N);
    b = randi(N);
    while(a == b)
        b = randi(N);
    end
    c = rand() * 2 - 0.5;
    pop(k,1:n) = pop(a,1:n) * c + pop(b,1:n) * (1-c);
    tmp = 0;
    while(true)
        tmp = tmp + 1;
        out_of_range = sum(pop(k,1:n) < L) || sum(pop(k,1:n) > U);
        dominate_by_parents = dominate(pop(a,:),pop(k,:)) && dominate(pop(b,:),pop(k,:));
        if(tmp > 100)
            break;
        end
        if(~(out_of_range || dominate_by_parents))
            break;
        end
        c = rand(1,n) * 2 - 0.5;
        pop(k,1:n) = pop(a,1:n) .* c + pop(b,1:n) .* (1-c);        
    end    
    if(tmp > 100)
        continue;
    end
    k = k + 1;
end
end

