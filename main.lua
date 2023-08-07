function love.load()
    love.window.setMode(0,0)
    rectangle = {
        x = 250,
        y = 250,
        width = 100,
        height = 100,
        mode = "line",
        velocity = 0,
        fallingtime = 0,
        settingsbox = "closed",
        mouselocked = false,
    }
    function rectangle.reset()
        rectangle.velocity = 0
        rectangle.fallingtime = 0
    end
    floor = {
        x = 0,
        y = love.graphics.getHeight() - 100,
        width = love.graphics.getWidth(),
        height = 100,
        mode = "line",
    }
end

function love.update(dt)
    if rectangle.mouselocked == true then
        rectangle.x, rectangle.y = love.mouse.getX() - rectangle.width / 2, love.mouse.getY() - rectangle.height / 2
        rectangle.reset()
    elseif rectangle.y + rectangle.velocity >= floor.y - floor.height then
        rectangle.reset()
        rectangle.y = floor.y - floor.height
    else
        rectangle.velocity = rectangle.velocity + 9.82 * dt
    end
    rectangle.y = rectangle.y + rectangle.velocity
end

function love.draw()
    love.graphics.rectangle(rectangle.mode, rectangle.x, rectangle.y, rectangle.width, rectangle.height)
    love.graphics.rectangle(floor.mode, floor.x, floor.y, floor.width, floor.height)
end

function love.keypressed(key)
    if key == "space" and rectangle.velocity == 0 then
        rectangle.velocity = -10
    end
end

function love.mousepressed(x,y,button)
    if button == 1 and x >= rectangle.x and x <= rectangle.x + rectangle.width and y >= rectangle.y and y <= rectangle.y + rectangle.height then
        rectangle.mouselocked = true
    end
end

function love.mousereleased()
    rectangle.mouselocked = false
end