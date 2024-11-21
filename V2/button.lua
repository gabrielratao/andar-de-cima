local love = require "love"

function Button(text, func, func_param, width, height, hoverSound, pressedSound)
    padding = padding or 15
    return {
        width = width or 100,
        height = height or 100,
        func = func or function() print("This button has no function attached") end,
        text = text or "No Text",
        button_x = 0,
        button_y = 0,
        text_x = 0,
        text_y = 0,
        padding = padding,
        
        hoverSound = hoverSound and love.audio.newSource(hoverSound, "static") or nil,
        pressedSound = pressedSound and love.audio.newSource(pressedSound, "static") or nil,

        isHovered = false,
        isPressed = false,
        hasPlayedHoverSound = false,

        draw = function (self, button_x, button_y, text_y)
            self.button_x = button_x or self.button_x
            self.button_y = button_y or self.button_y

            -- Calcula a posição do texto com o padding aplicado
            self.text_x = self.button_x + self.padding
            self.text_y = self.button_y + self.padding

            -- Verifica se o mouse está sobre o botão
            local mouseX, mouseY = love.mouse.getPosition()
            local prevHoverState = self.isHovered -- Armazena o estado anterior

            self.isHovered = mouseX > self.button_x and mouseX < (self.button_x + self.width) and 
                             mouseY > self.button_y and mouseY < (self.button_y + self.height)

            -- Se entrou no hover e ainda não tocou o som, toca o som
            if self.isHovered and not prevHoverState and self.hoverSound then
                love.audio.play(self.hoverSound)
            end

            if self.isPressed then
                love.graphics.setColor(150/255, 71/255, 18/255)
            elseif self.isHovered then
                love.graphics.setColor(252/255, 135/255, 56/255)
            else 
                love.graphics.setColor(223/255, 113/255, 38/255)
            end
            
            love.graphics.rectangle("fill", self.button_x, self.button_y, self.width, self.height, 5)

            love.graphics.setColor(0, 0, 0)
            love.graphics.print(self.text, self.text_x, self.text_y)

            love.graphics.setColor(1, 1, 1)
        end,
--[[
        hover = function(self, x, y)
            self.isHovered = x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height
        end,
]]
        press = function(self)
            if self.isHovered then
                self.isPressed = true
            end
            if self.pressedSound then
                love.audio.play(self.pressedSound)
            end
        end,

        release = function(self)
            print("botão liberado: ", self.text, "isHovered: ", self.isHovered)
            if self.isPressed and self.isHovered then
                self.func()
            end
            self.isPressed = false 
        end
    }
end

return Button