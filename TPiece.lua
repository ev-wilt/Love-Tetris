local piece = require("piece")
local TPiece = piece:init {
    rotations = {
        {
            {0, 1, 0},
            {1, 1, 0},
            {0, 1, 0}
        },
        {
            {0, 0, 0},
            {1, 1, 1},
            {0, 1, 0}
        },
        {
            {0, 1, 0},
            {0, 1, 1},
            {0, 1, 0}
        },
        {
            {0, 1, 0},
            {1, 1, 1},
            {0, 0, 0}     
        }
    },
    sprite = love.graphics.newImage("sprites/TPiece.png")
}

return TPiece