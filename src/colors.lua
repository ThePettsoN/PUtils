local _, PUtils = ...

local Lib = PUtils.Library
if not Lib then
    return
end

local ColorUtils = {}
Lib.Colors = ColorUtils

local LookupUtils = Lib.Lookups
local ClassLookup = LookupUtils.ClassId
local SpecializationLookup = LookupUtils.SpecializationId

local ClassColors = {
    [ClassLookup.WARLOCK] =     "008788EE",
    [ClassLookup.DEATHKNIGHT] = "00C41E3A",
    [ClassLookup.HUNTER] =      "00AAD372",
    [ClassLookup.EVOKER] =      "0033937F",
    [ClassLookup.SHAMAN] =      "000070DD",
    [ClassLookup.MAGE] =        "003FC7EB",
    [ClassLookup.WARRIOR] =     "00C69B6D",
    [ClassLookup.ROGUE] =       "00FFF468",
    [ClassLookup.DRUID] =       "00FF7C0A",
    [ClassLookup.PALADIN] =     "00F48CBA",
    [ClassLookup.MONK] =        "0000FF98",
    [ClassLookup.DEMONHUNTER] = "00A330C9",
    [ClassLookup.PRIEST] =      "00FFFFFF",
}

local SpecializationColors = {
    -- Druid
    [SpecializationLookup.DRUID.BALANCE] =            ClassColors[ClassLookup.DRUID],
    [SpecializationLookup.DRUID.FERAL] =              ClassColors[ClassLookup.DRUID],
    [SpecializationLookup.DRUID.GUARDIAN] =           ClassColors[ClassLookup.DRUID],
    [SpecializationLookup.DRUID.RESTORATION] =        ClassColors[ClassLookup.DRUID],
    [SpecializationLookup.EVOKER.DEVASTATION] =       ClassColors[ClassLookup.EVOKER],
    [SpecializationLookup.EVOKER.PRESERVATION] =      ClassColors[ClassLookup.EVOKER],
    [SpecializationLookup.EVOKER.AUGMENTATION] =      ClassColors[ClassLookup.EVOKER],
    [SpecializationLookup.DEATHKNIGHT.BLOOD] =        ClassColors[ClassLookup.DEATHKNIGHT],
    [SpecializationLookup.DEATHKNIGHT.FROST] =        ClassColors[ClassLookup.DEATHKNIGHT],
    [SpecializationLookup.DEATHKNIGHT.UNHOLY] =       ClassColors[ClassLookup.DEATHKNIGHT],
    [SpecializationLookup.HUNTER.BEASTMASTERY] =      ClassColors[ClassLookup.HUNTER],
    [SpecializationLookup.HUNTER.MARKSMANSHIP] =      ClassColors[ClassLookup.HUNTER],
    [SpecializationLookup.HUNTER.SURVIVAL] =          ClassColors[ClassLookup.HUNTER],
    [SpecializationLookup.PRIEST.DISCIPLINE] =        ClassColors[ClassLookup.PRIEST],
    [SpecializationLookup.PRIEST.HOLY] =              ClassColors[ClassLookup.PRIEST],
    [SpecializationLookup.PRIEST.SHADOW] =            ClassColors[ClassLookup.PRIEST],
    [SpecializationLookup.ROGUE.ASSASSINATION] =      ClassColors[ClassLookup.ROGUE],
    [SpecializationLookup.ROGUE.OUTLAW] =             ClassColors[ClassLookup.ROGUE],
    [SpecializationLookup.ROGUE.SUBTLETY] =           ClassColors[ClassLookup.ROGUE],
    [SpecializationLookup.SHAMAN.ELEMENTAL] =         ClassColors[ClassLookup.SHAMAN],
    [SpecializationLookup.SHAMAN.ENHANCEMENT] =       ClassColors[ClassLookup.SHAMAN],
    [SpecializationLookup.SHAMAN.RESTORATION] =       ClassColors[ClassLookup.SHAMAN],
    [SpecializationLookup.WARLOCK.AFFLICTION] =       ClassColors[ClassLookup.WARLOCK],
    [SpecializationLookup.WARLOCK.DEMONOLOGY] =       ClassColors[ClassLookup.WARLOCK],
    [SpecializationLookup.WARLOCK.DESTRUCTION] =      ClassColors[ClassLookup.WARLOCK],
    [SpecializationLookup.MONK.BREWMASTER] =          ClassColors[ClassLookup.MONK],
    [SpecializationLookup.MONK.WINDWALKER] =          ClassColors[ClassLookup.MONK],
    [SpecializationLookup.MONK.MISTWEAVER] =          ClassColors[ClassLookup.MONK],
    [SpecializationLookup.DEMONHUNTER.HAVOC] =        ClassColors[ClassLookup.DEMONHUNTER],
    [SpecializationLookup.DEMONHUNTER.VENGEANCE] =    ClassColors[ClassLookup.DEMONHUNTER],
    [SpecializationLookup.MAGE.ARCANE] =              ClassColors[ClassLookup.MAGE],
    [SpecializationLookup.MAGE.FIRE] =                ClassColors[ClassLookup.MAGE],
    [SpecializationLookup.MAGE.FROST] =               ClassColors[ClassLookup.MAGE],
    [SpecializationLookup.PALADIN.HOLY] =             ClassColors[ClassLookup.PALADIN],
    [SpecializationLookup.PALADIN.PROTECTION] =       ClassColors[ClassLookup.PALADIN],
    [SpecializationLookup.PALADIN.RETRIBUTION] =      ClassColors[ClassLookup.PALADIN],
    [SpecializationLookup.WARRIOR.ARMS] =             ClassColors[ClassLookup.WARRIOR],
    [SpecializationLookup.WARRIOR.FURY] =             ClassColors[ClassLookup.WARRIOR],
    [SpecializationLookup.WARRIOR.PROTECTION] =       ClassColors[ClassLookup.WARRIOR],
}

ColorUtils.Class = ClassColors
ColorUtils.Specialization = SpecializationColors