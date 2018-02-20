piece = require("piece")
local ZPiece = piece:init {
    rotations = {
        {
            0, 0, 0,
            1, 1, 0,
            0, 1, 1
        },
        {
            0, 1, 0,
            1, 1, 0,
            1, 0, 0
        },
        {
            1, 1, 0,
            0, 1, 1,
            0, 0, 0 
        },
        {
            0, 0, 1,
            0, 1, 1,
            0, 1, 0
        }
    },
    sprite = love.graphics.newImage("sprites/ZPiece.png")
}

return ZPiece