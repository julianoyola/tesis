function [resultado,KL] = comparar_histogramas(histogramaReferencia, histogramaObservacion, metrica, umbral)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Compara el histograma n con el de referencia, se utiliza la divergencia KL
%       o distancia cruzada.
%
%Entrada:
%       histogramaReferencia: histograma de referencia, histograma modelo o
%         Q. Es el promedio de las observaciones sobre una base de imágenes.
%       histogramaObservacion: histograma puntual a comparar
%       metrica: KLD, DistanciaEuclidea, DistanciaInterseccion
%       umbral: con el que comparar
%
%Salida:
%       resultado: valor de verdad de la comparacion con el histograma de
%       referencia
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dimRef = ndims(histogramaReferencia);
dimObs = ndims(histogramaObservacion);

if (dimRef ~= dimObs)
    error('El histograma de referencia y el observado tienen diferentes dimensiones');
end

tamRef = size(histogramaReferencia);
tamObs = size(histogramaObservacion);

if (~isequal(tamRef, tamObs))
    error('El histograma de referencia y el observado tienen diferente tamaño');
end

if (strcmp(metrica, 'KLD'))
    
    % Vectorizar los histogramas 2D
    vectorReferencia = histogramaReferencia(:);
    vectorObservacion = histogramaObservacion(:);

    % Normalizar los histogramas
    vectorReferencia = vectorReferencia/sum(vectorReferencia) + eps;
    vectorObservacion = vectorObservacion/sum(vectorObservacion) + eps;

    % Calcular KLD
    kld = kldiv(vectorObservacion, vectorReferencia);
    distancia = kld;

    fprintf('KLD: %5.3f\n ', distancia);

elseif (strcmp(metrica, 'DistanciaEuclidea'))
    
    for i = 1 : tamRef(1)
        if (dimRef > 1)
            for j = 1 : tamRef(2)
                if (dimRef > 2)
                    for k = 1 : tamRef(3)
                        dist2 = dist2 + (histogramaReferencia(i,j,k) - histogramaObservacion(i,j,k))^2;
                    end
                else
                    dist2 = dist2 + (histogramaReferencia(i,j) - histogramaObservacion(i,j))^2;
                end
            end
        else
            dist2 = dist2 + (histogramaReferencia(i) - histogramaObservacion(i))^2;
        end
    end

    distancia = sqrt(dist2);

    fprintf('Distancia euclídea: %5.3f\n ', distancia);    
    
elseif (strcmp(metrica, 'DistanciaInterseccion'))
    
    if (dimRef == 1)
        sqrt(sum( (A - B) .^ 2 ))
    elseif (dimRef == 1)
        sqrt(sum( (A - B) .^ 2 ))
    elseif (dimRef == 1)
        sqrt(sum( (A - B) .^ 2 ))
    end
    
    for i = 1 : tamRef(1)
        if (dimRef > 1)
            for j = 1 : tamRef(2)
                if (dimRef > 2)
                    for k = 1 : tamRef(3)
                        dist = dist + min(histogramaReferencia(i,j,k), histogramaObservacion(i,j,k));
                    end
                else
                    dist2 = dist2 + (histogramaReferencia(i,j) - histogramaObservacion(i,j))^2;
                end
            end
        else
            dist2 = dist2 + (histogramaReferencia(i) - histogramaObservacion(i))^2;
        end
    end

    distancia = sqrt(dist2);

    fprintf('Distancia euclídea: %5.3f\n ', distancia);    
    sum
end

resultado = (distancia <= umbral);

%resultado = (KL <= 2);
%resultado = (KL <= 0.171);
