function [ ] = test(  )
%DIBUJAR_LAB Summary of this function goes here
%   Detailed explanation goes here

addpath('0-Aprendizaje', 1);


	M = zeros(5);
    M(1,1) = 1;

	N = zeros(5);
    N(2,2) = 1;
    
	P = zeros(5);
    P(4,4) = 1;
    
    norm(M-N,1)
    norm(M-N,2)
    
    norm(M-P,1)
    norm(M-P,2)
    
end

