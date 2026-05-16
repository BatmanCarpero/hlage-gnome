SWEP.PrintName = "Chompski"
SWEP.Author = "BatmanCarpero"

SWEP.Instructions = "Give me foo berries!"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = "models/props_junk/gnome.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary = SWEP.Primary

function SWEP:SetupDataTables()
    self:NetworkVar("Int", 0, "Mood")
end