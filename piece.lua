local piece = {
    rotations = {},
    sprite = {},
    local currentPosition = {}
}

-- Sets the current position of the piece, where X and Y represent
-- the coordinates of the top-leftmost sprite of the piece.
function piece:setCurrentPosition(x, y)
    self.currentPosition["x"] = x
    self.currentPosition["y"] = y
end

-- Gets the current position of the piece, where X and Y represent
-- the coordinates of the top-leftmost sprite of the piece.
function piece:getCurrentPosition()
    return piece.currentPosition
end

-- Draws the piece on the board at its current position.
function piece:drawPiece()

end

return piece