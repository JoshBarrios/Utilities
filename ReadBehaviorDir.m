% function pictures = ReadBehaviorDir(parentPath)
parentPath = uigetdir;
pd = dir(parentPath);

for l = 5:length(pd)
    try
    path = pd(l).name;
    d = dir(fullfile(parentPath,path));
    
    for k = 1:length(d)
        imBool(k) = contains(d(k).name,'.tif');
    end
    
    imInds = find(imBool);
    num_images = sum(imBool);
    
    sizePic = imread(fullfile(parentPath,path,d(4).name));
    [picx,picy] = size(sizePic);
    pictures = uint8(zeros(picx,picy,num_images));
    
    for m = 1:num_images
        imInd = imInds(m);
        imname = d(imInd).name;
        fullname = fullfile(parentPath,path,imname);
        pic = imread(fullname);
        pictures(:,:,m) = pic;
    end
    
    filename = fullfile(parentPath,path,'movie.raw');
    WriteRAW(filename,pictures);
    catch
        display('Error')
    end
    clear imBool pictures
    
end