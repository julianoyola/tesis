function MH = calcular_MH(vesicula, universo)
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
MH.C1 = mahal(vesicula.C1, universo.C1);
MH.C2 = mahal(vesicula.C2, universo.C2);
MH.C3 = mahal(vesicula.C3, universo.C3);

MH.C1C2 = mahal(vesicula.C1C2, universo.C1C2);
MH.C1C3 = mahal(vesicula.C1C3, universo.C1C3);
MH.C2C3 = mahal(vesicula.C2C3, universo.C2C3);

MH = [mean(MH.C1), mean(MH.C2), mean(MH.C3), mean(MH.C1C2), mean(MH.C1C3), mean(MH.C2C3)]; 
