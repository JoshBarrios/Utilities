%% Josh Barrios 12/10/2018
% Extracts fish number, plane number, and trial number from folder name.
% Looks for lowercase letters

function [fishNum,planeNum,trialNum] = GetTrialInfo(subPath)

folders = split(subPath,"\");

subPath = folders{end};

% Find fishNum
if contains(subPath,'fish')
    fishInd = strfind(subPath,'fish');
    if fishInd + 5 > length(subPath)
        fishNum = str2num(subPath(fishInd + 4));
    else 
        fishNum = findNum(subPath(fishInd + 4:fishInd + 7));
    end
    
else contains(subPath,'f');
    fishInd = strfind(subPath,'f');
    if ~isempty(fishInd)
        fishInd = fishInd(end);
    end
    if fishInd + 2 > length(subPath)
        fishNum = str2num(subPath(fishInd + 1));
    else 
        fishNum = findNum(subPath(fishInd + 1:end));
    end
end

% Find planeNum
if contains(subPath,'plane')
    planeInd = strfind(subPath,'plane');
    if planeInd + 6 > length(subPath)
        planeNum = str2num(subPath(planeInd + 5));
    else 
        planeNum = findNum(subPath(planeInd + 5:end));
    end
    
else contains(subPath,'p');
    planeInd = strfind(subPath,'p');
    if ~isempty(planeInd)
        planeInd = planeInd(end);
    end
    if planeInd + 2 > length(subPath)
        planeNum = str2num(subPath(planeInd + 1));
    else 
        planeNum = findNum(subPath(planeInd + 1:end));
    end
end



% Find trialNum
if contains(subPath,'trial')
    trialInd = strfind(subPath,'trial');
    if trialInd + 6 > length(subPath)
        trialNum = str2num(subPath(trialInd + 5));
    else 
        trialNum = findNum(subPath(trialInd + 5:end));
    end
    
else contains(subPath,'t');
    trialInd = strfind(subPath,'t');
    if ~isempty(trialInd)
        trialInd = trialInd(end);
    end
    if trialInd + 2 > length(subPath)
        trialNum = str2num(subPath(trialInd + 1));
    else 
        trialNum = findNum(subPath(trialInd + 1:end));
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

