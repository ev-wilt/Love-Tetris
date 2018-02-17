local TPiece = piece:new {
    rotations = {
        {
            0, 0, 0,
            1, 1, 1,
            0, 1, 0
        },
        {
            0, 1, 0,
            0, 1, 1,
            0, 1, 0
        },
        {
            0, 1, 0,
            1, 1, 1,
            0, 0, 0      
        },
        {
            0, 1, 0,
            1, 1, 0,
            0, 1, 0
        }
    },
    sprite = love.graphics.newImage("sprites/TPiece.png")
}

return TPiece