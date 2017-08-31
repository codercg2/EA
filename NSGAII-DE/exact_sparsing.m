function [ pop ] = exact_sparsing( popExt,newSize )
%exact_sparsing 精确稀疏化个体数量到newSize个
%   此处显示详细说明
save('matlab.mat');
s = size(popExt);
extSize = s(1);
n = s(2) - 4;
if(extSize <= newSize)
    pop = popExt;
    warning('newSize is not smaller than popExt lenght.');
    return;
end

popExt = sortrows(popExt,n + 1);
d = sqrt(sum((popExt(2:extSize,n+1:n+2) - popExt(1:extSize - 1,n+1:n+2)).^2,2));
d_mean = mean(d);
d_std = sqrt(var(d));
abnormal = find(d >= d_mean + 12 * d_std, 1);
%如果有异常值，则使用3倍标准差，没有异常值，则使用9倍标准差
if(~isempty(abnormal))
    d_sel = d(d < d_mean + 3 * d_std);
else
    d_sel = d(d < d_mean + 9 * d_std);
end
k = length(d) - length(d_sel);
last_popSize = newSize;
while(true)
    %k代表数值过大的距离的数目，也代表曲线断开的缺口个数，k + 1 代表曲线段数，每段曲线上点数比
    %距离数多1，则 k + 1 段曲线多出 k + 1 个点， newSize个点对应newSize - k - 1 段距离
    d_avg = sum(d_sel) /(newSize - k - 1);
    s = 0;
    j = 2;
    i = 1;
    pop = zeros(newSize * 2,n + 4);
    pop(1,:) = popExt(1,:); %边界点
    while(i < extSize)
        s1 = s + d(i);
        if(d_avg <= s || (s <= d_avg && d_avg <= s1))
            dd = d_avg - s;
            dd1 = s1 - d_avg;
            if(dd < dd1)
                pop(j,:) = popExt(i,:);
            else
                i = i + 1;
                pop(j,:) = popExt(i,:);
            end
            s = 0;
            j = j + 1;
        end
        if(i >= extSize) %由于前面i自加了一次，下面访问d(i)可能会越界
            break;
        end
        s = s + d(i);
        i = i + 1;
    end
    
    pop(j,:) = popExt(extSize,:); %边界点
    pop(sum(pop,2) == 0,:) = [];
    popSize = size(pop,1);
    if(popSize == newSize)
        break;
    else
        k = k + popSize - newSize;
        if(popSize > newSize && last_popSize < newSize)
            pop = crowding_distance_assignment(pop);
            pop(newSize + 1:end,:) = [];
            fprintf('精确稀疏化使用拥挤距离去除了%d个解\n',popSize - newSize);
            break;
        end
    end
    last_popSize = popSize;
end
save('matlab.mat');
end

