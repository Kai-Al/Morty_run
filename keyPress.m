
function keyPress(src, event) % Funcion de teclado
    global direction new_star_game runLoop;
    runLoop = true;
    new_star_game = 1;
    switch (event.Key)
        case 'leftarrow'
            direction = 1;
        case 'rightarrow'
            direction = 2;
        case 'uparrow'
            direction = 3;
        case 'downarrow'
            direction = 4;
    end
    
end