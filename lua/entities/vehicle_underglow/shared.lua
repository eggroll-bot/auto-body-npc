ENT.Type = "anim"
ENT.PrintName = "Underglow Light"
ENT.Author = "TheAsian EggrollMaker"
ENT.Contact = "theasianeggrollmaker@gmail.com"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables( )
	self:NetworkVar( "Int", 0, "Red" )
	self:NetworkVar( "Int", 1, "Green" )
	self:NetworkVar( "Int", 2, "Blue" )
end
