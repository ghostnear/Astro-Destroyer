local asteroid = {
    x = 0,
    y = 0,
    r = 0,
    img = nil,
    index = 1
}

asteroidImages = {}
table.insert(asteroidImages, love.graphics.newImage("img/astero-1.png"))
table.insert(asteroidImages, love.graphics.newImage("img/astero-2.png"))

function asteroid:load()
    self.index = love.math.random(2)
    self.img = asteroidImages[self.index]
end

function asteroid:update(dt)
    self.r = self.r + dt * 45
end

function asteroid:draw()
    love.graphics.draw(self.img, self.x, self.y, math.rad(self.r), 1, 1, 32, 32)
end

return asteroid