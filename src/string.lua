local _, PUtils = ...

local Lib = PUtils.Library
if not Lib then
    return
end

local StringUtils = {}
Lib.String = StringUtils

-- Lua APIs
local stringformat = string.format
local srep = string.rep

StringUtils.printf = function(s, ...)
    print(stringformat(s, ...))
end

local defaultTemplate = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
StringUtils.uuid = function(template)
    template = template or defaultTemplate
    return string.gsub(template, "[xy]", function(c)
        local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end)
end

StringUtils.indent = function (str, length)
    return string.format("%s%s", srep(" ", length), str)
end

StringUtils.capitalize = function(str)
    return string.gsub(str, "^%l", string.upper)
end