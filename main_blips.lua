Blips = {}
Blips.__index = Blips

--[[
    @@param caso você já tenha uma função reescrevendo tais funções
]]
local __dxdraw = dxDrawImage
local function dxDrawImage(...)
    return __dxdraw( ... )
end

local _dxdraw = dxDrawText
local function dxDrawText(...)
    return _dxdraw( ... )
end

function Blips:create(element, blipSize, image)
    local instance = setmetatable({}, Blips)
    instance.blip = createBlipAttachedTo(element, 0, 2, 255, 0, 0, 255)
    instance.element = element
    instance.image = image
    instance.blipSize = blipSize or 20
    addEventHandler('onClientRender', root, function()
        instance:draw()
    end)
    return instance
end

function Blips:draw()
    local x, y, z = getElementPosition(self.element)
    local x2, y2, z2 = getElementPosition(localPlayer)
    local sx, sy = getScreenFromWorldPosition(x, y, z+0.5, 0.08)
    if sx and sy then
        dxDrawImage(sx-16, sy-32, 32, 32, self.image, 0, 0, 0)
        dxDrawText(string.format('%.2f', getDistanceBetweenPoints3D(x2, y2, z2, x, y, z)), sx - 50, sy + 20, sx + 50, sy + 50, tocolor(255, 255, 255), 1, 'default-bold', 'center')
    end
    setBlipSize(self.blip, self.blipSize)
end

function Blips:setBlipSize(size)
    self.blipSize = size
end

function Blips:destroy()
    if isElement(self.blip) then
        destroyElement(self.blip)
    end
    removeEventHandler('onClientRender', root, function() self:draw() end)

end
