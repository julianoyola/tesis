function [seleccionados] = evaluar_histogramas(imagen_espacio_color, circulos, carpeta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Calcula los histogramas de los circulos y mide que tan lejos esta del
%       registrado como histograma promedio utilizando KLD y distintas normas 
%
%Entrada:
%       imagen_espacio_color: 
%       circulos: vector de los siguientes pares (y0,x0,radio,acumulado(x0,y0))
%
%Salida:
%       seleccionados: circulos que estan 'cerca' del histograma de
%       referencia y sus mediciones
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seleccionados=[];

archivo = strcat(carpeta, '\histograma_promedio.mat');
histograma_referencia = load(archivo);

archivo = strcat(carpeta, '\universo.mat');
universo = load(archivo);

for i = 1 : size(circulos,1)

    y0 = circulos(i, 1);
    x0 = circulos(i, 2);
    radio = circulos(i, 3);
    
    [L, A, B] = obtener_area_rocha(x0, y0, radio, imagen_espacio_color);

    vesicula.C1 = L;
    vesicula.C2 = A;
    vesicula.C3 = B;
    vesicula.C1C2 = [L A];
    vesicula.C1C3 = [L B];
    vesicula.C2C3 = [A B];
    histograma = calcular_histogramas(L, A, B, 'Lab');
   
   % Calcular normas (distancias) y KLD con el histograma promedio 
    KLD = calcular_KLD(histograma,histograma_referencia);
    N1 = calcular_N1(histograma,histograma_referencia);
    N2 = calcular_N2(histograma,histograma_referencia);   
    MH = calcular_MH(vesicula, universo);
    H2T = calcular_H2T(vesicula, universo);
   % media = calcular_media(histograma);
    
    % Comparo con un umbral las distancias y el KLD 
%     esta_cerca_histo_ref_KLD = comparar_histograma_referencia(KLD,5);
%     esta_cerca_histo_ref_N1  = comparar_histograma_referencia(N1,5);
%     esta_cerca_histo_ref_N2  = comparar_histograma_referencia(N2,5);
    
     seleccionado = 0;    
    
  %  if (esta_cerca_histo_ref_KLD == true) && (esta_cerca_histo_ref_N1 == true) && (esta_cerca_histo_ref_N2 == true)
  %      seleccionado = 1;
  %  end

%   seleccionados = [seleccionados; circulos(i,:), KLD, N1, N2, media];

   seleccionados = [seleccionados; circulos(i,:), KLD, N1, N2, MH, H2T];
end
