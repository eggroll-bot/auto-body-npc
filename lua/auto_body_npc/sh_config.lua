-- Name of the auto body shop.

AutoBodyNPC.Name = "ROCKFORD CUSTOMS"

-- Price for a respray for prices that haven't been explicitly defined for a specific car.

AutoBodyNPC.Config.GlobalResprayPrice = 750

-- Price for a bodygroup change for prices that haven't been explicitly defined for a specific car.

AutoBodyNPC.Config.GlobalBodygroupPrice = 500

-- Price for an engine upgrade for prices that haven't been explicitly defined for a specific car.

AutoBodyNPC.Config.GlobalEnginePrice = 1500

-- Prices for underglow for prices that haven't been explicitly defined for a specific car. Example is below.

--[[

AutoBodyNPC.Config.GlobalUnderglowPrices = {
	[ "Red" ] = { -- Display name of color. This is what is displayed in the menu.
		[ "color" ] = Color( 255, 0, 0 ), -- RGB color.
		[ "price" ] = 500 -- Price.
	}
}

]]

AutoBodyNPC.Config.GlobalUnderglowPrices = {
	[ "Red" ] = {
		[ "color" ] = Color( 255, 0, 0 ),
		[ "price" ] = 500
	},

	[ "Green" ] = {
		[ "color" ] = Color( 0, 255, 0 ),
		[ "price" ] = 500
	},

	[ "Blue" ] = {
		[ "color" ] = Color( 0, 0, 255 ),
		[ "price" ] = 500
	}
}

-- Prices for the above options customized per car. If you leave out any option below, it will default to the global prices set above. Example is below.

--[[

AutoBodyNPC.Config.CustomCars = {
	[ "wranglertdm" ] = { -- Vehicle class name
		[ "respray" ] = 1000, -- Price for a respray.

		[ "bodygroup" ] = { -- Price for bodygroup upgrades. Options will be different for each car. The options below are only specific to the Jeep Wrangler from TDM.
			[ "bumperf" ] = { -- Price for front bumper customization.
				[ 1 ] = 150, -- Option 1
				[ 2 ] = 100, -- Option 2
				[ 3 ] = 200 -- Option 3
			},

			[ "bumperr" ] = {
				[ 1 ] = 200, -- Option 1
				[ 2 ] = 300 -- Option 2
			},

			[ "hood" ] = { -- Price for hood customization.
				[ 1 ] = 150, -- Option 1
				[ 2 ] = 100, -- Option 2
				[ 3 ] = 200 -- Option 3
			},

			[ "wheel" ] = {
				[ 1 ] = 200, -- Option 1
				[ 2 ] = 300 -- Option 2
			}
		},

		[ "engine" ] = 2000, -- Price for an engine upgrade.

		[ "underglow" ] = { -- Prices for underglow colors.
			[ "Red" ] = 750,
			[ "Green" ] = 200,
			[ "Blue" ] = 500
		}
	}
}

]]

AutoBodyNPC.Config.CustomCars = {
	[ "wranglertdm" ] = { -- Vehicle class name
		[ "respray" ] = 1000, -- Price for a respray.

		[ "bodygroup" ] = { -- Price for bodygroup upgrades. Options will be different for each car. The options below are only specific to the Jeep Wrangler from TDM.
			[ "bumperf" ] = { -- Price for front bumper customization.
				[ 1 ] = 150, -- Option 1
				[ 2 ] = 100, -- Option 2
				[ 3 ] = 200 -- Option 3
			},

			[ "bumperr" ] = {
				[ 1 ] = 200, -- Option 1
				[ 2 ] = 300 -- Option 2
			},

			[ "hood" ] = { -- Price for hood customization.
				[ 1 ] = 150, -- Option 1
				[ 2 ] = 100, -- Option 2
				[ 3 ] = 200 -- Option 3
			},

			[ "wheel" ] = {
				[ 1 ] = 200, -- Option 1
				[ 2 ] = 300 -- Option 2
			}
		},

		[ "engine" ] = 2000, -- Price for an engine upgrade.

		[ "underglow" ] = { -- Prices for underglow colors.
			[ "Red" ] = 750,
			[ "Green" ] = 200,
			[ "Blue" ] = 500
		}
	}
}
