util.AddNetworkString( "AutoBodyNPC_UpdateVehicle" )

local function UpdateVehicle( _, ply )
	local npc = net.ReadEntity( )
	local vehicle = net.ReadEntity( )
	local to_change = net.ReadUInt( 3 ) -- 1 = respray, 2 = skin, 3 = bodygroup, 4 = engine, 5 = underglow

	if not IsValid( npc ) or not IsValid( vehicle ) then
		return
	end

	if ply:GetPos( ):DistToSqr( npc:GetPos( ) ) > 262144 or npc:GetPos( ):DistToSqr( vehicle:GetPos( ) ) > ( AutoBodyNPC.Config.CarFindRadius + 100 ) ^ 2 then -- Checks for a max ply -> npc distance of 512 (262144 = 512 ^ 2) and a max npc -> car distance of whatever is in the config file + 100.
		return
	end

	if to_change == 1 then -- Respray
		local color = {
			[ "a" ] = 255
		}

		color.r = net.ReadUInt( 8 ) -- 8-bit unsigned integers can only go from 0-255.
		color.g = net.ReadUInt( 8 )
		color.b = net.ReadUInt( 8 )
		-- take money.
		vehicle:SetColor( color )
		-- save color to data.
	elseif to_change == 2 then -- Skin
		local skin_index = net.ReadUInt( 8 )

		if skin_index > vehicle:SkinCount( ) - 1 then
			return
		end

		-- take money.
		vehicle:SetSkin( skin_index )
		-- save skin to data.
	elseif to_change == 3 then -- Bodygroup
		local bodygroup_id = net.ReadUInt( 8 )
		local bodygroup_value = net.ReadUInt( 8 )

		if bodygroup_id > vehicle:GetNumBodyGroups( ) - 1 or bodygroup_value > vehicle:GetBodygroupCount( bodygroup_id ) - 1 then
			return
		end

		-- take money.
		vehicle:SetBodygroup( bodygroup_id, bodygroup_value )
		-- save bodygroup to data.
	elseif to_change == 4 then -- Engine
		local engine_level = net.ReadUInt( 3 )

		if engine_level > 4 then
			return
		end

		-- take money.
		vehicle:SetNWInt( "EngineLevel", engine_level )
		-- apply engine modifications.
		-- save engine to data.
	elseif to_change == 5 then -- Underglow
		local underglow_id = net.ReadUInt( 7 )

		if underglow_id > #AutoBodyNPC.Config.GlobalUnderglowSettings then
			return
		end

		-- take money.
		vehicle:SetNWInt( "UnderglowColor", k )
		local color = AutoBodyNPC.Config.GlobalUnderglowSettings[ underglow_id ].color
		-- apply underglow color.
		-- save underglow to data.
	end
end

net.Receive( "AutoBodyNPC_UpdateVehicle", UpdateVehicle )
