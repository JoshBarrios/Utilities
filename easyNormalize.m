function normalized = easyNormalize(matrix)       % This function takes the matrix MATRIX and does a very simple "normalization" by setting the first value of all traces to zero. Time must be the second dimension of the matrix.

for k = 1:size(matrix,1)
    normalized(k,:) = matrix(k,:) - matrix(k,1);
end