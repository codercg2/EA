function [ output_args ] = NSGAII_DE(func_flag)
%NSGAII_DE 此处显示有关此函数的摘要
%   此处显示详细说明
%参数设置
MaxGen = 100;           %最大代数
ExtGen = 50;
N = 100;                %种群规模

de_F = 0.5;                %DE缩放因子
de_cr = 0.3;               %DE交叉概率
switch(func_flag)
    case 'SCH'
        F1 = @f11;  %目标函数1
        F2 = @f12;  %目标函数2
        n = 1;      %变量维数
        L = -1000;  %下边界
        U = 1000;   %上边界
        MaxGen = 50;
        ExtGen = 50;
    case 'FON'
        F1 = @f21;  %目标函数1
        F2 = @f22;  %目标函数2
        n = 3;      %变量维数
        L = -4;  %下边界
        U = 4;   %上边界
    case 'POL'
        F1 = @f31;  %目标函数1
        F2 = @f32;  %目标函数2
        n = 2;      %变量维数
        L = -pi;  %下边界
        U = pi;   %上边界
    case 'KUR'
        F1 = @KUR_F1;  %目标函数1
        F2 = @KUR_F2;  %目标函数2
        n = 3;      %变量维数
        L = -5;  %下边界
        U = 5;   %上边界
    case 'ZDT1'
        F1 = @ZDT1_F1;  %目标函数1
        F2 = @ZDT1_F2;  %目标函数2
        n = 30;      %变量维数
        L = 0;  %下边界
        U = 1;   %上边界
        
        MaxGen = 500;
    case 'ZDT2'
        F1 = @ZDT2_F1;  %目标函数1
        F2 = @ZDT2_F2;  %目标函数2
        n = 30;      %变量维数
        L = 0;  %下边界
        U = 1;   %上边界
        
        MaxGen = 500;
        eta_c = 10;
    case 'ZDT3'
        F1 = @ZDT3_F1;  %目标函数1
        F2 = @ZDT3_F2;  %目标函数2
        n = 30;      %变量维数
        L = 0;  %下边界
        U = 1;   %上边界
        
        MaxGen = 400;
    case 'ZDT4'
        F1 = @ZDT4_F1;  %目标函数1
        F2 = @ZDT4_F2;  %目标函数2
        n = 10;      %变量维数
        L = -5 * ones(1,n);  %下边界
        L(1) = 0;
        U = 5 * ones(1,n);   %上边界
        U(1) = 1;
        
        MaxGen = 1000;
    case 'ZDT6'
        F1 = @ZDT6_F1;  %目标函数1
        F2 = @ZDT6_F2;  %目标函数2
        n = 10;      %变量维数
        L = 0;  %下边界
        U = 1;   %上边界
        MaxGen = 500;
    otherwise
        F1 = @f21;  %目标函数1
        F2 = @f22;  %目标函数2
        n = 3;      %变量维数
        L = -4;  %下边界
        U = 4;   %上边界
end


pop = zeros(N * 2,n + 4);   %当前种群,一行表示一个个体,前n列表示个体向量，n+1,n+2列为目标向量，最后两列分别表示rank和crowding distance
popNew = zeros(N * 2,n + 4); 
popExtend = zeros(N * ExtGen,n + 4);

one = ones(N * 2,1);
if(length(U) > 1)
    pop(:,1:n) = rand(N * 2,n) .* (one * (U - L)) + one * L;    %初始化种群
else
    pop(:,1:n) = rand(N * 2,n) * (U - L) + L;    %初始化种群
end

for gen = 1:MaxGen + ExtGen
    for i = 1:2*N
        pop(i,n + 1) = -F1(pop(i,1:n));
        pop(i,n + 2) = -F2(pop(i,1:n));
    end

    %排序分类
    F = fast_nondominate_sort(pop);
    k = 1;
    j = 1;
    while(true)
        frontSet = F{j};
        len = length(frontSet);
        
        I = zeros(len,n + 4);
        for i = 1:len
            r = frontSet(i);
            pop(r,n + 3) = j;   %赋予rank值
            I(i,:) = pop(r,:);
        end
        I = crowding_distance_assignment(I);       %计算每类每个个体的crowding distance
        if(k + len > N)
            break;
        end
        popNew(k:k + len - 1,:) = I;
        k = k + len;
        j = j + 1;
    end

    for i = 1:size(I,1)
        popNew(k,:) = I(i,:);
        k = k + 1;
        if(k > N)
            break;
        end
    end
    figure(1);
    plot(-popNew(1:N,n + 1),-popNew(1:N,n + 2),'bo');
    hold on;
%     plot(-I(i:end,n + 1),-I(i:end,n + 2),'rs');
    title(gen);
    hold off;
    pause(0.01);

    if(gen > MaxGen)
        from = (gen - MaxGen - 1) * N + 1;
        to = from + N - 1;
        popExtend(from:to,:) = popNew(1:N,:);
        figure(3);
        plot(-popExtend(:,n + 1),-popExtend(:,n + 2),'bo');
        title('扩充种群');
        if(gen >= MaxGen + ExtGen)
            popExtend(:,end) = 0; %最后一列为crowding_distance，现已没有意义
            popExtend = unique(popExtend,'rows');
            popExtend(find(popExtend(:,n + 3) > 1),:) = []; %去掉不是最优面的解
            F_ext = fast_nondominate_sort(popExtend);
            firstFront = F_ext{1};
            popNondominateExt = zeros(size(popExtend));
            for i=1:length(firstFront)
                popNondominateExt(i,:) = popExtend(firstFront(i),:);
            end
            popNondominateExt(find(sum(popNondominateExt,2) == 0),:) = [];
            popSparsing = sparsing(popNondominateExt,N);
            figure(4);
            plot(-popSparsing(:,n + 1),-popSparsing(:,n + 2),'bo');
            title('最终结果');
        end
    end
    
    
    %交叉和变异，产生下一代种群
    pop = crossover_and_mutation(popNew,[L;U],F1,F2,de_F,de_cr);    
end

figure(2);
plot(-pop(1:N,n + 1),-pop(1:N,n + 2),'bo');
title('原始结果');
end

