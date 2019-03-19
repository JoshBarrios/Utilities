%% Josh Barrios 2/19/19
% Takes a string and an index value and looks for a number following that
% index. Intended to find fish numbers and trial numbers in filenames.
% Start the string with the index after 'Fish' or 'F' and go to end.

function num = findNum(string)

if ~isempty(string)
    for k = 1:length(string)
        numBool(k) = ~isnan(str2double(string(k)));
    end
    
    seqs = findseq(single(numBool));
    
    if ~isempty(seqs)                   % seqs doesn't find single numbers
        num = str2double(string(seqs(1,2):seqs(1,3)));
    else
        inds = find(numBool);
        num = inds(1);
    end
else
    num = NaN;
end