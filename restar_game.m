function restar_game % Funcion de inicializacion de variables
    global AsteroideX AsteroideY ShieldX ShieldY PlayerInit AsteroideInit direction touch_bottom shields new_star_game;
    % Inicializacion de variables de juego
    PlayerInit = [300 432]; %Posición inical del jugador
    ShieldX = randperm(700, 1); %Posición inicial del escudo en el eje X
    ShieldY = randperm(100, 1)*10; %Posición inicial del escudo en el eje Y
    AsteroideX = randperm(700, 3); %Posición inicial de los asteroides en el eje X
    AsteroideY = -randperm(100, 3)*10; %Posición inicial de los asteroides en el eje Y
    AsteroideInit = {}; %Inicialización de la celda de asteroides

    for i = 1:3
        %Si el escudo está en la misma posición que el asteroide, se vuelve a calcular la posición del escudo.
        if (AsteroideX(i) == ShieldX && AsteroideY(i) == ShieldY)
            ShieldX = randperm(700, 1);
            ShieldY = randperm(100, 1)*10;
        end
        AsteroideInit{i} = [AsteroideX(i) AsteroideY(i)]; %Posición inicial de los asteroides
    end

    ShieldInit = {}; %Posición inicial del escudo
    direction = 0; %Inicialización de la variable de dirección
    touch_bottom = zeros(10, 1); %Inicialización de la variable de toque en el fondo
    score = 0; %Inicialización de la variable de puntuación
    new_star_game = 0; %Inicialización de la variable de reinicio de juego
    runLoop = false;
    shields = 2; %Inicialización de la variable de escudos
    disp("Entró a restart_game")
    drawnow;
end