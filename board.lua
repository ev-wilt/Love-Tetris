local board = {
    currentPiece = {},
    currentPieceLoc = {},
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
    font = love.graphics.newFont("fonts/BitPotionExt.ttf", 30),
    score = 0,
    lines = 0,
    level = 1,
    speedMultiplier = 1,
    rotationIndex = 1,
    spriteSize = 20
}

-- Makes the matrix into a 2D matrix and sets all cells to 0.
function board:initMatrix()
    for y = self.minY, self.maxY do
        self.matrix[y] = {}
        for x = self.minX, self.maxX do
            if x ~= self.minX and x ~= self.maxX then
                self.matrix[y][x] = 0
            end
        end
    end
end

-- Adds the next piece from the piece queue into the board.
function board:addNextPiece()
    self.currentPieceLoc = {y = 2, x = 4}
    self.currentPiece = self:popPiece()
    self.rotationIndex = 1
    self:pushPiece()
end

-- Draws the board, including background, pieces that have already landed, and the edge walls.
function board:drawMatrix()
    love.graphics.setColor(196, 207, 161)
    for y = self.minY + 2, self.maxY do
        for x = self.minX, self.maxX do
            if self.matrix[y][x] == 0 then
                love.graphics.rectangle("fill", 50 + x * self.spriteSize, 50 + y * self.spriteSize, self.spriteSize, self.spriteSize)
            elseif self.matrix[y][x] == nil then
                love.graphics.draw(self.boarder, 50 + x * self.spriteSize, 50 + y * self.spriteSize)
            elseif self.matrix[y][x]:type() == "Image" then
                love.graphics.draw(self.matrix[y][x], 50 + x * self.spriteSize, 50 + y * self.spriteSize)
            end
        end
    end
end

-- Draws the piece currently being controlled by the player.
function board:drawCurrentPiece()
    for y = 1, #self.currentPiece.rotations[self.rotationIndex] do
        for x = 1, #self.currentPiece.rotations[self.rotationIndex][y] do
            if self.currentPiece.rotations[self.rotationIndex][y][x] == 1 then
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
    love.graphics.setColor(107, 115, 83)
    love.graphics.rectangle("fill", 320, 370, 100, 100)
    love.graphics.setColor(196, 207, 161)
    love.graphics.rectangle("fill", 325, 375, 90, 90)
    local nextPiece = self.pieceQueue[1]
    local defaultRotation = nextPiece.rotations[1]
    for y = 1, #defaultRotation do
        for x = 1, #defaultRotation[y] do
            if defaultRotation[y][x] == 1 then
                love.graphics.draw(nextPiece.sprite, 310 + x * self.spriteSize, 360 + y * self.spriteSize)
            end
        end
    end
end

-- Draws the current level, score, and lines.
function board:drawStats()
    love.graphics.setFont(self.font)
    love.graphics.setColor(107, 115, 83)
    love.graphics.rectangle("fill", 320, 300, 100, 65)
    love.graphics.rectangle("fill", 320, 230, 100, 65)
    love.graphics.rectangle("fill", 320, 160, 100, 65)

    love.graphics.setColor(196, 207, 161)
    love.graphics.rectangle("fill", 325, 305, 90, 55)
    love.graphics.rectangle("fill", 325, 235, 90, 55)
    love.graphics.rectangle("fill", 325, 165, 90, 55)

    love.graphics.setColor(107, 115, 83)
    love.graphics.print("Score", 350, 160)
    love.graphics.print("Level", 350, 230)
    love.graphics.print("Lines", 350, 300)

    love.graphics.print(self.score, 330, 180)
    love.graphics.print(self.level, 330, 250)
    love.graphics.print(self.lines, 330, 320)

end

