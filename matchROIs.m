% Make new ROI list, dF/F traces and shit go to the places of the original
% like after this, say finalThing = new(sortIDX);

function sortIDX = matchROIs(original,new)

sortIDX = zeros(1,length(original));

for k = 1:length(original)
    o = original(k);
    for l = 1:length(new)
        n = new(l);
        sizeTest = size(o) == size(n);
        sizeTest = logical(sizeTest(1) * sizeTest(2));
        if sizeTest
            if o == n
                sortIDX(l) = k;
            end
        end
    end
end
        