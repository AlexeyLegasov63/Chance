--!strict

-- Checks if the value is a computed function
local function isComputed(value: any)
	return typeof(value) == "function"
end

return isComputed
