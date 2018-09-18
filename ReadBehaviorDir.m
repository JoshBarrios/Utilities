function pictures = ReadBehaviorDir(parentPath)

pd = dir(parentPath);

for l = 3:length(pd)
    path = pd(l).name;
    d = dir(fullfile(parentPath,path));
    num_images = length(d)-3;
    
    pictures(:,:,1) = imread(fullfile(parentPath,path,d(4).name));
    binPic = imresize(pictures(:,:,1),0.25);
    [picx,picy] = size(binPic);
    pictures = uint8(zeros(picx,picy,num_images));
    
    for m = 4:length(d)
        imname = d(m).name;
        fullname = fullfile(parentPath,path,imname);
        tempPic = imread(fullname);
        binPic = imresize(tempPic,0.25);
        pictures(:,:,m-3) = binPic;
    end
    
    filename = fullfile(parentPath,path,'.raw');
    save = WriteRAW(filename,pictures);
    
end