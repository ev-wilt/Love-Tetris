local LPiece = piece:new {
    rotations = {
        {
            1, 1, 1,
            1, 0, 0
        },
        {
            1, 0,
            1, 0,
            1, 1,
        },
        {
            0, 0, 1,
            1, 1, 1
        },
        {
            1, 0,
            1, 0,
            1, 1,
        }
    },
    sprite = love.graphics.newImage("sprites/LPiece.png")
}

return LPiece