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

local defaultTemplate ='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
StringUtils.uuid = function(template)
    template = template or defaultTemplate
    local id = string.gsub(template, '[x]', function (c)
        return string.format('%x', math.random(0, 0xf))
    end)

    return id
end

StringUtils.indent = function (str, length)
    return string.format("%s%s", srep(" ", length), str)
end

StringUtils.capitalize = function(str)
    return string.gsub(str, "^%l", string.upper)
end