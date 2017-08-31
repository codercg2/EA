funcs = {'SCH';'FON';'POL';'KUR';'ZDT1';'ZDT2';'ZDT3';'ZDT4';'ZDT6'};
for i=1:length(funcs)
    flag = funcs{i};
    fprintf('%s\n',flag);
    NSGAII_DEPE(flag);
end