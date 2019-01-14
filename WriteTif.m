stack = input('Which variable?   ');

name = input('Name the stack (with .tif extension)');

destination = uigetdir;

imwrite(uint16(stack(:,:,1)), fullfile(destination,name));

for k = 2:size(stack,3)
    imwrite(uint16(stack(:,:,k)), fullfile(destination,name), 'writemode', 'append');
end