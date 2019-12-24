include( "shared.lua" )

function ENT:Draw( )
	self:DrawModel( )
	local pos = self:GetPos( ) + self:GetForward( ) * 4
	local ang = self:GetAngles( )
	ang:RotateAroundAxis( ang:Up( ), 90 )
	ang:RotateAroundAxis( ang:Forward( ), 90 )
	cam.Start3D2D( pos, ang, 0.25 )
	draw.SimpleText( AutoBodyNPC.Config.Name, "DermaDefault", 0, -310, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	cam.End3D2D( )
end
