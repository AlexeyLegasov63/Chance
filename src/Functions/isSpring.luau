--!strict

local function isSpring(candidate: any): boolean
	return type(candidate) == "table" and candidate.__type == "spring"
end

return isSpring
