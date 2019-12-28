hook.Add( "VC_CD_spawnedVehicle", "AutoBodyNPC_SpawnVehicle", function( ply, vehicle, test_drive ) -- We're going to interact as little as we can with VCMod because their API is terrible and most of the documentation sucks.
	if not test_drive then
		vehicle:SetNWEntity( "VCModOwner", ply )
		local file_name = "auto_body_npc/ply_data/" .. ply:SteamID64( ) .. ".txt"

		if not file.Exists( file_name, "DATA" ) then
			return
		end

		local vcmod_id = vehicle.VC_CD_ID
		local ply_vehicle_data = util.JSONToTable( file.Read( "auto_body_npc/ply_data/" .. ply:SteamID64( ) .. ".txt" ) )
		local vehicle_data = ply_vehicle_data[ vcmod_id ]

		if not vehicle_data then
			return
		end

		local color = vehicle_data.Color
		local skin = vehicle_data.Skin
		local bodygroups = vehicle_data.Bodygroups
		local engine_level = vehicle_data.EngineLevel
		local underglow_id = vehicle_data.UnderglowID

		if color then
			vehicle:SetColor( color )
		end

		if skin then
			vehicle:SetSkin( skin )
		end

		if bodygroups then
			for bodygroup_id, bodygroup_value in pairs( bodygroups ) do
				vehicle:SetBodygroup( bodygroup_id, bodygroup_value )
			end
		end

		if engine_level then
			vehicle:SetEngineLevel( engine_level )
		end

		if underglow_id then
			vehicle:SetUnderglowID( underglow_id )
		end
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
