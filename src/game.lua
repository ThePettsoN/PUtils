local _, PUtils = ...
local Utils = LibStub:GetLibrary(PUtils.MAJOR_VERSION)

local GameUtils = {}
Utils.game = GameUtils

do
	local gameVersion
	local gameVersionIndex

	GameUtils.GameVersionLookup = Utils.table.createLookup({
		SeasonOfDiscovery = 1,
		Hardcore = 2,
		Retail = 3,
		Wotlk = 4,
	})

	local function determineVersion()
		if not C_Engraving then
			gameVersionIndex = GameUtils.GameVersionLookup.Retail
		elseif C_Console then
			gameVersionIndex = GameUtils.GameVersionLookup.Wotlk
		elseif C_GameRules.IsHardcoreActive() then
			gameVersionIndex = GameUtils.GameVersionLookup.Hardcore
		else
			gameVersionIndex = GameUtils.GameVersionLookup.SeasonOfDiscovery
		end

		gameVersion = GameUtils.GameVersionLookup[gameVersionIndex]
	end

	GameUtils.getGameVersion = function()
		if not gameVersion then
			determineVersion()
		end

		return gameVersion, gameVersionIndex
	end

	GameUtils.compareGameVersion = function(index)
		if not gameVersion then
			determineVersion()
		end

		if index < gameVersionIndex then
			return -1
		end

		if index == gameVersionIndex then
			return 0
		end

		return 1
	end
end

do
	local gameExpansion
	local gameExpansionIndex

	GameUtils.GameExpansionLookup = Utils.table.createLookup({
		Vanilla = 1,
		Tbc = 2,
		Wotlk = 3,
	})

	local function determineExpansion()
		local expansion = GetBuildInfo():sub(1,1)
		
		gameExpansionIndex = tonumber(expansion)
		gameExpansion = GameUtils.GameExpansionLookup[gameExpansionIndex]
		if not gameExpansion and gameExpansionIndex >= 10 then
			gameExpansion = "Retail"
			GameUtils.GameExpansionLookup[gameExpansion] = gameExpansionIndex
			GameUtils.GameExpansionLookup[gameExpansionIndex] = gameExpansion
		end
	end

	GameUtils.getGameExpansion = function()
		if not gameExpansion then
			determineExpansion()
		end

		return gameExpansion, gameExpansionIndex
	end

	GameUtils.compareGameExpansion = function(index)
		if not gameExpansion then
			determineExpansion()
		end

		if index < gameExpansion then
			return -1
		end

		if index == gameExpansion then
			return 0
		end

		return 1
	end
end

GameUtils.ClassIds = {
	None = 0,
	Warrior = 1,
	Paladin = 2,
	Hunter = 3,
	Rogue = 4,
	Priest = 5,
	DeathKnight = 6,
	Shaman = 7,
	Mage = 8,
	Warlock = 9,
	Druid = 11,
}

GameUtils.ShapeshiftIds = {
	Druid = {
		AquaticForm = 2,
		TravelForm = 4,
		FlightForm = 5,
		FlightFormBalance = 6
	},
	Shaman = {
		GhostWolf = 1,
	},
}
