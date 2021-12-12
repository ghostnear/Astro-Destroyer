-- This file creates one bullet instance and returns it
bullet = {
    x = 0,
    y = 0,
    speed = 1000,
    size = 10,
    angle = 0
}

-- Make new bullet instance
function bullet:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

-- Update the bullet
function bullet:update(dt)
    self.x = self.x + math.sin(self.angle) * self.speed * dt
    self.y = self.y + math.cos(self.angle) * self.speed * dt
end

-- Draw the bullet
function bullet:draw(dt)
    -- Player bullets color
    love.graphics.setColor(0.6, 0.6, 0.6)

    -- Draw the line
    love.graphics.line(
        self.x + self.size / 2 * math.sin(self.angle), self.y + self.size / 2 * math.cos(self.angle),
        self.x - self.size / 2 * math.sin(self.angle), self.y - self.size / 2 * math.cos(self.angle))
end

return bullet