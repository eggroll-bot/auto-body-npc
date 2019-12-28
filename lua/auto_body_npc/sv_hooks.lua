hook.Add( "VC_CD_spawnedVehicle", "AutoBodyNPC_SpawnVehicle", function( ply, vehicle, test_drive ) -- We're going to interact as little as we can with VCMod because their API is terrible and most of the documentation sucks.
	if not test_drive then
		vehicle:SetNWEntity( "VCModOwner", ply )
		-- set bodygroups, color, skin, underglow, and engine upgrades, if any. For engine upgrades, set the vehicle's NWInt "EngineLevel" to 0-4. 0 being stock, 1-4 being EMS upgrades. For underglow upgrades, set the vehicle's NWInt "UnderglowColor" to be the key for each color in the config file, if any, otherwise don't set it.
		vehicle:SetNWInt( "EngineLevel", 0 ) -- Set it to 0 for now.
	end
end )

hook.Add( "VC_CD_playerSoldVehicle", "AutoBodyNPC_SoldVehicle", function( ply, vcmod_id )
	-- remove all mods for that vehicle from file. if file empty, remove file.
end )

hook.Add( "CanProperty", "AutoBodyNPC_CanCustomizeProperties", function( ply, property, ent )
	if IsValid( ent:GetNWEntity( "VCModOwner" ) ) and ( property == "skin" or property == "bodygroups" ) then -- Vehicle is from VCMod.
		DarkRP.notify( ply, NOTIFY_ERROR, 4, "You need to customize the vehicle in the auto body shop." )

		return false
	end
end )

hook.Add( "CanTool", "AutoBodyNPC_DisableColorToolOnVehicles", function( ply, tr, tool )
	if tool == "colour" and tr.Entity:IsVehicle( ) then
		DarkRP.notify( ply, NOTIFY_ERROR, 4, "You need to customize the vehicle in the auto body shop." )

		return false
	end
end )
