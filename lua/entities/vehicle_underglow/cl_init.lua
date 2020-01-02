include( "shared.lua" )

function ENT:Think( )
	local red = self:GetRed( )
	local green = self:GetGreen( )
	local blue = self:GetBlue( )

	if red and green and blue then
		local dlight = DynamicLight( self:EntIndex( ) )

		if dlight then
			dlight.pos = self:GetPos( )
			dlight.brightness = 6
			dlight.size = 120
			dlight.r = red
			dlight.g = green
			dlight.b = blue
			dlight.nomodel = true
			dlight.dietime = CurTime( ) + FrameTime( )
		end
	end
end
