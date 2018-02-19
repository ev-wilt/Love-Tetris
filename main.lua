-- Love Tetris
-- Created by Evan Wilt

function love.load()
    love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
    love.graphics.setBackgroundColor(65, 65, 65)
    board = require("board")
    board:initMatrix()
end

function love.update(dt)

end

function love.draw()
    board:drawMatrix()
end