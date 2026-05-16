include("shared.lua")

net.Receive("GnomeChompskiKill", function()
    local gnome = net.ReadEntity()
    if IsValid(gnome) then
        surface.PlaySound("red-gnome/hahe.wav")
    end
end)

function ENT:Draw()

    self:DrawModel()

    local pos = self:GetPos() + Vector(0,0,25)
    local ang = LocalPlayer():EyeAngles()

    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)

    cam.Start3D2D(pos, Angle(0, ang.y, 90), 0.1)

        draw.SimpleText(
            "Mood: " .. self:GetMood(),
            "DermaLarge",
            0,
            0,
            color_white,
            TEXT_ALIGN_CENTER
        )

    cam.End3D2D()
end