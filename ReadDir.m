path = uigetdir;
d = dir(path);
num_images = length(d)-2;
    
pictures(:,:,1) = imread(fullfile(path,d(3).name));
[picx,picy] = size(pictures(:,:,1));
pictures = zeros(picx,picy,num_images-2);

for m = 3:length(d)
        imname = d(m).name;
        fullname = fullfile(path,imname);
        pictures(:,:,m-2) = imread(fullname);
        pause(.0001)
end    