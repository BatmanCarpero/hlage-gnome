AddCSLuaFile()
include("shared.lua")

local GNOME_MAX_DIST = 50

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

    -- Hacer que el gnomo mire hacia el jugador
    local dirToPlayer = (ply:GetPos() - ent:GetPos()):Normalize()
    local angleToPlayer = dirToPlayer:Angle()
    ent:SetAngles(angleToPlayer)

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