function [ param ] = cargarParametrosPorCarpeta( carpeta, procesarArchivoControl )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Carga los parámetros de la ejecución
%       Para una referencia de los parámetros, ver archivo 'param.desc'
%
%Entrada:
%       archivo: archivo de parámetros 
%       procesarArchivoControl: flag que indica si hay que procesar el
%           archivo de control, que contiene los centros que hay que procesar, 
%           ignorando el resto
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    archivo = strcat(carpeta, '\param.in');
    fid = fopen(archivo);
    
    if (fid == -1)
        error(strcat('No se pudo abrir el archivo: ', archivo));
    end

    % Leer espacio de color y cantidad de archivos a procesar
    values = textscan(fid, '%q %q %u %u', 1);
    % 'HSL' 'HSI' 'HSV' 'YCbCr' 'Lab'
    param.espacioColor = values{1}{1};
    % 'Lab' 'RGB'
    param.espacioColorHistogramas = values{2}{1};
    param.cantArchivos = values{3};
    param.normalizarPiel = values{4};
    
    % Leer carpeta de resultados
    %values = textscan(fid, '%q', 1);
    param.carpetaEntrada = strcat(carpeta, '\Input\');
    param.carpetaSalida = strcat(carpeta, '\Output\');
    param.carpetaFiguras = strcat(param.carpetaSalida, 'Figuras\');
    param.carpetaCapturas = strcat(param.carpetaSalida, 'Capturas\');
    param.carpetaHistogramas = strcat(param.carpetaSalida, 'Histogramas\');

    values = textscan(fid, '%q', 1);
    param.tituloPrueba = values{1}{1};

    for i = 1 : param.cantArchivos
        
        archivo = struct;

        % Leer nombre de archivo de imagen
        values = textscan(fid, '%q %u', 1);
        archivo.nombreArchivoImagen = strcat(param.carpetaEntrada, values{1}{1});
        
        % Nombre base de archivo
        posBarra = strfind(archivo.nombreArchivoImagen, '\');
        posPunto = strfind(archivo.nombreArchivoImagen, '.');
        if isempty(posBarra)
            posInicio = 1;
        else
            posInicio = posBarra(end)+1;
        end
        posFinal = posPunto(end)-1;
        archivo.baseNombreArchivo = archivo.nombreArchivoImagen(posInicio:posFinal);
        
        % Archivos de salida y de control
        archivo.nombreArchivoSalida = strcat(param.carpetaSalida, archivo.baseNombreArchivo, '.out');
        archivo.nombreArchivoControl = strcat(archivo.nombreArchivoImagen, '.control');
        
        % Leer cuáles son los radios a procesar para esta imagen
        archivo.cantRadios = values{2};
        values = textscan(fid, '%f', archivo.cantRadios, 'CollectOutput', true);
        archivo.radios = values{1}';

        % Archivo de control, con los circulos a considerar
        if (procesarArchivoControl)
            archivo.centros = load(archivo.nombreArchivoControl);
            
            if (param.normalizarPiel == 1)
                archivo.centrosPiel = archivo.centros(1:1,:);
                archivo.centros = archivo.centros(2:end,:);
            end
        end
        
        param.archivos(i) = archivo;
    end

    fclose(fid);

    % Mostrar parámetros
%     param 
%     for i = 1 : param.cantArchivos
%         param.archivos(i)
%     end

end
