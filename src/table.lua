local _, PUtils = ...
local Utils = LibStub:GetLibrary(PUtils.MAJOR_VERSION)

-- WoW APIs
local CopyTable = CopyTable

local TableUtils = {}
Utils.table = TableUtils

TableUtils.mergeArray = function(dest, source)
	for i = 1, #source do
		dest[#dest + 1] = source[i]
	end

	return dest
end

TableUtils.mergeRecursive = function(dest, source)
	for k, v in pairs(source) do
		local isTable = type(v) == "table"

		if isTable and v[1] and type(dest[k]) == "table" and dest[k][1] then -- Stupid check that assumes that all tables where index 1 exists in both dest and source are arrays.
			TableUtils.mergeArray(dest[k], v)
		elseif isTable and type(dest[k]) == "table" then
			TableUtils.mergeRecursive(dest[k], v)
		elseif isTable then
			dest[k] = CopyTable(v)
		else
			dest[k] = v
		end
	end

	return dest
end

TableUtils.find = function(tbl, value)
	for k, v in pairs(tbl) do
		if v == value then
			return v, k
		end
	end
end

TableUtils.createLookup = function(tbl, out)
	out = out or {}
	for k, v in pairs(tbl) do
		out[k] = v
		out[v] = k
	end

	return out
end

TableUtils.dump = function(tbl, indent)
	indent = indent or 0

	for k, v in pairs(tbl) do
		local vType = v and type(v) or "nil"
		if vType == "string" or vType == "number" or vType == "nil" or vType == "boolean" or vType == "function" then
			Utils.string.printf("%s: %s", Utils.string.indent(k, indent), tostring(v))
		elseif vType == "userdata" then
			Utils.string.printf("%s: userdata", Utils.string.indent(k, indent))
		elseif vType == "table" then
			Utils.string.printf("%s: {", Utils.string.indent(k, indent))
			TableUtils.dump(v, indent + 4)
			Utils.string.printf("%s", Utils.string.indent("}", indent))
		end
	end
end
