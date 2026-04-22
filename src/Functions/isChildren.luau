--!strict

local function isChildren(candidate: any): boolean
	return type(candidate) == "table" and candidate.__type == "children"
end

return isChildren