-- Checks for possible collisions when the piece is moved.
-- Params:  xShift = Change in x coordinates
--          yShift = Change in y coordinates
function board:pieceWillCollide(xShift, yShift)
    for y = 1, #self.currentPiece.rotations[self.rotationIndex] do
        for x = 1, #self.currentPiece.rotations[self.rotationIndex][y] do
            if self.currentPiece.rotations[self.rotationIndex][y][x] == 1 then
                if x + self.currentPieceLoc.x + xShift < self.minX or x + self.currentPieceLoc.x + xShift > self.maxX then
                    return true
                elseif y + self.currentPieceLoc.y + yShift > self.maxY then
                    return true
                elseif self.matrix[y + self.currentPieceLoc.y + yShift][x + self.currentPieceLoc.x + xShift] ~= 0 then
                    return true
                end
            end
        end
    end
    return false
end

-- Updates the current piece location with the given parameters.
-- If the piece has landed, the next piece is added.
-- Params:  xShift = Change in x coordinates
--          yShift = Change in y coordinates
function board:shiftPiece(xShift, yShift)
    if self:pieceWillCollide(xShift, yShift) == false then
        self.currentPieceLoc.x = self.currentPieceLoc.x + xShift
        self.currentPieceLoc.y = self.currentPieceLoc.y + yShift
    elseif self:pieceWillCollide(xShift, yShift) == true and xShift == 0 then
        self:addPieceToMatrix()
    end
end

-- Adds the currently falling piece to the matrix, meaning it has landed.
function board:addPieceToMatrix()
    for y = 1, #self.currentPiece.rotations[self.rotationIndex] do
        for x = 1, #self.currentPiece.rotations[self.rotationIndex][y] do
            if self.currentPiece.rotations[self.rotationIndex][y][x] == 1 then
                self.matrix[y + self.currentPieceLoc.y][x + self.currentPieceLoc.x] = self.currentPiece.sprite
            end
        end
    end
    self:checkGameOver()
    self:checkClearRows()    
    self:addNextPiece()
end

-- Rotates the current piece, if possible.
-- If the next piece will be out of bounds, it's "wall-kicked" back into the board.
function board:rotatePiece()
    if self.rotationIndex < 4 then
        self.rotationIndex = self.rotationIndex + 1
    else
        self.rotationIndex = 1
    end
    if board:pieceWillCollide(0, 0) == true then 
        local shift = 1
        while shift < 2 and board:pieceWillCollide(shift, 0) == true and board:pieceWillCollide(-shift, 0) == true and board:pieceWillCollide(0, shift) == true do
            shift = shift + 1
        end
        if board:pieceWillCollide(shift, 0) == false then
            self:shiftPiece(shift, 0)
            return
        elseif board:pieceWillCollide(-shift, 0) == false then
            self:shiftPiece(-shift, 0)
            return
        elseif board:pieceWillCollide(0, shift) == false then
            self:shiftPiece(0, shift)
            return
        end
        if self.rotationIndex == 1 then
            self.rotationIndex = 4
        else
            self.rotationIndex = self.rotationIndex - 1
        end
    end
end

-- Checks the board for cleared rows and calls itself to check for multiple clear rows.
function board:checkClearRows()
    for y = self.minY, self.maxY do
        local fullRowCounter = 0
        for x = self.minX + 1, self.maxX - 1 do
            if self.matrix[y][x] ~= 0 then
                fullRowCounter = fullRowCounter + 1
                if fullRowCounter == self.maxX - 2 then
                    for i = y, self.minY + 1, -1 do
                        self.matrix[i] = self.matrix[i - 1]
                    end
                    if self.lines < 999 then
                        self.lines = self.lines + 1
                        if self.lines <= 200 and self.lines % 10 == 0 then
                            self.level = self.lines / 10 + 1
                            self.speedMultiplier = self.speedMultiplier + 0.3
                        end
                    end
                    self:checkClearRows()
                end
            end
        end
    end
end

-- Restarts the game if a set piece is above the playfield.
function board:checkGameOver()
    for y = self.minY + 2, self.minY + 3 do
        for x = self.minX + 1, self.maxX - 1 do
            if self.matrix[y][x] ~= 0 then
                print(y)
                print(x)
                self.score = 0
                self.lines = 0
                self.level = 1
                self:initMatrix()
            end
        end
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