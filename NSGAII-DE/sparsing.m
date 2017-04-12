function [ pop ] = sparsing( popExt,newSize )
%sparsing 此处显示有关此函数的摘要
%   此处显示详细说明

s = size(popExt);
extSize = s(1);
n = s(2) - 4;
if(extSize <= newSize)
    pop = popExt;
    warning('newSize is not smaller than popExt lenght.');
    return;
end
pop = zeros(newSize * 1.5,n + 4);
popExt = sortrows(popExt,n + 1);
d = sqrt(sum((popExt(2:extSize,n+1:n+2) - popExt(1:extSize - 1,n+1:n+2)).^2,2));
d_mean = mean(d);
d_std = sqrt(var(d));
abnormal = find(d >= d_mean + 12 * d_std);
%如果有异常值，则使用3倍标准差，没有异常值，则使用9倍标准差
if(length(abnormal) > 0)
    d_sel = d(find(d < d_mean + 3 * d_std));
else
    d_sel = d(find(d < d_mean + 9 * d_std));
end

d_avg = sum(d_sel) /(newSize - 1);

s = 0;
j = 2;
i = 1;
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
    s = s + d(i);
    i = i + 1;
end
if(j <= 100)
    pop(j,:) = popExt(extSize,:); %边界点
else
    pop = [pop;popExt(extSize,:)]; %边界点
end
pop(find(sum(pop,2) == 0),:) = [];
save('matlabkur.mat');
end

