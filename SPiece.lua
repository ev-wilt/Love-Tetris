piece = require("piece")
local SPiece = piece:init {
    rotations = {
        {
            0, 0, 0,
            0, 1, 1,
            1, 1, 0
        },
        {
            1, 0, 0,
            1, 1, 0,
            0, 1, 0
        },
        {
            0, 1, 1,
            1, 1, 0,
            0, 0, 0 
        },
        {
            0, 1, 0,
            0, 1, 1,
            0, 0, 1
        }
    },
    sprite = love.graphics.newImage("sprites/SPiece.png")
}

return SPiece