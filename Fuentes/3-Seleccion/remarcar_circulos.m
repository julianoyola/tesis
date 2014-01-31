function [resultado] = remarcar_circulos(imagen,seleccionados)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Dibuja los circulos descriptos en la variable circulos sobre la
%       imagen 
%
%Entrada:
%       imagen: imagen 
%       circulos: espacio de hough con circulos encontrados
%       vradio: radios a evaluar  
%
%Salida:
%       resultado: imagen con los circulos dibujados
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = size(imagen,1);
m = size(imagen,2);
circulo(1:n,1:m) = 0;

for indice = 1:size(seleccionados,1)
	a = seleccionados(indice,:);
  
% dibujo los circulos de radio vradio(indice)    
    centro = [a(1),a(2)];
    circulo = circulo + dibujar_circulos(centro,a(3),n,m);
end

resultado = im2double(imagen);
resultado(:,:,1) = resultado(:,:,1) + circulo;
resultado(:,:,2) = resultado(:,:,2) + circulo;
resultado(:,:,3) = resultado(:,:,3) + circulo;
resultado = imadjust(resultado, [0 1], [0 1]);
