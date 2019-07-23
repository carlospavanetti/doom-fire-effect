local FIRE_WIDTH, FIRE_HEIGHT = 800, 600
local fire_pixels = {}

function love.load()
    for i = 1, FIRE_WIDTH * FIRE_HEIGHT do
        local initial = (i > FIRE_WIDTH * (FIRE_HEIGHT - 1)) and 256 or 0
        fire_pixels[i] = initial
    end
    love.graphics.setPointSize(2)
end

local function spread_fire(source)
    local rand = math.random(7)
    local dest = source - rand + 3
    for i = 1, 2 * rand do
        fire_pixels[dest - (i * FIRE_WIDTH)] = math.max(
            0, fire_pixels[source] - rand
        )
    end
end

function love.update(dt)
    for x = 1, FIRE_WIDTH do
        for y = 2, FIRE_HEIGHT do
            spread_fire((y - 1) * FIRE_WIDTH + x)
        end
    end
end

local function set_temperature_color(temperature)
    local gray = temperature
    -- local gray = 255 * temperature / 64.0
    local r = gray
    local g = math.max(0, 255 * (gray - 128) / (255 - 128))
    local b = math.max(0, 128 * (gray - 192) / (255 - 192))
    love.graphics.setColor(gray, g, b)
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
