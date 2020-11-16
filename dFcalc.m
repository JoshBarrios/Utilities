function dff = dFcalc (img, varargin)
% Computes normalized fluorescence image given a raw fluorescence image
% over time
% img, raw fluorescence movie
% method, method of computation ('simple' or 'frame')

method = varargin{1};

switch method
    case 'simple'
        tic;
        f0 = img(:,:,1);
        dff = zeros(size(img));
        
        for k = 1:size(img,3)
            
            f = img(:,:,k);
            dff(:,:,k) = (f-f0)./f0;
        end
        display(strcat('Finished calculating dF/F ',num2str(toc),'s elapsed'));

        
    case 'frame'
        tic;
        ff = mean(img(:));
        mfxy = mean(img,3);
        dff = zeros(size(img));
        
        parfor k = 1:size(img,3)
            
            f = img(:,:,k);
            dff(:,:,k) = arrayfun(@(f,mfxy) (f-mfxy)/(mfxy+ff),f,mfxy);
            
        end
        display(strcat('Finished calculating dF/F ',num2str(toc),'s elapsed'));
end
end

            
            