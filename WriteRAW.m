function [] = WriteRAW(filename,image)
tic

imH = size(image,1);
imW = size(image,2);
numFrames = size(image,3);
image2 = imrotate(image,90);

fid = fopen(filename,'w+');
cnt = fwrite(fid,image2,'uint8');
fclose(fid);

noteName = strcat(filename(1:end-4),'_RAWmetadata.mat');
notes(1,:) = {'height' 'width' 'number of frames'};
notes(2,:) = {imH imW numFrames};

save(noteName,'notes');

elapsedTime = toc;
display(strcat('========== Finished writing RAW image...',num2str(elapsedTime),' seconds elapsed =========='));