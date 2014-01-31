function [] = learn_circulos(archivoParametros)

addpath('1-Preprocesamiento', 1);
addpath('2-Deteccion', 1);
addpath('3-Seleccion', 1);
addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Realiza la detecci�n de patrones de una enfermedad de la piel sobre las
%       imagen provistas, sin comparar con histograma promedio, para generar
%       una base de c�rculos.
%
%Entrada:
%       archivoParametros: archivo de par�metros 
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
    % a) Selecci�n de un espacio de color �ptimo
    % b) Ecualizaci�n del histograma
    % c) Detecci�n de �reas de la piel
    fprintf('Preprocesando: espacio de color, ecualizaci�n de histograma\n');
    
    [contexto.imagenes.preprocesada, contexto.imagenes.espacio_color] = preprocesar(contexto.imagenes.original, param.espacioColor, param.espacioColorHistogramas);

    % 2. Detecci�n de �reas de la piel
    fprintf('Preprocesando: detecci�n de piel\n');
    
    areas_piel = detectar_piel(contexto.imagenes.original);

    % 3. Deteccion de patrones
    % a) Suavizacion de la imagen
    % b) Deteccion de bordes
    % c) Aplicacion de operaciones morfologicas
    % d) Deteccion de circulos
    fprintf('Realizando detecci�n: suavizaci�n de imagen, detecci�n de bordes, operaciones morfol�gicas, detecci�n de c�rculos\n');

    [bordes, centros] = detectar(contexto, contexto.imagenes.preprocesada, areas_piel);

    % 4. Seleccion de candidatos
    % a) Seleccion de circulos seg�n umbral
    % b) Deteccion de multiples ocurrencias
    % c) Comparaci�n de histogramas
    fprintf('Seleccionando candidatos: umbralizaci�n, detecci�n de m�ltiples ocurrencias, comparaci�n de histogramas\n');

    %seleccionados = seleccionar(contexto.imagenes.espacio_color, centros, param.archivos(i).radios, contexto);
    seleccionados = learn_seleccionar_circulos(centros, param.archivos(i).radios);
    
    % 5. Generaci�n de resultados (archivo imagen y archivo .out)
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
