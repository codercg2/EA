function [ output ] = dominate( p, q )
%UNTITLED 判断p是否支配q
%   判断p是否支配q,p，q为n + 4维横向量，返回结果为true或者false
n = length(p);
if(n ~= length(q))
    error('dominate(p,q) get different dimension input arguments!');
end
n = n - 4;
output = true;
for i = 1:2
    if(p(n + i) < q(n + i))
        output = false;
        break;
    end
end
if(output == true)
    if(p(n:n+2) == q(n:n+2))
        output = false;
    end
end
end

