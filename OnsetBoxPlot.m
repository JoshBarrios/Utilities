function onsetBoxPlot = OnsetBoxPlot(triggeredTraces,plotTitle)

%% Find activity onset

for l = 1:size(triggeredTraces,1)
    for k = 1:size(triggeredTraces,1)
        trace = triggeredTraces(k,:);
        try
            dActivity = trace(2:end) - trace(1:end-1);
            rises = dActivity > 0.2;
            riseInd = find(rises);
            firstRises(l,k) = min(riseInd);
        catch
            firstRises(l,k) = NaN;
        end
    end
end

firstRises = firstRises';

%% Plot activity onset

figure
onsetBoxPlot = notBoxPlot(firstRises);
xlim([0 2])
ylabel('Activity Onset (frame)')
title(plotTitle)

