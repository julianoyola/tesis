function [chart] = construir_chroma_chart()

chart = construir_chart_inicial();

chart = agregar_imagen('Alagil04.jpg', chart);
chart = agregar_imagen('Alagil05.jpg', chart);
chart = agregar_imagen('chicken_pox_primary_lesions_03.jpg', chart);
chart = agregar_imagen('chicken_pox_picture_13.jpg', chart);
chart = agregar_imagen('Varicel-04.jpg', chart);

chart = double(chart);
chart = chart / max(max(chart));

save('chart.mat', 'chart');
save('chart.txt', 'chart', '-ascii');

end

function [chart] = construir_chart_inicial()

lo_a = -100;
lo_b = -100;
hi_a = 100;
hi_b = 100;

Ma = hi_a - lo_a + 1;
Mb = hi_b - lo_b + 1;

chart = zeros(Ma, Mb);

end

function [chart] = agregar_imagen(archivo_imagen, chart)

imagen = imread(archivo_imagen);

% Convertir a espacio de color L*a*b
cform2lab = makecform('srgb2lab');
lab = applycform(imagen, cform2lab);
lab = lab2double(lab);
a = lab(:,:,2);
b = lab(:,:,3);

[M,N] = size(a);

conv

for i = 1 : M
    for j = 1 : N
        [ia, ib] = ab2ind(a(i,j), avg_b);
        chart(ia,ib) = chart(ia,ib) + 1;
    end
end

end