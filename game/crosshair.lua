-- This file creates one crosshair instance and returns it
local crosshair = {
    x = 0,
    y = 0,
    size = 20
}

-- Make new crosshair instance
function crosshair:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj.x, obj.y = love.mouse.getPosition() 
    love.mouse.setVisible(false)
    return obj
end

-- Draw the crosshair
function crosshair:draw()
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.line(self.x - self.size / 2, self.y, self.x + self.size / 2, self.y)
    love.graphics.line(self.x, self.y - self.size / 2, self.x, self.y + self.size / 2)
end

-- On mouse move adjust position
function crosshair:mousemoved(x, y, dx, dy, isTouch)
    -- Set new target
	self.x = x
    self.y = y
end

return crosshair