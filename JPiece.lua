local piece = require("piece")
local JPiece = piece:init {
    rotations = {
        {
            {0, 0, 0},
            {1, 1, 1},
            {0, 0, 1}
        },
        {
            {0, 1, 1},
            {0, 1, 0},
            {0, 1, 0}
        },
        {
            {1, 0, 0},
            {1, 1, 1},
            {0, 0, 0}
        },
        {
            {0, 1, 0},
            {0, 1, 0},
            {1, 1, 0}
        }
    },
    sprite = love.graphics.newImage("sprites/JPiece.png")
}

return JPiece