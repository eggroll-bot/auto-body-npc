util.AddNetworkString( "AutoBodyNPC_UpdateVehicle" )

local function UpdateVehicle( _, ply )
	local npc = net.ReadEntity( )
	local vehicle = net.ReadEntity( )
	local to_change = net.ReadUInt( 3 ) -- 1 = respray, 2 = skin, 3 = bodygroup, 4 = engine, 5 = underglow

	if not isentity( npc ) or not isentity( vehicle ) or npc:GetClass( ) ~= "auto_body_npc" or not vehicle:IsVehicle( ) or vehicle:GetNWEntity( "VCModOwner" ) ~= ply then
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
		local config_custom_cars = AutoBodyNPC.Config.CustomCars[ vehicle:GetVehicleClass( ) ]
		local price = config_custom_cars and config_custom_cars.respray or AutoBodyNPC.Config.GlobalResprayPrice
		ply:addMoney( -price )
		vehicle:SetColor( color )
		vehicle:SaveRespray( color )
	elseif to_change == 2 then -- Skin
		local skin_index = net.ReadUInt( 8 )

		if skin_index > vehicle:SkinCount( ) - 1 then
			return
		end

		local config_custom_cars = AutoBodyNPC.Config.CustomCars[ vehicle:GetVehicleClass( ) ]
		local price = config_custom_cars and config_custom_cars.skin or AutoBodyNPC.Config.GlobalSkinPrice
		ply:addMoney( -price )
		vehicle:SetSkin( skin_index )
		vehicle:SaveSkin( skin_index )
	elseif to_change == 3 then -- Bodygroup
		local bodygroup_id = net.ReadUInt( 8 )
		local bodygroup_value = net.ReadUInt( 8 )

		if bodygroup_id > vehicle:GetNumBodyGroups( ) - 1 or bodygroup_value > vehicle:GetBodygroupCount( bodygroup_id ) - 1 then
			return
		end

		local bodygroup_name = vehicle:GetBodygroupName( bodygroup_id )
		local config_custom_cars = AutoBodyNPC.Config.CustomCars[ vehicle:GetVehicleClass( ) ]
		local price = config_custom_cars -- This conditional screwfest checks if the bodygroup's custom pricing exists.
						and config_custom_cars.bodygroup
						and config_custom_cars.bodygroup[ bodygroup_name ]
						and config_custom_cars.bodygroup[ bodygroup_name ][ bodygroup_value ]
						or AutoBodyNPC.Config.GlobalBodygroupPrice -- If not, then default to the global price.
		ply:addMoney( -price )
		vehicle:SetBodygroup( bodygroup_id, bodygroup_value )
		vehicle:SaveBodygroup( bodygroup_id, bodygroup_value )
	elseif to_change == 4 then -- Engine
		local engine_level = net.ReadUInt( 3 )

		if engine_level > 4 then
			return
		end

		if engine_level ~= 0 then
			local config_custom_cars = AutoBodyNPC.Config.CustomCars[ vehicle:GetVehicleClass( ) ]
			local engine_price_multiplier = config_custom_cars and config_custom_cars.engine or AutoBodyNPC.Config.GlobalEnginePrice
			local price = engine_price_multiplier * engine_level
			ply:addMoney( -price )
		end

		vehicle:SetEngineLevel( engine_level )
		vehicle:SaveEngineLevel( engine_level )
	elseif to_change == 5 then -- Underglow
		local underglow_id = net.ReadUInt( 7 )

		if underglow_id > #AutoBodyNPC.Config.GlobalUnderglowSettings then
			return
		end

		if underglow_id ~= 0 then
			local config_custom_cars = AutoBodyNPC.Config.CustomCars[ vehicle:GetVehicleClass( ) ]
			local underglow_table = AutoBodyNPC.Config.GlobalUnderglowSettings[ underglow_id ]
			local price = config_custom_cars
							and config_custom_cars.underglow
							and config_custom_cars.underglow[ underglow_table.name ]
							or underglow_table.price
			ply:addMoney( -price )
		end

		vehicle:SetUnderglowID( underglow_id )
		vehicle:SaveUnderglowID( underglow_id )
	end
end

net.Receive( "AutoBodyNPC_UpdateVehicle", UpdateVehicle )
