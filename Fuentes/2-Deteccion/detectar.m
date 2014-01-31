function [bordes, centros] = detectar(contexto, imagen, areas_piel)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       2. Deteccion de patrones
%       a) Suavizacion de la imagen
%       b) Deteccion de bordes
%       c) Aplicacion de operaciones morfologicas
%       d) Deteccion de circulos
%
%Entrada:
%       contexto: información de contexto (archivo que se está procesando, radios, 
%                 carpeta de salida, etc)
%       imagen: imagen 
%       areas_piel: matriz de ceros y unos que indica los pixeles que
%                   corrresponden a áreas de la piel
%
%Salida:
%       bordes: imagen de los bordes (canny + operaciones morfologicas)
%       centros: acumulador de circulos encontrados
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

radios = contexto.archivo.radios;

% Canny
% a) Suavizacion de la imagen
% b) Deteccion de bordes
imbordes = edge(imagen, 'canny', [0.15 0.4], 2);
%imbordes=edge(bw,'canny',[0.1 0.45]);
%imbordes=edge(bw,'canny',[0.1 0.2]);
%imbordes=edge(bw,'canny',[0.1 0.17]);
%imbordes=edge(bw,'canny');

% Grabar archivo de bordes detectados (sólo bordes)
%figure; imshow(imbordes);
grabarImagenResultado(contexto, imbordes, 'bordes detectados', 'png');


% c) Aplicacion de operaciones morfologicas
imbridges = bwmorph(imbordes, 'bridge');
%imclose = bwmorph(imbordes,'close');
%imclose = imbridges;
%imclose = bwmorph(imbridges,'close');

% Grabar archivo de bordes detectados + op.morf (sólo bordes)
%figure; imshow(imbridges);
grabarImagenResultado(contexto, imbridges, 'bordes con op.morf', 'png');

% Filtrado con el área detectada de la piel
imbridges = imbridges & areas_piel;


% d) Deteccion de circulos
% Buscar los circulos de los radios indicados en vradio en la imagen 
him = zeros(size(imagen,1),size(imagen,2),1);
for radio = 1:size(radios,2);
    acum = hough_circulo(imbridges,radios(radio));
    him(:,:,radio) = acum;
end

bordes = imbridges;
centros = him;

% Guardar la imagen original con los bordes detectados
imagen_con_bordes = im2double(contexto.imagenes.original);
imagen_con_bordes(:,:,1) = imagen_con_bordes(:,:,1) + bordes;
imagen_con_bordes(:,:,2) = imagen_con_bordes(:,:,2) + bordes;
imagen_con_bordes(:,:,3) = imagen_con_bordes(:,:,3) + bordes;
imagen_con_bordes = imadjust(imagen_con_bordes, [0 1], [0 1]);

%     figure;
%     imshow(imagen_con_bordes); title('Imagen original con bordes detectados');
%     colormap(gray(256));

grabarImagenResultado(contexto, imagen_con_bordes, 'imagen con bordes', 'png');
