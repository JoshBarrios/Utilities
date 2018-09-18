function meanPlot = TriggeredMeanPlot(traces,time,plotTitle)

meanTrace = nanmean(traces,1);
% semTrace = SEM_calc(traces);
semTrace = meanTrace/sqrt(8);

meanPlot = figure;
plot(time,meanTrace,'b','LineWidth',2)
hold on
plot(time,meanTrace + semTrace,':b')
hold on
plot(time,meanTrace - semTrace,':b')
ylabel('Normalized Fluorescence','FontSize',16)
xlabel('time (s)','FontSize',16)
title(plotTitle,'FontSize',16)
