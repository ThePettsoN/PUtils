local _, PUtils = ...
local Utils = LibStub:GetLibrary(PUtils.MAJOR_VERSION)

-- Lua APIs
local stringformat = string.format

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
            return string.format('%x', random(0, 0xf))
        end)
        return id
    end
end
