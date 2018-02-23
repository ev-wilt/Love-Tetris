local board = {
    currentPiece = {},
    currentPieceLoc = {},
    currentPieceRotation = {},
    matrix = {},
    pieces = {
        [1] = require("IPiece"),
        [2] = require("JPiece"),
        [3] = require("LPiece"),
        [4] = require("OPiece"),
        [5] = require("SPiece"),
        [6] = require("TPiece"),
        [7] = require("ZPiece")
    },
    pieceQueue = {},
    minX = 1, maxX = 12,
    minY = 1, maxY = 20,
    boarder = love.graphics.newImage("sprites/boarder.png"),
    spriteSize = 20
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

-- Adds the next piece from the piece queue into the board.
function board:addNextPiece()
    self.currentPieceLoc = {y = 0, x = 4}
    self.currentPiece = self:popPiece()
    self.currentPieceRotation = self.currentPiece.rotations[1]
    self:pushPiece()
end

-- Draws the board, including background, pieces that have already landed, and the edge walls.
function board:drawMatrix()
    for x = self.minX, self.maxX do
        for y = self.minY, self.maxY - 2 do
            if self.matrix[x][y] == 0 then
                love.graphics.setColor(196, 207, 161)
                love.graphics.rectangle("fill", 50 + x * self.spriteSize, 50 + y * self.spriteSize, self.spriteSize, self.spriteSize)
            elseif self.matrix[x][y] == nil then
                love.graphics.draw(self.boarder, 50 + x * self.spriteSize, 50 + y * self.spriteSize)
            end
        end
    end
end

-- Draws the piece currently being controlled by the player.
function board:drawCurrentPiece()
    for y = 1, #self.currentPieceRotation do
        for x = 1, #self.currentPieceRotation[y] do
            if self.currentPieceRotation[y][x] == 1 then
                love.graphics.draw(
                    self.currentPiece.sprite,
                    50 + self.spriteSize * (self.currentPieceLoc.x + x),
                    50 + self.spriteSize * (self.currentPieceLoc.y + y)
                )
            end
        end
    end
end

-- Draws the next piece in the queue.
function board:drawNextPiece()
    local nextPiece = self.pieceQueue[1]
    local defaultRotation = nextPiece.rotations[1]
    for y = 1, #defaultRotation do
        for x = 1, #defaultRotation[y] do
            if defaultRotation[y][x] == 1 then
                love.graphics.draw(nextPiece.sprite, 320 + x * 20, 340 + y * 20)
            end
        end
    end
end

-- Checks for possible collisions when the piece is moved.
-- Params:  xShift = Change in x coordinates
--          yShift = Change in y coordinates
function board:pieceWillCollide(xShift, yShift)
    for y = 1, #self.currentPieceRotation do
        for x = 1, #self.currentPieceRotation[y] do
            if self.currentPieceRotation[y][x] == 1 then
                if self.matrix[x + self.currentPieceLoc.x + xShift][y + self.currentPieceLoc.y + yShift] == 1 then
                    return true
                end
            end
        end
    end
    return false
end

-- Moves each sprite in the current piece down one cell if possible.
-- Params:  xShift = Change in x coordinates
--          yShift = Change in y coordinates
function board:shiftPiece(xShift, yShift)
    if self:pieceWillCollide(xShift, yShift) == false then
        self.currentPieceLoc.x = self.currentPieceLoc.x + xShift
        self.currentPieceLoc.y = self.currentPieceLoc.y + yShift
    end
end

-- Adds a new random piece to the piece queue.
function board:pushPiece()
    local newPiece = self.pieces[math.random(#self.pieces)]
    table.insert(self.pieceQueue, newPiece)
end

-- Removes a piece from the piece queue.
-- Returns: the popped piece.
function board:popPiece()
    return table.remove(self.pieceQueue, 1)
end

return board