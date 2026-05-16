AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

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
end

function ENT:Use(ply)

    if not IsValid(ply) then return end
    if not ply:IsPlayer() then return end

    -- Dar la SWEP otra vez
    ply:Give("weapon_gnome")

    ply:ChatPrint("Has recogido al gnomo.")

    self:Remove()
end