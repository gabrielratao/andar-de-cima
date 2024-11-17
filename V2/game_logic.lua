--[[
    TODO:

    → IDEALIZAR MELHOR O BOTÃO DE PAUSA

    → CRIAR TELA "ESCAPE" PRA QUANDO CAIR EM UMA CENA NÃO CRIADA 

    → ADICIONAR O SOUNDESIGN

]]


local love = require "love"
local story = require("story")
local fonts = require("fonts")


local game_logic = {}

-- Variáveis globais
local currentSceneIndex = 1  -- Começa na primeira cena
local buttons = {}


-- Margens e espaçamento
local marginX = 50
local marginY = 100
local lineSpacing = 20 -- Espaço entre texto principal e subtexto
local buttonSpacing = 20 -- Espaço entre os botões
local maxTextWidth = 800 -- Limite para a largura do texto principal

function game_logic.load()
    fonts.applyDefault()
    print("Game logic carregado.")

    
    -- Inicializa a primeira cena
    game_logic.loadScene(currentSceneIndex)



end

function game_logic.loadScene(sceneIndex)
    print("Carregando cena: " .. sceneIndex)
    currentSceneIndex = sceneIndex
    local currentScene = story[sceneIndex]
    
    if not currentScene then
        print("Erro: Cena não encontrada para o índice " .. sceneIndex)
        
        --botão retornar para o menu principal
        return
    end

    print("Texto da cena: " .. currentScene.text)

    -- Limpa os botões da cena anterior mas mantem o de voltar ao menu
    buttons = {}

    -- Cria botões para cada opção da cena
    for i, option in ipairs(currentScene.options) do
        -- Calcula dinamicamente a largura do botão com base no texto
        local font = love.graphics.getFont()
        local textWidth = font:getWidth(option.text)
        local buttonWidth = textWidth + 30 -- Largura do texto + padding
        local buttonHeight = 50 -- Altura fixa para consistência

        -- Calcula a posição do botão
        local buttonX = marginX -- Alinhado à esquerda
        local buttonY = marginY + 300 + lineSpacing + (i - 1) * (buttonHeight + buttonSpacing)

        print("Criando botão para opção " .. i .. ": " .. option.text)
        local newButton = Button(
            option.text, -- Texto do botão
            function()
                print("Botão pressionado: " .. option.text)
                game_logic.loadScene(option.next) -- Atualiza para a próxima cena
            end,
            nil, -- Nenhum parâmetro adicional necessário
            buttonWidth, 
            buttonHeight,
            "assets/hover-sound.mp3"
        )
        newButton.button_x = buttonX
        newButton.button_y = buttonY
        table.insert(buttons, newButton)
    end
    print("Botões criados para a cena " .. sceneIndex)

end

function game_logic.draw()
    -- Desenha o texto da cena atual
    local currentScene = story[currentSceneIndex]

    if not currentScene then
        -- print("Erro: Tentativa de desenhar uma cena invalida.")
        local currentSceneNotFound = love.graphics.print("Error: Cena não encontrada.", 200, 300)
        return
    end
    

    love.graphics.setColor(1, 1, 1)

    -- Desenha o texto principal da cena
    local font = love.graphics.getFont()
    local _, wrappedText = font:getWrap(currentScene.text, maxTextWidth)
    local textHeight = #wrappedText * font:getHeight()

    -- Desenha o texto principal com largura limitada
    love.graphics.printf(
        currentScene.text, 
        marginX, 
        marginY, 
        maxTextWidth, 
        "left"
    )

    -- Desenha o subtexto com largura limitada
    local subtextY = marginY + textHeight + lineSpacing
    love.graphics.printf(
        currentScene.subtext or "O que você faz?", -- Subtexto padrão
        marginX,
        subtextY,
        maxTextWidth,
        "left"
    )

    -- Desenha os botões das opções
    for index, button in ipairs(buttons) do
        -- Recalcula as posições para garantir que os botões são desenhados corretamente
        button:draw(button.button_x, button.button_y)
    end

end

function game_logic.handleClick(x, y, button)
    if button == 1 then
        -- Verifica se algum botão foi pressionado
        for index, btn in ipairs(buttons) do
            btn:press()
        end
    end
end

function game_logic.mousereleased(x, y, button)
    if button == 1 then
        -- Libera o clique do botão
        for index, btn in ipairs(buttons) do
            btn:release()
        end
    end
end

return game_logic