function [ output_args ] = DE( )
%DE 差分进化算法
%   此处显示详细说明
fun = @fun1;
F = 0.5;
CR = 0.3;

draw = false;

M = 100;    %种群规模
It = 1000;  %迭代代数
n = 4;      %个体向量维度
POP = zeros(M,n);    %种群
POP_H = zeros(M,n);    %变异种群
POP_V = zeros(M,n);     %交叉种群
POP_New = zeros(M,n);   %新生成的种群
Fit_Pop = zeros(M,1);   %M个个体的适应度
Fit_Best = zeros(It,1);     %每一代的最优个体适应值
for i=1:M
    X = rand(1,n) * 20 - 10;
    POP(i,:) = X;
end
for k = 1:It        %迭代It代
    Fit_Best(k) = -fun(POP(1));      %取当前种群的第1个个体的适应值    
    for i=1:M       %对每一代的M个个体进行变异、交叉、选择操作
        %变异
        p = randi(M,1,3);
        POP_H(i,:) = POP(p(1),:) + F * (POP(p(2),:) - POP(p(3),:));
        while(~isValid(POP_H(i,:)))
            p = randi(M,1,3);
            POP_H(i,:) = POP(p(1),:) + F * (POP(p(2),:) - POP(p(3),:));
        end
             
        %交叉
        rnbr = randi(n);
        for j = 1:n
            if(rand() < CR || j == rnbr)
                POP_V(i,j) = POP_H(i,j);
            else
                POP_V(i,j) = POP(i,j);
            end
        end
        %计算适应值
        Fit_V = -fun(POP_V(i,:));
        Fit = -fun(POP(i,:));
        Fit_Pop(i) = Fit;
        if(Fit_Best(k) < Fit)
            Fit_Best(k) = Fit;
        end
        %选择
        if(Fit_V > Fit)
            POP_New(i,:) = POP_V(i,:);
        else
            POP_New(i,:) = POP(i,:);
        end        
    end
    if(n == 2 && draw == true)      %如果是二维，则进行散点图可视化
        figure(1);
        scatter(POP(:,1),POP(:,2),15,'filled');
        s_ti = sprintf('第%d代 最大适应值:%f',k,Fit_Best(k));
        title(s_ti);
        disp(s_ti);
        pause(0.01);
    end    
    %更新种群
    POP = POP_New;
end
figure(2);
plot(Fit_Best);
title('适应值曲线图');
end

function output = isValid(X)
    n = length(X);
    output = true;
    for i = 1:n
        if(X(i) < -10 || X(i) > 10)
            output = false;
            break;
        end
    end
end

