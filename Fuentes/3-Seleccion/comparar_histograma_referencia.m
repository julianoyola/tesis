function [resultado,KL, distancia] = comparar_histograma_referencia(histograma,opcion,umbral)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Compara el histograma n con el de referencia, se utiliza la divergencia KL
%       o distancia cruzada.
%
%Entrada:
%       histograma: histograma a comparar 
%       opcion: AB, LA o LB
%       umbral: con el que comparar
%
%Salida:
%       resultado: valor de verdad de la comparacion con el histograma de
%       referencia
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

histograma_referencia = load('histograma_promedio.mat');

% hist_refe es una estructura, ver si es la mejor forma de guardarla
if (strcmp(opcion, 'AB'))
    vector_hist_refe = histograma_referencia.nAB(:);
elseif (strcmp(opcion, 'LA'))
    vector_hist_refe = histograma_referencia.nLA(:);
elseif (strcmp(opcion, 'LB'))
%    hist_refe = open('hist-ref-LB.mat');
    vector_hist_refe = histograma_referencia.nLB(:);
end

%vectorizo los histogramas 2D
vector_hist = histograma(:);

%calculo probabilidades
vector_hist_refe = vector_hist_refe/sum(vector_hist_refe) + eps;
vector_hist = vector_hist/sum(vector_hist) + eps;

matriz_para_calcular_distancia = [vector_hist_refe vector_hist];

%calculo distancia
%distancia = pdist(matriz_para_calcular_distancia);
%distancia cuadratica 

distancia = (vector_hist_refe - vector_hist)' * (vector_hist_refe - vector_hist); 

%calculo KLD
KL = kldiv(vector_hist,vector_hist_refe);

%fprintf('KLD: %5.3f\n ', KL);


resultado = (KL <= 100);
%resultado = (KL <= 2);
%resultado = (KL <= 0.171);
