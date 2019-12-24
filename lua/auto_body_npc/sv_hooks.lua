hook.Add( "VC_CD_spawnedVehicle", "AutoBodyNPC_SetOwnerOnSpawnVehicle", function( ply, vehicle, test_drive ) -- We're going to interact as little as we can with VCMod because their API is terrible and most of the documentation sucks.
	if not test_drive then
		vehicle:SetNWEntity( "VCModOwner", ply )
	end
end )
