local PANEL = { }

function PANEL:Init( )
	self:SetFont( "GratisSmall" )
	self:SetContentAlignment( 4 )
	self:SetTextInset( self:GetWide( ) * 0.25, 0 )
end

function PANEL:Paint( w, h )
	if self:IsHovered( ) then
		if not self.hoverlerp then
			self.hoverlerp = 0
		elseif self.hoverlerp < 1 then
			self.hoverlerp = self.hoverlerp + 0.02
		end

		surface.SetDrawColor( Color( 25, 25, 25 ) )
		surface.DrawRect( 0, 0, Lerp( self.hoverlerp, 0, self:GetWide( ) ), h )
	elseif self.hoverlerp then
		self.hoverlerp = self.hoverlerp - 0.02
		surface.SetDrawColor( Color( 25, 25, 25 ) )
		surface.DrawRect( 0, 0, Lerp( self.hoverlerp, 0, self:GetWide( ) ), h )

		if self.hoverlerp <= 0 then
			self.hoverlerp = nil
		end
	end
end

function PANEL:UpdateColours( )
end

function PANEL:AddRightAlignedText( text )
	self.RightAlignedText = vgui.Create( "DLabel", self )
	self.RightAlignedText:SetFont( "GratisSmall" )
	self.RightAlignedText:SetText( string.upper( text ) )
	self.RightAlignedText:SizeToContents( )
	self.RightAlignedText:Dock( RIGHT )
	self.RightAlignedText:DockMargin( 0, 0, self:GetWide( ) * 0.25, 0 )
end

vgui.Register( "AutoBodyNPCButton", PANEL, "DButton" )

PANEL = { }
local glow_material = Material( "sprites/light_ignorez" )

function PANEL:GetTitle( )
	return self.OriginalTitle
end

function PANEL:SetTitle( title )
	local exploded_title = string.Explode( " ", string.upper( title ), false )

	for k, v in pairs( exploded_title ) do
		if string.EndsWith( v, "I" ) then
			exploded_title[ k ] = v .. " " -- Add an extra space following an "I" because the spacing is near non-existant as is.
		end
	end

	self.OriginalTitle = string.upper( title )
	self.Title = table.concat( exploded_title, " " )
end

function PANEL:SetVehiclePreviewModel( model )
	local vehicle_modelpanel = self.VehiclePreview

	if model then
		vehicle_modelpanel:SetModel( model )
		local preview_ent = vehicle_modelpanel:GetEntity( )
		local min_bounds, max_bounds = preview_ent:GetRenderBounds( ) -- Re-set the cam position and cam angles.
		local size = math.abs( min_bounds.x ) + math.abs( max_bounds.x )
		size = math.max( size, math.abs( min_bounds.y ) + math.abs( max_bounds.y ) )
		size = math.max( size, math.abs( min_bounds.z ) + math.abs( max_bounds.z ) )
		vehicle_modelpanel:SetCamPos( Vector( size, size, size / 2 ) )
		vehicle_modelpanel:SetLookAt( ( min_bounds + max_bounds ) / 2 )
		local active_vehicle = self:GetActiveVehicle( )
		vehicle_modelpanel:SetColor( active_vehicle:GetColor( ) )
		preview_ent:SetSkin( active_vehicle:GetSkin( ) )

		for _, v in pairs( active_vehicle:GetBodyGroups( ) ) do
			local id = v.id
			local value = active_vehicle:GetBodygroup( id )
			preview_ent:SetBodygroup( id, value )
		end

		local underglow_id = self:GetActiveVehicle( ):GetNWInt( "UnderglowColor" )

		if underglow_id ~= 0 then
			local underglow_color = AutoBodyNPC.Config.GlobalUnderglowSettings[ underglow_id ].color

			vehicle_modelpanel.PreDrawModel = function( )
				render.SetMaterial( glow_material )
				render.DrawSprite( preview_ent:GetPos( ), 256, 256, underglow_color ) -- Can't use the vehicle_underglow entity within the DModelPanel, so this is our best option. Though, it doesn't look as good as the vehicle_underglow entity.

				return true -- Default functionality
			end
		else -- If the previous vehicle had an underglow, clear it up.
			vehicle_modelpanel.PreDrawModel = function( )
				return true -- Default functionality
			end
		end

		vehicle_modelpanel:Show( )
	else
		vehicle_modelpanel:Hide( )
	end
