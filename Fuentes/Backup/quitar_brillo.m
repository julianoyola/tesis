
function [jbw] = quitar_brillo(archivo_imagen)

% cargo la imagen 
imagen=imread(archivo_imagen);
bw = rgb2gray(imagen);

dimagen=double(imagen);
dbw=double(bw);


figure, imshow(bw); title('imgen');

%jcolor = adapthisteq(dimagen(:,:,2),'clipLimit',0.02); 
%figure, imshow(jcolor); title('aplico a la imagen original');

jbw = adapthisteq(dbw,'NumTiles',[64 64]); 
figure, imshow(jbw); title('aplico a la imagen bw');


