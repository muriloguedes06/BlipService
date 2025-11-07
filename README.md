# Lua blipservice library

## Introduction

This is a simple library to create animations making BlipsAttached easier to use and you can make edits without limitations, just be careful how you call it.

## Installation

Just download file `main_blips.lua` and put it in your project directory. it will work in any project that uses Lua.

* Note: This library he was created and tested on Lua 5.1

## Creating Meta File

```xml
<meta>
    <oop>true</oop>
    <info author='Murilo' version='1.0' description='BlipService System' />

    <script src='main_blips.lua' type='client' cache='false' />
</meta>
```

## Creating BlipService

Create a new blipservice using the method `create`, the method takes a table with the following properties: element, blipsize, icon. For example:

```lua
local Blip = Blips:create(element, size, icon)
```

## Instantiating

You can start it either outside **OnMarkerHit** or inside using the `create` method to instantiate it. For Example:

```lua
local vehicle = createVehicle(522, 2329.571, -1616.674, 5.726)
local Blip = Blips:create(vehicle, 20, 'assets/icons/vehicle.png')
```

## GetDistanceBlip

The simplest way to get the distance **Blip** value is this way, but you can do it in others and adapt it to your liking as this is a code to educate and teach beginners.

```lua
local x, y, z = getElementPosition(self.element)
local x2, y2, z2 = getElementPosition(localPlayer)
local sx, sy = getScreenFromWorldPosition(x, y, z+0.5, 0.08)

if sx and sy then
    dxDrawText(string.format('%.2f', getDistanceBetweenPoints3D(x2, y2, z2, x, y, z)), sx - 50, sy + 20, sx + 50, sy + 50, tocolor(255, 255, 255), 1, 'default-bold', 'center')
end
```

## Render Example

This is basically the way you should use the `BlipService`, putting it inside the Render it will create an infinite **loop**.

```lua
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
```

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/muriloguedes06/BlipService/blob/main/LICENSE) file for details
