function [ param ] = cargarParametrosVicky( archivo )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Carga los parámetros necesarios para el main.
%
%Entrada:
%       archivoParametros: archivo de parámetros 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fid = fopen(archivo);

    % Leer espacio de color y cantidad de archivos a procesar
    % 'HSL' 'HSI' 'HSV' 'YCbCr' 'Lab'
    values = textscan(fid, '%q %u', 1);
    param.espacioColor = values{1}{1};
    param.cantArchivos = values{2};
    
    values = textscan(fid, '%q', 1);
    param.carpetaSalida = values{1}{1};

    for i = 1 : param.cantArchivos
        
        values = textscan(fid, '%q %u', 1);
        % Leer nombre de archivo y radios
        archivo = struct;
        archivo.nombreArchivoImagen = values{1}{1};
        %archivo.nombreArchivoControl = strcat(archivo.nombreArchivoImagen, '.control');
        archivo.nombreArchivoSalida = strcat(archivo.nombreArchivoImagen, '.out');
        archivo.cantRadios = values{2};
        
        posBarra = strfind(archivo.nombreArchivoImagen, '\');
        posPunto = strfind(archivo.nombreArchivoImagen, '.');
        if isempty(posBarra)
            posInicio = 1;
        else
            posInicio = posBarra(end)+1;
        end
        posFinal = posPunto(end)-1;
        archivo.baseNombreArchivo = archivo.nombreArchivoImagen(posInicio:posFinal);

        values = textscan(fid, '%f', archivo.cantRadios, 'CollectOutput', true);
        
        archivo.radios = values{1}';
        %archivo.centros = load(archivo.nombreArchivoControl);

        if archivo.nombreArchivoImagen(1) == '%'
            archivo.skip = 1;
        else
            archivo.skip = 0;
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
