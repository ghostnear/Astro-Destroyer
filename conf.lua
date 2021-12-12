function love.conf(t)
    t.version = "11.3"                  -- The LÖVE version this game was made for (string)
    t.gammacorrect = true               -- Enable gamma-correct rendering, when supported by the system (boolean)

    t.window.title = "Astro Destroyer"  -- The window title (string)
    t.window.icon = "img/icon.png"
    t.window.width = 1080               -- The window width (number)
    t.window.height = 720               -- The window height (number)
    t.window.vsync = 1                  -- Vertical sync mode (number)
    t.window.msaa = 8                   -- The number of samples to use with multi-sampled antialiasing (number)
    t.window.highdpi = true             -- Enable high-dpi mode for the window on a Retina display (boolean)
    t.window.usedpiscale = true         -- Enable automatic DPI scaling when highdpi is set to true as well (boolean)
end