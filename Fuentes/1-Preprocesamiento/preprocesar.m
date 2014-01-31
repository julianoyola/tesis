function [imagen_preprocesada, imagen_color] = preprocesar(imagen, espacio_bw, espacio_color)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Preprocesar la imagen.
%       a) Seleccion de un espacio de color óptimo
%       b) Ecualizacion del histograma
%
%Entrada:
%       imagen: imagen
%       espacio_color: Espacio de color a utilizar para obtener la
%           luminancia (opciones: 'HSL' 'HSI' 'HSV' 'YCbCr' 'Lab')
%
%Salida:
%       imagen_preprocesada: imagen
%       imagen_espacio_color: imagen en el espacio de color elegido
%       areas_piel: matriz con ceros y unos que indican qué pixeles
%           corresponden a la piel
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Seleccion de un espacio de color óptimo
imagen_bw = obtener_imagen_bw(imagen, espacio_bw);
imagen_color = obtener_imagen_color(imagen, espacio_color);

% b) Ecualizacion del histograma
imagen_preprocesada = preprocesar_ecualizacion(imagen_bw);
%imagen_preprocesada = imagen_bw;

end


function imagen_bw = obtener_imagen_bw(imagen, espacio_color)

if (strcmp(espacio_color, 'Lab'))
    imagen_bw = convertir_lab_bw(imagen);
elseif (strcmp(espacio_color, 'YCbCr'))
    imagen_bw = convertir_ycbcr_bw(imagen);
elseif (strcmp(espacio_color, 'HSV'))
    imagen_bw = convertir_hsv_bw(imagen);
elseif (strcmp(espacio_color, 'HSL'))
    imagen_bw = convertir_hsl_bw(imagen);
elseif (strcmp(espacio_color, 'HSI'))
    imagen_bw = convertir_hsi_bw(imagen);
end

imagen_bw = double(imagen_bw);

end

function imagen_color = obtener_imagen_color(imagen, espacio_color)

if (strcmp(espacio_color, 'Lab'))
    imagen_color = convertir_lab(imagen);
elseif (strcmp(espacio_color, 'RGB'))
    imagen_color = imagen;
elseif (strcmp(espacio_color, 'YCbCr'))
    imagen_color = convertir_ycbcr(imagen);
end

imagen_color = double(imagen_color);

end

function [bw_ecualizada] = preprocesar_ecualizacion(bw)

% Scale values to range from 0 to 1
bw_ecualizada = bw/256; 
% Perform CLAHE
bw_ecualizada = adapthisteq(bw_ecualizada, 'NumTiles', [16 16], 'ClipLimit', 0.0025) * 256;

end

function bw = convertir_lab_bw(imagen)

% Convertir a espacio de color L*a*b
cform2lab = makecform('srgb2lab');
lab = applycform(imagen, cform2lab);
lab = double(lab);
bw = lab(:,:,1);

end

function lab = convertir_lab(imagen)

% Convertir a espacio de color L*a*b
cform2lab = makecform('srgb2lab');
lab = applycform(imagen, cform2lab);
lab = lab2double(lab);

end

function ycbcr = convertir_ycbcr(imagen)
    imagendouble = double(imagen);
    ycbcr = rgb2ycbcr(imagendouble);
end

function bw = convertir_ycbcr_bw(imagen)
    ycbcr = rgb2ycbcr(imagen);
    bw = ycbcr(:,:,3);
end

function hsv = convertir_hsv(imagen)
    hsv = rgb2hsv(imagen);
end

function bw = convertir_hsv_bw(imagen)
    hsv = rgb2hsv(imagen);
    bw = hsv(:,:,3);
end

function hsl = convertir_hsl(imagen)
    hsl = rgb2hsl(imagen);
end

function bw = convertir_hsl_bw(imagen)
    hsl = rgb2hsl(imagen);
    bw = hsl(:,:,3);
end

function hsi = convertir_hsi(imagen)
    hsi = rgb2hsi(imagen);
end

function bw = convertir_hsi_bw(imagen)
    hsi = rgb2hsi(imagen);
    bw = hsi(:,:,3);
end
