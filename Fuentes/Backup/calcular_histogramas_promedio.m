function [histogramas, universo] = suma_histogramas(imagen_espacio_color, circulos)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Calcula los histogramas promedio de los circulos. De una componente
%       y dos componentes
%
%Entrada:
%       imagen_espacio_color: 
%       circulos: vector de los siguientes pares (y0,x0,radio,acumulado(x0,y0))
%
%Salida:
%       histogramas: histogramas promedios calculados de cada una de las componentes
%       y combinada de dos en dos.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[n,m,k] = size(imagen_espacio_color);

suma_L = zeros(1,101);
suma_A = zeros(1,256);
suma_B = zeros(1,256);

suma_LA = zeros(256,101);
suma_LB = zeros(256,101);
suma_AB = zeros(256,256);

universo.L = [];
universo.A = [];
universo.B = [];

for i = 1 : size(circulos,1)
      
    y0 = circulos(i, 1);
    x0 = circulos(i, 2);
    radio = circulos(i, 3);
    
    [L, A, B] = area_rocha(x0, y0, radio, imagen_espacio_color);

    universo.L = [universo.L ; L];
    universo.A = [universo.A ; A];
    universo.B = [universo.B ; B];
    

    %rangos de valores de cada componente:
    % L -> 0:100, A -> -127:128, B -> -127:128
        
    %calculo el histograma simple de la componentes L de LAB
    histL = hist(L,[0:100]);

    %calculo el histograma simple de la componentes A de LAB
    histA = hist(A,[-127:128]);
 
    %calculo el histograma simple de la componentes B de LAB
    histB = hist(B,[-127:128]);
    

    %calculo el histograma bidimensional de las componentes L y A de LAB
    [LA,xout,yout] = hist2d(L, A, [0:100], [-127:128]);

    %calculo el histograma bidimensional de las componentes L y B de LAB
    [LB,xout,yout] = hist2d(L, B, [0:100], [-127:128]);

    %calculo el histograma bidimensional de las componentes A y B de LAB
    [AB,xout,yout] = hist2d(A, B, [-127:128]);

    suma_L = suma_L + histL;
    suma_A = suma_A + histA;
    suma_B = suma_B + histB;
    
    suma_LA = suma_LA + LA;
    suma_LB = suma_LB + LB;
    suma_AB = suma_AB + AB;

end

universo.LA = [universo.L universo.A];
universo.LB = [universo.L universo.B];
universo.AB = [universo.A universo.B];

histogramas.L = suma_L;
histogramas.A = suma_A;
histogramas.B = suma_B;

histogramas.LA = suma_LA;
histogramas.LB = suma_LB;
histogramas.AB = suma_AB;