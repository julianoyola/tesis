function [ ] = grabarImagenResultado( contexto, imagen, descripcion, extension )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Guarda una imagen en la carpeta de resultados.
%
%Entrada:
%       contexto: información de contexto (carpeta de salida, nombre base, etc) 
%       imagen: imagen a grabar 
%       descripcion: descripción a concatenar a la imagen 
%       extension: extensión y formato del archivo 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputFile = strcat(contexto.carpetaSalida, contexto.archivo.baseNombreArchivo, ' (', descripcion, ').', extension);
imwrite(imagen, outputFile, extension);

end
