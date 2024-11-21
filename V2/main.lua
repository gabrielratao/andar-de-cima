local menu = require("menu")  -- Carrega a lógica do menu
local game_logic = require("game_logic")  -- Carrega a lógica do jogo
local fonts = require("fonts")

state = "menu"

local menuMusic, gameMusic
local currentMusic -- Para rastrear qual música está tocando

function love.load()
    -- Carregar o background
    love.graphics.setBackgroundColor(68/255, 64/255, 104/255)

    -- Musicas
    menuMusic = love.audio.newSource("assets/Undertale OST - Fallen Down.mp3", "stream")
    gameMusic = love.audio.newSource("assets/Undertale OST - Ruins.mp3", "stream")

    menuMusic:setLooping(true)
    gameMusic:setLooping(true)

    -- Começa com a música do menu
    currentMusic = menuMusic
    love.audio.play(currentMusic)

    -- Carrega o menu
    menu.load()
    game_logic.load()
end

function love.update(dt)
    -- Checa a mudança de estado para atualizar a música
    if state == "menu" and currentMusic ~= menuMusic then
        switchMusic(menuMusic)
    elseif state == "game" and currentMusic ~= gameMusic then
        switchMusic(gameMusic)
    end
end

function love.draw()
    if state == "menu" then
        menu.draw()
    elseif state == "game" then
        game_logic.draw()
    else
        print("Estado desconhecido ou não tratado:", state)
    end
end

function love.mousepressed(x, y, button)
    if state == "menu" then
        menu.handleClick(x, y, button)
        print("click: ", x, y)
    elseif state == "game" then
        game_logic.handleClick(x, y, button)
        print("click: ", x, y)
    end
end

function love.mousereleased(x, y, button)
    if state == "menu" then
        menu.mousereleased(x, y, button)
    elseif state == "game" then
        game_logic.mousereleased(x, y, button)
    end
end

-- Função para trocar de música
function switchMusic(newMusic)
    if currentMusic then
        currentMusic:stop() -- Para a música atual
    end
    currentMusic = newMusic -- Define a nova música
    love.audio.play(currentMusic) -- Toca a nova música
end
