local _, PUtils = ...

local Lib = PUtils.Library
if not Lib then
    return
end

local GameUtils = {}
Lib.Game = GameUtils

-- Lua APIs
local strlower = strlower

local LookupUtils = PUtils.Library.Lookups
local StringUtils = PUtils.Library.String

local classIndex, className
local gameVersionIndex, gameVersion
local seasonIndex, season
local maxLevel

local function determineGameData()
	gameVersionIndex = LE_EXPANSION_LEVEL_CURRENT
	gameVersion = LookupUtils.GameVersion[gameVersionIndex]

	seasonIndex = C_Seasons and C_Seasons.GetActiveSeason() or 0
	season = LookupUtils.Season[seasonIndex]

	maxLevel = GetMaxLevelForExpansionLevel(gameVersionIndex)
end
determineGameData()

GameUtils.GetGameVersion = function()
	return gameVersion, LookupUtils.GameVersion[gameVersion]
end
GameUtils.CompareGameVersion = function(value)
	local valueType = type(value)
	if valueType == "number" then
		return value <= gameVersionIndex
	end

	if valueType == "string" then
		return LookupUtils.GameVersion[value] <= gameVersionIndex
	end

	error(string.format("Invalid value type: %s (%s)", tostring(value), valueType))
end
GameUtils.GetSeason = function()
	return season, LookupUtils.Season[season]
end
GameUtils.CompareSeason = function(value)
	local valueType = type(value)
	if valueType == "number" then
		return value <= seasonIndex
	end

	if valueType == "string" then
		return LookupUtils.Season[value] <= seasonIndex
	end

	error(string.format("Invalid value type"))
end
GameUtils.GetMaxLevel = function()
	return maxLevel
end
GameUtils.GetPlayerClass = function()
	if not className then
		className, classIndex = UnitClassBase("player")
	end

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

	error(string.format("Invalid value type: %s (%s)", tostring(value), valueType))
end

GameUtils.IterateGroupMembers = function()
	local unit = IsInRaid() and 'raid' or 'party'
	local numGroupMembers = unit == 'party' and GetNumSubgroupMembers() or GetNumGroupMembers()
	local i = unit == 'party' and 0 or 1

	return function()
		local ret
		if i == 0 and unit == 'party' then
			ret = 'player'
		elseif i <= numGroupMembers and i > 0 then
			ret = unit .. i
		end
		i = i + 1

		return ret
	end
end

-- Generates functions to quickly check if player is on a specific expansion
-- eg. IsClassic(), IsWotlk()
for k, v in pairs(LookupUtils.GameVersion) do
	if type(k) == "string" then
		local gameVersionName = StringUtils.capitalize(strlower(k))
		GameUtils["Is" .. gameVersionName] = function()
			return v == gameVersionIndex
		end
	end
end

-- Generates functions to quickly check if player is on a specific expansion
-- eg. IsHardcore(), IsSeasonOfDiscovery()
for k, v in pairs(LookupUtils.Season) do
	if type(k) == "string" then
		GameUtils["Is" .. k] = function()
			return v == seasonIndex
		end
	end
end
