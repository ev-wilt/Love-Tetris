local piece = {
    rotations = {},
    sprite = {},
    local currentPosition = {}
}

-- Sets the current position of the piece, where X and Y represent
-- the coordinates of the top-leftmost sprite of the piece.
function setCurrentPosition(x, y)
    piece.currentPosition["x"] = x
    piece.currentPosition["y"] = y
end

-- Gets the current position of the piece, where X and Y represent
-- the coordinates of the top-leftmost sprite of the piece.
function getCurrentPosition()
    return piece.currentPosition
end

-- Draws the piece on the board at its current position.
function drawPiece()

end

return piece