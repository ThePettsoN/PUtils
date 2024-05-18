local _, PUtils = ...
local Utils = LibStub:GetLibrary(PUtils.PATCH)

local GameUtils = {}
Utils.game = GameUtils

do
	local gameVersion
	local gameVersionIndex

	GameUtils.GameVersionLookup = Utils.table.createLookup({
		Vanilla = 1,
		SeasonOfDiscovery = 2,
		Hardcore = 3,
		TBC = 4,
		Wotlk = 5,
		Cataclysm = 6,
		Retail = 7,
	})

	local function determineVersion()
		if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
			gameVersionIndex = GameUtils.GameVersionLookup.Retail
		elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
			gameVersionIndex = GameUtils.GameVersionLookup.TBC
		elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
			gameVersionIndex = GameUtils.GameVersionLookup.Wotlk
		elseif WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC then
			gameVersionIndex = GameUtils.GameVersionLookup.Cataclysm
		elseif C_Engraving then
			gameVersionIndex = GameUtils.GameVersionLookup.SeasonOfDiscovery
		elseif C_GameRules.IsHardcoreActive() then
			gameVersionIndex = GameUtils.GameVersionLookup.Hardcore
		else
			gameVersionIndex = GameUtils.GameVersionLookup.Vanilla
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

		return index == gameVersionIndex
	end
end

do
	local gameExpansion
	local gameExpansionIndex

	GameUtils.GameExpansionLookup = Utils.table.createLookup({
		Vanilla = 1,
		Tbc = 2,
		Wotlk = 3,
		Cataclysm = 4,
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

		if index < gameExpansionIndex then
			return -1
		end

		if index == gameExpansionIndex then
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

GameUtils.ItemRarity = {
	Poor = 0,
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Epic = 4,
	Legendary = 5,
	Artifact = 6,
	Heirloom = 7,
	Token = 8,
}
