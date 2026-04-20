--!strict

local function isTween(candidate: any): boolean
	return type(candidate) == "table" and candidate.__type == "tween"
end

return isTween
