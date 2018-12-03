%% Josh Barrios 12/1/18
% Takes data from behaviorDataAll and fluoDataAll and makes "trials" structure
% This new structure contains average data from each trial, inlcuding mean
% dF/F values for each cluster, pActivation values for the population (mean
% of the rasters), and all behavior and stim data

for k = 1:size(behaviorDataAll,1)
    try
    if ~isempty(behaviorDataAll{k})
        bFishNums(k) = str2num(behaviorDataAll{k,1});
        bPlaneNums(k) = str2num(behaviorDataAll{k,2});
        bTrialNums(k) = str2num(behaviorDataAll{k,3});
    else
        bFishNums(k) = NaN;
        bPlaneNums(k) = NaN;
        bTrialNums(k) = NaN;
    end
    catch
        bFishNums(k) = NaN;
        bPlaneNums(k) = NaN;
        bTrialNums(k) = NaN;
    end
end

%%
for k = 1:size(fluoDataAll,1)
    if ~isempty(fluoDataAll{k,1})
    trials(k).fishNum = str2num(fluoDataAll{k,1});
    trials(k).planeNum = str2num(fluoDataAll{k,2});
    trials(k).trialNum = str2num(fluoDataAll{k,3});
    trials(k).traces = fluoDataAll{k,4};
    trials(k).rasters = fluoDataAll{k,5};
    trials(k).ROIs = fluoDataAll{k,6};
    trials(k).clusterIDs = fluoDataAll{k,8};
    
    bInd = find(bFishNums == trials(k).fishNum & bPlaneNums == trials(k).planeNum & bTrialNums == trials(k).trialNum);
    if ~isempty(bInd)
        bData = behaviorDataAll{bInd,4};
        if ~isempty(bData)
            bOnsets = [bData{3,:}];
            bOnsets = round((bOnsets/500)*3.44);
            bOnsets = bOnsets(~(bOnsets == 0));
            bhavBool = zeros(1,size(trials(k).traces,1));
            bhavBool(bOnsets) = 1;
            trials(k).bhavBool = bhavBool;
        else
            trials(k).bhavBool = [];
        end
    else
        trials(k).bhavBool = [];
    end
    end
end


clearvars -except neurons behaviorDataAll fluoDataAll trials