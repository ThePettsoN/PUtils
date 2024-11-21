local _, PUtils = ...

local MAJOR = 1
local MINOR = 5
PUtils.PATCH = string.format("PUtils-%d.%d", MAJOR, MINOR)

LibStub:NewLibrary(PUtils.PATCH, MINOR)
