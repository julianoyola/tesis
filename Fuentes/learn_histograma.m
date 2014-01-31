function [] = learn_histograma(archivoParametros)

addpath('0-Aprendizaje', 1);
addpath('1-Preprocesamiento', 1);
addpath('2-Deteccion', 1);
addpath('3-Seleccion', 1);
addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Obtiene un histograma promedio de los circulos indicados
%
%Entrada:
%       archivoParametros: archivo de parámetros 
%
%Salida:
%       histograma pormedio: en el archivo histograma_promedio.mat, lo deja
%       en la carpeta de salida
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

param = cargarParametrosPorCarpeta(archivoParametros, true);

fprintf('espacio de color es : %s\n', param.espacioColorHistogramas);

if (strcmp(param.espacioColorHistogramas, 'Lab'))

    suma_C1 = zeros(1,101);
    suma_C2 = zeros(1,256);
    suma_C3 = zeros(1,256);

    suma_C1C2 = zeros(256,101);
    suma_C1C3 = zeros(256,101);
    suma_C2C3 = zeros(256,256);
    
elseif (strcmp(param.espacioColorHistogramas, 'RGB'))
    
    suma_C1 = zeros(1,256);
    suma_C2 = zeros(1,256);
    suma_C3 = zeros(1,256);

    suma_C1C2 = zeros(256,256);
    suma_C1C3 = zeros(256,256);
    suma_C2C3 = zeros(256,256);
end
    
    
cantidad_ronchas = 0;

for i = 1 : param.cantArchivos
    
    contexto = struct;
    contexto.archivo = param.archivos(i);
    contexto.carpetaSalida = param.carpetaSalida;
    contexto.imagenes = struct;
    
    % 0. Cargar la imagen
    fprintf('----------\n');
    fprintf('Procesando imagen: %s\n', contexto.archivo.nombreArchivoImagen);

    contexto.imagenes.original = imread(contexto.archivo.nombreArchivoImagen);
    
    fprintf('Iniciando procesamiento imagen: %s\n', contexto.archivo.nombreArchivoImagen);

    % 1. Preprocesamiento de la imagen
    % para obtener la imagen en el espacio de color seleccionado
    [contexto.imagenes.preprocesada, contexto.imagenes.espacio_color] = preprocesar(contexto.imagenes.original, param.espacioColor, param.espacioColorHistogramas);
 
    
    % 2. Calculo de histogramas
    fprintf('Circulos indicados para esta imagen en el archivo de control\n');
    contexto.archivo.centros
   
    fprintf('Calculando histogramas\n');
    [histogramas, universo] = suma_histogramas(contexto.imagenes.espacio_color, contexto.archivo.centros, contexto.carpetaSalida, contexto.archivo.baseNombreArchivo, param.espacioColorHistogramas, param);

    suma_C1 = suma_C1 + histogramas.C1;
    suma_C2 = suma_C2 + histogramas.C2;
    suma_C3 = suma_C3 + histogramas.C3;

    suma_C1C2 = suma_C1C2 + histogramas.C1C2;
    suma_C1C3 = suma_C1C3 + histogramas.C1C3;
    suma_C2C3 = suma_C2C3 + histogramas.C2C3;
    
    cantidad_ronchas = cantidad_ronchas + size(contexto.archivo.centros,1);
    
    fprintf('Finalizado procesamiento imagen: %s\n', contexto.archivo.nombreArchivoImagen);
end

histograma_promedio.C1 = suma_C1/cantidad_ronchas;
histograma_promedio.C2 = suma_C2/cantidad_ronchas;
histograma_promedio.C3 = suma_C3/cantidad_ronchas;

histograma_promedio.C1C2 = suma_C1C2/cantidad_ronchas;
histograma_promedio.C1C3 = suma_C1C3/cantidad_ronchas;
histograma_promedio.C2C3 = suma_C2C3/cantidad_ronchas;

archivoSalida = strcat(contexto.carpetaSalida, '.histograma_promedio.mat');
fprintf('Guardando histograma promedio %s\n',archivoSalida);
save(archivoSalida, '-struct', 'histograma_promedio' );

archivoSalida = strcat(contexto.carpetaSalida, '.universo.mat');
fprintf('Guardando universo de vesiculas %s\n',archivoSalida);
save(archivoSalida, '-struct', 'universo' );

titulo = strcat(param.tituloPrueba, ' (Histograma promedio)');
fprintf('Graficando el histograma promedio %g %s\n', i, archivoSalida);
if (strcmp(param.espacioColorHistogramas, 'Lab'))
    dibujar_histogramas_LAB(archivoSalida, titulo);
elseif (strcmp(param.espacioColorHistogramas, 'RGB'))
    dibujar_histogramas_RGB(archivoSalida, titulo);
end
