function [histogramas] = calcular_histogramas(C1, C2, C3, espacioColor)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Calcula los histogramas de cada una de las componentes y combinada de dos en componentes
%
%Entrada:
%       L, A, B: Componentes LAB
%       R, G, B: Componentes RGB
%
%Salida:
%       histogramas: histogramas calculados de cada una de las componentes
%       y combinada de dos en dos.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rangos de valores de cada componente:
% Lab
% L -> 0:100, A -> -127:128, B -> -127:128  
% RGB
% R -> 0:255, G -> 0:255, B -> 0:255

if (strcmp('Lab', espacioColor))
    rangoC1 = [0:100];
    rangoC2 = [-127:128];
    rangoC3 = [-127:128];
elseif (strcmp('RGB', espacioColor))
    rangoC1 = [0:255];
    rangoC2 = [0:255];
    rangoC3 = [0:255];
end

%calculo el histograma simple de la primera componente
histC1 = hist(C1, rangoC1);

%calculo el histograma simple de la segunda componente
histC2 = hist(C2, rangoC2);
 
%calculo el histograma simple de la tercera componente
histC3 = hist(C3, rangoC3);


%calculo el histograma bidimensional de las componentes 1 y 2 (L y A de
%LAB, R y G de RGB)
[histC1C2, xout, yout] = hist2d(C1, C2, rangoC1, rangoC2);

%calculo el histograma bidimensional de las componentes 1 y 3 (L y B de
%LAB, R y B de RGB)
[histC1C3, xout, yout] = hist2d(C1, C3, rangoC1, rangoC3);

%calculo el histograma bidimensional de las componentes 2 y 3 (A y B de
%LAB, G y B de RGB)
[histC2C3, xout, yout] = hist2d(C2, C3, rangoC2, rangoC3);

%guardo los histogramas calculados
histogramas.C1 = histC1;
histogramas.C2 = histC2;
histogramas.C3 = histC3;

histogramas.C1C2 = histC1C2;
histogramas.C1C3 = histC1C3;
histogramas.C2C3 = histC2C3;


