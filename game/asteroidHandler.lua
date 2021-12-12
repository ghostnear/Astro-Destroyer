require("lib.table_copy")

local asteroids = {
    count = 0,
    timer = 0,
    asteroids = {}
}

function asteroids:update(dt)
    self.timer = self.timer + dt

    if self.timer >= 0.33 then
        self.timer = 0
        local newAsteroid = require("game.asteroid")
        newAsteroid:load()
        newAsteroid.x = 1111
        newAsteroid.y = love.math.random(720)
        table.insert(self.asteroids, table_copy(newAsteroid))
    end

    for key, element in pairs(self.asteroids) do
        element:update(dt)
        element.x = element.x - dt * 128
        if element.x < -32 then
            table.remove(self.asteroids, key)
        end
    end 
end

function asteroids:draw()
    for key, element in pairs(self.asteroids) do 
        element:draw()
    end
end

return asteroids