-- Enable automatic workshop downloading for this addon. If set to false, this will resource.AddFile the files for this addon automatically. Set this to false only if you have a FastDL setup.

AutoBodyNPC.Config.UseWorkshop = true

-- Name of the auto body shop.

AutoBodyNPC.Config.Name = "BRYAN'S MOTORWORKS"

-- Model for the auto body shop NPC.

AutoBodyNPC.Config.Model = "models/eli.mdl"

-- Radius to find cars that the player owns.

AutoBodyNPC.Config.CarFindRadius = 512

-- Price for a respray for prices that haven't been explicitly defined for a specific car.

AutoBodyNPC.Config.GlobalResprayPrice = 750

-- Price for a skin change for prices that haven't been explicitly defined for a specific car.

AutoBodyNPC.Config.GlobalSkinPrice = 500

-- Price for a bodygroup change for prices that haven't been explicitly defined for a specific car.

AutoBodyNPC.Config.GlobalBodygroupPrice = 500

-- Price for an engine upgrade (per tier) for prices that haven't been explicitly defined for a specific car.

AutoBodyNPC.Config.GlobalEnginePrice = 1500

-- Prices for underglow for prices that haven't been explicitly defined for a specific car. Example is below.

--[[

AutoBodyNPC.Config.GlobalUnderglowSettings = {
	{
		[ "name" ] = "RED" -- Display name of color. This is what is displayed in the menu.
		[ "color" ] = Color( 255, 0, 0 ), -- RGB color.
		[ "price" ] = 500 -- Price.
	}
}

]]

AutoBodyNPC.Config.GlobalUnderglowSettings = {
	{
		[ "name" ] = "RED",
		[ "color" ] = Color( 255, 0, 0 ),
		[ "price" ] = 500
	},

	{
		[ "name" ] = "GREEN",
		[ "color" ] = Color( 0, 255, 0 ),
		[ "price" ] = 500
	},

	{
		[ "name" ] = "BLUE",
		[ "color" ] = Color( 0, 0, 255 ),
		[ "price" ] = 500
	}
}

-- "Pretty" bodygroup names for each bodygroup type. If a bodygroup type is left out, the bodygroup type's name will be used with underscores replaced with spaces. All letters will be automatically capitalized. Example: "hood" -> "HOOD", "wheel" -> "WHEEL", "tau_cannon" -> TAU CANNON.

AutoBodyNPC.Config.BodygroupNames = {
	[ "bumperf" ] = "FRONT BUMPER",
	[ "bumperr" ] = "REAR BUMPER"
}

-- Prices for the above options customized per car. If you leave out any option below, it will default to the global prices set above. Example is below.

--[[

AutoBodyNPC.Config.CustomCars = {
	[ "wranglertdm" ] = { -- Vehicle class name
		[ "respray" ] = 1000, -- Price for a respray.
		[ "skin" ] = 750, -- Price for a skin change.

		[ "bodygroup" ] = { -- Price for bodygroup upgrades. Options will be different for each car. The options below are only specific to the Jeep Wrangler from TDM.
			[ "bumperf" ] = { -- Price for front bumper customization.
				[ 0 ] = 150, -- Option 0
				[ 1 ] = 100, -- Option 1
				[ 2 ] = 200 -- Option 2
			},

			[ "bumperr" ] = {
				[ 0 ] = 200, -- Option 0
				[ 1 ] = 300 -- Option 1
			},

			[ "hood" ] = { -- Price for hood customization.
				[ 0 ] = 150, -- Option 0
				[ 1 ] = 100, -- Option 1
				[ 2 ] = 200 -- Option 2
			},

			[ "wheel" ] = {
				[ 0 ] = 200, -- Option 0
				[ 1 ] = 300 -- Option 1
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
		[ "skin" ] = 750, -- Price for a skin change.

		[ "bodygroup" ] = { -- Price for bodygroup upgrades. Options will be different for each car. The options below are only specific to the Jeep Wrangler from TDM.
			[ "bumperf" ] = { -- Price for front bumper customization.
				[ 0 ] = 150, -- Option 0
				[ 1 ] = 100, -- Option 1
				[ 2 ] = 200 -- Option 2
			},

			[ "bumperr" ] = {
				[ 0 ] = 200, -- Option 0
				[ 1 ] = 300 -- Option 1
			},

			[ "hood" ] = { -- Price for hood customization.
				[ 0 ] = 150, -- Option 0
				[ 1 ] = 100, -- Option 1
				[ 2 ] = 200 -- Option 2
			},

			[ "wheel" ] = {
				[ 0 ] = 200, -- Option 0
				[ 1 ] = 300 -- Option 1
			}
		},

		[ "engine" ] = 2000, -- Price for an engine upgrade (per tier).

		[ "underglow" ] = { -- Prices for underglow colors.
			[ "RED" ] = 750,
			[ "GREEN" ] = 200,
			[ "BLUE" ] = 500
		}
	}
}
