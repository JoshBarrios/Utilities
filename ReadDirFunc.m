function pictures = ReadDirFunc(parentPath)
% path = uigetdir;
tic;
display('=====Reading in directory=====');

d = dir(parentPath);

for k = 1:length(d)
    if contains(d(k).name,'.tif')
        isIm(k) = 1;
    else
        isIm(k) = 0;
    end
end

imInds = find(isIm);

num_images = length(imInds);
    
pictures(:,:,1) = imread(fullfile(parentPath,d(imInds(1)).name));
[picx,picy] = size(pictures(:,:,1));
pictures = zeros(picx,picy,num_images,'uint8');

parfor m = 1:num_images
    ind = imInds(m);
        imname = d(ind).name;
        fullname = fullfile(parentPath,imname);
        pictures(:,:,m) = imread(fullname);
end    

pictures = uint8(pictures);

display(strcat('=====Finished reading directory_', num2str(toc),'s elapsed====='));