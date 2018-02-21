local piece = {
    rotations = {},
    sprite = {},
    currentPosition = {}
}

-- Initializes any new instances of the piece class.
function piece:init(properties)
    properties = properties or {}
    setmetatable(properties, self)
    self.__index = self
    return properties
end

-- Sets the current position of the piece, where X and Y represent
-- the coordinates of the top-leftmost sprite of the piece.
function piece:setCurrentPosition(x, y)
    self.currentPosition["x"] = x
    self.currentPosition["y"] = y
end

-- Gets the current position of the piece, where X and Y represent
-- the coordinates of the top-leftmost sprite of the piece.
function piece:getCurrentPosition()
    return self.currentPosition
end

-- Draws the piece on the board at its current position.
function piece:drawPiece()

end

return piece