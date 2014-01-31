function [seleccionados] = seleccionar(imagen_espacio_color, centros, radios, contexto)

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
%       centros: de los circulos
%       radios : vector de radios de circulos a buscar
%       contexto: variables de contexto
%
%Salida:
%       seleccionados: circulos seleccionados
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Selecciona de circulos segun umbral
seleccionados = seleccionar_circulos(centros, radios, 0.9);

% b) Deteccion de multiples ocurrencias
seleccionados = detectar_duplicados(seleccionados, 2);

% c) Comparación de histogramas
%seleccionados = evaluar_histogramas(imagen_espacio_color, seleccionados,contexto.carpetaEntrada);

