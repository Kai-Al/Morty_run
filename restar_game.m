function restar_game % Funcion de inicializacion de variables
    global AsteroideX AsteroideY PlayerInit AsteroideInit ShieldInit fire direction bullet_stat touch_bottom score new_star_game;
    % Inicializacion de variables de juego
    PlayerInit = [300 432]; %Posición inical del jugador
    AsteroideX = randperm(700, 10); %Posición inicial de los asteroides en el eje X
    AsteroideY = -randperm(100, 10)*10; %Posición inicial de los asteroides en el eje Y
    AsteroideInit = {}; %Inicialización de la celda de asteroides

    for i = 1:3
        AsteroideInit{i} = [AsteroideX(i) AsteroideY(i)]; %Posición inicial de los asteroides
    end

    ShieldInit = {}; %Posición inicial del escudo
    fire = 0; %Inicialización de la variable de disparo
    direction = 0; %Inicialización de la variable de dirección
    bullet_stat = 0; %Inicialización de la variable de estado de la bala
    touch_bottom = zeros(10, 1); %Inicialización de la variable de toque en el fondo
    score = 0; %Inicialización de la variable de puntuación
    new_star_game = 0; %Inicialización de la variable de reinicio de juego
    runLoop = false;
    disp("Entró a restart_game")
    drawnow;
end