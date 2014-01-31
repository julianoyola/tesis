function obtener_matriz_ampolla(imagen, circulos, carpeta, nombreBase, espacioDeColor)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       obtiene la matriz de los pixeles de las ampollas 
%
%Entrada:
%       imagen: imagen en LAB o RGB 
%       circulos: vector de los siguientes pares (y0,x0,radio,acumulado(x0,y0))
%       carpeta: donde guardar el archivo de la matriz
%       nombreBase: de la imagen
%
%Salida:
%       Graba las matrices
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1 : size(circulos,1)

    y0 = circulos(i, 1);
    x0 = circulos(i, 2);
    radio = circulos(i, 3);
    
    [C1, C2, C3] = obtener_area_rocha(x0, y0, radio, imagen);

    ampolla.C1 = C1;
    ampolla.C2 = C2;
    ampolla.C3 = C3;
    
    nombreArchivo = strcat(carpeta, nombreBase, '_ampolla_', espacioDeColor, '_', num2str(i),'.mat');
    
    save(nombreArchivo, '-struct', 'ampolla' );

end
