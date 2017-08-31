funcs = {'SCH','KUR'};
for i=1:length(funcs)
    flag = funcs{i};
    fprintf('%s\n',flag);
    NSGAII_DEPE_F1Test(flag);
end