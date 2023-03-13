% Morty run 
% Juego en el jugador debe evitar los asteroides y recoger los escudos
global AsteroideX AsteroideY PlayerInit AsteroideInit ShieldInit new_star_game direction score runLoop;

restar_game; % Función de inicializacion de variables

% Inicializacion de variables de juego

GAME_RESOLUTION = [800 600]; % Resolucion del juego
GAME.WINDOW_RES = GAME_RESOLUTION; % Resolucion de la ventana
MainFigureInitPos = [500 100]; % Posicion inicial de la ventana
MainFigureSize = [800 600]; % Tamaño de la ventana
MainAxesInitPos = [0 0]; % Posicion inicial de los ejes
MainAxesSize = [800 600]; % Tamaño de los ejes

MainFigureHd1 = figure('Name', 'Morty run',... % Nombre de la ventana
    'NumberTitle', 'off',... % Desactiva el numero de la ventana
    'MenuBar', 'none',... % Desactiva la barra de menu
    'ToolBar', 'none',... % Desactiva la barra de herramientas
    'Units', 'pixels',... % Unidades de la ventana
    'Position', [MainFigureInitPos MainFigureSize],... % Posicion y tamaño de la ventana
    'Resize', 'off',... % Desactiva el redimensionamiento de la ventana
    'Color', [0 0 0],... % Color de fondo de la ventana
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

PlayerCanvasHd1 = image( PlayerInit(1), PlayerInit(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');
    
Asteroide1CanvasHd1 = image( AsteroideInit{1}(1), AsteroideInit{1}(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');
    
Asteroide2CanvasHd1 = image( AsteroideInit{2}(1), AsteroideInit{2}(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');
    
Asteroide3CanvasHd1 = image( AsteroideInit{3}(1), AsteroideInit{3}(2), [], ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on');
    
GameOverHd1 = text (GAME_RESOLUTION(1)/2, (GAME_RESOLUTION(2)/2)-200, 'GAME OVER', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'off', ...
    'Color', [1 1 1], ...
    'FontSize', 50, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

PressKeyHd1 = text (GAME_RESOLUTION(1)/2, GAME_RESOLUTION(2)/2, 'Press any key to start', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'on', ...
    'Color', [1 1 1], ...
    'FontSize', 20, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

ScoreHd1 = text (GAME_RESOLUTION(1)/2, GAME_RESOLUTION(2)/2, '0', ...
    'Parent', MainAxesHd1, ...
    'Visible', 'off', ...
    'Color', [1 1 1], ...
    'FontSize', 50, ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

jugador = imread('Morty.png');
jugador = imresize(jugador, [100 100]);
asteroide = imread('asteroide.png');
asteroide = imresize(asteroide, [100 100]);
escudo = imread('escudo.png');
escudo = imresize(escudo, [100 100]);
escudoLogo = imread('escudo.png');
escudoLogo = imresize(escudoLogo, [30 30]);

set(PlayerCanvasHd1, 'CData', jugador)
set (Asteroide1CanvasHd1, 'CData', asteroide);
set (Asteroide2CanvasHd1, 'CData', asteroide);
set (Asteroide3CanvasHd1, 'CData', asteroide);

global dir mdir bdir shields s_shield ShieldCanvasHd1

dir = 0;
mdir = ones(1, 3);
bdir = 0;
shields = 0;
s_shield = 1;
ShieldCanvasHd1 = zeros(1, shields+1);
runLoop = true;

while runLoop
    if new_star_game == 1
        restar_game;
        new_star_game = 0;
        set(GameOverHd1, 'Visible', 'off');
        set(PressKeyHd1, 'Visible', 'off');
        set(ScoreHd1, 'Visible', 'off');
        while runLoop
            drawnow;
            if (direction == 1)
                dir = 1; %Movimiento hacia la derecha
                direction = 0;
            elseif (direction == 2)
                dir = -1; %Movimiento hacia la izquierda
                direction = 0;
            elseif (direction == 3)
                dir = 0;
                direction = 0;
            elseif (direction == 4)
                dir = 0;
                direction = 0;
            end

        %Revisa si el jugador choca con los asteroides
        %El jugador se choca si: (Teniendo en cuenta que el asteroide es de 100x100 y el jugador de 100x100)
        %   - El jugador está en el mismo eje X que el asteroide
        %   - El jugador está en el mismo eje Y que el asteroide
        for i=1:3
            if ( (PlayerInit(1) >= AsteroideX(i) && PlayerInit(1) <= AsteroideX(i)+100) || (PlayerInit(1)+100 >= AsteroideX(i) && PlayerInit(1)+100 <= AsteroideX(i)+100) ) && ( (PlayerInit(2) >= AsteroideY(i) && PlayerInit(2) <= AsteroideY(i)+100) || (PlayerInit(2)+100 >= AsteroideY(i) && PlayerInit(2)+100 <= AsteroideY(i)+100) )
                disp('Chocaste con un asteroide');
                if shields == 0
                    set(GameOverHd1, 'Visible', 'on');
                    set(PressKeyHd1, 'Visible', 'on');
                    set(ScoreHd1, 'Visible', 'off');
                    dir = 0;
                    restar_game;
                    runLoop = false;
                else
                    shields = shields - 1;
                end
            % Si no choca con el asteroide, se mueve
            else
                PlayerInit(1) = PlayerInit(1) - dir;
                if PlayerInit(1) < 0
                    PlayerInit(1) = 0;
                elseif PlayerInit(1) >= GAME_RESOLUTION(1)-100
                    PlayerInit(1) = GAME_RESOLUTION(1)-100;
                end
                set(PlayerCanvasHd1, 'XData', PlayerInit(1));
        
                for i=1:3
                    AsteroideY(i) = AsteroideY(i) + mdir(i);
                    if AsteroideY(i) > GAME_RESOLUTION(2)
                        AsteroideY(i) = -100;
                        AsteroideX(i) = randi([0 GAME_RESOLUTION(1)-100]);
                    end
                end
                set(Asteroide1CanvasHd1, 'XData', AsteroideX(1), 'YData', AsteroideY(1));
                set(Asteroide2CanvasHd1, 'XData', AsteroideX(2), 'YData', AsteroideY(2));
                set(Asteroide3CanvasHd1, 'XData', AsteroideX(3), 'YData', AsteroideY(3));
            end
        end
        end
        runLoop = true;
    end
    drawnow;
end 
