local piece = require("piece")
local LPiece = piece:init {
    rotations = {
        {
            {1, 0},
            {1, 0},
            {1, 1},
        },
        {
            {1, 1, 1},
            {1, 0, 0}
        },
        {
            {1, 1},
            {0, 1},
            {0, 1},
        },
        {
            {0, 0, 1},
            {1, 1, 1}
        }
    },
    sprite = love.graphics.newImage("sprites/LPiece.png")
}

return LPiece