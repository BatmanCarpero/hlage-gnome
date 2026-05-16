AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("GnomeChompskiKill")

hook.Add("GetDeathNoticeEntityName", "GnomeChompskiDeathName", function(name)
    if name == "sent_gnome" then
        return "Gnome Chompski"
    end
end)

function ENT:Initialize()

    self:SetModel("models/props_junk/gnome.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if IsValid(phys) then
        phys:Wake()
    end

    self:SetUseType(SIMPLE_USE)

    self:SetMood(100)

    local gnome = self
    hook.Add("PlayerDeath", "GnomeChompskiKill_" .. tostring(self:EntIndex()), function(victim, inflictor, attacker)
        if not IsValid(gnome) then return end
        if inflictor == gnome or attacker == gnome then
            net.Start("GnomeChompskiKill")
            net.WriteEntity(gnome)
            net.Broadcast()
        end
    end)
end

function ENT:Use(ply)

    if not IsValid(ply) then return end
    if not ply:IsPlayer() then return end

    local mood = self:GetMood()

    ply:Give("weapon_gnome")

    local wep = ply:GetWeapon("weapon_gnome")
    if IsValid(wep) then
        wep:SetMood(mood)
    end

    ply:ChatPrint("Has recogido al gnomo.")

    hook.Remove("PlayerDeath", "GnomeChompskiKill_" .. tostring(self:EntIndex()))

    self:Remove()
end