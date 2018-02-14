local board = {
    matrix = {}
}

function board.initMatrix()
    for x = 1, 10 do
        board.matrix[x] = {}
        for y = 1, 20 do
            board.matrix[x][y] = 0
        end
    end
end

return board