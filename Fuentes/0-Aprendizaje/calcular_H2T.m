function H2T = calcular_H2T(vesicula, universo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Calcula KLD de los distintos histogramas
%
%Entrada:
%       histograma: histogramas a comparar 
%
%Salida:
%       kld: calculo kld 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculo los KLD simetricos
% H2T.C1 = mahal(vesicula.C1, universo.C1);
% H2T.C2 = mahal(vesicula.C2, universo.C2);
% H2T.C3 = mahal(vesicula.C3, universo.C3);

clase1 = ones(size(vesicula.C1C2, 1),1);
clase2 = ones(size(universo.C1C2, 1),1) * 2;

c1c2 = [[clase1 vesicula.C1C2]; [clase2 universo.C1C2]];
c1c3 = [[clase1 vesicula.C1C3]; [clase2 universo.C1C3]];
c2c3 = [[clase1 vesicula.C2C3]; [clase2 universo.C2C3]];
%save('c:\users\joyola\desktop\test.mat', 'c1c2');
%MBoxtest(c1c2)

%T2Hot2ihe(c1c2)

H2T.C1C2 = T2Hot2ihe(c1c2);
H2T.C1C3 = T2Hot2ihe(c1c3);
H2T.C2C3 = T2Hot2ihe(c2c3);

H2T = [H2T.C1C2.P, H2T.C1C3.P, H2T.C2C3.P]; 
