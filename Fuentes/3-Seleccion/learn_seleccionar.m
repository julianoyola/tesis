function [seleccionados,histogramas] = learn_seleccionar(imagen_espacio_color, centros, radios)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       2. Deteccion de patrones
%       a) Suavizacion de la imagen
%       b) Deteccion de bordes
%       c) Aplicacion de operaciones morfologicas
%       d) Deteccion de circulos
%       e) Comparacion de histogramas bidimensionales con KLD
%
%Entrada:
%       imagen_espacio_color: imagen en el espacio de color seleccionado 
%       radios : vector de radios de circulos a buscar
%
%Salida:
%       imagen_candidatos: imagen
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Selecciona de circulos segun umbral
seleccionados = seleccionar_circulos(centros, radios, 0.9);

% b) Deteccion de multiples ocurrencias
seleccionados = detectar_duplicados(seleccionados, 2);

%seleccionados = detectar_falsos(imagen_preprocesada, seleccionados, 1.5);

% c) Calcula de histogramas
histogramas = calcular_histogramas(imagen_espacio_color, seleccionados);

