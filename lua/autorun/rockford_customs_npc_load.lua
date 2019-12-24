RockfordCustomsNPC = { }
RockfordCustomsNPC.Config = { }

if SERVER then
	AddCSLuaFile( "rockford_customs_npc/cl_panels.lua" )
	AddCSLuaFile( "rockford_customs_npc/sh_config.lua" )
	include( "rockford_customs_npc/cl_panels.lua" )
	include( "rockford_customs_npc/sh_config.lua" )
elseif CLIENT then
	include( "rockford_customs_npc/cl_panels.lua" )
	include( "rockford_customs_npc/sh_config.lua" )
end
