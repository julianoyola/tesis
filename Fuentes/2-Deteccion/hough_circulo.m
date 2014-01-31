function [acum] = hough_circulo(imbordes,radio)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Detecta circulos a traves de hough para circulos, realizando una
%       transformacion del espacio, similar que para lineas. Utilizando la
%       formula del circulo: (x-x0)^2 + (y-y0)^2 = r^2
%
%Entrada:
%       archivo_imagen: imagen en blanco y negro de los bordes
%       radio : radio que busca
%
%Salida:
%       x0circulo: coordenada de x con un posible circulo
%       y0circulo: coordenada de y con un posible circulo aplicando
%       acum     : acumulador de circulos deectados sin aplicar umbral
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% inicializo acumulador 
acum = zeros(size(imbordes));
% me quedo con los indices de las celdas con los bordes
[fila, columna] = find(imbordes);
[n,m]=size(imbordes);

radio2=radio^2;
% acumulo posibles circulos
for k = 1:length(columna)
    %fprintf('fila:  %d\t total: %d\n', k, length(fila));
    primero = round(max(1,(columna(k) - radio )));
    ultimo  = round(min((columna(k) + radio),m));
    
    for y0 = primero:ultimo
        xsqrt= sqrt(radio2-(columna(k)-y0)^2);
        if xsqrt > 0
            x0 = round(fila(k) - xsqrt);
            if (1 <= x0) && (x0 <= n)
               acum(x0,y0) = acum(x0,y0) + 1;
            end
            x0 = round(fila(k) + xsqrt);
            if (1 <= x0) && (x0 <= n)
              acum(x0,y0) = acum(x0,y0) + 1;
            end
        end    
    end

    primero = round(max(1,(fila(k) - radio))); 
    ultimo  = round(min((fila(k) + radio),n));
    
    for x0 = primero:ultimo
        ysqrt= sqrt(radio2-(fila(k)-y0)^2);
        if ysqrt > 0
            y0 = round(columna(k) - ysqrt);
            if (1 <= y0) && (y0 <= m)
               acum(x0,y0) = acum(x0,y0) + 1;
            end
            y0 = round(columna(k) + ysqrt);
            if (1 <= y0) && (y0 <= m)
              acum(x0,y0) = acum(x0,y0) + 1;
            end
        end    
    end 

end


