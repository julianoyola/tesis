function [areas_piel] = detectar_piel(imagen)

[M,N,P] = size(imagen);
% 
% umbral = 0.05;
% 
% % Convertir a espacio de color L*a*b
% cform2lab = makecform('srgb2lab');
% lab = applycform(imagen, cform2lab);
% lab = lab2double(lab);
% a = lab(:,:,2);
% b = lab(:,:,3);
% 
% areas_piel = zeros([M,N]);
% 
% chart = load('chart.txt', '-ascii');
% 
% for i = 1 : M
%     for j = 1 : N
%         [ia,ib] = ab2ind(a(i,j),b(i,j));
%         
%         areas_piel(i,j) = chart(ia, ib);% > umbral;
%     end
% end

% Detección de Rostros Humanos en Posición Frontal en Imágenes a Color
% Utilizando Propiedades Estadísticas de la Piel Humana Junto con el Método de Concordancia con el Rostro Plantilla
% Marlon Fabián Macías Sánchez (1), Patricia X. Chávez Burbano (2)
% a ? [-10, 60] y b ? [-10, 40]

areas_piel = ones([M,N]);

end