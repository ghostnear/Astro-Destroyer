-- This file creates one player instance and returns it
local player = {
    x = 100,
    y = 360,
    velocity_x = 0,
    velocity_y = 0,
    velocity_max = 100,
    target_x = 0,
    target_y = 0,
    friction = 0.5,
    moved = false,
    speed = 200,
    angle = 0,
    disabled = false,
    size = 20,
    shootSFX = nil,
    bullettimer = 0.66,
    bullettimermax = 0.66
}

-- Make new player instance
function player:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    obj.target_x, obj.target_y = love.mouse.getPosition() 

    -- Load shooting sound
    obj.shootSFX = love.audio.newSource("sound/effects/shipShoot.wav", "stream")
    obj.shootSFX:setVolume(0.2)
    
    return obj
end

-- Update the player
function player:update(dt)
    -- Update velocities
    self.moved = false
    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.velocity_x = self.velocity_x + self.speed * dt
        self.moved = true
    end
    if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.velocity_x = self.velocity_x - self.speed * dt
        self.moved = true
    end
    if love.keyboard.isDown('s') or love.keyboard.isDown('down') then
        self.velocity_y = self.velocity_y + self.speed * dt
        self.moved = true
    end
    if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
        self.velocity_y = self.velocity_y - self.speed * dt
        self.moved = true
    end

    -- Correct velocities
    if self.moved == false then
        if self.velocity_x > 0 then
            self.velocity_x = math.max(self.velocity_x - self.friction * self.velocity_max * dt, 0)
        else 
            self.velocity_x = math.min(self.velocity_x + self.friction * self.velocity_max * dt, 0)
        end
        if self.velocity_y > 0 then
            self.velocity_y = math.max(self.velocity_y - self.friction * self.velocity_max * dt, 0)
        else 
            self.velocity_y = math.min(self.velocity_y + self.friction * self.velocity_max * dt, 0)
        end
    end

    -- Limit velocities
    self.velocity_x = math.max(math.min(self.velocity_x, self.velocity_max), -self.velocity_max)
    self.velocity_y = math.max(math.min(self.velocity_y, self.velocity_max), -self.velocity_max)

    -- Update coordonates
    self.x = self.x + self.velocity_x * dt
    self.y = self.y + self.velocity_y * dt

    -- Screen warping
    if self.x < 0 then
        self.x = love.graphics.getWidth() + self.x
    end
    if self.y < 0 then
        self.y = love.graphics.getHeight() + self.y
    end
    if self.x > love.graphics.getWidth() then
        self.x = self.x - love.graphics.getWidth()
    end
    if self.y > love.graphics.getHeight() then
        self.y = self.y - love.graphics.getHeight()
    end

    -- Update bullet timer
    if self.bullettimer > 0 then
        self.bullettimer = self.bullettimer - dt
        self.bullettimer = math.max(self.bullettimer, 0)
    end

    -- Update angle
    local modX = self.x - self.target_x
    local modY = self.y - self.target_y
    self.angle = math.atan2(modY, modX)
end

-- Draw the player
function player:draw()
    -- Coordonates for the points
    local actualAngle = -self.angle - math.pi / 2

    -- Draw the player triangle
    self.size = self.size + 1
    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon("line",
        self.x + math.sin(actualAngle) * self.size, self.y + math.cos(actualAngle) * self.size,
        self.x + math.sin(2 * math.pi / 3 + actualAngle) * self.size, self.y + math.cos(2 * math.pi / 3 + actualAngle) * self.size,
        self.x + math.sin(4 * math.pi / 3 + actualAngle) * self.size, self.y + math.cos(4 * math.pi / 3 + actualAngle) * self.size)
    self.size = self.size - 1
    love.graphics.setColor(0, 0, 0)
    love.graphics.polygon("fill",
        self.x + math.sin(actualAngle) * self.size, self.y + math.cos(actualAngle) * self.size,
        self.x + math.sin(2 * math.pi / 3 + actualAngle) * self.size, self.y + math.cos(2 * math.pi / 3 + actualAngle) * self.size,
        self.x + math.sin(4 * math.pi / 3 + actualAngle) * self.size, self.y + math.cos(4 * math.pi / 3 + actualAngle) * self.size)

    -- Draw the gun extension above
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(self.x + math.sin(actualAngle) * self.size, self.y + math.cos(actualAngle) * self.size,
    self.x + math.sin(actualAngle) * self.size * 1.25, self.y + math.cos(actualAngle) * self.size * 1.25)
end

-- On mouse move adjust angle
function player:mousemoved(x, y, dx, dy, isTouch)
    -- Set new target
	self.target_x = x
    self.target_y = y
end

return player