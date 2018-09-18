function bgsubtracted = bgsubtract(mov)

maxproj = uint8(max(mov,[],3));
bgsubtracted = uint8(zeros(size(mov)));
for k = 1:size(mov,3)
    bgsubtracted(:,:,k) = maxproj - mov(:,:,k);
end