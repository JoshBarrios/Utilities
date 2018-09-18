function out = threshFind(subPics)
%%
viewPic1 = subPics(:,:,125);
viewPic2 = subPics(:,:,10250);
viewPic3 = subPics(:,:,50000);
viewPic4 = subPics(:,:,120000);
% imBW = false(size(viewPic),'gpuArray');

figT = figure('position',[360 500 400 400]);

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .2, 0.5])
thresh = uicontrol('style','slider','min',0,'max',100,'position',[150 10 200 20]);
TextH = uicontrol('style','text','position',[10 340 40 15]);

addlistener(thresh, 'Value', 'PostSet', @callbackfn);
movegui(figT, 'center')

    function callbackfn(source,eventdata)
        num = get(eventdata.AffectedObject,'Value');
        
        ind1 = find(viewPic1 > num);
        imBW1 = false(size(viewPic1));
        imBW1(ind1) = 1;
        skel1 = findTailSkel(imBW1);
        ind2 = find(viewPic2 > num);
        imBW2 = false(size(viewPic2));
        imBW2(ind2) = 1;
        skel2 = findTailSkel(imBW2);
        ind3 = find(viewPic3 > num);
        imBW3 = false(size(viewPic3));
        imBW3(ind3) = 1;
        skel3 = findTailSkel(imBW3);
        ind4 = find(viewPic4 > num);
        imBW4 = false(size(viewPic4));
        imBW4(ind4) = 1;
        skel4 = findTailSkel(imBW4);
        
        subplot(2,2,1)
        imshow(skel1);
        subplot(2,2,2)
        imshow(skel2);
        subplot(2,2,3)
        imshow(skel3);
        subplot(2,2,4)
        imshow(skel4);
        
        TextH.String = num2str(num);
    end
out = thresh;
end