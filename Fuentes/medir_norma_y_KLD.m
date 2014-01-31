function [] = medir_norma_y_KLD(carpeta)

addpath('0-Aprendizaje', 1);
addpath('1-Preprocesamiento', 1);
addpath('2-Deteccion', 1);
addpath('3-Seleccion', 1);
addpath('3-Seleccion\h2t', 1);
addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Mide los indicadores
%
%Entrada:
%       carpeta: archivo de parámetros 
%       histograma de referencia: debe estar en la carpeta
%
%Salida:
%       mediciones: mediciones de las normas 1 y 2 y de KLD
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

fprintf('medir_normas_y_KLD\n');
param = cargarParametrosPorCarpeta(carpeta, true);

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
  
    % 2. Calculo de KLD , N1 y N2
    fprintf('Circulos indicados para esta imagen en el archivo de control\n');
    contexto.archivo.centros
   
    seleccionados = evaluar_histogramas(contexto.imagenes.espacio_color, contexto.archivo.centros,carpeta);

    % 3. Resultados
    fprintf('Guardando resultados\n');
    
    nombreArchivo = strcat(contexto.carpetaSalida, contexto.archivo.baseNombreArchivo, '-mediciones.dat');
    fprintf('Guardando resultados %s\n',nombreArchivo);
    csvwrite(nombreArchivo, seleccionados);

end
