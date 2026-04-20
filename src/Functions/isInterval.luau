--!strict

local function isInterval(candidate: any): boolean
	return type(candidate) == "table" and candidate.__type == "interval"
end

return isInterval
