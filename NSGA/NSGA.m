function [ output_args ] = NSGA()
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
f1 = @f11;
f2 = @f12;

Maxgen = 1000;   %最大迭代代数
N = 100;    %种群规模
rpnum = 10; %替换数量
pc = 1; %杂交概率
pm = 0; %变异概率

SigmaShare = 1;

DecRate = 0.99;         %虚拟适应值下降比率

Pop = zeros(N,3);   %第一维是自变量，第二维是rank，第三维是虚拟适应值
FitVector = zeros(N,2);

%初始化种群
for i=1:N
    Pop(i) = rand() * 20 - 10;
    FitVector(i,1) = -f1(Pop(i));
    FitVector(i,2) = -f2(Pop(i));
end

for gen = 1:Maxgen
    front = 1;
    classifiedNum = 0;    
    VirFit = 1000;     %虚拟适应值
    Pop(:,2) = 0;       %分类等级置0
    
    %按非支配排序进行分类，计算共享函数，赋虚拟适应值    
    while(classifiedNum < N)
        frontSetNum = 0;    %当前前沿面中的个体数

        for i = 1:N         %对第个个体i找一次前沿面
            if(Pop(i,2) > 0) %如果个体i已经分类，则跳过
                continue;
            end
            Pop(i,2) = front;   %首先假设第i个个体处于Pareto前沿面
            frontSetNum = frontSetNum + 1;
            for j = 1:N
                FitVector(i,1) = -f1(Pop(i));
                FitVector(i,2) = -f2(Pop(i));
                junclassified = Pop(j,2) == 0;   %只与未分类的个体进行比较
                if(junclassified && FitVector(i,1) < FitVector(j,1) && FitVector(i,2) < FitVector(j,2))
                    %如果个体j未分类且j支配i，则i不处于当前最优面,将i的rank置为0
                    Pop(i,2) = 0;
                    frontSetNum = frontSetNum - 1;
                    break;
                end
            end
        end
        
        %计算共享函数
        frontSet = zeros(frontSetNum,1);
        for i=1:frontSetNum
            if(Pop(i,2) == front)
                frontSet(i) = Pop(i,1);
            end
        end
        len = length(frontSet);
        sh = zeros(len,len);
        sum = 0;
        for i = 1:len
            for j = i + 1:len
                d = abs(Pop(i,1) - Pop(j,1));
                if(d < SigmaShare)
                    sh(i,j) = 1 - power((d/SigmaShare),2);
                end
                sum = sum + sh(i,j);
            end
        end
        NicheCount = sum / len + 1;
        
        %计算虚拟适应值
        VirFit = VirFit * DecRate / NicheCount;
        for i = 1:N
            if(Pop(i,2) == front)
                Pop(i,3) = VirFit;
            end
        end
        
        classifiedNum = classifiedNum + frontSetNum;
        front = front + 1;
    end     
    %种群按适应值排序,将适应值最差的个体放到前面
    for i = 1:rpnum
        for j = i:N
            if(Pop(i,3) > Pop(j,3))
                tmp = Pop(i,:);
                Pop(i,:) = Pop(j,:);
                Pop(j,:) = tmp;
            end
        end
    end
    %交叉操作，得到下一代新种群 
    for i = 1:rpnum
        while(true)
            p1 = randi([rpnum,N]);
            p2 = randi([rpnum,N]);
            while(p1 == p2)
                p2 = randi([rpnum,N]);
            end
            a = rand() * 2 - 0.5;        
            Pop(i,1) = Pop(p1,1) * a + Pop(p2,1) * (1 - a);
            if(-10 < Pop(i,1) && Pop(i,1) < 10)
                break;
            end    
        end
    end
    
    if(mod(gen,100) == 0)
        figure(1);        
        plot(Pop(rpnum + 1:N,1),ones(N - rpnum),'bo');
        s_ti = sprintf('第%d代',gen);
%         axis([-2,4,0,5]);
        title(s_ti);
        
        figure(2);
        ObjVector = -FitVector;
        plot(ObjVector(:,1),ObjVector(:,2),'bs');
        pause(0.01);
    end
end
Pop

