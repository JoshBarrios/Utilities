function pictures = ReadDirFunc(path)
% path = uigetdir;
tic;
display('=====Reading in directory=====');

d = dir(path);

for k = 1:length(d)
    if contains(d(k).name,'.tif')
        isIm(k) = 1;
    else
        isIm(k) = 0;
    end
end

imInds = find(isIm);

num_images = length(imInds);
    
pictures(:,:,1) = imread(fullfile(path,d(imInds(1)).name));
[picx,picy] = size(pictures(:,:,1));
pictures = zeros(picx,picy,num_images);

parfor m = 1:num_images
    ind = imInds(m);
        imname = d(ind).name;
        fullname = fullfile(path,imname);
        pictures(:,:,m) = imread(fullname);
end    

display(strcat('=====Finished reading directory_', num2str(toc),'s elapsed====='));