%% Josh Barrios 12/10/2018
% Extracts fish number, plane number, and trial number from folder name.

function [fishNum,planeNum,trialNum] = GetTrialInfo(subPath)

% subPath = subPath(end-20:end);

% Find fishNum
if contains(subPath,'Fish')
    fishInd = strfind(subPath,'Fish');
    if fishInd + 5 > length(subPath)
        fishNum = str2num(subPath(fishInd + 4));
    else if isempty(str2num(subPath(fishInd + 5)))
            fishNum = str2num(subPath(fishInd + 4));
        else
            fishNum = str2num(subPath(fishInd + 4: fishInd + 5));
        end
    end
    
else contains(subPath,'F');
    fishInd = strfind(subPath,'F');
    if fishInd + 2 > length(subPath)
        fishNum = str2num(subPath(fishInd + 1));
    else if isempty(str2num(subPath(fishInd + 2)))
            fishNum = str2num(subPath(fishInd + 1));
        else
            fishNum = str2num(subPath(fishInd + 1: fishInd + 2));
        end
    end
end

% Find planeNum
if contains(subPath,'Plane')
    planeInd = strfind(subPath,'Plane');
    if planeInd + 6 > length(subPath)
        planeNum = str2num(subPath(planeInd + 5));
    else if isempty(str2num(subPath(planeInd + 6)))
            planeNum = str2num(subPath(planeInd + 5));
        else
            planeNum = str2num(subPath(planeInd + 5: planeInd + 6));
        end
    end
    
else contains(subPath,'P');
    planeInd = strfind(subPath,'P');
    if planeInd + 2 > length(subPath)
        planeNum = str2num(subPath(planeInd + 1));
    else if isempty(str2num(subPath(planeInd + 2)))
            planeNum = str2num(subPath(planeInd + 1));
        else
            planeNum = str2num(subPath(planeInd + 1: planeInd + 2));
        end
    end
end

% Find trialNum
if contains(subPath,'Trial')
    trialInd = strfind(subPath,'Trial');
    if trialInd + 6 > length(subPath)
        trialNum = str2num(subPath(trialInd + 5));
    else if isempty(str2num(subPath(trialInd + 6)))
            trialNum = str2num(subPath(trialInd + 5));
        else
            trialNum = str2num(subPath(trialInd + 5: trialInd + 6));
        end
    end
    
else contains(subPath,'T');
    trialInd = strfind(subPath,'T');
    if trialInd + 2 > length(subPath)
        trialNum = str2num(subPath(trialInd + 1));
    else if isempty(str2num(subPath(trialInd + 2)))
            trialNum = str2num(subPath(trialInd + 1));
        else
            trialNum = str2num(subPath(trialInd + 1: trialInd + 2));
        end
    end
end

if isempty(fishNum)
    fishNum = NaN;
end
if isempty(planeNum)
    planeNum = NaN;
end
if isempty(trialNum)
    trialNum = NaN;
end

