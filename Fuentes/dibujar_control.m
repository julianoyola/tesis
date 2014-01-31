function [ ] = dibujar_control( archivo_imagen )

addpath('1-Preprocesamiento', 1);
addpath('2-Deteccion', 1);
addpath('3-Seleccion', 1);
addpath('9-Util', 1);

    close all;

    A = imread(archivo_imagen);
    control = load(strcat(archivo_imagen, '.control'));

    B = remarcar_circulos(A, control);
    imshow(B);

end
