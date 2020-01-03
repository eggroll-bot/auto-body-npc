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

function ENT:Think( )
	local pnl = self.AutoBodyPanel

	if IsValid( pnl ) and pnl:GetActiveVehicle( ) and self:GetPos( ):DistToSqr( pnl:GetActiveVehicle( ):GetPos( ) ) > ( AutoBodyNPC.Config.CarFindRadius + 100 ) ^ 2 then -- Checks for a max ply -> npc distance of 512 (262144 = 512 ^ 2) and a max npc -> car distance of whatever is in the config file + 100.
		pnl:PopulateCars( )
	end

	if IsValid( pnl ) and LocalPlayer( ):GetPos( ):DistToSqr( self:GetPos( ) ) > 262144 then
		pnl.Background:Remove( )
		pnl.VehiclePreview:Remove( )
		pnl:Remove( )
		self.AutoBodyPanel = nil
		hook.Remove( "EntityRemoved", "AutoBodyNPC_VehicleRemoved" )
	end

	self:SetNextClientThink( CurTime( ) + 0.25 )
end

net.Receive( "AutoBodyNPC_OpenGUI", function( )
	local npc = net.ReadEntity( )
	local to_open = net.ReadBool( )

	if to_open then
		npc.AutoBodyPanel = vgui.Create( "AutoBodyNPCPanel" )
		npc.AutoBodyPanel:SetNPC( npc )
		npc.AutoBodyPanel:PopulateCars( )
	else
		if IsValid( npc.AutoBodyPanel ) then
			npc.AutoBodyPanel.Background:Remove( )
			npc.AutoBodyPanel.VehiclePreview:Remove( )
			npc.AutoBodyPanel:Remove( )
			npc.AutoBodyPanel = nil
			hook.Remove( "EntityRemoved", "AutoBodyNPC_VehicleRemoved" )
		end
	end
end )
