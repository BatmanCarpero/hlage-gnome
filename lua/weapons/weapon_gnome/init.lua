AddCSLuaFile()
include("shared.lua")

function SWEP:PrimaryAttack()

    if CLIENT then return end

    local ply = self:GetOwner()

    local trace = ply:GetEyeTrace()

    local ent = ents.Create("sent_gnome")

    ent:SetPos(trace.HitPos + Vector(0,0,20))

    ent:Spawn()

    self:Remove()

end