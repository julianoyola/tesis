function [imagen_res,him] = encontrar_circulos(imagen, vradio)

%function [imagen_res,him] = encontrar_circulos(archivo_imagen, vradio, incremento)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Encuentra circulos a traves de hough para circulos. Luego los dibuja 
%       en la imagen original
%
%Entrada:
%       archivo_imagen: imagen 
%       vradio : vector de radios de circulos a buscar
%
%Salida:
%       imagen_res: imagen original mas los circulos dibujados
%       him: vector de imagenes de circulos encontrados  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

% cargo la imagen y calculo sus bordes con canny
%imagen=imread(archivo_imagen);

%bw = rgb2gray(imagen);
%bw = bwyuv(imagen);

[RGB, imagenSinBrillo, bw] = quitar_brillo2(archivo_imagen);

%suavizar imagen
% filtro = fspecial('gaussian',[7 7],2);
% sinruido= imfilter(bw,filtro,'replicate');
% figure, image(sinruido);title('Imagen suavizada');
% colormap(gray(256));

%imbordes=edge(bw,'canny',[0.1 0.45]);
%imbordes=edge(bw,'canny',[0.1 0.2]);
%imbordes=edge(sinruido,'canny',[0.1 0.17]);
imbordes=edge(bw,'canny',[0.15 0.4],2);
%imbordes=edge(bw,'canny');

imbridges = bwmorph(imbordes,'bridge');
%imclose = bwmorph(imbordes,'close');
%imclose = imbridges;

%imclose = bwmorph(imbridges,'close');

figure;
subplot(1,2,1);
imshow(imbordes);title('Imagen con canny');
colormap(gray(256));
subplot(1,2,2);
imshow(imbridges);title('Imagen con bridge');
colormap(gray(256));
%subplot(1,3,3);
%imshow(imclose);title('Imagen con close');
%colormap(gray(256));

him=zeros(size(imagen,1),size(imagen,2),1);

% busco los circulos de los radios indicados en vradio en la imagen 
for radio=1:size(vradio,2);
    acum = hough_circulo(imbridges,vradio(radio));
    him(:,:,radio) = acum;
    
    figure;
    imagesc(acum);title(['Acumulador del radio: ', num2str(vradio(radio))]);
    colormap(gray(256));
end

% anillo del circulo
% busco los circulos de los radios indicados en vradio en la imagen 
%acum = hough_circulo_corona(imclose,vradio,incremento);
%him(:,:,1) = acum;

%muestro la imagen original con los bordes detectados
imgenmasbridges = im2double(imagen);
imgenmasbridges(:,:,1) = imgenmasbridges(:,:,1) + imbridges;
imgenmasbridges(:,:,2) = imgenmasbridges(:,:,2) + imbridges;
imgenmasbridges(:,:,3) = imgenmasbridges(:,:,3) + imbridges;
imgenmasbridges = imadjust(imgenmasbridges, [0 1], [0 1]);
figure;
imshow(imgenmasbridges);title('Imagen original con bordes detectados');
colormap(gray(256));

% dibujo los circulos sobre la imagen original
imagen_res = remarcar_circulos(imagen,imagenSinBrillo,him,vradio);


%muestro la imagen original con los bordes y los circulos detectados
imagen_resmasbridges = im2double(imagen_res);
imagen_resmasbridges(:,:,1) = imagen_resmasbridges(:,:,1) + imbridges;
imagen_resmasbridges(:,:,2) = imagen_resmasbridges(:,:,2) + imbridges;
imagen_resmasbridges(:,:,3) = imagen_resmasbridges(:,:,3) + imbridges;
imagen_resmasbridges = imadjust(imagen_resmasbridges, [0 1], [0 1]);
figure;
imshow(imagen_resmasbridges);title('Imagen original con bordes y circulos detectados');
colormap(gray(256));


figure;
imshow(imagen_res);title('Imagen resultado');
colormap(gray(256));
