AutoBodyNPC = { }
AutoBodyNPC.Config = { }

if SERVER then
	AddCSLuaFile( "auto_body_npc/sh_config.lua" )
	AddCSLuaFile( "auto_body_npc/cl_fonts.lua" )
	AddCSLuaFile( "auto_body_npc/cl_panels.lua" )
	include( "auto_body_npc/sh_config.lua" )
	include( "auto_body_npc/sv_data.lua" )
	include( "auto_body_npc/sv_hooks.lua" )
	include( "auto_body_npc/sv_panels.lua" )
	include( "auto_body_npc/sv_vehicles.lua" )

	if AutoBodyNPC.Config.UseWorkshop then
		resource.AddWorkshop( "2522663994" )
	else
		resource.AddFile( "resource/fonts/gratis.ttf" )
		resource.AddFile( "materials/auto_body_npc/garage.jpg" )
		resource.AddFile( "materials/auto_body_npc/logo.png" )
	end
elseif CLIENT then
	include( "auto_body_npc/sh_config.lua" )
	include( "auto_body_npc/cl_fonts.lua" )
	include( "auto_body_npc/cl_panels.lua" )
end
