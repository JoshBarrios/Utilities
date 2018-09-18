function unpacked = UnpackCellofCells(cellOfCells)

unpacked = cellOfCells{1};

for k = 2:size(cellOfCells,1)
    num = size(cellOfCells{k},1);
    unpacked(end+1:end+num) = cellOfCells{k};
end