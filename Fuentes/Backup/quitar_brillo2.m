
function [RGB, J, bw] = quitar_brillo2(archivo_imagen)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%
%Entrada:
%       archivo_imagen: imagen en una matriz 
%
%Salida:
%       RGB: Imagen original en RGB
%       J  : Imagen original sin brillo en RGB
%       bw:  Imagen sin brillo en blanco y negro
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RGB=imread(archivo_imagen);
figure, image(RGB);  title('Imagen original');

% Convertir a espacio de color de luminancia
cform2lab = makecform('srgb2lab');
LAB = applycform(RGB, cform2lab); 
LAB = double(LAB);
bw = LAB(:,:,1);

% Mostrar la imagen en BW
figure, image(bw);title('Imagen en BW');
colormap(gray(256));

% Scale values to range from 0 to 1
bw = bw/256; 

% Perform CLAHE
bw = adapthisteq(bw,'NumTiles',[16 16],'ClipLimit',0.0025)*256;

figure, image(bw);title('Imagen en bw con contraste aplicado');
colormap(gray(256));

% Convert back to RGB color space
LAB(:,:,1) = bw;
cform2srgb = makecform('lab2srgb');
J = applycform(LAB, cform2srgb); 

% Display the results
figure, image(J);title('Imagen en color con contraste aplicado');
