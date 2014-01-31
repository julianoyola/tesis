function [seleccionados] = seleccionar_circulos(circulos,vradio,umbral)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Selecciona entre los circulos detectados según el acumulador
%
%Entrada:      
%       circulos: espacio de hough con circulos encontrados
%       vradio: radios a evaluar  
%       umbral: con el que se compara
%
%Salida:
%       seleccionados: circulos seleccionanados segun umbral (vector de: [y0, x0, radio, porcentaje acumulado])
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seleccionados = [];

for indice = 1:size(vradio,2)
    acum=circulos(:,:,indice);
    acum = double(acum);
% busco centro de posibles circulos
    y0circulo = []; x0circulo = [];
    acumUmbral = acum / (max(max(acum)));
    acumMax = imregionalmax(acumUmbral);
   % acumMax(1:291,1:181)
   
 %    figure;
 %    imagesc(acumUmbral);title(['Acumulador divido por el maximo acumulado del radio ', num2str(vradio(indice)) ]);
 %    colormap(gray(256));
    
 %    figure;
 %    imagesc(acumMax);title('Maximos del acumulador');
 %    colormap(gray(256));
    
    [potencial_y0, potencial_x0] = find(acumMax == 1);

    for k = 1:length(potencial_y0)
        if acumUmbral(potencial_y0(k),potencial_x0(k)) >= umbral
            y0circulo = [y0circulo;potencial_y0(k)];
            x0circulo = [x0circulo;potencial_x0(k)];
            
            seleccionados = [seleccionados;[potencial_y0(k),potencial_x0(k),vradio(indice),acumUmbral(potencial_y0(k),potencial_x0(k))]];
        end
    end
    
end
