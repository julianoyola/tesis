function [] = prueba_hist2d(archivo_imagen)

close all;

% Cargar la imagen
imagen_original = imread(archivo_imagen);
imagen_original_double = double(imagen_original);
 
red=imagen_original_double(:,:,1);
green=imagen_original_double(:,:,2);

colores=[0:255];
nred=hist(red(:),colores);
ngreen=hist(green(:),colores);

[n,x,y] = hist2d(red(:),green(:),[0:255]);
%imagesc(x(1,:),y(:,1),n); hold on; plot(red,green,'y.'); colorbar

%figure;
%imshow(imagen_original); title('Imagen original');
%colormap(gray(256));

%pause;
