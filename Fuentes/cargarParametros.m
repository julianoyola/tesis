function [ param ] = cargarParametros( archivo, procesarArchivoControl )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Descripcion:
%       Carga los par�metros de la ejecuci�n
%       Para una referencia de los par�metros, ver archivo 'param.desc'
%
%Entrada:
%       archivo: archivo de par�metros 
%       procesarArchivoControl: flag que indica si hay que procesar el
%           archivo de control, que contiene los centros que hay que procesar, 
%           ignorando el resto
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fid = fopen(archivo);

    % Leer espacio de color y cantidad de archivos a procesar
    values = textscan(fid, '%q %q %u', 1);
    % 'HSL' 'HSI' 'HSV' 'YCbCr' 'Lab'
    param.espacioColor = values{1}{1};
    % 'Lab' 'RGB'
    param.espacioColorHistogramas = values{2}{1};
    param.cantArchivos = values{3};
    
    % Leer carpeta de resultados
    values = textscan(fid, '%q', 1);
    param.carpetaSalida = values{1}{1};

    for i = 1 : param.cantArchivos
        
        archivo = struct;

        % Leer nombre de archivo de imagen
        values = textscan(fid, '%q %u', 1);
        archivo.nombreArchivoImagen = values{1}{1};
        
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
        
        % Leer cu�les son los radios a procesar para esta imagen
        archivo.cantRadios = values{2};
        values = textscan(fid, '%f', archivo.cantRadios, 'CollectOutput', true);
        archivo.radios = values{1}';

        % Archivo de control, con los circulos a considerar
        if (procesarArchivoControl)
            archivo.centros = load(archivo.nombreArchivoControl);
        end
        
        param.archivos(i) = archivo;
    end

    fclose(fid);

    % Mostrar par�metros
%     param 
%     for i = 1 : param.cantArchivos
%         param.archivos(i)
%     end

end
