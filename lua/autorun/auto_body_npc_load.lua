AutoBodyNPC = { }
AutoBodyNPC.Config = { }

if SERVER then
	AddCSLuaFile( "auto_body_npc/cl_panels.lua" )
	AddCSLuaFile( "auto_body_npc/sh_config.lua" )
	include( "auto_body_npc/cl_panels.lua" )
	include( "auto_body_npc/sh_config.lua" )
	resource.AddFile( "resource/fonts/roboto_medium.ttf" )
elseif CLIENT then
	include( "auto_body_npc/cl_panels.lua" )
	include( "auto_body_npc/sh_config.lua" )
end
