function [seleccionados] = learn_seleccionar_circulos(centros, radios)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       2. Deteccion de patrones
%       a) Suavizacion de la imagen
%       b) Deteccion de bordes
%       c) Aplicacion de operaciones morfologicas
%       d) Deteccion de circulos
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
