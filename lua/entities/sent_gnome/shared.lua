ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Gnome Chompski"
ENT.Author = "BatmanCarpero"

ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Mood")
end