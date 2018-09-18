[file,path] = uigetfile('*.tif','Find movie');
tic

info = imfinfo(fullfile(path,file));
num_images = numel(info);
width = info.Width;
height = info.Height;

mov = zeros(height,width,num_images);
for k = 1:num_images
    mov(:,:,k) = imread(fullfile(path,file),k,'Info',info);
end
toc
clear file height info k num_images path width