local board = {
    matrix = {},
    pieces = {
        IPiece = require("IPiece"),
        JPiece = require("JPiece"),
        LPiece = require("LPiece"),
        OPiece = require("OPiece"),
        SPiece = require("SPiece"),
        TPiece = require("TPiece"),
        ZPiece = require("ZPiece")
    },
    pieceQueue = {},
    minX = 1, maxX = 12,
    minY = 1, maxY = 20,
    boarder = love.graphics.newImage("sprites/boarder.png")
}

-- Makes the matrix into a 2D matrix and sets all cells to 0.
function board:initMatrix()
    for x = self.minX, self.maxX do
        self.matrix[x] = {}
        for y = self.minY, self.maxY do
            if x ~= self.minX and x ~= self.maxX then
                self.matrix[x][y] = 0
            end
        end
    end
end

-- Draws the board, including background, pieces that have already landed, and the edge walls.
function board:drawMatrix()
    for x = self.minX, self.maxX do
        for y = self.minY, self.maxY - 2 do
            if self.matrix[x][y] == 0 then
                love.graphics.setColor(196, 207, 161)
                love.graphics.rectangle("fill", 50 + x * 20, 50 + y * 20, 20, 20)
            elseif self.matrix[x][y] == nil then
                love.graphics.draw(self.boarder, 50 + x * 20, 50 + y * 20)
            end
        end
    end
end

-- Adds a new random piece to the piece queue.
function board:pushPiece()
    
end


return board