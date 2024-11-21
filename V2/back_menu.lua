local love = require "love"

local backMenu = {}

function backMenu.confirmMessage(changeState)
    local title = "Voltar ao menu principal"
    local messagem = "Você tem certeza? Todo o progresso será perdido."
    local options = {"OK", "Nope", escapebutton = 2}

    local coiche = love.window.showMessageBox(title, message, options)

    if choice == 1 then
        print("Voltando ao menu principal....")
        changeState("menu")
    else
        print("Cancelado pelo usuário.")
    end
end

return backMenu