-- Love Tetris
-- Created by Evan Wilt

function love.load()
    love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
    love.graphics.setBackgroundColor(65, 65, 65)
    math.randomseed(os.time())
    board = require("board")
    board:initMatrix()
    board:pushPiece()
    board:addNextPiece()
end

function love.keypressed(key)
    if key == "s" then
        board:shiftPiece(0, 1)
    elseif key == "d" then 
        board:shiftPiece(1, 0)
    elseif key == "a" then 
        board:shiftPiece(-1, 0)
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    board:drawMatrix()
    board:drawCurrentPiece()
    board:drawNextPiece()
end