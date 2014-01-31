function [circulo] = dibujar_circulos(centro,radio,n,m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Dibuja un circulo en el centro indicado del radio indicado 
%
%Entrada:
%       centro: del circulo
%       radio: del circulo
%
%Salida:
%       circulo: dibujo del circulo con tamaño de la imagen indicado
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

circulo(1:n, 1:m) = 0;

for angulo=1:360

%  [punto] = centro + radio * [sin(angulo*pi/180) cos(angulo*pi/180)];
  [punto] = centro + radio * [sin(angulo) cos(angulo)];
  xpunto = round(punto(1));
  ypunto = round(punto(2));
    
  if ( (punto(1) >= 1) && (punto(1) <= n) && (punto(2) >= 1) && (punto(2) <= m) )
      circulo(xpunto, ypunto) = 1.0;
  end

end
