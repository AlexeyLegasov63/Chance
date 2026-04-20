--!strict

local function isRendered(candidate: any): boolean
	return type(candidate) == "table" and candidate.__type == "rendered"
end

return isRendered
