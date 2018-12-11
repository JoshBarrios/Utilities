%% Josh Barrios 12/10/2018
% Looks through a directory to find a calcium imaging movie. If there are
% more than one tif files in the directory, it imports channel 1

function mov = Find2pMov(folderpath)

subDir = dir(folderpath);
for l = 1:length(subDir)
    if contains(subDir(l).name,'.tif')
        fileBool(l) = 1;
    else
        fileBool(l) = 0;
    end
end
if sum(fileBool) > 1
    for l = 1:length(subDir)
        if contains(subDir(l).name,'ch1.tif')
            fileBool(l) = 1;
        else
            fileBool(l) = 0;
        end
    end
end
movInd = find(fileBool);
fullpath = fullfile(folderpath,subDir(movInd).name);
mov = ReadTifFunc(fullpath);
end