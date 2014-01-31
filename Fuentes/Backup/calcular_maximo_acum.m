function [maximo_acum] = calcular_maximo_acum(radio)

% calcula el maximo acumulardor para el radio

maximo_acum = 0;
for angulo = 0:90

    x = radio * cos(angulo);
    y = radio * sin(angulo);
    
    fprintf ('x: %d\n', x);
    fprintf ('y: %d\n', y);
    
    if x == round(x) && y == round(y)
        maximo_acum = maximo_acum + 1;
    end    
    
end