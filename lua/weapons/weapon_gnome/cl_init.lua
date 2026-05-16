include("shared.lua")

surface.CreateFont("GnomeMoodFont", {
    font      = "Trebuchet MS",
    size      = 24,
    weight    = 900,
    antialias = false,
    shadow    = false,
})

local HL_R, HL_G, HL_B = 255, 160, 0

local COL_BG_R,  COL_BG_G,  COL_BG_B,  COL_BG_A  = 0, 0, 0, 200
local COL_BOR_R, COL_BOR_G, COL_BOR_B, COL_BOR_A = 80, 50, 0, 230

local NUM_CUBES = 20
local CUBE_W    = 11
local CUBE_H    = 18
local CUBE_GAP  = 3
local PAD       = 6
local LABEL_W   = 52

local function DrawMoodHUD(mood)

    local t  = math.Clamp(mood / 100, 0, 1)
    local sw = ScrW()
    local sh = ScrH()

    local cubesW = NUM_CUBES * (CUBE_W + CUBE_GAP) - CUBE_GAP
    local panelW = PAD + LABEL_W + PAD + cubesW + PAD
    local panelH = PAD * 2 + CUBE_H

    local panelX = 36
    local panelY = sh - 120 - panelH - 8

    surface.SetDrawColor(COL_BG_R, COL_BG_G, COL_BG_B, COL_BG_A)
    surface.DrawRect(panelX, panelY, panelW, panelH)

    surface.SetDrawColor(COL_BOR_R, COL_BOR_G, COL_BOR_B, COL_BOR_A)
    surface.DrawOutlinedRect(panelX, panelY, panelW, panelH, 1)

    surface.SetDrawColor(0, 0, 0, 120)
    surface.DrawRect(panelX + 1, panelY + 1, panelW - 2, 2)

    surface.SetFont("GnomeMoodFont")
    local _, fh = surface.GetTextSize("MOOD")
    local lx = panelX + PAD
    local ly = panelY + math.floor((panelH - fh) / 2)

    surface.SetTextColor(HL_R, HL_G, HL_B, 255)
    surface.SetTextPos(lx, ly)
    surface.DrawText("MOOD")

    local sepX = panelX + PAD + LABEL_W
    surface.SetDrawColor(COL_BOR_R, COL_BOR_G, COL_BOR_B, 180)
    surface.DrawRect(sepX, panelY + 3, 1, panelH - 6)

    local cubesX = sepX + PAD
    local cubesY = panelY + PAD

    local filledF = t * NUM_CUBES
    local floorF  = math.floor(filledF)

    for i = 1, NUM_CUBES do
        local cx = cubesX + (i - 1) * (CUBE_W + CUBE_GAP)

        local alpha
        if i <= floorF then
            alpha = 255
        elseif i == floorF + 1 then
            local frac = filledF - floorF
            alpha = math.max(28, math.floor(frac * 255))
        else
            local dist = i - (floorF + 1)
            alpha = math.max(8, 45 - dist * 6)
        end

        surface.SetDrawColor(HL_R, HL_G, HL_B, alpha)
        surface.DrawRect(cx, cubesY, CUBE_W, CUBE_H)

        if alpha > 40 then
            local shade = math.floor(alpha * 0.35)
            surface.SetDrawColor(255, 220, 80, shade)
            surface.DrawRect(cx, cubesY, CUBE_W, 3)

            surface.SetDrawColor(255, 200, 60, math.floor(shade * 0.6))
            surface.DrawRect(cx, cubesY, 1, CUBE_H)

            surface.SetDrawColor(80, 40, 0, math.floor(alpha * 0.5))
            surface.DrawRect(cx, cubesY + CUBE_H - 2, CUBE_W, 2)
        end

        surface.SetDrawColor(HL_R, HL_G, HL_B, math.min(alpha + 20, 255))
        surface.DrawOutlinedRect(cx, cubesY, CUBE_W, CUBE_H, 1)
    end
end

function SWEP:DrawHUD()
    DrawMoodHUD(self:GetMood())
end