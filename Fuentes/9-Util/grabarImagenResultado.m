function [ ] = grabarImagenResultado( contexto, imagen, descripcion, extension )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Guarda una imagen en la carpeta de resultados.
%
%Entrada:
%       contexto: informaci�n de contexto (carpeta de salida, nombre base, etc) 
%       imagen: imagen a grabar 
%       descripcion: descripci�n a concatenar a la imagen 
%       extension: extensi�n y formato del archivo 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputFile = strcat(contexto.carpetaSalida, contexto.archivo.baseNombreArchivo, ' (', descripcion, ').', extension);
imwrite(imagen, outputFile, extension);

end
