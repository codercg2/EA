funcs = {'KUR';'ZDT2'};
gens = [10,20,50]
for i=1:length(funcs)
    flag = funcs{i};
    fprintf('%s\n',flag);
    for j=1:length(gens)
        NSGAII_DEPE_ExpGenTest(flag,gens(j));
    end
end