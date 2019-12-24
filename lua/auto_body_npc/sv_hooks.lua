hook.Add( "VC_CD_spawnedVehicle", "AutoBodyNPC_SpawnVehicle", function( ply, vehicle, test_drive ) -- We're going to interact as little as we can with VCMod because their API is terrible and most of the documentation sucks.
	if not test_drive then
		vehicle:SetNWEntity( "VCModOwner", ply )
		-- set bodygroups, color, skin, underglow, and engine upgrades, if any.
	end
end )

hook.Add( "CanProperty", "AutoBodyNPC_CanCustomizeProperties", function( _, property, ent )
	if IsValid( ent:GetNWEntity( "VCModOwner" ) ) and ( property == "skin" or property == "bodygroups" ) then -- Vehicle is from VCMod.
		return false
	end
end )
