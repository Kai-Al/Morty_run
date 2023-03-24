clear all, close all, clc
% Morty run
% Juego en el jugador debe evitar los asteroides y recoger los escudos
global PlayerInit AsteroideInit new_star_game direction score runLoop ShieldX ShieldY AsteroideX AsteroideY;

restar_game; % Función de inicializacion de variables

% Inicializacion de variables de juego

GAME_RESOLUTION = [640 580]; % Resolucion del juego
GAME.WINDOW_RES = GAME_RESOLUTION; % Resolucion de la ventana
MainFigureInitPos = [500 100]; % Posicion inicial de la ventana
MainFigureSize = [640 580]; % Tamaño de la ventana
MainAxesInitPos = [0 0]; % Posicion inicial de los ejes
MainAxesSize = [640 580]; % Tamano de los ejes
ObjectSize = [50 50]; % Tamaño de los objetos
PlayerSize = [100 100]; % Tamaño del jugador

MainFigureHd1 = figure('Name', 'Morty run', ... % Nombre de la ventana
    'NumberTitle', 'off', ... % Desactiva el numero de la ventana
    'MenuBar', 'none', ... % Desactiva la barra de menu
    'ToolBar', 'none', ... % Desactiva la barra de herramientas
    'Units', 'pixels', ... % Unidades de la ventana
    'Position', [MainFigureInitPos MainFigureSize], ... % Posicion y tamaño de la ventana
    'Resize', 'off', ... % Desactiva el redimensionamiento de la ventana
    'Color', [0 0 0], ... % Color de fondo de la ventana
    'KeyPressFcn', @keyPress, ... % Funcion de teclado
    'CloseRequestFcn', @closeGame); % Funcion de cierre de la ventana

MainAxesHd1 = axes('Parent', MainFigureHd1, ...
    'Units', 'pixels', ...
    'Position', [MainAxesInitPos MainAxesSize], ...
    'Visible', 'on', ...
    'Color', [0 0 0], ...
    'XLim', [0 GAME_RESOLUTION(1)], ...
    'YLim', [0 GAME_RESOLUTION(2)], ...
    'YDir', 'reverse', ...
    'NextPlot', 'add', ...
    'Visible', 'on', ...
    'XTick', [], ...
    'YTick', []);

