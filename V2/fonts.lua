-- 

local fonts = {}

fonts.defaultFont = love.graphics.newFont("assets/W95FA.otf", 24)
fonts.titleFont = love.graphics.newFont("assets/Crang.ttf", 42)

fonts.defaultColor = {1, 1, 1}

function fonts.applyDefault()
    love.graphics.setFont(fonts.defaultFont)
    love.graphics.setColor(fonts.defaultColor)
end

return fonts