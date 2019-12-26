AutoBodyNPC = { }
AutoBodyNPC.Config = { }

if SERVER then
	AddCSLuaFile( "auto_body_npc/cl_fonts.lua" )
	AddCSLuaFile( "auto_body_npc/cl_panels.lua" )
	AddCSLuaFile( "auto_body_npc/sh_config.lua" )
	include( "auto_body_npc/sh_config.lua" )
	include( "auto_body_npc/sv_hooks.lua" )
	resource.AddFile( "resource/fonts/gratis.ttf" )
	resource.AddFile( "materials/auto_body_npc/garage.png" )
	resource.AddFile( "materials/auto_body_npc/logo.png" )
elseif CLIENT then
	include( "auto_body_npc/cl_fonts.lua" )
	include( "auto_body_npc/cl_panels.lua" )
	include( "auto_body_npc/sh_config.lua" )
end
