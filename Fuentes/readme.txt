Programas y ejecuci�n
---------------------

Hay 4 programas en el trabajo.

'learn_circulos.m'
Toma como par�metro un archivo de par�metros (ver formato del archivo).
Calcula los c�rculos que sean ampollas posibles sobre un conjunto de im�genes, y deja como resultado un archivo con el mismo nombre de la imagen, con la extensi�n '.out', que contiene las coordenadas, el radio y el factor de acumulaci�n de cada c�rculo.
Ej: learn_circulos('param.in');

'learn_histograma.m'
Toma como par�metro un archivo de par�metros (ver formato del archivo), y por cada imagen, un archivo que tenga el mismo nombre, con la extensi�n agregada '.control', conteniendo los c�rculos a analizar. El archivo '.control' debe tener el mismo formato que el '.out' del paso anterior, pero debe contener s�lo aquellos c�rculos que se desea analizar.
Para los c�rculos especificados, calcula los histogramas promedio sobre el espacio de color L*a*b*, sobre las coordenadas: L, A, B, LA, LB y AB. Deja como resultado un archivo que tiene el mismo nombre que el archivo de par�metros, pero con el agregado '.histprom.mat', que contiene las 6 variables de los histogramas promedio.
Ej: learn_histograma('param.in');

'main.m'
Toma como par�metro un archivo de par�metros (ver formato del archivo).
Calcula los c�rculos que sean ampollas posibles sobre un conjunto de im�genes, y deja como resultado un archivo con el mismo nombre de la imagen, con la extensi�n '.dat', que contiene las coordenadas, el radio y el factor de acumulaci�n de cada c�rculo, y le suma las distancias al histograma promedio (KLD sim�trico, norma 1 y norma 2).
Ej: main('param.in');

'dibujar_histogramas.m'
Toma como par�metro un archivo de histograma promedio (*.histprom.mat).
Dibuja los histogramas de 1 variable con un gr�fico de barras, y los de 2 variables con un mesh y con un gr�fico de isol�neas.
Ej: dibujar_histogramas('ejemplo.histprom.mat');


Formato del archivo de par�metros
---------------------------------

espacio_de_color_deteccion ("Lab", "RGB", "YCbCr", "HSI", "HSL", "HSV") espacio_de_color_histogramas ("Lab", "RGB") cantidad_de_imagenes (ej: 3)
carpeta_de_resultados (ej: "..\Resultados\")
por cada imagen un rengl�n: archivo_imagen (ej: "..\Imagenes\U.Iowa\Varicel-02.jpg") cantidad_de_radios (ej: 3) radios (ej: 23 24 25)
