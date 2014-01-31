function [] = dibujar_histogramas_RGB(archivoHistograma, titulo)

addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Dibuja un histograma cualquiera, por ejemplo el promedio
%
%Entrada:
%       archivoHistograma: archivo con los histogramas R, G, B, RG, RB, GB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% close all;

hist = load(archivoHistograma);

h = figure('Name', strcat(titulo, ' - ', 'Histogramas de las componentes individuales'));
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

subplot(2,2,1);
bar([0:255], hist.C1);
title('Histograma de la componente R de RGB');
xlabel('Valor');
ylabel('# de ocurrencias');

subplot(2,2,2);
bar([0:255], hist.C2);
title('Histograma de la componente G de RGB');
xlabel('Valor');
ylabel('# de ocurrencias');

subplot(2,2,3);
bar([0:255], hist.C3);
title('Histograma de la componente B de RGB');
xlabel('Valor');
ylabel('# de ocurrencias');

print('-dpng', strcat(archivoHistograma, '.bar.png'));
saveas(h,strcat(archivoHistograma, '.bar.fig'),'fig') 


h = figure('Name', strcat(titulo, ' - ', 'Histogramas de las componentes de a pares'));
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

subplot(2,2,1);
[x,y] = meshgrid(0:255,0:255);
meshc(x,y,hist.C1C2);
axis([0 255 0 255 -10 20]);
title('Histograma 2D de las componentes R y G de RGB');
xlabel('Valor de R');
ylabel('Valor de G');
zlabel('# de ocurrencias');

subplot(2,2,2);
[x,y] = meshgrid(0:255,0:255);
meshc(x,y,hist.C1C3);
axis([0 255 0 255 -10 20]);
title('Histograma 2D de las componentes R y B de RGB');
xlabel('Valor de R');
ylabel('Valor de B');
zlabel('# de ocurrencias');

subplot(2,2,3);
[x,y] = meshgrid(0:255,0:255);
meshc(x,y,hist.C2C3);
axis([0 255 0 255 -10 20]);
title('Histograma 2D de las componentes G y B de RGB');
xlabel('Valor de G');
ylabel('Valor de B');
zlabel('# de ocurrencias');

print('-dpng', strcat(archivoHistograma, '.mesh.png'));
saveas(h,strcat(archivoHistograma, '.mesh.fig'),'fig') ;


h = figure('Name', strcat(titulo, ' - ', 'Contorno de los histogramas de las componentes de a pares'));
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

subplot(2,2,1);
[x,y] = meshgrid(0:255,0:255);
contour(x,y,hist.C1C2);
title('Isolíneas del histograma 2D de las componentes R y G');
xlabel('Valor de R');
ylabel('Valor de G');

subplot(2,2,2);
[x,y] = meshgrid(0:255,0:255);
contour(x,y,hist.C1C3);
title('Isolíneas del histograma 2D de las componentes R y B');
xlabel('Valor de R');
ylabel('Valor de B');

subplot(2,2,3);
[x,y] = meshgrid(0:255,0:255);
contour(x,y,hist.C2C3);
title('Isolíneas del histograma 2D de las componentes G y B');
xlabel('Valor de G');
ylabel('Valor de B');

print('-dpng', strcat(archivoHistograma, '.contour.png'));
saveas(h,strcat(archivoHistograma, '.contour.fig'),'fig') ;

close all;