end

function PANEL:UpdateVehiclePreview( upgrade_type, upgrade_value )
	local vehicle_modelpanel = self.VehiclePreview
	local preview_ent = vehicle_modelpanel:GetEntity( )

	if upgrade_type == 1 then -- Respray -- Value: Color structure.
		vehicle_modelpanel:SetColor( upgrade_value ) -- Using preview_ent.SetColor doesn't work for some reason.
	elseif upgrade_type == 2 then -- Skin -- Value: Skin number.
		preview_ent:SetSkin( upgrade_value )
	elseif upgrade_type == 3 then -- Bodygroup -- Value: { bodygroup_id, bodygroup_value }.
		preview_ent:SetBodygroup( upgrade_value[ 1 ], upgrade_value[ 2 ] )
	elseif upgrade_type == 4 then -- Underglow -- Value: 0 = No underglow color, otherwise color structure provided.
		if upgrade_value == 0 then
			vehicle_modelpanel.PreDrawModel = function( )
				return true -- Default functionality
			end
		else
			vehicle_modelpanel.PreDrawModel = function( )
				render.SetMaterial( glow_material )
				render.DrawSprite( preview_ent:GetPos( ), 256, 256, upgrade_value ) -- Make it have a glowing sprite.

				return true -- Default functionality
			end
		end
	end
end

function PANEL:CreateBackground( )
	self.Background = vgui.Create( "DImage" )
	self.Background:SetImage( "auto_body_npc/garage.jpg" )
	self.Background:SetSize( ScrW( ), ScrH( ) )
	self.Background:SetKeepAspect( true )
end

function PANEL:CreateCloseButton( )
	self.CloseButton = vgui.Create( "AutoBodyNPCButton", self )
	self.CloseButton:SetFont( "Gratis" )
	self.CloseButton:SetText( "CLOSE" )
	self.CloseButton:SetTextColor( Color( 255, 255, 255 ) )
	self.CloseButton:Dock( BOTTOM )
	self.CloseButton:DockMargin( 0, 5, 0, 0 )
	self.CloseButton:SetTall( self.CloseButton:GetTall( ) + 10 )
	self.CloseButton:SetContentAlignment( 5 )

	self.CloseButton.DoClick = function( )
		self.Background:Remove( )
		self.VehiclePreview:Remove( )
		self:Remove( )
		hook.Remove( "EntityRemoved", "AutoBodyNPC_VehicleRemoved" )
	end
end

function PANEL:CreateTopBanner( )
	self.Banner = vgui.Create( "DImage", self )
	self.Banner:SetImage( "auto_body_npc/logo.png" )
	self.Banner:SetTall( 0.175 * self:GetTall( ) )
	self.Banner:Dock( TOP )
	self.Banner:SetKeepAspect( true )
	self.Banner:SetImageColor( Color( 225, 225, 225 ) ) -- Make it a little easier on the eyes.
end

