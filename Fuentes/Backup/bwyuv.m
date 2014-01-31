function [ Y ] = bwyuv( A )
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);
[Y,U,V] = rgb2yuv(R,G,B);
