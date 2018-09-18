%% Create colorized "raster" plot
function rasterish = ColorRaster(triggeredTraces,windowSize,fRate,figTitle)

plotTemp = triggeredTraces;
plotVar = std(plotTemp,0,2);
[sorted,I] = sort(plotVar);
sortedPlotVar = plotTemp(I,:);

range = windowSize/2;
midPt = range+1;
time = round(([-range:range]/fRate),1);

rasterish = figure;
surf(sortedPlotVar,'EdgeColor','none');
view(2);    
xticks([1:10:size(sortedPlotVar,2)])
xticklabels(time(1:10:end))
hold on
plot([midPt,midPt],[0,size(sortedPlotVar,1)],'r:','lineWidth',1)
set(gca,'FontSize',14)
xlabel('time (s)','FontSize',20)
ylabel('Unit #','FontSize',20)
title(figTitle)
colorbar