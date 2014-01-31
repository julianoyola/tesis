function distancia = calcular_N1(histograma)
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

histograma_referencia = load('histograma_promedio.mat');

norm()


distancia.L = ((histograma_referencia.L/(sum(histograma_referencia.L+eps)) - (histograma.L/sum(histograma.L)+eps))' * ((histograma_referencia.L/sum(histograma_referencia.L)+eps))
distancia.A = ((histograma_referencia.A/(sum(histograma_referencia.A)+eps)) - (histograma.A/sum(histograma.A)+eps))' * ((histograma_referencia.A/sum(histograma_referencia.A)+eps));
distancia.B = ((histograma_referencia.B/(sum(histograma_referencia.B)+eps)) - (histograma.B/sum(histograma.B)+eps))' * ((histograma_referencia.B/sum(histograma_referencia.B)+eps)); 

distancia.LA = ((histograma_referencia.LA(:)/(sum(histograma_referencia.LA(:))+eps) - (histograma.LA(:)/sum(histograma.LA(:))+eps))' * ((histograma_referencia.LA(:)/sum(histograma_referencia.LA(:))+eps));
distancia.LB = ((histograma_referencia.LB(:)/(sum(histograma_referencia.LB(:))+eps) - (histograma.LB(:)/sum(histograma.LB(:))+eps))' * ((histograma_referencia.LB(:)/sum(histograma_referencia.LB(:))+eps));
distancia.AB = ((histograma_referencia.AB(:)/(sum(histograma_referencia.AB(:))+eps) - (histograma.AB(:)/sum(histograma.AB(:))+eps))' * ((histograma_referencia.AB(:)/sum(histograma_referencia.AB(:))+eps));