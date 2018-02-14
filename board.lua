local board = {
    matrix = {}
}

function board.initMatrix(minX, maxX, minY, maxY)
    minX = minX or 1
    maxX = maxX or 10
    minY = minY or 1
    maxY = maxY or 20
    for x = minX, maxX do
        board.matrix[x] = {}
        for y = minY, maxY do
            board.matrix[x][y] = 0
            love.graphics.setColor(196, 207, 161)
            love.graphics.rectangle("fill", 50 + x * 25, 50 + y * 25, 25, 25)
        end
    end
end

return board