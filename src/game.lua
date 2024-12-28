local _, PUtils = ...

local Lib = PUtils.Library
if not Lib then
    return
end

local GameUtils = {}
Lib.Game = GameUtils

-- Lua APIs
local strlower = strlower

local TableUtils = PUtils.Library.Table
local StringUtils = PUtils.Library.String

local GameVersionLookup = TableUtils.createLookup({
	CLASSIC = LE_EXPANSION_CLASSIC,
	TBC = LE_EXPANSION_BURNING_CRUSADE,
	WOTLK = LE_EXPANSION_WRATH_OF_THE_LICH_KING,
	CATA = LE_EXPANSION_CATACLYSM,
	MOP = LE_EXPANSION_MISTS_OF_PANDARIA,
	WOD = LE_EXPANSION_WARLORDS_OF_DRAENOR,
	LEGION = LE_EXPANSION_LEGION,
	BFA = LE_EXPANSION_BATTLE_FOR_AZEROTH,
	SHADOWLANDS = LE_EXPANSION_SHADOWLANDS,
	DRAGONFLIGHT = LE_EXPANSION_DRAGONFLIGHT,
	TWW = LE_EXPANSION_WAR_WITHIN,
})

local SeasonLookup = TableUtils.createLookup({
	NoSeason = 0,
	SeasonOfMastery = 1,
	SeasonOfDiscovery = 2,
	Hardcore = 3,
	Fresh = 4,
	FreshHardcore = 12,
})

local ClassIdLookup = TableUtils.createLookup({
	NONE = 0,
	WARRIOR = 1,
	PALADIN = 2,
	HUNTER = 3,
	ROGUE = 4,
	PRIEST = 5,
	DEATHKNIGHT = 6,
	SHAMAN = 7,
	MAGE = 8,
	WARLOCK = 9,
	MONK = 10,
	DRUID = 11,
	DEMONHUNTER = 12,
	EVOKER = 13,
})

local ShapeshiftIdLookup = {
	DRUID = TableUtils.createLookup({
		AQUATIC_FORM = 2,
		TRAVEL_FORM = 4,
		FLIGHT_FORM = 5,
		FLIGHT_FORM_BALANCE = 6
	}),
	SHAMAN = TableUtils.createLookup({
		GHOST_WOLF = 1,
	}),
}

local ItemRarityLookup = TableUtils.createLookup({
	POOR = 0,
	COMMON = 1,
	UNCOMMON = 2,
	RARE = 3,
	EPIC = 4,
	LEGENDARY = 5,
	ARTIFACT = 6,
	HEIRLOOM = 7,
	TOKEN = 8,
})

GameUtils.GameVersionLookup = GameVersionLookup
GameUtils.SeasonLookup = SeasonLookup
GameUtils.ClassIdLookup = ClassIdLookup
GameUtils.ShapeshiftIdLookup = ShapeshiftIdLookup
GameUtils.ItemRarityLookup = ItemRarityLookup

local classIndex, className
local gameVersionIndex, gameVersion
local seasonIndex, season
local maxLevel

local function determineGameData()
	gameVersionIndex = LE_EXPANSION_LEVEL_CURRENT
	gameVersion = GameVersionLookup[gameVersionIndex]

	seasonIndex = C_Seasons and C_Seasons.GetActiveSeason() or 0
	season = SeasonLookup[seasonIndex]

	maxLevel = GetMaxLevelForExpansionLevel(gameVersionIndex)

	className, classIndex = UnitClassBase("player")
end
determineGameData()

GameUtils.GetGameVersion = function()
	return gameVersion, GameVersionLookup[gameVersion]
end
GameUtils.CompareGameVersion = function(value)
	local valueType = type(value)
	if valueType == "number" then
		return value <= gameVersionIndex
	end

	if valueType == "string" then
		return GameVersionLookup[value] <= gameVersionIndex
	end

	error("Invalid value type", value, valueType)
end
GameUtils.GetSeason = function()
	return season, SeasonLookup[season]
end
GameUtils.CompareSeasion = function(value)
	local valueType = type(value)
	if valueType == "number" then
		return value <= seasonIndex
	end

	if valueType == "string" then
		return SeasonLookup[value] <= seasonIndex
	end

	error("Invalid value type")
end
GameUtils.GetMaxLevel = function()
	return maxLevel
end
GameUtils.GetPlayerClass = function()
	return className, classIndex
end
GameUtils.ComparePlayerClass = function (value)
	local valueType = type(value)
	if valueType == "number" then
		return value == classIndex
	end

	if valueType == "string" then
		return value == className
	end

	error("Invalid value type", value, valueType)
end

-- Generates functions to quickly check if player is on a specific expansion
-- eg. IsClassic(), IsWotlk()
for k, v in pairs(GameVersionLookup) do
	if type(k) == "string" then
		local gameVersionName = StringUtils.capitalize(strlower(k))
		GameUtils["Is" .. gameVersionName] = function()
			return v == gameVersionIndex
		end
	end
end

-- Generates functions to quickly check if player is on a specific expansion
-- eg. IsHardcore(), IsSeasonOfDiscovery()
for k, v in pairs(SeasonLookup) do
	if type(k) == "string" then
		GameUtils["Is" .. k] = function()
			return v == seasonIndex
		end
	end
end
