function [imData]=ReadRAW(filename)
tic

noteName = strcat(filename(1:end-4),'_RAWmetadata.mat');
load(noteName);

% Use low-level File I/O to read the file
fp = fopen(filename , 'rb');

%image x, y and z dims
sizx = notes{2,2};
sizy = notes{2,1};
total_frames = notes{2,3};

% set offset to first image
slice = 1;
total_z_pos = 1;
first_offset = sizx*sizy*2*(slice-1);
ofds = zeros(1,total_frames);

%compute frame offsets
file_en = total_frames/total_z_pos;
imData = cell(1,file_en);
for i = 1:file_en
    ofds(i) = first_offset+(i-1)*sizx*sizy*total_z_pos;
end

for cnt = 1:file_en
    fseek(fp,ofds(cnt),'bof');
    tmp1 = fread(fp, [sizx sizy], 'uint8', 0, 'ieee-le')';
    imData{cnt} = cast(tmp1,'uint8');
end

imData = cell2mat(imData);
imData = reshape(imData,[sizy,sizx,file_en]);
fclose(fp);

elapsedTime = toc;
display(strcat('========== Finished reading RAW image...',num2str(elapsedTime),' seconds elapsed =========='));

end
