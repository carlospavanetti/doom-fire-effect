local FIRE_WIDTH, FIRE_HEIGHT = 800, 600
local fire_pixels = {}

function love.load()
    for i = 1, FIRE_WIDTH * FIRE_HEIGHT do
        local initial = (i > FIRE_WIDTH * (FIRE_HEIGHT - 1)) and 36 or 0
        fire_pixels[i] = initial
    end
    love.graphics.setPointSize(2)
end

local function spread_fire(source)
    fire_pixels[source - FIRE_WIDTH] = math.max(
        0, fire_pixels[source] - 1
    )
end

function love.update(dt)
    for x = 1, FIRE_WIDTH do
        for y = 2, FIRE_HEIGHT do
            spread_fire((y - 1) * FIRE_WIDTH + x)
        end
    end
end

local function set_temperature_color(temperature)
    -- local gray = 7 * temperature
    local gray = 255 * temperature / 36.0
    love.graphics.setColor(gray, gray, gray)
end

local draw_points = love.graphics.point or love.graphics.points
function love.draw()
    for x = 1, FIRE_WIDTH do
        for y = 1, FIRE_HEIGHT do
            set_temperature_color(
                fire_pixels[(y - 1) * FIRE_WIDTH + x]
            )
            draw_points(x, y)
        end
    end
end
