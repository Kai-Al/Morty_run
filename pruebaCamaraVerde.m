clear all, close all, clc

% 640x480
camara = webcam(1);
preview(camara); % Muestra la camara

for i=1:250

    imagen = snapshot(camara); % Toma una captura de camara
   
    % imagenFinal contendra una imagen en donde el objeto verde está en
    % blanco y el resto en negro
    imagenFinal = BinarizarImg(imagen);

    % Halla las coordenadas en columnas y los guarda
    % en yPromedio y xPromedio

    % Encuentra las filas y columnas del objeto verde
    [fila, columna] = find(imagenFinal > 0);
    filaMin = min(fila); % Encuentra la fila minima donde aparece el objeto verde
    filaMax = max(fila); % Encuentra la columna minima donde aparece el objeto verde
    colMin = min(columna); % Encuentra la fila maxima donde aparece el objeto verde
    colMax = max(columna); % Encuentra la columna maxima donde aparece el objeto verde
    
    % Se halla el punto medio entre la primera y la ultima fila entre
    % las que esta el objeto verde
    yPromedio = fix((filaMin + filaMax)/2);
   
    % Se halla el punto medio entre la primera y la ultima columna entre
    % las que esta el objeto verde
    xPromedio = fix((colMin + colMax)/2);

    % Imprime las coordenadas Y y X
    disp("Y:" + yPromedio);
    disp("X:" + xPromedio);

    % Contendrá una imagen en negro y un punto blanco
    % el punto blanco será la posicion en donde está el objeto verde
    copiaImagen = imagenFinal*0;

    % HACE EL PUNTO MAS GRANDE
    copiaImagen(yPromedio, xPromedio) = 1;

    copiaImagen(yPromedio+1, xPromedio) = 1;
    copiaImagen(yPromedio, xPromedio+1) = 1;
    copiaImagen(yPromedio+2, xPromedio) = 1;
    copiaImagen(yPromedio, xPromedio+2) = 1;
    copiaImagen(yPromedio+1, xPromedio+1) = 1;
    copiaImagen(yPromedio+2, xPromedio+2) = 1;

    
    %figure(2), imshow(copiaImagen); % MUESTRA LA POSICION DEL OBJETO VERDE
    figure(2), imshow(imagenFinal); % MUESTRA EL OBJETO VERDE CAPTURADO
    pause(0.001);

end