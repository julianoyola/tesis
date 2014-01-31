function [] = learn(archivoParametros)

addpath('1-Preprocesamiento', 1);
addpath('2-Deteccion', 1);
addpath('3-Seleccion', 1);
addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Obtiene un histograma promedio de una lista de archivos con
%       imágenes de varicela
%
%Entrada:
%       archivoParametros: archivo de parámetros 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

param = cargarParametros(archivoParametros);

suma_nLA = zeros(32,11);
suma_nLB = zeros(32,11);
suma_nAB = zeros(32,32);

cantidad_ronchas = 0;

for i = 1 : param.cantArchivos

    contexto = struct;
    contexto.archivo = param.archivos(i);
    contexto.carpetaSalida = param.carpetaSalida;
    contexto.imagenes = struct;
    
    % 0. Cargar la imagen
    imagen_original = imread(contexto.archivo.nombreArchivoImagen);

    % 1. Preprocesamiento de la imagen
    % a) Selección de un espacio de color óptimo
    % b) Ecualización del histograma
    % c) Detección de áreas de la piel
    [imagen_preprocesada,imagen_espacio_color] = preprocesar(imagen_original, param.espacioColor);
    contexto.imagenes.original = imagen_original;
    
    % 2. Detección de áreas de la piel
    areas_piel = detectar_piel(imagen_original);

    % 3. Deteccion de patrones
    % a) Suavizacion de la imagen
    % b) Deteccion de bordes
    % c) Aplicacion de operaciones morfologicas
    % d) Deteccion de circulos
    [bordes, centros] = detectar(contexto, imagen_preprocesada, areas_piel);

    % 4. Seleccion de candidatos
    % a) Selecciona de circulos segun umbral
    % b) Deteccion de multiples ocurrencias
    % c) Comparación de histogramas
    [seleccionados,histogramas]= learn_seleccionar(imagen_espacio_color, centros, param.archivos(i).radios);

    nLA = histogramas.nLA;
    nLB = histogramas.nLB;
    nAB = histogramas.nAB;
    
    suma_nLA = suma_nLA + nLA;
    suma_nLB = suma_nLB + nLB;
    suma_nAB = suma_nAB + nAB;
   
    cantidad_ronchas = cantidad_ronchas + size(seleccionados,1);
    
end

histograma_referencia.nLA = suma_nLA/cantidad_ronchas;
histograma_referencia.nLB = suma_nLB/cantidad_ronchas;
histograma_referencia.nAB = suma_nAB/cantidad_ronchas;

save('histograma_referencia.mat', '-struct', 'histograma_referencia' );