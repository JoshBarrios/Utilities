function matrix = unpackCell(cellArray)

for k = 1:length(cellArray)
    matrix(:,k) = cell2mat(cellArray(k));
end