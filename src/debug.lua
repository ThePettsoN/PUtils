local _, PUtils = ...
local Utils = LibStub:GetLibrary(Putils.PATCH)

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

local function printMessage(moduleName, color, severity, msg, ...)
    print(string.format("[%s]|c%s[%s] %s|r", moduleName, color, severity, string.format(msg, ...)))
end

do
    DebugUtils.initialize = function(module, name, severity)
        if Modules[name] then
            printMessage("PUtils", "00ff0000", "ERROR", "Tried to initialize already initialized module '%s'|r", name)
            return
        end

        if severity and not Severities[severity] then
            printMessage("PUtils", "00ff0000", "ERROR", "Tried to initialize '%s 'with unknown severity '%s'.|r", name, severity)
            return
        end

        Modules[name] = module
        Modules[module] = name
        module.__putils_debug = {
            severity = Severities[severity] or Severities.Info
        }

        module.info = DebugUtils.info
        module.debug = DebugUtils.debug
        module.warning = DebugUtils.warning
        module.error = DebugUtils.error
        module.printf = function(self, string, ...) Utils.string.printf(string, ...) end
        module.setSeverity = DebugUtils.setSeverity
        module.getSeverity = DebugUtils.getSeverity
    end
end

DebugUtils.setSeverity = function(self, severity)
    local newSeverity = Severities[severity]
    if not newSeverity then
        return
    end

    self.__putils_debug.severity = newSeverity
end

DebugUtils.getSeverity = function(self, severity)
    return self.__putils_debug.severity
end

DebugUtils.debug = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Debug then
        printMessage(Modules[self], "00ffffff", "DEBUG", s, ...)
    end
end

DebugUtils.info = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Info then
        printMessage(Modules[self], "00ffffff", "INFO", s, ...)
    end
end

DebugUtils.warning = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Warning then
        printMessage(Modules[self], "00eed202", "WARNING", s, ...)
    end
end

DebugUtils.error = function(self, s, ...)
    if self.__putils_debug.severity <= Severities.Error then
        printMessage(Modules[self], "00ff0000", "ERROR", s, ...)
    end
end
