function [d,r]=maxlloyd(x,p,n, maxiter)
% [d,r]=maxlloyd(x,p,n, maxiter)
% n cant de niveles
% maxiter= cant max de iteraciones
% d  extremos de intervalos: son n+1
% r  representantes de cada clase
%     d1< r1 < d2 <r2    rn < d(n+1)
% x son los eventos  (ordenados)
% p su probabilidad
 lx=length(x);
                 % d iniciales
 d(1)=x(1);
 d(n+1)=x(lx)+0.1;
 q=(d(n+1)-d(1))/n;
 for ii=2:n
   d(ii)=d(ii-1)+q;
 end
 d
 dv=d;
 dv(1)=dv(1)+10;         %para forzar la desigualdad la primera vez en el while
 for ii=2:n
  r(ii)=(d(ii-1)+d(ii))/2;
 end
 rv=r;
 rv(1)=rv(1)+10;
 iter=1;
 while (norm(rv-r)+norm(dv-d)>0 & iter<=maxiter)
    norm(rv-r)+norm(dv-d);
    dv=d;
    rv=r;
    iter
    cantnonulos=0;
    cambio=0;
%                                 calculo nuevos r
  while cantnonulos~=n
   cantnonulos=0;
   for i=1:n
     sp=sum( p.*( (d(i)<=x) & (x<d(i+1))));
     if abs(sp)<10^(-7)   %no hay valor esperado en ese intervalo, no existe
        cambio=1;
        if i<n  % no estoy en el ultimo intervalo
           d(i+1)=d(i+1)+0.1;
           
        else 
           d(i)=d(i)-0.1;
           
        end 
     else
      cantnonulos=cantnonulos+1;  
     end %if abs(sp)
   end %for
   d;
   end % while

%cantnonulos
   if cambio 
   disp('cambie d por que no habia un representante en cada clase')
   d
   end
   for i=1:n
    sp=sum( p.*( (d(i)<=x) & (x<d(i+1))));
    r(i)=sum((x.*p).*( (d(i)<=x) & (x<d(i+1))));
    r(i)=r(i)/sp;
   end
   disp('nuevo r')
    r

%                                  calculo nuevos d
    for i=2:n
      d(i)=(r(i-1)+r(i))/2;
    end
    disp('nuevo d')
    d
   
%                                   calculo dp la distorsion promedio
%                               es la esperanza del error de cuantizacion al cuadrado

    for i=1:n
     ec(i)=sum((((x-r(i)).^2).*p).*( (d(i)<=x) & (x<d(i+1))));
    end
    dp=sum(ec);

    for i=1:n
     e(i)=sum((abs(x-r(i)).*p).*( (d(i)<=x) & (x<d(i+1))));
    end
    ep=sum(e);
    spri=sprintf('distor prom %d  esper del error %d ',dp,ep);
    disp(spri)

    iter=iter+1;
  end %while (norm(rv-r)+norm(dv-d)>0 & iter<=maxiter)
  disp('Paro porque no hay cambios en r y d')
  