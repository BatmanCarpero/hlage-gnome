AddCSLuaFile()
include("shared.lua")

local GNOME_MAX_DIST = 35

function SWEP:PrimaryAttack()

    if CLIENT then return end

    local ply = self:GetOwner()

    local shootPos  = ply:GetShootPos()
    local aimVector = ply:GetAimVector()

    local trace = ply:GetEyeTrace()

    local placePos
    if shootPos:Distance(trace.HitPos) <= GNOME_MAX_DIST then
        placePos = trace.HitPos
    else
        placePos = shootPos + aimVector * GNOME_MAX_DIST
    end

    local ent = ents.Create("sent_gnome")
    ent:SetPos(placePos + Vector(0, 0, 0))
    ent:Spawn()
    ent:SetMood(self:GetMood())

    local dirToPlayer   = (ply:GetPos() - ent:GetPos()):GetNormalized()
    local angleToPlayer = dirToPlayer:Angle()
    ent:SetAngles(Angle(0, angleToPlayer.y, 0))

    self:Remove()

end

function SWEP:SecondaryAttack()
    if not IsValid(self:GetOwner()) then return end

    local ply = self:GetOwner()

    if CLIENT then return end

    local files = file.Find("sound/red-gnome/*.*", "GAME")
    if not files or #files == 0 then return end

    local choice = files[math.random(#files)]
    local soundPath = "red-gnome/" .. choice

    ply:EmitSound(soundPath)

    self:SetNextSecondaryFire(CurTime() + 0.5)
    self:SetNextPrimaryFire(CurTime() + 0.2)

end