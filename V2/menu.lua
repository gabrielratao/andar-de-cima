local love = require "love"
local fonts = require("fonts")
local Button = require("button")
local game_logic = require("game_logic")

local menu = {}

local backgroundMenu
local predio

local startButton
local loadGame
local exitButton



-- Dimensões e posições dos botões
local buttonWidth = 200
local buttonHeight = 50
-- local startButtonX = (love.graphics.getWidth() - buttonWidth) / 2  -- Centraliza horizontalmente
local startButtonX = 50
local startButtonY = 200
-- local exitButtonX = (love.graphics.getWidth() - buttonWidth) / 2  -- Centraliza horizontalmente
local exitButtonX= 50
local exitButtonY = 400
-- local loadGameX = (love.graphics.getWidth() - buttonWidth) / 2 -- Centraliza horizontalmente
local loadGameX = 50
local loadGameY = 300

function  menu.load()
    print("Carregado")

    backgroundMenu = love.graphics.newImage("assets/background 2.png")
    predio = love.graphics.newImage("assets/predio.png")

    startButton = Button("Iniciar jogo", function()
        state = "game"
        print("Iniciar jogo clicado!")
    end, nil, buttonWidth, buttonHeight, "assets/hover-sound.mp3", "assets/pressed-sound.mp3")

    loadGame = Button("Carregar Jogo", function()
        print("O botão deve carregar os blocos de historia disponiveis.")
    end, nil, buttonWidth, buttonHeight, "assets/hover-sound.mp3", "assets/pressed-sound.mp3")

    exitButton = Button("Sair do jogo", function()
        love.event.quit()
        print("Sair do jogo clicado")
    end, nil, buttonWidth, buttonHeight, "assets/hover-sound.mp3", "assets/pressed-sound.mp3")

   

end

function menu.draw()
    love.graphics.draw(backgroundMenu, 0, 0)
    --local screenWidth, screenHeight = love.graphics.getDimensions()
    --love.graphics.draw(backgroundMenu, 0, 0, 0, screenWidth / backgroundMenu:getWidth(), screenHeight / backgroundMenu:getHeight())

    --local newSize = 384
    love.graphics.draw(predio, 0, 0, 0 --[[, newSize / predio:getWidth(), newSize / predio:getHeight()]])

    love.graphics.setFont(fonts.titleFont)
    love.graphics.setColor(223/255, 113/255, 38/255)
    love.graphics.printf("No Andar de Cima", 0, 100, love.graphics.getWidth(), "center")

    fonts.applyDefault()
    startButton:draw(startButtonX, startButtonY)
    loadGame:draw(loadGameX, loadGameY)
    exitButton:draw(exitButtonX, exitButtonY)

end

function menu.handleClick(x, y, button) -- Identifica em qual botão foi o click
    print("clicado")
    if startButton.isHovered then
        startButton:press()
    elseif loadGame.isHovered then
        loadGame:press()
    elseif exitButton.isHovered then
        exitButton:press()
    end
    
end

function menu.mousereleased(x, y, button) -- Chama a função do botão
    if button == 1 then 
        startButton:release()
        loadGame:release()
        exitButton:release()
        if startButton.isPressed then
            state = "game"
        elseif exitButton.isPressed then
            love.event.quit()
        end
    end
end

return menu