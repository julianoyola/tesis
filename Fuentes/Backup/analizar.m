function [ ] = analizar( A )
% Esta función analiza una imagen.
% Realiza una descomposición en RBG y calcula el histograma de cada color.

R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);

[Hrb,Hrr] = histog2(R);
[Hgb,Hgr] = histog2(G);
[Hbb,Hbr] = histog2(B);

predR = sum(sum((R > G) .* (R > B)))
predG = sum(sum((G > R) .* (G > B)))
predB = sum(sum((B > G) .* (B > R)))

figure(1);
colormap(gray(256));

subplot(2,3,1);
image(R);

subplot(2,3,2);
image(G);

subplot(2,3,3);
image(B);

subplot(2,3,4);
bar(Hrb, Hrr);
xlabel(strcat(['Red: ', num2str(predR)]));

subplot(2,3,5);
bar(Hgb, Hgr);
xlabel(strcat(['Green: ', num2str(predG)]));

subplot(2,3,6);
bar(Hbb, Hbr);
xlabel(strcat(['Blue: ', num2str(predB)]));
