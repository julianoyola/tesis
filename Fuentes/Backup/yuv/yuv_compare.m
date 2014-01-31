function [PSNRY,PSNRU,PSNRV,MSEY,MSEU,MSEV]=yuv_compare(yuvfile1,yuvfile2,dims,frames,yuvformat)
%Compares two YUV sequences by computing PSNR
%[PSNRY,PSNRU,PSNRV,MSEY,MSEU,MSEV]=yuv_compare(yuvfile1,yuvfile2,dims)
%Version: 1.21, Date: 2007/08/29, author: Nikola Sprljan
%
%Input:
% yuvfile1 - first YUV sequence file
% yuvfile2 - second YUV sequence file
% dims - frame dimensions
% frames - [optional, default = full sequence] number of frames to compare
% yuvformat - [optional, default = 'YUV420_8']. YUV format, supported formats 
%             the same as in yuv_import.m
%
%Output:
% PSNRY, PSNRU, PSNRV - PSNR values of the sequence for each frame, for Y, 
%                       U and V, respectively
% MSEY, MSEU, MSEV - the same, but MSE
%
%Uses: 
% seq_frames.m
% yuv_import.m 
% iq_measures.m (Quality Assessment toolbox - computation of MSE and PSNR)
%
%Example:
% [PY, PU, PV]=yuv_compare('compressed.yuv','original.yuv',[352 288]);

if (nargin < 4)
    frames = Inf;
end;
if (nargin < 5)
    yuvformat = 'YUV420_8';
end;
numfrm1 = seq_frames(yuvfile1,dims,yuvformat);
numfrm2 = seq_frames(yuvfile2,dims,yuvformat);
numfrm = min([numfrm1 numfrm2 frames]);
PSNRY = zeros(numfrm,1);PSNRU = zeros(numfrm,1);PSNRV = zeros(numfrm,1);
MSEY = zeros(numfrm,1);MSEU = zeros(numfrm,1);MSEV = zeros(numfrm,1);
for i=1:numfrm 
    [Y1, U1, V1] = yuv_import(yuvfile1,dims,1,i-1,yuvformat);
    [Y2, U2, V2] = yuv_import(yuvfile2,dims,1,i-1,yuvformat);

    [MSEY(i),PSNRY(i)] = iq_measures(Y1{1},Y2{1});
    [MSEU(i),PSNRU(i)] = iq_measures(U1{1},U2{1});
    [MSEV(i),PSNRV(i)] = iq_measures(V1{1},V2{1});    
end;
