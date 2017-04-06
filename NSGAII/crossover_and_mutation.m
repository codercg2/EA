function [ pop_o ] = crossover_and_mutation( pop,e,pool,eta_c )
%CROSSOVER_AND_MUTATION 此处显示有关此函数的摘要
%   此处显示详细说明
s = size(pop);

N = s(1) / 2;
n = s(2) - 4;
L = e(1,:);
U = e(2,:);

pc = 0.9;
pm = 0.05;
eta_m = 20;

k = N + 1;
while(k <= 2 * N)
    %二进制锦标赛选择
    rp = randperm(N);
    sel = floor(pool);
    rp = rp(1:sel);
    rp = sort(rp);
    
    a = rp(1);
    b = rp(2);

    if(rand() < pc)
        u = rand(1,n);
        tmp1 = u <= 0.5;
        tmp2 = tmp1 * 2 - 1;
        beta_q = power(((u - 1 + tmp1) .* tmp2 * 2),tmp2) .^ (1 / (eta_c + 1)); 

        pop(k,1:n) = 0.5 * (pop(a,1:n) .* (1 + beta_q) + pop(b,1:n) .* (1 - beta_q));
%         if(~isreal(pop))
%             error('warning');
%         end
        out_of_range = sum(pop(k,1:n) < L) || sum(pop(k,1:n) > U);
        dominate_by_parents = dominate(pop(a,:),pop(k,:)) || dominate(pop(b,:),pop(k,:));
        k = k + ~(out_of_range||dominate_by_parents);

        if(k > 2 * N)
            break;
        end
        pop(k,1:n) = 0.5 * (pop(a,1:n) .* (1 - beta_q) + pop(b,1:n) .* (1 + beta_q));
%         if(~isreal(pop))
%             error('warning');
%         end
        out_of_range = sum(pop(k,1:n) < L) || sum(pop(k,1:n) > U);
        dominate_by_parents = dominate(pop(a,:),pop(k,:)) || dominate(pop(b,:),pop(k,:));
        k = k + ~(out_of_range||dominate_by_parents);
    end
    if(rand() < pm)
        v = pop(a,1:n);
        u = max(pop(1:N,1:n));
        l = min(pop(1:N,1:n));
        r = rand(1,n);
        delta1 = (v - l)./(u - l);
        delta2 = (u - v)./(u - l);
        delta = zeros(1,n);
        b = r <= 0.5;
        delta(b) = (2 * r(b) + (1 - 2 * r(b)).*(1 - delta1(b)).^(eta_m + 1)).^(1 / (eta_m + 1)) - 1;
        b = ~b;
        delta(b) = 1 - (2*(1-r(b)) + 2 * (r(b)-0.5) .* (1-delta2(b)).^(eta_m + 1)).^(1/(eta_m + 1));
        pop(k,1:n) = v + delta .* (u - l);
        if(~isreal(pop(k,1:n)))
            error('warning');
        end
        out_of_range = sum(pop(k,1:n) < L) || sum(pop(k,1:n) > U);
        k = k + ~out_of_range;
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
pop_o = pop;
end

