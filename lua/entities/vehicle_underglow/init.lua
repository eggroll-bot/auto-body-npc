AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize( )
	self:PhysicsInit( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NOCLIP )
	self:SetSolid( SOLID_NONE )
	self:SetRenderMode( RENDERMODE_GLOW )
	self:SetColor( Color( 0, 0, 0, 0 ) )
end
