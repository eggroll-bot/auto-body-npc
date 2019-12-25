hook.Add( "VC_CD_spawnedVehicle", "AutoBodyNPC_SpawnVehicle", function( ply, vehicle, test_drive ) -- We're going to interact as little as we can with VCMod because their API is terrible and most of the documentation sucks.
	if not test_drive then
		vehicle:SetNWEntity( "VCModOwner", ply )
		-- set bodygroups, color, skin, underglow, and engine upgrades, if any. For engine upgrades, set vehicle.EngineLevel to 0-4. 0 being stock, 1-4 being EMS upgrades.
		vehicle.EngineLevel = 0 -- Set it to 0 for now.
	end
end )

hook.Add( "CanProperty", "AutoBodyNPC_CanCustomizeProperties", function( ply, property, ent )
	if IsValid( ent:GetNWEntity( "VCModOwner" ) ) and ( property == "skin" or property == "bodygroups" ) then -- Vehicle is from VCMod.
		DarkRP.notify( ply, NOTIFY_ERROR, 4, "You need to customize the vehicle in the auto body shop." )

		return false
	end
end )
