local text = "hello"

local options = {
    fontSize = 99,
    vertical = false,
    textColor = {1, 1, 1, 1},
    bgColor = {0, 0, 0},
    fontName = 'Play-Bold',
}


--Do not change the following
local rslib = require('rslib')
local rx, ry = getResolution()
local vertical = options.vertical or false
if vertical then
    ry, rx = getResolution()
end
local textColor = options.textColor or {1, 1, 1, 1}
local bgColor = options.bgColor or {0, 0, 0}
local fontName = options.fontName or 'Play-Bold'
local fontSize = options.fontSize or 64
local lineSpacing = fontSize + 2
local wrapWidth = 0.9 * rx
-- compute line wrapping
local font = loadFont(fontName, fontSize)
local lines = rslib.getTextWrapped(font, text, wrapWidth)

-- rendering
setBackgroundColor(table.unpack(bgColor))
local y = (ry - lineSpacing * (#lines - 1)) / 2
local layer = createLayer()
if vertical then
    setLayerTranslation(layer, ry,0)
    setLayerRotation(layer, math.rad(90))
end
for i, line in ipairs(lines) do
    setNextFillColor(layer, table.unpack(textColor))
    setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
    addText(layer, font, line, rx/2, y)
    y = y + lineSpacing
end