function PANEL:CreateTitleBar( )
	self.TitleBar = vgui.Create( "DPanel", self )
	self.TitleBar:SetTall( 0.06 * self:GetTall( ) )
	self.TitleBar:Dock( TOP )
	self:SetTitle( "" )

	self.TitleBar.Paint = function( _, w, h )
		surface.SetDrawColor( Color( 40, 40, 40, 190 ) )
		surface.DrawRect( 0, 0, w, h )
		draw.SimpleText( self.Title, "Gratis", w / 2, h / 2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
end

function PANEL:CreateContentScrollPanel( )
	self.ContentScrollPanel = vgui.Create( "DScrollPanel", self )
	self.ContentScrollPanel:Dock( FILL )
	self.ContentScrollPanel:GetVBar( ):SetSize( self:GetWide( ) * 0.01, 0 )
	self.ContentScrollPanel:GetVBar( ):SetHideButtons( true )
	self.ContentScrollPanel:GetVBar( ).Paint = function( ) end

	self.ContentScrollPanel:GetVBar( ).btnGrip.Paint = function( _, w, h )
		surface.SetDrawColor( Color( 50, 50, 50 ) )
		surface.DrawRect( 0, 0, w, h )
	end
end

function PANEL:CreateVehiclePreview( )
	self.VehiclePreview = vgui.Create( "DModelPanel" )
	self.VehiclePreview:SetPos( ScrW( ) * 0.322, ScrH( ) * 0.3 )
	self.VehiclePreview:SetSize( ScrW( ) * 0.5, ScrH( ) * 0.75 )
	self.VehiclePreview:SetModel( "models/props_borealis/bluebarrel001.mdl" ) -- Temporary model. Just so it doesn't complain.
	self.VehiclePreview:SetFOV( 45 )
	self.VehiclePreview:SetCursor( "arrow" )
	self.VehiclePreview.LayoutEntity = function( ) end
	self.VehiclePreview:Hide( )
end

function PANEL:AddButton( text, do_click, bottom_spacing, right_aligned_text, large ) -- Adds a button using Panel.AddContent and docks it to the scroll panel.
	local button = vgui.Create( "AutoBodyNPCButton" )

	if large then
		button:SetFont( "Gratis" )
	end

	button:SetText( string.upper( text ) )

	if large then
		button:SetTextColor( Color( 255, 255, 255 ) )
	else
		button:SetTextColor( Color( 215, 215, 215 ) )
	end

	button:SetTall( button:GetTall( ) + 10 )
	button:Dock( TOP )
	button:DockMargin( 0, 5, 0, bottom_spacing or 5 )
	button.DoClick = do_click
	self.ContentScrollPanel:AddItem( button )

	if isstring( right_aligned_text ) and right_aligned_text ~= "" then
		button:AddRightAlignedText( right_aligned_text )

		if large then
			button.RightAlignedText:SetFont( "Gratis" )
			button.RightAlignedText:SetTextColor( Color( 255, 255, 255 ) )
		else
			button.RightAlignedText:SetTextColor( Color( 215, 215, 215 ) )
		end
	end

	table.insert( self.Elements, button )
end

function PANEL:Reset( )
	self.ContentScrollPanel:Clear( )
	self.Elements = { }
end

function PANEL:GetBodygroupPrettyName( class )
	local name

	if AutoBodyNPC.Config.BodygroupNames[ class ] then
		name = string.upper( AutoBodyNPC.Config.BodygroupNames[ class ] )
	else
		name = string.upper( string.Replace( class, "_", " " ) )
	end

	return name
end

function PANEL:Init( )
	self:SetSize( ScrW( ) * 0.24, ScrH( ) * 0.85 )
	self:CenterHorizontal( 0.135 )
	self:CenterVertical( )
	self:MakePopup( )
	self.Elements = { }
	self:CreateBackground( )
	self:CreateCloseButton( )
	self:CreateTopBanner( )
	self:CreateTitleBar( )
	self:CreateContentScrollPanel( )
	self:CreateVehiclePreview( )
end

function PANEL:Paint( w, h )
	surface.SetDrawColor( 20, 20, 20, 240 )
	surface.DrawRect( 0, 0, w, h )
end

function PANEL:CreateResprayPanel( equipped )
	self:Reset( )

	self:AddButton( "RESPRAY", function( )
		self:CreateModificationPanel( )
	end, 15, "<", true )

	local color_selector = vgui.Create( "DColorMixer" )
	color_selector:SetTall( 0.3 * self:GetTall( ) )
	color_selector:Dock( TOP )
	color_selector:DockMargin( 10, 5, 10, 15 )
	color_selector:SetPalette( false )
	color_selector:SetAlphaBar( false )
	color_selector:SetColor( equipped )
	self.ContentScrollPanel:AddItem( color_selector )
	table.insert( self.Elements, color_selector )
	local config_custom_cars = AutoBodyNPC.Config.CustomCars[ self:GetActiveVehicle( ):GetVehicleClass( ) ]
	local price = DarkRP.formatMoney( config_custom_cars and config_custom_cars.respray or AutoBodyNPC.Config.GlobalResprayPrice )

	self:AddButton( "Purchase - " .. price, function( btn )
		local new_color = color_selector:GetColor( )

		if new_color ~= equipped then
			net.Start( "AutoBodyNPC_UpdateVehicle" )
			net.WriteEntity( self:GetNPC( ) )
			net.WriteEntity( self:GetActiveVehicle( ) )
			net.WriteUInt( 1, 3 ) -- 1 = Respray.
			net.WriteUInt( new_color.r, 8 )
			net.WriteUInt( new_color.g, 8 )
			net.WriteUInt( new_color.b, 8 )
			net.SendToServer( )
			self:UpdateVehiclePreview( 1, new_color ) -- 1 = Respray
			local current_hoverlerp = btn.hoverlerp
			self:CreateResprayPanel( new_color )
			self.Elements[ 3 ].hoverlerp = current_hoverlerp -- Sets hoverlerp of the purchase button back to the original hoverlerp value.
			notification.AddLegacy( "You purchased a respray for " .. price .. ".", NOTIFY_GENERIC, 2 )
		else
			notification.AddLegacy( "You need to modify the color before respraying.", NOTIFY_ERROR, 2 )
		end
	end, 0, "", true )

	self.Elements[ 3 ]:SetContentAlignment( 5 ) -- self.Elements[ 3 ] is the purchase button.
end

function PANEL:CreateSkinsPanel( equipped ) -- Desync the equipped from the server.
	self:Reset( )

	self:AddButton( "SKINS", function( )
		self:CreateModificationPanel( )
	end, 15, "<", true )

	local config_custom_cars = AutoBodyNPC.Config.CustomCars[ self:GetActiveVehicle( ):GetVehicleClass( ) ]
	local price = DarkRP.formatMoney( config_custom_cars and config_custom_cars.skin or AutoBodyNPC.Config.GlobalSkinPrice )

	for i = 0, self:GetActiveVehicle( ):SkinCount( ) - 1 do
		if i == equipped then
			self:AddButton( "SKIN " .. i + 1, function( ) end, 5, "EQUIPPED" )
		else
			self:AddButton( "SKIN " .. i + 1, function( btn )
				net.Start( "AutoBodyNPC_UpdateVehicle" )
				net.WriteEntity( self:GetNPC( ) )
				net.WriteEntity( self:GetActiveVehicle( ) )
				net.WriteUInt( 2, 3 ) -- 2 = Skin.
				net.WriteUInt( i, 8 )
				net.SendToServer( )
				self:UpdateVehiclePreview( 2, i ) -- 2 = Skin
				local current_hoverlerp = btn.hoverlerp
				self:CreateSkinsPanel( i )
				self.Elements[ i + 2 ].hoverlerp = current_hoverlerp
				notification.AddLegacy( "You purchased a skin change for " .. price .. ".", NOTIFY_GENERIC, 2 )
			end, 5, price )
		end
	end
end

function PANEL:CreateBodygroupPanel( bodygroup_id, name, pretty_name, num_options, equipped )
	self:Reset( )

	self:AddButton( pretty_name, function( )
		self:CreateBodygroupsPanel( )
	end, 15, "<", true )

	local config_custom_cars = AutoBodyNPC.Config.CustomCars[ self:GetActiveVehicle( ):GetVehicleClass( ) ]
	local should_check_custom_bodygroup_price = config_custom_cars and config_custom_cars.bodygroup
	local price = DarkRP.formatMoney( AutoBodyNPC.Config.GlobalBodygroupPrice )

	for i = 0, num_options - 1 do
		if i == equipped then
			self:AddButton( "OPTION " .. i + 1, function( ) end, 5, "EQUIPPED" )
		else
			local current_price

			if should_check_custom_bodygroup_price then
				current_price = config_custom_cars.bodygroup[ name ] and config_custom_cars.bodygroup[ name ][ i ]
				current_price = current_price and DarkRP.formatMoney( current_price )
			end

			current_price = current_price or price

			self:AddButton( "OPTION " .. i + 1, function( btn )
				net.Start( "AutoBodyNPC_UpdateVehicle" )
				net.WriteEntity( self:GetNPC( ) )
				net.WriteEntity( self:GetActiveVehicle( ) )
				net.WriteUInt( 3, 3 ) -- 3 = Bodygroup.
				net.WriteUInt( bodygroup_id, 8 )
				net.WriteUInt( i, 8 )
				net.SendToServer( )
				self:UpdateVehiclePreview( 3, { bodygroup_id, i } ) -- 3 = Bodygroup
				local current_hoverlerp = btn.hoverlerp
				self:CreateBodygroupPanel( bodygroup_id, name, pretty_name, num_options, i )
				self.Elements[ i + 2 ].hoverlerp = current_hoverlerp
				notification.AddLegacy( "You purchased a bodygroup change for " .. price .. ".", NOTIFY_GENERIC, 2 )
			end, 5, current_price )
		end
	end
end

function PANEL:CreateBodygroupsPanel( )
	self:Reset( )

	self:AddButton( "BODYGROUPS", function( )
		self:CreateModificationPanel( )
	end, 15, "<", true )

	local bodygroups = self:GetActiveVehicle( ):GetBodyGroups( )

	for _, v in pairs( bodygroups ) do
		if v.num <= 1 then -- Apparently bodygroups with only one option exist.
			continue
		end

		local pretty_bodygroup_name = self:GetBodygroupPrettyName( v.name )
		local active_bodygroup = self:GetActiveVehicle( ):GetBodygroup( v.id )

		self:AddButton( pretty_bodygroup_name, function( )
			self:CreateBodygroupPanel( v.id, v.name, pretty_bodygroup_name, v.num, active_bodygroup )
		end )
	end
end

function PANEL:CreateEnginePanel( equipped )
	self:Reset( )

	self:AddButton( "ENGINE", function( )
		self:CreateModificationPanel( )
	end, 15, "<", true )

	if equipped == 0 then
		self:AddButton( "STOCK ENGINE", function( ) end, 5, "EQUIPPED" )
	else
		self:AddButton( "STOCK ENGINE", function( btn )
			net.Start( "AutoBodyNPC_UpdateVehicle" )
			net.WriteEntity( self:GetNPC( ) )
			net.WriteEntity( self:GetActiveVehicle( ) )
			net.WriteUInt( 4, 3 ) -- 4 = Engine.
			net.WriteUInt( 0, 3 )
			net.SendToServer( )
			local current_hoverlerp = btn.hoverlerp
			self:CreateEnginePanel( 0 )
			self.Elements[ 2 ].hoverlerp = current_hoverlerp
			notification.AddLegacy( "You reverted back to the stock engine.", NOTIFY_GENERIC, 2 )
		end, 5, DarkRP.formatMoney( 0 ) )
	end

	for i = 1, 4 do
		if i == equipped then
			self:AddButton( "EMS UPGRADE LEVEL " .. i, function( ) end, 5, "EQUIPPED" )
		else
			local config_custom_cars = AutoBodyNPC.Config.CustomCars[ self:GetActiveVehicle( ):GetVehicleClass( ) ]
			local engine_price_multiplier = config_custom_cars and config_custom_cars.engine or AutoBodyNPC.Config.GlobalEnginePrice
			local price = DarkRP.formatMoney( engine_price_multiplier * i )

			self:AddButton( "EMS UPGRADE LEVEL " .. i, function( btn )
				net.Start( "AutoBodyNPC_UpdateVehicle" )
				net.WriteEntity( self:GetNPC( ) )
				net.WriteEntity( self:GetActiveVehicle( ) )
				net.WriteUInt( 4, 3 ) -- 4 = Engine.
				net.WriteUInt( i, 3 )
				net.SendToServer( )
				local current_hoverlerp = btn.hoverlerp
				self:CreateEnginePanel( i )
				self.Elements[ i + 2 ].hoverlerp = current_hoverlerp
				notification.AddLegacy( "You purchased an engine upgrade for " .. price .. ".", NOTIFY_GENERIC, 2 )
			end, 5, price )
		end
	end
end

function PANEL:CreateUnderglowPanel( equipped )
	self:Reset( )

	self:AddButton( "UNDERGLOW", function( )
		self:CreateModificationPanel( )
	end, 15, "<", true )

	if equipped == 0 then
		self:AddButton( "NO UNDERGLOW", function( ) end, 5, "EQUIPPED" )
	else
		self:AddButton( "NO UNDERGLOW", function( btn )
			net.Start( "AutoBodyNPC_UpdateVehicle" )
			net.WriteEntity( self:GetNPC( ) )
			net.WriteEntity( self:GetActiveVehicle( ) )
			net.WriteUInt( 5, 3 ) -- 5 = Underglow.
			net.WriteUInt( 0, 7 ) -- 0 = No underglow color
			net.SendToServer( )
			self:UpdateVehiclePreview( 4, 0 ) -- 4 = Underglow, 0 = No underglow color
			local current_hoverlerp = btn.hoverlerp
			self:CreateUnderglowPanel( 0 )
			self.Elements[ 2 ].hoverlerp = current_hoverlerp
			notification.AddLegacy( "You reverted back to having no underglow.", NOTIFY_GENERIC, 2 )
		end, 5, DarkRP.formatMoney( 0 ) )
	end

	for k, v in pairs( AutoBodyNPC.Config.GlobalUnderglowSettings ) do
		if k == equipped then
			self:AddButton( v.name, function( ) end, 5, "EQUIPPED" )
		else
			local config_custom_cars = AutoBodyNPC.Config.CustomCars[ self:GetActiveVehicle( ):GetVehicleClass( ) ]
			local price = config_custom_cars and config_custom_cars.underglow and config_custom_cars.underglow[ v.name ] or v.price
			price = DarkRP.formatMoney( price )

			self:AddButton( v.name, function( btn )
				net.Start( "AutoBodyNPC_UpdateVehicle" )
				net.WriteEntity( self:GetNPC( ) )
				net.WriteEntity( self:GetActiveVehicle( ) )
				net.WriteUInt( 5, 3 ) -- 5 = Underglow.
				net.WriteUInt( k, 7 )
				net.SendToServer( )
				self:UpdateVehiclePreview( 4, v.color ) -- 4 = Underglow
				local current_hoverlerp = btn.hoverlerp
				self:CreateUnderglowPanel( k )
				self.Elements[ k + 2 ].hoverlerp = current_hoverlerp
				notification.AddLegacy( "You purchased an underglow upgrade for " .. price .. ".", NOTIFY_GENERIC, 2 )
			end, 5, price )
		end
	end
end

function PANEL:CreateModificationPanel( name )
	self:Reset( )

	if name then
		self:SetTitle( name )
	end

	self:AddButton( "MODIFICATIONS", function( )
		self:PopulateCars( )
	end, 15, "<", true )

	self:AddButton( "RESPRAY", function( )
		self:CreateResprayPanel( self:GetActiveVehicle( ):GetColor( ) )
	end )

	self:AddButton( "SKINS", function( )
		self:CreateSkinsPanel( self:GetActiveVehicle( ):GetSkin( ) )
	end )

	self:AddButton( "BODYGROUPS", function( )
		self:CreateBodygroupsPanel( )
	end )

	self:AddButton( "ENGINE", function( )
		self:CreateEnginePanel( self:GetActiveVehicle( ):GetNWInt( "EngineLevel" ) )
	end )

	self:AddButton( "UNDERGLOW", function( )
		self:CreateUnderglowPanel( self:GetActiveVehicle( ):GetNWInt( "UnderglowColor" ) )
	end )
end

function PANEL:PopulateCars( )
	self:Reset( )
	self:SetActiveVehicle( nil )
	hook.Remove( "EntityRemoved", "AutoBodyNPC_VehicleRemoved" )
	self:SetTitle( "SELECT A CAR" )

	local entities = ents.FindInSphere( self:GetNPC( ):GetPos( ), AutoBodyNPC.Config.CarFindRadius )

	for _, v in pairs( entities ) do
		if not v:IsVehicle( ) or v:GetNWEntity( "VCModOwner" ) ~= LocalPlayer( ) then
			continue
		end

		local name = v:VC_getName( )

		self:AddButton( name, function( )
			self:SetActiveVehicle( v )
			self:CreateModificationPanel( name )

			hook.Add( "EntityRemoved", "AutoBodyNPC_VehicleRemoved", function( ent )
				if ent == self:GetActiveVehicle( ) then
					timer.Simple( 0, function( ) -- Wait a frame for it to be removed.
						self:PopulateCars( )
						hook.Remove( "EntityRemoved", "AutoBodyNPC_VehicleRemoved" )
					end )
				end
			end )
		end, 5, "", true )
	end
end

function PANEL:GetNPC( )
	return self.NPC
end

function PANEL:SetNPC( npc )
	self.NPC = npc
end

function PANEL:GetActiveVehicle( )
	return self.ActiveVehicle
end

function PANEL:SetActiveVehicle( vehicle )
	self.ActiveVehicle = vehicle
	self:SetVehiclePreviewModel( vehicle and vehicle:GetModel( ) ) -- Argument will be nil if vehicle is nil.
end

vgui.Register( "AutoBodyNPCPanel", PANEL, "DPanel" )
