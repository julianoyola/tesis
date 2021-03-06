function [] = dibujar_histogramas(archivoHistograma)

addpath('9-Util', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Dibuja un histograma cualquiera, por ejemplo el promedio
%
%Entrada:
%       archivoHistograma: archivo con los histogramas A,B,L,AB,LA y LB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% close all;

hist = load(archivoHistograma);

h = figure;
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

subplot(2,2,1);
bar([0:100], hist.L);
title('Histograma de la componente L de Lab');
xlabel('Valor');
ylabel('# de ocurrencias');

subplot(2,2,2);
bar([-127:128], hist.A);
title('Histograma de la componente A de Lab');
xlabel('Valor');
ylabel('# de ocurrencias');

subplot(2,2,3);
bar([-127:128], hist.B);
title('Histograma de la componente B de Lab');
xlabel('Valor');
ylabel('# de ocurrencias');

print('-dpng', strcat(archivoHistograma, '.bar.png'));
saveas(h,strcat(archivoHistograma, '.bar.fig'),'fig') 


h = figure;
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

subplot(2,2,1);
[x,y] = meshgrid(0:100,-127:128);
meshc(x,y,hist.LA);
axis([0 100 -127 128 -10 20]);
title('Histograma 2D de las componentes L y A de Lab');
xlabel('Valor de L');
ylabel('Valor de A');
zlabel('# de ocurrencias');

subplot(2,2,2);
[x,y] = meshgrid(0:100,-127:128);
meshc(x,y,hist.LB);
axis([0 100 -127 128 -10 20]);
title('Histograma 2D de las componentes L y B de Lab');
xlabel('Valor de L');
ylabel('Valor de B');
zlabel('# de ocurrencias');

subplot(2,2,3);
[x,y] = meshgrid(-127:128);
meshc(x,y,hist.AB);
axis([-127 128 -127 128 -10 20]);
title('Histograma 2D de las componentes A y B de Lab');
xlabel('Valor de A');
ylabel('Valor de B');
zlabel('# de ocurrencias');

print('-dpng', strcat(archivoHistograma, '.mesh.png'));
saveas(h,strcat(archivoHistograma, '.mesh.fig'),'fig') ;


h = figure;
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

subplot(2,2,1);
[x,y] = meshgrid(0:100,-127:128);
contour(x,y,hist.LA);
title('Isolíneas del histograma 2D de las componentes L y A');
xlabel('Valor de L');
ylabel('Valor de A');

subplot(2,2,2);
[x,y] = meshgrid(0:100,-127:128);
contour(x,y,hist.LB);
title('Isolíneas del histograma 2D de las componentes L y B');
xlabel('Valor de L');
ylabel('Valor de B');

subplot(2,2,3);
[x,y] = meshgrid(-127:128);
contour(x,y,hist.AB);
title('Isolíneas del histograma 2D de las componentes A y B');
xlabel('Valor de A');
ylabel('Valor de B');

print('-dpng', strcat(archivoHistograma, '.contour.png'));
saveas(h,strcat(archivoHistograma, '.contour.fig'),'fig') ;

close all;

