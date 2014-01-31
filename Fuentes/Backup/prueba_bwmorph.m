function [imagen_res] = prueba_bwmorph(archivo_imagen)

% cargo la imagen 
imagen=imread(archivo_imagen);
bw0 = rgb2gray(imagen);
bw=edge(bw0,'canny',[0.1 0.2]);
%bw = imagen;
figure, imshow(bw); title('bw');

% la imagen menos la morfologia cerrada
imresul = bwmorph(bw,'bothat');
figure, imshow(imresul); title('bothat');

% este sirve
% conecta lo que esta desconectado
imresul = bwmorph(bw,'bridge');
figure, imshow(imresul); title('bridge');

% limpia caracteres sueltos
imresul = bwmorph(bw,'clean');
figure, imshow(imresul);title('clean');

% dilatacion y erosion
imbordes = bwmorph(bw,'close');
figure, imshow(imbordes);title('close');

% diagonaliza 
imbordes = bwmorph(bw,'diag');
figure, imshow(imbordes);title('diag');

%  dilata
imbordes = bwmorph(bw,'dilate');
figure, imshow(imbordes);title('dilate');

% erosiona
imbordes = bwmorph(bw,'erode');
figure, imshow(imbordes);title('erode');


imbordes = bwmorph(bw,'fill');
figure, imshow(imbordes);title('fill');

imbordes = bwmorph(bw,'hbreak');
figure, imshow(imbordes);title('hbreak');

imbordes = bwmorph(bw,'majority');
figure, imshow(imbordes);title('majority');

% erosion y dilatacion
imbordes = bwmorph(bw,'open');
figure, imshow(imbordes);title('open');

imresul = bwmorph(bw,'remove');
figure, imshow(imresul);title('remove');

% encoge objetos a puntos
imbordes = bwmorph(bw,'shrink');
figure, imshow(imbordes);title('shrink');

%esqueleto
imbordes = bwmorph(bw,'skel');
figure, imshow(imbordes);title('skel');

% saca punta
imbordes = bwmorph(bw,'spur');
figure, imshow(imbordes);title('spur');

% engrosa
imbordes = bwmorph(bw,'thicken');
figure, imshow(imbordes);title('thicken');

% convierte objetos a lineas
imbordes = bwmorph(bw,'thin');
figure, imshow(imbordes);title('thin');

% 
imbordes = bwmorph(bw,'tophat');
figure, imshow(imbordes);title('tophat');





