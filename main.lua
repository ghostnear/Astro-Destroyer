require("lib.utilities")

-- Star handler
starHandler = require("game.starHandler")

-- Asteroid handler
asteroidHandler = require("game.asteroidHandler")

-- Bullets handler
bulletsHandler = require("game.bulletsHandler")

-- Player handler
player = require("game.player"):new()

-- Crosshair handler
crosshair = require("game.crosshair"):new()

-- Background music
music = love.audio.newSource("sound/menu.mp3", "stream")
music:setVolume(0.5)
music:setLooping(true)
music:play()

-- Timer and scoring
timer = 60
score = 0

function love.load()
    -- Create the stars
    starHandler:init()
end

function love.update(dt)
    -- Delta time correction
    dt = math.min(dt, 0.5)

    -- Update the stars
    starHandler:update(dt)

    -- Reduce timer
    if timer > 0 then
        -- Count the time
        timer = timer - dt

        -- Update the bullets
        bulletsHandler:update(dt)

        -- Update the asteroids
        asteroidHandler:update(dt)

        -- Update the player
        player:update(dt)

        -- Shoot
        if (love.keyboard.isDown('space') or love.mouse.isDown(1)) and player.bullettimer == 0 then
            bulletsHandler:addBullet(player)
        end

        -- Check bullet / asteroid collisions
        checkBulletCollisions()

        -- Check player collisions
        checkPlayerCollisions()
    end
end

function checkBulletCollisions()
    -- Check bullet / asteroid collisions
    for indexBullet, q in pairs(bulletsHandler.bullets) do
        for indexAsteroid, r in pairs(asteroidHandler.asteroids) do
            if pointDistance(q.x, q.y, r.x, r.y) <= 30 then
                table.remove(bulletsHandler.bullets, indexBullet)
                table.remove(asteroidHandler.asteroids, indexAsteroid)
                score = score + 1
                checkBulletCollisions()
                return nil
            end
        end
    end
end

function checkPlayerCollisions()
    -- Check asteroid / player collisions
    for indexAsteroid, q in pairs(asteroidHandler.asteroids) do
        if pointDistance(q.x, q.y, player.x, player.y) <= 40 then
            timer = -1
            return nil
        end
    end
end

function love.draw()
    -- Draw the stars
    starHandler:draw()

    -- If there is still time left
    if timer > 0 then
        -- Draw the asteroids
        asteroidHandler:draw()

        -- Draw the player
        player:draw()

        -- Draw the bullets
        bulletsHandler:draw()

        -- Draw the crosshair
        crosshair:draw()

        -- Draw timer text
        love.graphics.setColor(1, timer / 60, timer / 60, 1)
        love.graphics.print("Time: " .. math.floor(timer))

        love.graphics.setColor(0, 0.8, 0.1, 1)
        love.graphics.print("Score: " .. score, 0, 16)
    else
        love.graphics.setColor(0.9, 0.9, 0.9, 1, 10)
        love.graphics.print("Final score: " .. score, 456, 340, 0, 2)
    end

end

function love.mousemoved(x, y)
    -- Update player rotation
    player:mousemoved(x, y)

    -- Update crosshair position
    crosshair:mousemoved(x, y)
end