require("lib.table_copy")

local bullets = {
    count = 0,
    bullets = {}
}

function bullets:addBullet(player)
    -- Create new bullet
    local q = require("game.bullet"):new()
    q.angle = -player.angle - math.pi / 2
    q.x = player.x + math.sin(q.angle) * player.size
    q.y = player.y + math.cos(q.angle) * player.size
    table.insert(self.bullets, q)

    -- Play shooting sound
    player.shootSFX:play()

    -- Reset bullet timer
    player.bullettimer = player.bullettimermax
end

function bullets:update(dt)
    for index, q in pairs(self.bullets) do
        q:update(dt)

        -- Optimisation by removing bullets out of the display area
        if q.x + q.size < 0 or q.y + q.size < 0 or q.x - q.size > love.graphics.getWidth() or q.y - q.size > love.graphics.getHeight() then
            table.remove(self.bullets, index)
        end
    end 
end

function bullets:draw()
    for _, q in pairs(self.bullets) do
        q:draw()
    end 
end

return bullets