MainCanvasHd1 = image([0 MainAxesSize(1)], [0 MainAxesSize(2)], [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');

PlayerCanvasHd1 = image(PlayerInit(1), PlayerInit(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');

Asteroide1CanvasHd1 = image(AsteroideInit{1}(1), AsteroideInit{1}(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');

Asteroide2CanvasHd1 = image(AsteroideInit{2}(1), AsteroideInit{2}(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');

Asteroide3CanvasHd1 = image(AsteroideInit{3}(1), AsteroideInit{3}(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');

EscudoCanvasHd1 = image(ShieldX, ShieldY, [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');

GameOverHd1 = text (GAME_RESOLUTION(1) / 2, (GAME_RESOLUTION(2) / 2) - 200, 'GAME OVER', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'off', ...
    'Color', [1 1 1], ...
    'FontSize', 50, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

VictoryHd1 = text (GAME_RESOLUTION(1) / 2, (GAME_RESOLUTION(2) / 2) - 200, 'VICTORY', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'off', ...
    'Color', [1 1 1], ...
    'FontSize', 50, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

PressKeyHd1 = text (GAME_RESOLUTION(1) / 2, GAME_RESOLUTION(2) / 2, 'Press any key to start', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on', ...
    'Color', [1 1 1], ...
    'FontSize', 20, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

ScoreHd1 = text (GAME_RESOLUTION(1) / 2, GAME_RESOLUTION(2) / 2, '0', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'off', ...
    'Color', [1 1 1], ...
    'FontSize', 50, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

LifeCounterHd1 = text (GAME_RESOLUTION(1) - 50, GAME_RESOLUTION(2) - 50, '3', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on', ...
    'Color', [1 1 1], ...
    'FontSize', 20, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

jugador = imread('Morty.png');
jugador = imresize(jugador, PlayerSize);
asteroide = imread('asteroide.png');
asteroide = imresize(asteroide, ObjectSize);
escudo = imread('escudo.png');
escudo = imresize(escudo, ObjectSize);
escudoLogo = imread('escudo.png');
escudoLogo = imresize(escudoLogo, [30 30]);

set(PlayerCanvasHd1, 'CData', jugador)
set (Asteroide1CanvasHd1, 'CData', asteroide);
set (Asteroide2CanvasHd1, 'CData', asteroide);
set (Asteroide3CanvasHd1, 'CData', asteroide);
set (EscudoCanvasHd1, 'CData', escudo);

global dir mdir bdir shields s_shield ShieldCanvasHd1

dir = 0;
mdir = ones(1, 3) * 5; % Controla la velocidad de los meteoritos
bdir = 0;
Speed_shield = 1;
directionEscudo = 0;
ShieldCanvasHd1 = ones(1, shields + 1);
runLoop = true;

% 640x480
camara = webcam();
%preview(camara); % Muestra la camara
figure(3);
hImg = imshow(zeros(480, 640, 3, 'uint8'));

while runLoop

    if new_star_game == 1
        restar_game;
        new_star_game = 0;
        set(VictoryHd1, 'Visible', 'off');
        set(GameOverHd1, 'Visible', 'off');
        set(PressKeyHd1, 'Visible', 'off');
        set(ScoreHd1, 'Visible', 'off');
        set(LifeCounterHd1, 'Visible', 'on');

        while runLoop
            drawnow;

            captura = snapshot(camara); % Toma una captura de camara

            % imagenFinal contendra una imagen en donde el objeto verde está en
            % blanco y el resto en negro
            imagen_final = BinarizarImg(captura);

            % Halla las coordenadas en columnas y los guarda
            % en yPromedio y xPromedio

            % Encuentra las filas y columnas del objeto verde
            [fila, columna] = find(imagen_final > 0);
            filaMin = min(fila); % Encuentra la fila minima donde aparece el objeto verde
            filaMax = max(fila); % Encuentra la columna minima donde aparece el objeto verde
            colMin = min(columna); % Encuentra la fila maxima donde aparece el objeto verde
            colMax = max(columna); % Encuentra la columna maxima donde aparece el objeto verde

            % Se halla el punto medio entre la primera y la ultima fila entre
            % las que esta el objeto verde
            yPromedio = fix((filaMin + filaMax) / 2);

            % Se halla el punto medio entre la primera y la ultima columna entre
            % las que esta el objeto verde
            xPromedio = fix((colMin + colMax) / 2);

            % Imprime las coordenadas Y y X
            disp("Y:" + yPromedio);
            disp("X:" + xPromedio);

            % Contendrá una imagen en negro y un punto blanco
            % el punto blanco será la posicion en donde está el objeto verde
            copiaImagen = imagen_final * 0;

            % Muestra la captura original
            figure(3); subplot(2, 1, 1);
            imshow(flip(captura, 2));
            title('Imagen original');

            % Muestra la captura final con los objetos verdes detectados
            figure(3); subplot(2, 1, 2);
            imshow(flip(imagen_final, 2));
            title('Objetos verdes');

            %figure(2), imshow(copiaImagen); % MUESTRA LA POSICION DEL OBJETO VERDE
            %figure(2), imshow(imagenFinal); % MUESTRA EL OBJETO VERDE CAPTURADO

            if (PlayerInit(1) < xPromedio)
                dir = 5; %Movimiento hacia la derecha
                direction = 0;
            elseif (PlayerInit(1) > xPromedio)
                dir = -5; %Movimiento hacia la izquierda
                direction = 0;
            end

            %Revisa si el jugador choca con los asteroides
            %El jugador se choca si: (Teniendo en cuenta que el asteroide es de 100x100 y el jugador de 100x100)
            %   - El jugador está en el mismo eje X que el asteroide
            %   - El jugador está en el mismo eje Y que el asteroide
            for i = 1:3

                if ((PlayerInit(1) >= AsteroideX(i) && PlayerInit(1) <= AsteroideX(i) + 50) || (PlayerInit(1) + 100 >= AsteroideX(i) && PlayerInit(1) + 100 <= AsteroideX(i) + 50)) && ((PlayerInit(2) >= AsteroideY(i) && PlayerInit(2) <= AsteroideY(i) + 50) || (PlayerInit(2) + 100 >= AsteroideY(i) && PlayerInit(2) + 100 <= AsteroideY(i) + 50))

                    if shields == 0
                        set(GameOverHd1, 'Visible', 'on');
                        set(PressKeyHd1, 'Visible', 'on');
                        set(LifeCounterHd1, 'Visible', 'off');
                        dir = 0;
                        restar_game;
                        runLoop = false;
                    else
                        shields = shields - 1;
                        %Se cambia el texto del contador de vidas
                        set(LifeCounterHd1, 'String', num2str(shields + 1));
                        %Se mueve el asteroide a una posición aleatoria arriba de la pantalla
                        AsteroideX(i) = randi([0 GAME_RESOLUTION(1) - 100]);
                        AsteroideY(i) = GAME_RESOLUTION(2) + 100;
                        mdir(i) = 1;
                        set(Asteroide1CanvasHd1, 'XData', AsteroideX(i), 'YData', AsteroideY(i));
                        %Mostrar las vidas restantes
                    end

                    %Si el jugador no choca con el asteroide, se revisa si el jugador chocó con un escudo.
                    % Si no choca con el asteroide, se mueve
                else
                    PlayerInit(1) = PlayerInit(1) - dir;

                    if PlayerInit(1) < 0
                        PlayerInit(1) = 0;
                    elseif PlayerInit(1) >= GAME_RESOLUTION(1) - 100
                        PlayerInit(1) = GAME_RESOLUTION(1) - 100;
                    end

                    set(PlayerCanvasHd1, 'XData', PlayerInit(1));

                    %Se mueven los asteroides
                    for i = 1:3
                        AsteroideY(i) = AsteroideY(i) + mdir(i);

                        if AsteroideY(i) > GAME_RESOLUTION(2)
                            AsteroideY(i) = -100;
                            AsteroideX(i) = randi([0 GAME_RESOLUTION(1) - 100]);
                        end

                    end

                    set(Asteroide1CanvasHd1, 'XData', AsteroideX(1), 'YData', AsteroideY(1));
                    set(Asteroide2CanvasHd1, 'XData', AsteroideX(2), 'YData', AsteroideY(2));
                    set(Asteroide3CanvasHd1, 'XData', AsteroideX(3), 'YData', AsteroideY(3));

                    %Se mueve el escudo
                    ShieldY = ShieldY + Speed_shield;

                    if ShieldY > GAME_RESOLUTION(2)
                        ShieldY = -100;
                        ShieldX = randi([0 GAME_RESOLUTION(1) - 100]);
                    end

                    set(EscudoCanvasHd1, 'XData', ShieldX, 'YData', ShieldY);

                end

                if any((PlayerInit(1) >= ShieldX & PlayerInit(1) <= ShieldX + 50) | (PlayerInit(1) + 100 >= ShieldX & PlayerInit(1) + 100 <= ShieldX + 50) & (PlayerInit(2) >= ShieldY & PlayerInit(2) <= ShieldY + 50) | (PlayerInit(2) + 100 >= ShieldY & PlayerInit(2) + 100 <= ShieldY + 50))
                    shields = shields + 1;
                    %Se cambia el texto del contador de vidas
                    set(LifeCounterHd1, 'String', num2str(shields + 1));
                    ShieldX = randi([0 GAME_RESOLUTION(1) - 100]);
                    ShieldY = -100;
                    set(EscudoCanvasHd1, 'XData', ShieldX, 'YData', ShieldY);
                    %El jugador gana la partida si tiene 5 escudos
                    if shields >= 4
                        set(VictoryHd1, 'Visible', 'on');
                        set(PressKeyHd1, 'Visible', 'on');
                        set(LifeCounterHd1, 'Visible', 'on');
                        dir = 0;
                        restar_game;
                        runLoop = false;
                    end

                end

            end

        end

        runLoop = true;
    end

    drawnow;
end
