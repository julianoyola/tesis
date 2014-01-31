function distancia = calcular_N1(histograma,histograma_referencia)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%      Calcula norma 1 de los distintos histogramas
%
%Entrada:
%       histograma: histograma a comparar 
%
%Salida:
%       distancia calculada
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

distancia_L = norm(histograma_referencia.C1 - histograma.C1,1);
distancia_A = norm(histograma_referencia.C2 - histograma.C2,1);
distancia_B = norm(histograma_referencia.C3 - histograma.C3,1);

distancia_LA = norm(histograma_referencia.C1C2 - histograma.C1C2,1);
distancia_LB = norm(histograma_referencia.C1C3 - histograma.C1C3,1);
distancia_AB = norm(histograma_referencia.C2C3 - histograma.C2C3,1);

distancia = [distancia_L, distancia_A, distancia_B, distancia_LA, distancia_LB, distancia_AB]; 
