% x = [2 4 7 2 4 5 2 5 1 50];
% figure(1);
% h = plot(x);
% saveas(h,'图片/Barchart.png')


hFigure = figure(1);
x = 1:0.01:2;
y = sin(x);
set(gcf,'position',[100 100 350 240]);
plot(x,y,'ko','markersize',3);
set(gca,'FontName','Times New Roman');
xlabel('\itf_{1}','FontName','Times New Roman');
ylabel('\itf_{2}','FontName','Times New Roman');

% ScrszParms=get(0,'ScreenSize');
posHfig=[0 0 240 150]; % posHfig为 调整输出图片的尺寸
set(hFigure, 'PaperPositionMode', 'manual'); % hFigure 图像句柄
set(hFigure, 'PaperUnits', 'points'); 
set(hFigure, 'PaperPosition', posHfig); %
print(hFigure, '-dmeta', 'test'); % posHfig 为输出到图片  长宽比例失真