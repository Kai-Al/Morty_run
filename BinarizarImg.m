function imagenFinal = BinarizarImg(imagen)

    imagenBAW = rgb2gray(imagen); % Convierte la imagen entrante en blanco y negro
    
    red = imagen(:,:, 1); % Guarda en red la capa roja de IMAGEN
    green = imagen(:,:, 2); % Guarda en green la capa roja de IMAGEN
    blue = imagen(:,:, 3); % Guarda en blue la capa roja de IMAGEN
    
    red = double(red)/255; % Normaliza red
    green = double(green)/255; % Normaliza red
    blue = double(blue)/255; % Normaliza red
    
    soloGreen = green - (red + blue)/2; % Quitamos el rojo y el azul de la capa verde


    % Hace un Mapeo Logico de soloGreen. 
    % Los valores que sean mayores a 0.1 se ponen en 1 
    % y los que sean menores se ponen en 0
    soloGreenBinarizado = soloGreen > 0.1; 

    % Las secciones que sean menores a 600 se quitan de soloGreenBinarizado
    soloGreenBinarizado = bwareaopen(soloGreenBinarizado, 600); 

    % A cada region encontrada en la imagen se le asigna un numero y se
    % guarda en imagenFinal.
    % En n se guarda el numero de secciones encontradas
    [imagenFinal, n] = bwlabel(soloGreenBinarizado);

end