function [ pop ] = crossover_and_mutation( pop,e )
%CROSSOVER_AND_MUTATION 此处显示有关此函数的摘要
%   此处显示详细说明
s = size(pop);

N = s(1) / 2;
n = s(2) - 4;
L = e(1);
U = e(2);

pc = 0.9;
pm = 0.05;
eta_c = 20;
eta_m = 20;

k = N + 1;
while(k <= 2 * N)
    if(rand() < pc)
        u = rand(1,n);
        tmp1 = u <= 0.5;
        tmp2 = tmp1 * 2 - 1;
        beta_q = (((u - 1 + tmp1) * tmp2 * 2) .^ tmp2) ^ (1 / (eta_c + 1)); 
        pop(k,1:n) = 0.5 * (pop(a,1:n) .* (1 + beta_q) + pop(b,1:n) .* (1 - beta_q));
        pop(k + 1,1:n) = 0.5 * (pop(a,1:n) .* (1 - beta_q) + pop(b,1:n) .* (1 + beta_q));
        k = k + 2;
    end
%     tmp = 0;
%     while(true)
%         tmp = tmp + 1;
%         out_of_range = sum(pop(k,1:n) < L) || sum(pop(k,1:n) > U);
%         dominate_by_parents = dominate(pop(a,:),pop(k,:)) && dominate(pop(b,:),pop(k,:));
%         if(tmp > 100)
%             break;
%         end
%         if(~(out_of_range || dominate_by_parents))
%             break;
%         end
%         c = rand(1,n) * 2 - 0.5;
%         pop(k,1:n) = pop(a,1:n) .* c + pop(b,1:n) .* (1-c);        
%     end    
%     if(tmp > 100)
%         continue;
%     end

end
end

