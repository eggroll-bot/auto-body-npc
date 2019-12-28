include( "shared.lua" )

function ENT:Think( )
	local red = self:GetRed( )
	local green = self:GetGreen( )
	local blue = self:GetBlue( )

	if red and green and blue then
		local dlight = DynamicLight( self:EntIndex( ) )

		if dlight then
			dlight.pos = self:GetPos( )
			dlight.nomodel = true
			dlight.brightness = 6
			dlight.decay = 1000
			dlight.size = 88
			dlight.dietime = CurTime( ) + FrameTime( ) * 4
		end
	end
end
