AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize( )
	self:SetModel( "models/props_combine/breenglobe.mdl" ) -- Just a random model.
	self:SetColor( Color( 0, 0, 0, 0 ) )
	self:PhysicsInit( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NOCLIP )
	self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	self:SetRenderMode( RENDERMODE_GLOW )
end
