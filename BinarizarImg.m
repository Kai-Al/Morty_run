function imagenFinal = BinarizarImg(captura)
    
     % Capturamos una imagen de la cámara
    %captura = snapshot(camara);

    % Separa los componentes RGB en sus respectivas capas
    r = double(captura(:, :, 1));
    g = double(captura(:, :, 2));
    b = double(captura(:, :, 3));

    % Normaliza las capas RGB
    r = r / 255;
    g = g /255;
    b = b /255;

    % Se quita el rojo y el azul de la capa verde
    g = g - (r + b)/2;

    % Mapeo lógico de g
    % Los valores que sean mayores a 0.1 se ponen en 1 
    % y los que sean menores se ponen en 0
    captura_binarizada = g > 0.1;

    % Las areas que sean menores a 500 se quitan de imagen_binarizada
    captura_binarizada = bwareaopen(captura_binarizada, 500);
    imagenFinal = captura_binarizada;
        % A cada region encontrada en la imagen se le asigna un numero y se
        % guarda en captura_final.
        % En n se guarda el numero de secciones encontradas
        % [captura_final, n] = bwlabel(captura_binarizada);



end