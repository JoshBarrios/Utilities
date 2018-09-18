%% Create colorized "raster" plot sorted by activity onset

function rasterish = ColorRaster(triggeredTraces,windowSize,fRate,figTitle)

for k = 1:size(triggeredTraces,1)
    trace = triggeredTraces(k,:);
    try
        dActivity = trace(2:end) - trace(1:end-1);
        rises = dActivity > 0.2;
        riseInd = find(rises);
        firstRises(k) = min(riseInd);
    catch
        firstRises(k) = NaN;
    end
end


[sorted,I] = sort(firstRises);
sortedPlotVar = triggeredTraces(I,:);

range = windowSize/2;
midPt = range+1;
time = round(([-range:4:range]/fRate),1);

rasterish = figure;
surf(sortedPlotVar,'EdgeColor','none');
view(2);    
xticks([1:4:size(sortedPlotVar,2)])
xticklabels(time)
hold on
plot([midPt,midPt],[0,size(sortedPlotVar,1)],'r:','lineWidth',1)
set(gca,'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('Unit #','FontSize',20)
title(figTitle)
colorbar

