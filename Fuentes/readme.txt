Programas y ejecución
---------------------

Hay 4 programas en el trabajo.

'learn_circulos.m'
Toma como parámetro un archivo de parámetros (ver formato del archivo).
Calcula los círculos que sean ampollas posibles sobre un conjunto de imágenes, y deja como resultado un archivo con el mismo nombre de la imagen, con la extensión '.out', que contiene las coordenadas, el radio y el factor de acumulación de cada círculo.
Ej: learn_circulos('param.in');

'learn_histograma.m'
Toma como parámetro un archivo de parámetros (ver formato del archivo), y por cada imagen, un archivo que tenga el mismo nombre, con la extensión agregada '.control', conteniendo los círculos a analizar. El archivo '.control' debe tener el mismo formato que el '.out' del paso anterior, pero debe contener sólo aquellos círculos que se desea analizar.
Para los círculos especificados, calcula los histogramas promedio sobre el espacio de color L*a*b*, sobre las coordenadas: L, A, B, LA, LB y AB. Deja como resultado un archivo que tiene el mismo nombre que el archivo de parámetros, pero con el agregado '.histprom.mat', que contiene las 6 variables de los histogramas promedio.
Ej: learn_histograma('param.in');

'main.m'
Toma como parámetro un archivo de parámetros (ver formato del archivo).
Calcula los círculos que sean ampollas posibles sobre un conjunto de imágenes, y deja como resultado un archivo con el mismo nombre de la imagen, con la extensión '.dat', que contiene las coordenadas, el radio y el factor de acumulación de cada círculo, y le suma las distancias al histograma promedio (KLD simétrico, norma 1 y norma 2).
Ej: main('param.in');

'dibujar_histogramas.m'
Toma como parámetro un archivo de histograma promedio (*.histprom.mat).
Dibuja los histogramas de 1 variable con un gráfico de barras, y los de 2 variables con un mesh y con un gráfico de isolíneas.
Ej: dibujar_histogramas('ejemplo.histprom.mat');


Formato del archivo de parámetros
---------------------------------

espacio_de_color_deteccion ("Lab", "RGB", "YCbCr", "HSI", "HSL", "HSV") espacio_de_color_histogramas ("Lab", "RGB") cantidad_de_imagenes (ej: 3)
carpeta_de_resultados (ej: "..\Resultados\")
por cada imagen un renglón: archivo_imagen (ej: "..\Imagenes\U.Iowa\Varicel-02.jpg") cantidad_de_radios (ej: 3) radios (ej: 23 24 25)
