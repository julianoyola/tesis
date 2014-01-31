function [seleccionados] = detectar_duplicados(circulos, k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Detecta los circulos duplicados, de acuerdo a si son levemente
%       concentricos
%
%Entrada:
%       circulos: espacio de hough con circulos encontrados
%       k: indice que indica qué tan cercanos deben estar los centros de
%       los circulos, para que se los considere duplicados.
%
%Salida:
%       circulos: espacio de hough con circulos encontrados, con los
%       duplicados eliminados
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seleccionados = [];

for i = size(circulos,1) : -1 : 1
    
    y1 = circulos(i, 1);
    x1 = circulos(i, 2);
    r1 = circulos(i, 3);
    p1 = circulos(i, 4);
    
    estaDuplicado = false;
    
    for j = 1 : size(circulos,1)
        
        y2 = circulos(j, 1);
        x2 = circulos(j, 2);
        r2 = circulos(j, 3);
        p2 = circulos(j, 4);
        
        d = norm([y1-y2, x1-x2], 2);
        sonConcentricos = (d <= max(r1,r2) * k);
        estaDuplicado = estaDuplicado || (sonConcentricos && (p1 < p2 || p1==p2 && i<j));
    end

    if (estaDuplicado == false)
        seleccionados = [seleccionados; circulos(i,:) ];
    end
    
end


