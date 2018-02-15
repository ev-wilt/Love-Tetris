local board = {
    matrix = {},
    minX = 1, maxX = 12,
    minY = 1, maxY = 20,
    boarder = love.graphics.newImage("sprites/boarder.png")    
}

function board.initMatrix()
    for x = board.minX, board.maxX do
        board.matrix[x] = {}
        for y = board.minY, board.maxY do
            if x ~= board.minX and x ~= board.maxX then
                board.matrix[x][y] = 0
            end
        end
    end
    return board.matrix
end

function board.drawMatrix()
    for x = board.minX, board.maxX do
        for y = board.minY, board.maxY do
            if board.matrix[x][y] == 0 then
                love.graphics.setColor(196, 207, 161)
                love.graphics.rectangle("fill", 50 + x * 25, 50 + y * 25, 25, 25)
            elseif board.matrix[x][y] == nil then
                love.graphics.draw(board.boarder, 50 + x * 25, 50 + y * 25)
            end
        end
    end
    return board.matrix
end

return board