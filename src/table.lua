local _, PUtils = ...

local Lib =  PUtils.Library
if not Lib then
    return
end

local TableUtils = {}
Lib.Table = TableUtils

local StringUtils = Lib.String

TableUtils.mergeArray = function(dest, source)
	for i = 1, #source do
		dest[#dest + 1] = source[i]
	end

	return dest
end

TableUtils.isArray = function(tbl)
    return #tbl > 0
end

TableUtils.mergeRecursive = function(dest, source)
	for k, v in pairs(source) do
		local isTable = type(v) == "table"

		if isTable and TableUtils.isArray(v) and TableUtils.isArray(dest[k]) then
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
		if k then
			out[k] = v
			out[v] = k
		end
	end

	return out
end

TableUtils.dump = function(tbl, indent)
	indent = indent or 0

	for k, v in pairs(tbl) do
		local vType = v and type(v) or "nil"
		if vType == "string" or vType == "number" or vType == "nil" or vType == "boolean" or vType == "function" then
			StringUtils.printf("%s: %s", StringUtils.indent(k, indent), tostring(v))
		elseif vType == "userdata" then
			StringUtils.printf("%s: userdata", StringUtils.indent(k, indent))
		elseif vType == "table" then
			StringUtils.printf("%s: {", StringUtils.indent(k, indent))
			TableUtils.dump(v, indent + 4)
			StringUtils.printf("%s", StringUtils.indent("}", indent))
		end
	end
end

TableUtils.clone = function(tbl, out)
	out = out or {}

	for k, v in pairs(tbl) do
		if type(v) ~= "table" then
			out[k] = v
		else
			out[k] = TableUtils.clone(v)
		end
	end

	return out
end

TableUtils.keys = function(tbl, out)
	out = out or {}
	local i = 1
	for k, _ in pairs(tbl) do
		out[i] = k
		i = i + 1
	end

	return out, i - 1
end

TableUtils.values = function(tbl, out)
	out = out or {}
	local i = 1
	for _, v in pairs(tbl) do
		out[i] = v
		i = i + 1
	end

	return out, i - 1
end
