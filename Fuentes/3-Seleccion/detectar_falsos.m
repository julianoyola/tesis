function [seleccionados] = detectar_duplicados(imagen, circulos, t, k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Detecta los circulos falsos
%
%Entrada:
%       imagen: imagen 
%       circulos: espacio de hough con circulos encontrados
%       t: tamaño del area alrededor del circulo, en relacion al radio
%       k:
%
%Salida:
%       circulos: espacio de hough con circulos encontrados, con los
%       falsos eliminados
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

seleccionados = [];

for i = 1 : size(circulos, 1)
    
    y1 = circulos(i, 1);
    x1 = circulos(i, 2);
    r1 = circulos(i, 3);
    p1 = circulos(i, 4);
    
    l = t * r1;
    
    hsv = rgb2hsv(imagen);
    h = hsv(:,:,1);
    
    fromx = max(x1-l,1)
    tox = min(x1+l,size(h,2))
    fromy = max(y1-l,1)
    toy = min(y1+l,size(h,1))
    
    sector = h(fromy:toy, fromx:tox);
    [bins,repet] = histog2(sector);
%    pause;
    bar([bins,repet]);
    %pause;
    [d, r] = maxlloyd(bins, repet, 2, 5);
    q = quant2(sector, d, r);
    
    figure;
    imshow(q);
    
end

