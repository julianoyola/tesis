function [] = learn_circulos(archivoParametros)

addpath('1-Preprocesamiento', 1);
addpath('2-Deteccion', 1);
addpath('3-Seleccion', 1);
addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Obtiene un circulos detectados de una lista de archivos con
%       imágenes de varicela
%
%Entrada:
%       archivoParametros: archivo de parámetros 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

param = cargarParametrosVicky(archivoParametros);
%circulos = [];

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
    % a) Selecciona de circulos sin umbral
%    [seleccionados,histogramas]= learn_seleccionar(imagen_espacio_color, centros, param.archivos(i).radios);
    fprintf('Seleccionando circulos\n');
    seleccionados = learn_seleccionar_circulos(centros, param.archivos(i).radios);
    
    % 5. Guardo los circulos en un archivo .out
    nombre_archivo_salida = strcat(contexto.carpetaSalida, contexto.archivo.baseNombreArchivo,'.out'); 
    save(nombre_archivo_salida, 'seleccionados', '-ascii', '-double');
      
     % 6. Marcado en imagen resultado
    fprintf('Calculando resultado\n');

    imagen_resultado = remarcar_circulos(imagen_original, seleccionados);

    % 7. Mostrar resultado
   % figure; imshow(imagen_resultado);
   grabarImagenResultado(contexto, imagen_resultado, 'resultado', 'png');

   fprintf('Finalizado procesamiento imagen: %s\n', contexto.archivo.nombreArchivoImagen);
end