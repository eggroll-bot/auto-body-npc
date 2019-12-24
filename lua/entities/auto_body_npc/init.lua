AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize( )
	self:SetModel( "models/eli.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetSolid( SOLID_BBOX )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor( )
	self:SetUseType( SIMPLE_USE )
end

function ENT:SpawnFunction( _, tr )
	local spawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "rockford_customs_npc" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function ENT:Use( ply )
	--
end
