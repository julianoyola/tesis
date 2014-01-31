function numfrm=yuv2avi(yuvfilename,dims,avifilename,compression,fps)
%Imports YUV sequence and saves it as AVI
%numfrm=yuv2avi(yuvfilename,dims,avifilename,compression,fps)
%Version: 1.02, Date: 2006/05/25, author: Nikola Sprljan
%
%Input:
% yuvfilename - YUV sequence file
% dims - dimensions of the frame [width height]
% avifilename - name of the output AVI file
% compression - specifies compression for AVI, see help of the Matlab 
%               function 'avifile'
% fps - frames per second
%
%Output:
% numfrm - number of frames processed
%
%Uses:
% yuv2rgb.m (for converting into RGB)
% yuv_import.m (for importing the YUV frames)
% imresize.m (Matlab Image Toolbox)
%
%Example:
% numfrm = yuv2avi('city_CIF.yuv',[352 288],'test.avi','none',15);

numfrm = seq_frames(yuvfilename,dims);
%sizfrm = prod(dims);
avi = avifile(avifilename,'fps',fps,'quality',100,'colormap',gray(256),'compression',compression);
for i=1:numfrm 
    [Y, U, V] = yuv_import(yuvfilename,dims,1,i-1);
    yuv(:,:,1) = Y{1};
    yuv(:,:,2) = imresize(U{1},2,'bicubic');
    yuv(:,:,3) = imresize(V{1},2,'bicubic');
    rgb = yuv2rgb(Y{1},U{1},V{1});
    avi = addframe(avi,rgb);
    fprintf('Frame %d/%d\n',i,numfrm);
end;
avi = close(avi);
