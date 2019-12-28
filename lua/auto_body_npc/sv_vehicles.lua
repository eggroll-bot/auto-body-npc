local vehicle_meta = FindMetaTable( "Vehicle" )

function vehicle_meta:SetEngineLevel( engine_level )
	self:SetNWInt( "EngineLevel", engine_level )
	-- apply engine modifications.
end

function vehicle_meta:SetUnderglowID( id )
	self:SetNWInt( "UnderglowColor", engine_level )
	-- apply underglow.
end
