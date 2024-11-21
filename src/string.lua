local _, PUtils = ...
local Utils = LibStub:GetLibrary(PUtils.PATCH)
if Utils.string then
    return
end

-- Lua APIs
local stringformat = string.format
local srep = string.rep

local StringUtils = {}
Utils.string = StringUtils

StringUtils.printf = function(s, ...)
    print(stringformat(s, ...))
end

do
    local defaultTemplate ='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    StringUtils.uuid = function(template)
        template = template or defaultTemplate
        local id = string.gsub(template, '[x]', function (c)
            return string.format('%x', math.random(0, 0xf))
        end)
        return id
    end
end

StringUtils.indent = function (str, length)
    return string.format("%s%s", srep(" ", length), str)
end
