-- Love Tetris
-- Created by Evan Wilt

function love.load()
    love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})
    love.graphics.setBackgroundColor(65, 65, 65)
    math.randomseed(os.time())
    board = require("board")
    dropTimer = 0
    board:initMatrix()
    board:pushPiece()
    board:addNextPiece()
end

function love.update(dt)
    dropTimer = dropTimer + dt * board.speedMultiplier
    if dropTimer >= 1 and love.keyboard.isDown("s") == false then
        board:shiftPiece(0, 1)
        dropTimer = 0
    end
end

function love.keypressed(key)
    love.keyboard.setKeyRepeat(true)
    if key == "s" then
        board:shiftPiece(0, 1)
    elseif key == "d" then 
        board:shiftPiece(1, 0)
    elseif key == "a" then 
        board:shiftPiece(-1, 0)
    elseif key == "space" then
        love.keyboard.setKeyRepeat(false)
        board:rotatePiece()
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    board:drawMatrix()
    board:drawCurrentPiece()
    board:drawNextPiece()
    board:drawStats()
end