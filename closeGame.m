function closeGame(src, event) % Funcion de cierre de la ventana
    global runLoop;
    runLoop = false;
    close all;
    clear;
    return;
end