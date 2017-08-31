function [ output_args ] = myPlot(figureNum, x,y,fileName )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
hFigure = figure(figureNum);
set(gcf,'position',[100 100 350 240]);
plot(x,y,'ko','markersize',3);

set(gca,'FontName','Times New Roman');
xlabel('\itf_{1}','FontName','Times New Roman');
ylabel('\itf_{2}','FontName','Times New Roman');
posHfig=[0 0 240 150]; % posHfig为 调整输出图片的尺寸
set(hFigure, 'PaperPositionMode', 'manual'); % hFigure 图像句柄
set(hFigure, 'PaperUnits', 'points'); 
set(hFigure, 'PaperPosition', posHfig); %
print(hFigure, '-dmeta', fileName);

end

