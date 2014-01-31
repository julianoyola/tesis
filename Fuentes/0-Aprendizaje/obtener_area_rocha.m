function [C1, C2, C3] = obtener_area_rocha(x0, y0, radio, imagen_espacio_color)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Devuelve las componentes de la roncha 
%
%Entrada:
%       imagen_espacio_color: 
%       x0, y0, radio: del circulo
%
%Salida:
%       Componentes 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[n,m,k] = size(imagen_espacio_color);    

%fprintf('centro x0:  %d, centro y0: %d\n ', y0, x0);
if y0 - radio < 1
    yi = 1;
else
    yi = round(y0 - radio) + 1;
end

if y0 + radio > n
     yf = n;
else
     yf = round(y0 + radio);
end

C1=[]; C2=[]; C3=[];

for y = yi : yf
        
    if x0 - radio < 1
    xi = 1;
    else
       xi = round(x0 - radio) + 1;
    end

    if x0 + radio > m
       xf = m;
    else
       xf = round(x0 + radio);
    end

    for x = xi : xf

        distancia_al_centro = norm([y-y0 x-x0], 2);
        %fprintf('distancia_al_centro:  %d, y: %d, x: %d\n ', distancia_al_centro,y,x);

        if distancia_al_centro <= radio
            C1 = [C1; imagen_espacio_color(y, x, 1)];
            C2 = [C2; imagen_espacio_color(y, x, 2)];
            C3 = [C3; imagen_espacio_color(y, x, 3)];
        end
    end      
end
    