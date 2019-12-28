local vehicle_meta = FindMetaTable( "Vehicle" )

function vehicle_meta:SetEngineLevel( engine_level )
	self:SetNWInt( "EngineLevel", engine_level )
	self:SetMaxThrottle( 1 + engine_level * 0.1 )
end

function vehicle_meta:SetUnderglowID( id )
	self:SetNWInt( "UnderglowColor", id )
	-- apply underglow. find wheels and find point equidistant to them.
end
