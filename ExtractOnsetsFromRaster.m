function [onsetTraces,onsets] = ExtractOnsetsFromRaster(rasterTraces)
%%

seqs = findseq(rasterTraces);
seqs = seqs(seqs(:,1) == 1 & ~(seqs(:,2) == 1),:);
onsets = seqs(:,2);
onsetTraces = zeros(size(rasterTraces));
onsetTraces(onsets) = 1;