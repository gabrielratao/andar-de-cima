-- main.lua

-- Variáveis do jogo
local currentScreen = "menu" -- Tela inicial
local dialogueText = "Bem-vindo ao jogo! Escolha uma opção para prosseguir:"
local option1 = "Opção 1: Seguir pelo caminho A"
local option2 = "Opção 2: Seguir pelo caminho B"
local selectedOption = nil
local retroFont

-- Coordenadas e tamanho do botão de voltar
local backButtonX, backButtonY, backButtonWidth, backButtonHeight = 10, 10, 120, 65

function love.load()
    love.window.setTitle("Jogo de Diálogo")
    love.window.setMode(800, 600) -- Configura o tamanho da janela
    
    -- Carrega a fonte retro
    retroFont = love.graphics.newFont("retro.ttf", 20) -- Certifique-se de que o arquivo "retro.ttf" esteja na pasta
    love.graphics.setFont(retroFont)
end

function love.update(dt)
    -- Função de atualização; aqui, não temos nada para atualizar por enquanto
end

function love.draw()
    -- Define o fundo verde musgo para todas as telas
    love.graphics.clear(85 / 255, 107 / 255, 47 / 255)

    if currentScreen == "menu" then
        drawMenuScreen()
    elseif currentScreen == "game" then
        drawGameScreen()
    end
end

function drawMenuScreen()
    love.graphics.setColor(1, 1, 1) -- Define a cor do texto para branco
    love.graphics.printf("Clique ENTER para iniciar o jogo", 0, 250, 800, "center")
end

function drawGameScreen()
    -- Exibe o texto de diálogo
    love.graphics.printf(dialogueText, 0, 150, 800, "center")

    -- Define as coordenadas e tamanhos das opções para desenhar uma borda ao redor delas
    local option1X, option1Y, optionWidth, optionHeight = 200, 250, 400, 30
    local option2X, option2Y = 200, 300

    -- Define a cor da borda (preto) e desenha os retângulos
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", option1X, option1Y, optionWidth, optionHeight)
    love.graphics.rectangle("line", option2X, option2Y, optionWidth, optionHeight)

    -- Define a cor do texto (branco) e desenha as opções de texto
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(option1, option1X, option1Y, optionWidth, "center")
    love.graphics.printf(option2, option2X, option2Y, optionWidth, "center")

    -- Exibe a escolha do jogador, se houver
    if selectedOption then
        love.graphics.printf("Você escolheu: " .. selectedOption, 0, 450, 800, "center")
    end

    -- Desenha o botão de voltar
    love.graphics.setColor(0, 0, 0) -- Cor do botão (preto)
    love.graphics.rectangle("line", backButtonX, backButtonY, backButtonWidth, backButtonHeight)
    love.graphics.setColor(1, 1, 1) -- Cor do texto (branco)
    love.graphics.printf("Página inicial", backButtonX, backButtonY + 10, backButtonWidth, "center")
end

function love.keypressed(key)
    if currentScreen == "menu" and key == "return" then
        currentScreen = "game" -- Muda para a tela do jogo ao apertar ENTER
    elseif currentScreen == "game" then
        if key == "1" then
            selectedOption = "Opção 1"
            dialogueText = "Você seguiu pelo caminho A!"
        elseif key == "2" then
            selectedOption = "Opção 2"
            dialogueText = "Você seguiu pelo caminho B!"
        end
    end
end

function love.mousepressed(x, y, button)
    if currentScreen == "game" and button == 1 then -- Detecta clique esquerdo do mouse
        -- Verifica se o clique está dentro das coordenadas do botão de voltar
        if x >= backButtonX and x <= backButtonX + backButtonWidth and
           y >= backButtonY and y <= backButtonY + backButtonHeight then
            currentScreen = "menu" -- Retorna à tela inicial
            selectedOption = nil -- Reseta a opção selecionada
            dialogueText = "Bem-vindo ao jogo! Escolha uma opção para prosseguir:"
        end
    end
end
