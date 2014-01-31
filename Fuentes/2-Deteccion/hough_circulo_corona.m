function [acum] = hough_circulo_corona(imbordes, rango_radio, incremento)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Detecta circulos a traves de hough para circulos, realizando una
%       transformacion del espacio, similar que para lineas. Utilizando la
%       formula del circulo: (x-x0)^2 + (y-y0)^2 = r^2
%
%Entrada:
%       archivo_imagen: imagen en blanco y negro de los bordes
%       rango_radio : rango de radios en que busca
%       incremento : incremento en el cual genera radios dentro del rango
%
%Salida:
%       x0circulo: coordenada de x con un posible circulo
%       y0circulo: coordenada de y con un posible circulo aplicando
%       acum     : acumulador de circulos deectados sin aplicar umbral
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    acum = zeros(size(imbordes));

    % busco los circulos de los radios indicados en vradio en la imagen 
    for radio=rango_radio(1):incremento:rango_radio(2)
       acum = acum + hough_circulo(imbordes, radio);
    end

end
