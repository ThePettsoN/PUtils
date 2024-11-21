local _, PUtils = ...
local Utils = LibStub:GetLibrary(PUtils.PATCH)
if Utils.debug then
    return
end

-- Lua APIs
local stringformat = string.format

local DebugUtils = {}
Utils.debug = DebugUtils

local Modules = {}
local Severities = {
    Debug = 1,
    Info = 2,
    Warning = 3,
    Error = 4,
}
DebugUtils.Severities = Severities

local function charCodeAt(str)
    return string.byte(str, 1)
end

local function getColorCode(str)
    local hash = 0
    for i = 1, #str do
        local char = str:sub(i, i)
        hash = charCodeAt(char, 0) + bit.lshift(hash, 5) - hash
    end

    local color = "00"
    for i = 1, 3 do
        local value = bit.band(bit.rshift(hash, i * 8), 255)
        value = stringformat("%x", value)
        local n = #value
        if n < 2 then
            value = stringformat("%s%s", string.rep("0", 2 - n), value)
        end

        color = stringformat("%s%s", color, value)
    end

    return color
end


local function printMessage(moduleName, color, severity, msg, ...)
    local module = Modules[moduleName]
    local mColor = module and module.__putils_debug.color or "00ffffff"
    print(stringformat("|c%s[%s]|r |c%s%s %s|r", mColor, moduleName, color, severity, stringformat(msg, ...)))
end

local function linkFunctions(module)
    module.info = DebugUtils.info
    module.debug = DebugUtils.debug
    module.warning = DebugUtils.warning
    module.error = DebugUtils.error
    module.Info = DebugUtils.info
    module.Debug = DebugUtils.debug
    module.Warning = DebugUtils.warning
    module.Error = DebugUtils.error

    module.printf = function(_, string, ...) Utils.string.printf(string, ...) end
    module.setSeverity = DebugUtils.setSeverity
    module.getSeverity = DebugUtils.getSeverity
end

do
    DebugUtils.initialize = function(mod, name, severity, color)
        if Modules[name] then
            printMessage("PUtils", "00ff0000", "ERROR", "Tried to initialize already initialized module '%s'", name)
            return
        end

        if severity and not Severities[severity] then
            printMessage("PUtils", "00ff0000", "ERROR", "Tried to initialize '%s 'with unknown severity '%s'", name, severity)
            return
        end

        Modules[name] = mod
        Modules[mod] = name
        mod.__putils_debug = {
            severity = severity and Severities[severity] or Severities.Info,
            color = color or getColorCode(name)
        }

        linkFunctions(mod)
    end
end

do
    DebugUtils.initializeModule = function(mod, parent, name)
        local parentName = Modules[parent]
        if not parentName then
            printMessage("PUtils", "00ff0000", "ERROR", "Failed to find registered parent for module")
            return
        end

        Modules[mod] = parentName
        local data = parent.__putils_debug
        mod.__putils_debug = data

        linkFunctions(mod)
    end
end

DebugUtils.setSeverity = function(self, severity)
    local newSeverity = Severities[severity]
    if not newSeverity then
        return
    end

    self.__putils_debug.severity = newSeverity
end

DebugUtils.getSeverity = function(self)
    return self.__putils_debug.severity
end

DebugUtils.debug = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Debug then
        printMessage(Modules[self], "00daa1f7", "[Debug]", s, ...)
    end
end

DebugUtils.info = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Info then
        printMessage(Modules[self], "00ffffff", "", s, ...)
    end
end

DebugUtils.warning = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Warning then
        printMessage(Modules[self], "00eed202", "[Warning]", s, ...)
    end
end

DebugUtils.error = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Error then
        printMessage(Modules[self], "00ff0000", "[Error]", s, ...)
    end
end
