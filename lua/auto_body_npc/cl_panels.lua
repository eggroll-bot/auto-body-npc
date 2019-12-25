local PANEL = { }

function PANEL:Init( )
	self:SetFont( "Gratis" )
end

function PANEL:Paint( w, h )
	if self:IsHovered( ) then
		if not self.hoverlerp then
			self.hoverlerp = 0
		elseif self.hoverlerp < 1 then
			self.hoverlerp = self.hoverlerp + 0.0075
		end

		surface.SetDrawColor( Color( 25, 25, 25 ) )
		surface.DrawRect( 0, 0, Lerp( self.hoverlerp, 0, self:GetWide( ) ), h )
	elseif self.hoverlerp then
		self.hoverlerp = self.hoverlerp - 0.0075
		surface.SetDrawColor( Color( 25, 25, 25 ) )
		surface.DrawRect( 0, 0, Lerp( self.hoverlerp, 0, self:GetWide( ) ), h )

		if self.hoverlerp <= 0 then
			self.hoverlerp = nil
		end
	end
end

function PANEL:UpdateColours( )
end

vgui.Register( "AutoBodyNPCButton", PANEL, "DButton" )

PANEL = { }

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

function PANEL:CreateCloseButton( )
	self.CloseButton = vgui.Create( "AutoBodyNPCButton", self )
	self.CloseButton:SetText( "CLOSE" )
	self.CloseButton:SetTextColor( Color( 255, 255, 255 ) )
	self.CloseButton:Dock( BOTTOM )
	self.CloseButton:DockMargin( 0, 5, 0, 5 )

	self.CloseButton.DoClick = function( )
		self:Remove( )
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

function PANEL:AddButton( text, do_click ) -- Adds a button using Panel.AddContent and docks it to the scroll panel.
	local button = vgui.Create( "AutoBodyNPCButton" )
	button:SetText( text )
	button:SetTextColor( Color( 255, 255, 255 ) )
	button:SetTall( button:GetTall( ) + 10 )
	button:Dock( TOP )
	button:DockMargin( 0, 5, 0, 5 )
	button.DoClick = do_click
	self.ContentScrollPanel:AddItem( button )
	table.insert( self.Elements, button )
end

function PANEL:Reset( )
	self:SetTitle( "" )
	self.ContentScrollPanel:Clear( )
	self.Elements = { }
end

function PANEL:Init( )
	self:SetSize( ScrW( ) * 0.275, ScrH( ) * 0.85 )
	self:CenterHorizontal( 0.18 )
	self:CenterVertical( )
	self:MakePopup( )
	self.Elements = { }
	self:CreateCloseButton( )
	self:CreateTopBanner( )
	self:CreateTitleBar( )
	self:CreateContentScrollPanel( )
	self:SetTitle( "SELECT A CAR" )
end

function PANEL:Paint( w, h )
	surface.SetDrawColor( 20, 20, 20, 240 )
	surface.DrawRect( 0, 0, w, h )
end

function PANEL:GetCarTable( )
	return self.CarTable
end

function PANEL:SetCarTable( cars, populate_cars )
	self.CarTable = cars

	if populate_cars then
		for _, v in pairs( self.CarTable ) do
			local name = v:VC_getName( )
			self:AddButton( name, function( ) end )
		end
	end
end

vgui.Register( "AutoBodyNPCPanel", PANEL, "DPanel" )
