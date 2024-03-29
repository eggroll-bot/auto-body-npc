AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )
util.AddNetworkString( "AutoBodyNPC_OpenGUI" )

function ENT:Initialize( )
	self:SetModel( AutoBodyNPC.Config.Model )
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
	local ent = ents.Create( "auto_body_npc" )
	ent:SetPos( spawnPos )
	ent:Spawn( )
	ent:Activate( )

	return ent
end

function ENT:Use( ply )
	net.Start( "AutoBodyNPC_OpenGUI" )
	net.WriteEntity( self )
	net.WriteBool( true ) -- Open
	net.Send( ply )
end

function ENT:OnRemove( )
	net.Start( "AutoBodyNPC_OpenGUI" )
	net.WriteEntity( self )
	net.WriteBool( false ) -- Close
	net.Broadcast( )
end
