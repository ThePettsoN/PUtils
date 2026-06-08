local _, PUtils = ...

local Lib = PUtils.Library
if not Lib then
    return
end

local LookupUtils = {}
Lib.Lookups = LookupUtils

local TableUtils = PUtils.Library.Table

local GameVersionLookup = TableUtils.createLookup({
	CLASSIC = LE_EXPANSION_CLASSIC,
	TBC = LE_EXPANSION_BURNING_CRUSADE,
	WOTLK = LE_EXPANSION_WRATH_OF_THE_LICH_KING,
	CATACLYSM = LE_EXPANSION_CATACLYSM,
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

local SpecializationIdLookup = {
    WARRIOR = TableUtils.createLookup({
        ARMS = 71,
        FURY = 72,
        PROTECTION = 73,
    }),
    PALADIN = TableUtils.createLookup({
        HOLY = 65,
        PROTECTION = 66,
        RETRIBUTION = 70,
    }),
    HUNTER = TableUtils.createLookup({
        BEASTMASTERY = 253,
        MARKSMANSHIP = 254,
        SURVIVAL = 255,
    }),
    ROGUE = TableUtils.createLookup({
        ASSASSINATION = 259,
        OUTLAW = 260,
        SUBTLETY = 261,
    }),
    PRIEST = TableUtils.createLookup({
        DISCIPLINE = 256,
        HOLY = 257,
        SHADOW = 258,
    }),
    DEATHKNIGHT = TableUtils.createLookup({
        BLOOD = 250,
        FROST = 251,
        UNHOLY = 252,
    }),
    SHAMAN = TableUtils.createLookup({
        ELEMENTAL = 262,
        ENHANCEMENT = 263,
        RESTORATION = 264,
    }),
    MAGE = TableUtils.createLookup({
        ARCANE = 62,
        FIRE = 63,
        FROST = 64,
    }),
    WARLOCK = TableUtils.createLookup({
        AFFLICTION = 265,
        DEMONOLOGY  = 266,
        DESTRUCTION = 267,
    }),
    MONK = TableUtils.createLookup({
        BREWMASTER = 268,
        WINDWALKER = 269,
        MISTWEAVER = 270,
    }),
    DRUID = TableUtils.createLookup({
        BALANCE = 102,
        FERAL = 103,
        GUARDIAN = 104,
        RESTORATION = 105,
    }),
    DEMONHUNTER = TableUtils.createLookup({
        HAVOC = 577,
        VENGEANCE = 581,
    }),
    EVOKER = TableUtils.createLookup({
        DEVASTATION = 1467,
        PRESERVATION = 1468,
        AUGMENTATION = 1473,
    }),
}

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

LookupUtils.GameVersion = GameVersionLookup
LookupUtils.Season = SeasonLookup
LookupUtils.ClassId = ClassIdLookup
LookupUtils.SpecializationId = SpecializationIdLookup
LookupUtils.ShapeshiftId = ShapeshiftIdLookup
LookupUtils.ItemRarity = ItemRarityLookup