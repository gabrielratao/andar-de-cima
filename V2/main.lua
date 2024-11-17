local menu = require("menu")  -- Carrega a lógica do menu
local game_logic = require("game_logic")  -- Carrega a lógica do jogo"
local fonts = require("fonts")

state = "menu"


function love.load()
    --Carregar o banckground
    love.graphics.setBackgroundColor(68/255, 64/255, 104/255)

    -- Carrega o menu
    menu.load()
    
    game_logic.load()
end
    
function love.draw()
    --print("estado atual:", menu.state)
    if menu.state == "menu" then
        -- Desenha a tela do menu
        --print("Desenhando o menu...")
        menu.draw()  
    elseif menu.state == "game" then
        -- Desenha a tela do jogo
        --print("Desenhando o jogo...")
        game_logic.draw()  
    else
        print("Estado desconhecido ou não tratado:", state)
    end
end
    
function love.mousepressed(x, y, button)
    if menu.state == "menu" then
        menu.handleClick(x, y, button)
    elseif menu.state == "game" then
        game_logic.handleClick(x,y, button)
    end
end

function love.mousereleased(x, y, button)
    if menu.state == "menu" then
        menu.mousereleased(x, y, button)
    elseif menu.state == "game" then
        game_logic.mousereleased(x, y, button)
    end
end

