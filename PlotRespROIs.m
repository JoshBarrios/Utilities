%% Takes a set of triggered traces from triggeredAverage.m and plots the responsive ROIs.
%% ROIs are color coded based on the time at which they respond.

function respPlot = PlotRespROIs(rois,traces)

%%

for k = 1:size(traces,1)
    trace = traces(k,:);
    try
        dActivity = trace(2:end) - trace(1:end-1);
        rises = dActivity > 0.2;
        riseInd = find(rises);
        firstRises(k) = min(riseInd);
    catch
        firstRises(k) = NaN;
    end
end

responders = ~isnan(firstRises);
responderTraces = traces(responders,:);
responderRises = firstRises(responders);

colorMap = jet(size(traces,2));
timeStep = 1/3.44;
ends = 10 * timeStep;
colorMapTime = [-ends:timeStep:ends];
colorMapNums = [0:1/21:1];

colorTimeTicks = colorMapNums([1:2:21]);
colorTimeLabels = colorMapTime([1:2:21]);

%%
responderROIs = rois(responders);
respPlot = figure
for k = 1:length(responderROIs)
    ROI = cell2mat(responderROIs(k));
    plotColor = colorMap(responderRises(k),:);
    plot(ROI(1,:),-ROI(2,:),'Color',plotColor)
    hold on
end
set(gca,'Color','k')
colormap(colorMap)
colorbar('Ticks',colorTimeTicks,'TickLabels',colorTimeLabels,'Direction','reverse')

