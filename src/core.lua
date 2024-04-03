local _, PUtils = ...

local MAJOR = 1
local MINOR = 2
Putils.PATCH = string.format("PUtils-%d-%d", MAJOR, MINOR)

local Utils = LibStub and LibStub:NewLibrary(Putils.PATCH, MINOR)
