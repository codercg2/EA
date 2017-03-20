function [ output_args ] = NSGAII(func_flag)
%NSGAII �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
switch(func_flag)
    case 'SCH'
        F1 = @f11;  %Ŀ�꺯��1
        F2 = @f12;  %Ŀ�꺯��2
        n = 1;      %����ά��
        L = -1000;  %�±߽�
        U = 1000;   %�ϱ߽�
    otherwise
        F1 = @f11;
        F2 = @f22;
end

%��������
MaxGen = 500;           %������
gen = 0;                %��ǰ����
N = 100;                %��Ⱥ��ģ
pop = zeros(N * 2,n + 4);   %��ǰ��Ⱥ,һ�б�ʾһ������,ǰn�б�ʾ����������n+1,n+2��ΪĿ��������������зֱ��ʾrank��crowding distance
popNew = zeros(N * 2,n + 4); 
pop(:,1:n) = rand(N * 2,n) * (U - L) + L;    %��ʼ����Ⱥ
for gen = 1:MaxGen
    for i = 1:2*N
        pop(i,n + 1) = -F1(pop(i,1:n));
        pop(i,n + 2) = -F2(pop(i,1:n));
    end

    %�������
    F = fast_nondominate_sort(pop);
    k = 1;
    j = 1;
    while(true)
        frontSet = F{j};
        len = length(frontSet);
        if(k + len > N)
            I = zeros(len,n + 4);
            for i = 1:len
                r = frontSet(i);
                I(i,:) = pop(r,:);
            end
            break;
        end
        for i = 1:len
            r = frontSet(i);
            popNew(k,:) = pop(r,:);
            k = k + 1;
        end
        j = j + 1;
    end
    %����ÿ��ÿ�������crowding distance
    I = crowding_distance_assignment(I);    
    for i = 1:size(I,1)
        popNew(k,:) = I(i,:);
        k = k + 1;
        if(k > N)
            break;
        end
    end
    %����ͱ��죬������һ����Ⱥ
    pop = crossover_and_mutation(popNew);
    
    %���ӻ�
    plot(-pop(1:N,n + 1),-pop(1:N,n + 2),'bo');
    title(gen);
    pause(0.01);
end
end
