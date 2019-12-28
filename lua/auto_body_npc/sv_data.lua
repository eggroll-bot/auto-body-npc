local vehicle_meta = FindMetaTable( "Vehicle" )

if not file.Exists( "auto_body_npc/ply_data", "DATA" ) then
	file.CreateDir( "auto_body_npc/ply_data" )
end

--[[

Data file structure (curly braces means insert whatever's inside the braces):

Name: {Steam ID 64}.txt

Structure: JSON resulting from a table structure of the following:

{
	[ "{VCMod Vehicle ID}" ] = {
		[ "Color" ] = {Color table structure},
		[ "Skin" ] = {Skin ID},

		[ "Bodygroups" ] = {
			[ "{Bodygroup ID 1}" ] = {Bodygroup Value 1},
			[ "{Bodygroup ID 2}" ] = {Bodygroup Value 2}
		},

		[ "EngineLevel" ] = {Engine level (1-4) (Remove key if 0)},
		[ "UnderglowID" ] = {Underglow ID}
	}
}

]]

function vehicle_meta:SaveRespray( color )
	local ply = self:GetNWEntity( "VCModOwner" )
	local vcmod_id = vehicle.VC_CD_ID -- FFS, freemmaann. At least make your API work properly, so I don't have to do this.

	if not IsValid( ply ) or not vcmod_id then
		return
	end
end

function vehicle_meta:SaveSkin( skin )
	local ply = self:GetNWEntity( "VCModOwner" )
	local vcmod_id = vehicle.VC_CD_ID -- FFS, freemmaann. At least make your API work properly, so I don't have to do this.

	if not IsValid( ply ) or not vcmod_id then
		return
	end
end

function vehicle_meta:SaveBodygroup( bodygroup_id, bodygroup_value )
	local ply = self:GetNWEntity( "VCModOwner" )
	local vcmod_id = vehicle.VC_CD_ID -- FFS, freemmaann. At least make your API work properly, so I don't have to do this.

	if not IsValid( ply ) or not vcmod_id then
		return
	end
end

function vehicle_meta:SaveEngineLevel( engine_level )
	local ply = self:GetNWEntity( "VCModOwner" )
	local vcmod_id = vehicle.VC_CD_ID -- FFS, freemmaann. At least make your API work properly, so I don't have to do this.

	if not IsValid( ply ) or not vcmod_id then
		return
	end
end

function vehicle_meta:SaveUnderglowID( underglow_id )
	local ply = self:GetNWEntity( "VCModOwner" )
	local vcmod_id = vehicle.VC_CD_ID -- FFS, freemmaann. At least make your API work properly, so I don't have to do this.

	if not IsValid( ply ) or not vcmod_id then
		return
	end
end
