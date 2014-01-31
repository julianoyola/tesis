function [histogramas, universo] = suma_histogramas(imagen_espacio_color, circulos, carpetaSalida, baseNombreArchivo, espacio_color, param)
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
%       histogramas: histogramas sumados de los circulos, para cada una de las componentes
%       y combinada de dos en dos.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
if (strcmp(espacio_color, 'Lab'))
    
    suma_C1 = zeros(1,101);
    suma_C2 = zeros(1,256);
    suma_C3 = zeros(1,256);

    suma_C1C2 = zeros(256,101);
    suma_C1C3 = zeros(256,101);
    suma_C2C3 = zeros(256,256);
    
elseif (strcmp(espacio_color, 'RGB'))

    suma_C1 = zeros(1,256);
    suma_C2 = zeros(1,256);
    suma_C3 = zeros(1,256);

    suma_C1C2 = zeros(256,256);
    suma_C1C3 = zeros(256,256);
    suma_C2C3 = zeros(256,256);
    
end

universo.C1 = [];
universo.C2 = [];
universo.C3 = [];

for i = 1 : size(circulos,1)
      
    y0 = circulos(i, 1);
    x0 = circulos(i, 2);
    radio = circulos(i, 3);
    
    [C1, C2, C3] = obtener_area_rocha(x0, y0, radio, imagen_espacio_color);

    histograma = calcular_histogramas(C1, C2, C3, espacio_color);

    universo.C1 = [universo.C1 ; C1];
    universo.C2 = [universo.C2 ; C2];
    universo.C3 = [universo.C3 ; C3];
    
    archivoSalida = strcat(carpetaSalida, baseNombreArchivo, '_', num2str(i), '.histograma.mat');
    fprintf('Guardando histograma de la roncha  %g %s\n', i, archivoSalida);
    save(archivoSalida, '-struct', 'histograma' );
    
    fprintf('Graficando el histograma de la roncha  %g %s\n', i, archivoSalida);
    
    titulo = strcat(param.tituloPrueba, ' (', baseNombreArchivo, ':', num2str(i), ')');
    if (strcmp(espacio_color, 'Lab'))
        dibujar_histogramas_LAB(archivoSalida, titulo);
    elseif (strcmp(espacio_color, 'RGB'))
        dibujar_histogramas_RGB(archivoSalida, titulo);
    end
    
    suma_C1 = suma_C1 + histograma.C1;
    suma_C2 = suma_C2 + histograma.C2;
    suma_C3 = suma_C3 + histograma.C3;
    
    suma_C1C2 = suma_C1C2 + histograma.C1C2;
    suma_C1C3 = suma_C1C3 + histograma.C1C3;
    suma_C2C3 = suma_C2C3 + histograma.C2C3;

end

universo.C1C2 = [universo.C1 universo.C2];
universo.C1C3 = [universo.C1 universo.C3];
universo.C2C3 = [universo.C2 universo.C3];

histogramas.C1 = suma_C1;
histogramas.C2 = suma_C2;
histogramas.C3 = suma_C3;

histogramas.C1C2 = suma_C1C2;
histogramas.C1C3 = suma_C1C3;
histogramas.C2C3 = suma_C2C3;

%fprintf('histogramas.C1 \n')
%size (histogramas.C1)
