[file,path] = uigetfile('*.tif','Find movie');
tic
mov = uint8(TIFFStack(fullfile(path,file),true));
clc
clear file path
toc