function bhavOnsetsAll = GetBehaviorOnsets(behaviorDataAll,fishNum,planeNum,trialNums,numFrames)

k = fishNum;
l = planeNum;

% Get all behavior frames
bFishNums = behaviorDataAll(:,1);
bPlaneNums = behaviorDataAll(:,2);
bTrialNums = behaviorDataAll(:,3);

% Set all empty cells to zero and convert to numeric
for h = 1:size(bFishNums,1)
    if isempty(bFishNums{h})
        bFishNums{h} = '0';
        bPlaneNums{h} = '0';
        bTrialNums{h} = '0';
    end
    if isa(bFishNums{h},'char')
        bFishNums{h} = str2double(bFishNums{h});
        bPlaneNums{h} = str2double(bPlaneNums{h});
        bTrialNums{h} = str2double(bTrialNums{h});
    end
end

bFishNums = cell2mat(bFishNums);
bPlaneNums = cell2mat(bPlaneNums);
bTrialNums = cell2mat(bTrialNums);

thisPlaneInd = bFishNums == k & bPlaneNums == l;
for h = 1:size(trialNums)
    thisROIInd(:,h) = thisPlaneInd & bTrialNums == trialNums(h);
end
thisROIInd = sum(thisROIInd,2);

bData = behaviorDataAll(:,4);
thisROIbData = bData(logical(thisROIInd));

bhavOnsetsAll = [];
for h = 1:size(thisROIbData,1)
    if ~isempty(thisROIbData{h})
        thisTrialData = thisROIbData{h};
        for o = 1:size(thisTrialData,2)
            bhavOnsets(o) = thisTrialData{3,o};
        end
        % Convert to 2p frames
        bhavOnsets = round((bhavOnsets/500)*3.44);
        % Adjust for position in concatenated set of traces
        bhavOnsets = bhavOnsets + (numFrames*(h-1));
        bhavOnsetsAll = cat(2,bhavOnsetsAll,bhavOnsets);
        bhavOnsetsAll = bhavOnsetsAll(~(bhavOnsetsAll == 0));
        clear bhavOnsets
    end
end


