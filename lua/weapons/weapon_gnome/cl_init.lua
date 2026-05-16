include("shared.lua")

-- Colores para interpolar según el mood (0 = rojo, 100 = verde)
local COLOR_LOW  = Color(220, 50,  50)
local COLOR_HIGH = Color(80,  200, 80)

local function LerpColor(t, a, b)
    return Color(
        Lerp(t, a.r, b.r),
        Lerp(t, a.g, b.g),
        Lerp(t, a.b, b.b),
        255
    )
end

function SWEP:DrawHUD()

    local mood = self:GetMood()
    local t    = math.Clamp(mood / 100, 0, 1)
    local col  = LerpColor(t, COLOR_LOW, COLOR_HIGH)

    local sw = ScrW()
    local sh = ScrH()

    -- Fondo semitransparente
    local barW = 220
    local barH = 44
    local bx   = (sw - barW) / 2
    local by   = sh - 90

    draw.RoundedBox(8, bx, by, barW, barH, Color(0, 0, 0, 140))

    -- Barra de progreso del mood
    local fillW = math.floor((barW - 8) * t)
    if fillW > 0 then
        draw.RoundedBox(6, bx + 4, by + 4, fillW, barH - 8, col)
    end

    -- Texto encima de la barra
    draw.SimpleText(
        "Mood: " .. mood,
        "DermaLarge",
        sw / 2,
        by + barH / 2,
        color_white,
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )

end