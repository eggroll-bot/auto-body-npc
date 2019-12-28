local vehicle_meta = FindMetaTable( "Vehicle" )

function vehicle_meta:SetEngineLevel( engine_level )
	self:SetNWInt( "EngineLevel", engine_level )
	self:SetMaxThrottle( 1 + engine_level * 0.1 )
	self:VC_setHealthMax( self:VC_getHealthMax( ) * ( 1 + 0.2 * engine_level ) )
	self:VC_setHealth( self:VC_getHealth( false ) * ( 1 + 0.2 * engine_level ) )
end

function vehicle_meta:SetUnderglowID( id )
	self:SetNWInt( "UnderglowColor", id )

	if id == 0 then
		if self.Underglow then
			self.Underglow:Remove( )
		end

		return
	end

	local color = AutoBodyNPC.Config.GlobalUnderglowSettings[ id ].color
	self.Underglow = ents.Create( "vehicle_underglow" )
	self.Underglow:SetPos( self:GetPos( Vector( 0, 0, -10 ) ) )
	self.Underglow:SetAngles( self:GetAngles( ) )
	self.Underglow:SetParent( self )
	self.Underglow:Spawn( )
	self.Underglow:SetRed( color.r )
	self.Underglow:SetGreen( color.g )
	self.Underglow:SetBlue( color.b )
	self:DeleteOnRemove( self.Underglow )
end
