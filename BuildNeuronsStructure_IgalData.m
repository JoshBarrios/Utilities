%% Josh Barrios 11/26/2018
% For each cell, pulls out all recorded traces, finds relevant stim or 
% behavior triggers, and presents data. Requires "behaviorDataAll" and
% "fluoDataAll".

% 2p frame where the stimulus happens
% stimFrame = 552;
% number of 2p frames per movie
% frameNum = 586;

fishNums = [fluoDataAll{:,1}];
planeNums = [fluoDataAll{:,2}];
trialNums = [fluoDataAll{:,3}];

numFish = max(fishNums);
numPlanes = max(planeNums);
numTrials = max(trialNums);

%% For each plane, find all unique ROIs and place them in "neurons"
% structure

totNumROIs = 0;

for k = 1:numFish
    for l = 1:numPlanes
        thisPlaneInd = fishNums == k & planeNums == l;
        thisPlaneROIs = fluoDataAll(thisPlaneInd,6);
        thisPlaneTraces = fluoDataAll(thisPlaneInd,4);
        thisPlaneRasters = fluoDataAll(thisPlaneInd,5);
        thisPlaneClusterIDs = fluoDataAll(thisPlaneInd,8);
       
        
        %% Unpack vectors of ROI info, dFF traces, rasters, etc. for per-cell analysis
        
        % Unpack ROIs vector, make ROI vector for unique IDing
        ROIs = [thisPlaneROIs{:,1}];
        
        for m = 1:size(ROIs,1)
            sizes(m) = size(ROIs{m},1);
        end
        minSize = min(sizes);
        for m = 1:size(ROIs,2)
            temp = ROIs{m};
            ROI(m,1:minSize) = temp(1:minSize,1);
        end
        
        % Find unique ROIs, get indexing vector 'ic'
        [C, ia, ic] = unique(ROI','rows');
        numROIs = max(ic);
        clear ROI C ia
        
        % Unpack traces vector
        traces = thisPlaneTraces{1};
        for m = 2:size(thisPlaneTraces,1)
            num = size(thisPlaneTraces{m},2);
            traces(:,end+1:end+num) = thisPlaneTraces{m};
        end
        
        % Unpack rasters vector
        rasters = thisPlaneRasters{1};
        for m = 2:size(thisPlaneRasters,1)
            num = size(thisPlaneRasters{m},2);
            rasters(:,end+1:end+num) = thisPlaneRasters{m};
        end
        
        % Make trialNums vector
        trialNums = ones(size(thisPlaneTraces{1},2),1);
        for m = 2:size(thisPlaneTraces,1)
            num = size(thisPlaneTraces{m},2);
            trialNums(end+1:end+num) = ones(num,1) * m;
        end
        
        % Unpack clusterIDs vector
        IDs = thisPlaneClusterIDs{1};
        for m = 2:size(thisPlaneClusterIDs,1)
            num = size(thisPlaneClusterIDs{m},2);
            IDs(:,end+1:end+num) = thisPlaneClusterIDs{m};
        end
        
        %% Index data for each neuron and put into "neurons" structure
        
        for m = 1:numROIs
            
            % ROI number (for whole dataset)
            roiNum = totNumROIs + m;
            
            % Fish number
            neurons(roiNum).fishNum = k;
            
            % Plane number
            neurons(roiNum).planeNum = l;
            
            % Trial numbers this ROI was in
            neurons(roiNum).trialNums = trialNums(ic == m);
            
            % dF/F traces
            ROItraces = traces(:,ic == m);
            ROItraces = ROItraces(3:end,:); % Accounting for 2-frame delay in behavior camera & stim triggering
            neurons(roiNum).traces = reshape(ROItraces,[size(ROItraces,1)*size(ROItraces,2),1]);
            
%             % Rasters (significant calcium transient boolean)
%             ROIrasters = rasters(:,ic == m);
%             ROIrasters = ROIrasters(3:end,:); % Accounting for 2-frame delay in behavior camera & stim triggering
%             neurons(roiNum).rasters = reshape(ROIrasters,[size(ROIrasters,1)*size(ROIrasters,2),1]);
            
            % Cluster ID
            ROIClusterID = IDs(ic == m);
            neurons(roiNum).clusterID = ROIClusterID(1);
            
            % 2p stim frames
            numFrames = size(traces,1) - 2;
            for h = 1:size(neurons(roiNum).trialNums,1)
                stims(h) = (numFrames * (h-1)) + stimFrame-2;
            end
            neurons(roiNum).stimFrames = stims;
            clear stims
            
            % 2p behavior onset frames
            neurons(roiNum).bhavFrames = GetBehaviorOnsets(behaviorDataAll,k,l,neurons(roiNum).trialNums,numFrames);
            
            % Stimulus response boolean vector
            neurons(roiNum).stimResponseBool = CheckForResponses(neurons(roiNum).stimFrames,neurons(roiNum).bhavFrames);
            
            % Subsampled boolean behavior vector for ROC ("target" vector)
            bhavTarget = zeros(size(neurons(roiNum).traces));
            bhavTarget(neurons(roiNum).bhavFrames) = 1;
            neurons(roiNum).bhavBool = bhavTarget;
            
        end
        totNumROIs = totNumROIs + numROIs; % Update total number of ROIs
    end
end

clearvars -except neurons behaviorDataAll fluoDataAll
