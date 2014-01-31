function KLD = calcular_KLD(histograma,histograma_referencia)
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
KLD_L = kldiv((histograma.C1/sum(histograma.C1)+eps),(histograma_referencia.C1/sum(histograma_referencia.C1)+eps),'sym');
KLD_A = kldiv((histograma.C2/sum(histograma.C2)+eps),(histograma_referencia.C2/sum(histograma_referencia.C2)+eps),'sym');
KLD_B = kldiv((histograma.C3/sum(histograma.C3)+eps),(histograma_referencia.C3/sum(histograma_referencia.C3)+eps),'sym');

KLD_LA = kldiv((histograma.C1C2(:)/sum(histograma.C1C2(:))+eps),(histograma_referencia.C1C2(:)/sum(histograma_referencia.C1C2(:))+eps),'sym');
KLD_LB = kldiv((histograma.C1C3(:)/sum(histograma.C1C3(:))+eps),(histograma_referencia.C1C3(:)/sum(histograma_referencia.C1C3(:))+eps),'sym');
KLD_AB = kldiv((histograma.C2C3(:)/sum(histograma.C2C3(:))+eps),(histograma_referencia.C2C3(:)/sum(histograma_referencia.C2C3(:))+eps),'sym');

KLD = [KLD_L, KLD_A, KLD_B, KLD_LA, KLD_LB, KLD_AB]; 



