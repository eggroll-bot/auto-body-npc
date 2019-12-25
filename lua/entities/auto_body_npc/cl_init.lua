include( "shared.lua" )
surface.SetFont( "Gratis" )
local name_width = surface.GetTextSize( AutoBodyNPC.Config.Name )
local name = AutoBodyNPC.Config.Name

function ENT:Draw( )
	self:DrawModel( )
	local pos = self:GetPos( ) + self:GetForward( ) * 4
	local ang = self:GetAngles( )
	ang:RotateAroundAxis( ang:Up( ), 90 )
	ang:RotateAroundAxis( ang:Forward( ), 90 )
	cam.Start3D2D( pos, ang, 0.1 )
	surface.SetDrawColor( Color( 20, 20, 20, 225 ) )
	surface.DrawRect( -( name_width + 10 ) / 2, -755, name_width + 10, 30 )
	draw.SimpleText( name, "Gratis", 0, -740, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	cam.End3D2D( )
end

net.Receive( "AutoBodyNPC_OpenGUI", function( )
	local npc = net.ReadEntity( )
	local entities = ents.FindInSphere( npc:GetPos( ), AutoBodyNPC.Config.CarFindRadius )
	local cars = { }

	for _, v in pairs( entities ) do
		if v:IsVehicle( ) and v:GetNWEntity( "VCModOwner" ) == LocalPlayer( ) then
			table.insert( cars, v )
		end
	end

	local auto_body_npc_panel = vgui.Create( "AutoBodyNPCPanel" )
	auto_body_npc_panel:SetCarTable( cars )
	auto_body_npc_panel:PopulateCars( )
end )
