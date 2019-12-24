hook.Add( "CanProperty", "AutoBodyNPC_CanCustomizeProperties", function( _, property, ent )
	if IsValid( ent:GetNWEntity( "VCModOwner" ) ) and ( property == "skin" or property == "bodygroups" ) then -- Vehicle is from VCMod.
		notification.AddLegacy( "You must use the auto body shop to customize your vehicle.", NOTIFY_ERROR, 3 )

		return false
	end
end )
