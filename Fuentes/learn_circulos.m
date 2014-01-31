function [] = learn_circulos(archivoParametros)

addpath('1-Preprocesamiento', 1);
addpath('2-Deteccion', 1);
addpath('3-Seleccion', 1);
addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Realiza la detección de patrones de una enfermedad de la piel sobre las
%       imagen provistas, sin comparar con histograma promedio, para generar
%       una base de círculos.
%
%Entrada:
%       archivoParametros: archivo de parámetros 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

param = cargarParametros(archivoParametros, false);

for i = 1 : param.cantArchivos

    contexto = struct;
    contexto.archivo = param.archivos(i);
    contexto.carpetaSalida = param.carpetaSalida;
    contexto.imagenes = struct;
    
    % 0. Cargar la imagen
    fprintf('----------\n');
    fprintf('Procesando imagen: %s\n', contexto.archivo.nombreArchivoImagen);

    contexto.imagenes.original = imread(contexto.archivo.nombreArchivoImagen);
    
    % 1. Preprocesamiento de la imagen
    % a) Selección de un espacio de color óptimo
    % b) Ecualización del histograma
    % c) Detección de áreas de la piel
    fprintf('Preprocesando: espacio de color, ecualización de histograma\n');
    
    [contexto.imagenes.preprocesada, contexto.imagenes.espacio_color] = preprocesar(contexto.imagenes.original, param.espacioColor, param.espacioColorHistogramas);

    % 2. Detección de áreas de la piel
    fprintf('Preprocesando: detección de piel\n');
    
    areas_piel = detectar_piel(contexto.imagenes.original);

    % 3. Deteccion de patrones
    % a) Suavizacion de la imagen
    % b) Deteccion de bordes
    % c) Aplicacion de operaciones morfologicas
    % d) Deteccion de circulos
    fprintf('Realizando detección: suavización de imagen, detección de bordes, operaciones morfológicas, detección de círculos\n');

    [bordes, centros] = detectar(contexto, contexto.imagenes.preprocesada, areas_piel);

    % 4. Seleccion de candidatos
    % a) Seleccion de circulos según umbral
    % b) Deteccion de multiples ocurrencias
    % c) Comparación de histogramas
    fprintf('Seleccionando candidatos: umbralización, detección de múltiples ocurrencias, comparación de histogramas\n');

    %seleccionados = seleccionar(contexto.imagenes.espacio_color, centros, param.archivos(i).radios, contexto);
    seleccionados = learn_seleccionar_circulos(centros, param.archivos(i).radios);
    
    % 5. Generación de resultados (archivo imagen y archivo .out)
    fprintf('Calculando resultado\n');

    contexto.imagenes.resultado = remarcar_circulos(contexto.imagenes.original, seleccionados);
    grabarImagenResultado(contexto, contexto.imagenes.resultado, 'resultado', 'png');

    nombre_archivo_salida = strcat(contexto.carpetaSalida, contexto.archivo.baseNombreArchivo, '.out'); 
    save(nombre_archivo_salida, 'seleccionados', '-ascii', '-double');

    % 7. Mostrar resultado
    figure; 
    imshow(contexto.imagenes.resultado);

    for indice = 1 : size(seleccionados, 1)
        a = seleccionados(indice,:);
        text(a(2), a(1), strcat('y=', num2str(a(1),'%5.0f'), ' x=', num2str(a(2),'%5.0f'), ' r=', num2str(a(3),'%5.0f')));
    end

    text();

    fprintf('Finalizado procesamiento imagen: %s\n', contexto.archivo.nombreArchivoImagen);

end
