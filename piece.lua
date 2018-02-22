local piece = {
    rotations = {},
    sprite = {},
}

-- Initializes any new instances of the piece class.
-- Returns: the new instance of the class.
function piece:init(properties)
    properties = properties or {}
    setmetatable(properties, self)
    self.__index = self
    return properties
end

return piece