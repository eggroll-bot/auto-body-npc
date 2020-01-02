local vehicle_meta = FindMetaTable( "Vehicle" )

function vehicle_meta:SetEngineLevel( engine_level )
	self:SetNWInt( "EngineLevel", engine_level )
	self:SetMaxThrottle( 1 + engine_level * 0.1 )
	local current_health_percentage = self:VC_getHealth( false ) / self:VC_getHealthMax( ) -- We're using this, instead of the provided percentage health function because the percentage health function uses whole percentages only.
	self:VC_setHealthMax( self.VCModOriginalMaxHealth * ( 1 + 0.2 * engine_level ) )
	self:VC_setHealth( current_health_percentage * self:VC_getHealthMax( ) )
end

function vehicle_meta:SetUnderglowID( id )
	self:SetNWInt( "UnderglowColor", id )

	if self.Underglow then
		self.Underglow:Remove( )
		self.Underglow = nil
	end

	if id == 0 then
		return
	end

	local color = AutoBodyNPC.Config.GlobalUnderglowSettings[ id ].color
	self.Underglow = ents.Create( "vehicle_underglow" )
	self.Underglow:SetPos( self:GetPos( ) )
	self.Underglow:SetAngles( self:GetAngles( ) )
	self.Underglow:SetParent( self )
	self.Underglow:Spawn( )
	self.Underglow:SetRed( color.r )
	self.Underglow:SetGreen( color.g )
	self.Underglow:SetBlue( color.b )
	self:DeleteOnRemove( self.Underglow )
end
