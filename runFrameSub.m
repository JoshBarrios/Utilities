function [RFStrace] = runFrameSub(mov);

sub = mov(:,:,1:end-1) - mov(:,:,2:end);

RFS1 = mean(mov,1);
RFS2 = mean(RFS1,2);

RFStrace = squeeze(RFS2);