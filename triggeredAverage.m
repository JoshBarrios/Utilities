function [triggeredROIs,triggeredTracesAll] = triggeredAverage(ROIs,traces,triggerFrames,windowLength)

% traces is a two-dimensional matrix of fluorescence activity from each
% unit.
% ROIs is a cell array of ROI data with one ROI per
% trace.
% triggerFrames is a one-dimensional list of frames on which to trigger
% averaging. This may correspond to a behavior or stimulus onset.
% windowLength is the size of the desired averaging window. This must be an
% even number. mov is the image used with ExtractTraces. This is used to
% plot the responsive units on a z-projected image of the recorded
% population.

%% Create average +/- STE trace of all units over all stimuli

triggerFrames = round(triggerFrames);
lowBound = windowLength/2;
highBound = size(traces,1) - (windowLength/2);
lowBool = logical(triggerFrames > lowBound);
highBool = logical(triggerFrames < highBound);
triggerFrames = triggerFrames(lowBool & highBool);
numUnits = size(traces,2);
numTrigs = length(triggerFrames);
numWindows = numUnits * numTrigs;

triggeredTracesAll = zeros(numWindows,windowLength+1);
triggeredROIs = {};

for k = 1:numUnits
    for l = 1:numTrigs
        thisWindowNum = ((k-1)*numTrigs)+l;
        thisWindowRange = triggerFrames(l)-(windowLength/2):triggerFrames(l)+(windowLength/2);
        triggeredROIs(thisWindowNum) = ROIs(k);
        triggeredTracesAll(thisWindowNum,:) = traces(thisWindowRange,k);
        unitNums(thisWindowNum) = k;
    end
end
triggeredROIs = triggeredROIs';
% triggeredAverages = mean(triggeredTracesAll,1);
% triggeredSEMs = SEM_calc(triggeredTracesAll);
% range = -windowLength/2:windowLength/2;

% figure;
% plot(range,triggeredAverages,'b','LineWidth',2);
% hold on
% plot(range,triggeredAverages + triggeredSEMs, 'b:','LineWidth',2);
% hold on
% plot(range,triggeredAverages - triggeredSEMs, 'b:','LineWidth',2);
% xlabel('Time (frames)')
% ylabel('Normalized Fluorescence (dF/F)')
% title('Average Activity of All Recorded Units')

%% ID responders and make average response plot

% for k = 1:size(triggeredTracesAll,1)
%     thisTrace = triggeredTracesAll(k,:);
%     if trapz(thisTrace(1:windowLength/2)) < trapz(thisTrace(windowLength/2:end))
%         respondersBool(k) = 1;
%     else
%         respondersBool(k) = 0;
%     end
% end
% respondersBool = logical(respondersBool);
% 
% responsiveTraces = triggeredTracesAll(respondersBool,:);
% 
% responsiveAverages = mean(responsiveTraces,1);
% responsiveSEMs = SEM_calc(responsiveTraces);
% 
% figure;
% plot(range,responsiveAverages,'b','LineWidth',2);
% hold on
% plot(range,responsiveAverages + responsiveSEMs, 'b:','LineWidth',2);
% hold on
% plot(range,responsiveAverages - responsiveSEMs, 'b:','LineWidth',2);
% xlabel('Time (frames)')
% ylabel('Normalized Fluorescence (dF/F)')
% title('Average Activity of Responsive Units')

%% Plot responsive units on image of recorded population

% sdIm = uint8(std(mov,0,3));
% rgbImage = cat(3, sdIm, sdIm, sdIm);
% myColorMap = uint8(jet(256));
% [ysize, xsize] = size(mov(:,:,1));
% [x, y] = meshgrid(1:xsize, 1:ysize);
% 
% for k = 1:numUnits
%     thisUnitIndex = unitNums == k;
%     thisUnitResponses = respondersBool(thisUnitIndex);
%     responsePercentage(k) = sum(thisUnitResponses)/length(thisUnitResponses);
% end
% 
% for k = 1:numUnits
%     thisROI = cell2mat(rois(k));
%     roiBool = inpolygon(x,y,thisROI(1,:),thisROI(2,:));
%     
%     if responsePercentage(k) == 0
%         percentageColor = uint8(myColorMap(1,:));
%     else
%         percentageColor = uint8(myColorMap(round(256*responsePercentage(k)),:));
%     end
%     
%     roiIndex = find(roiBool);
%     for l = 1:length(roiIndex)
%         [yy,xx] = ind2sub(size(mov(:,:,1)),roiIndex(l));
%         rgbImage(yy,xx,1) = percentageColor(1);
%         rgbImage(yy,xx,2) = percentageColor(2);
%         rgbImage(yy,xx,3) = percentageColor(3);
%     end
% 
% end
% 
% figure
% imshow(double(rgbImage))


    %% 
%     percentageColor = double(myColorMap(200,:));
%     p1 = percentageColor(1);
%     p2 = percentageColor(2);
%     p3 = percentageColor(3);
%     
%     rIm = double(onesIm*p1);
%     gIm = double(onesIm*p2);
%     bIm = double(onesIm*p3);
%     
% testIm = cat(3,rIm,gIm,bIm);
% figure
% imshow(testIm)
    
