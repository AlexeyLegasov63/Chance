--!strict

local Types = require("../Types")

-- Checks if the instance has the property
local function isProperty(instance: Instance, candidate: Types.PossibleProperty): boolean
	if type(candidate) == "table" then
		return true -- It's an attribute
	end
	return pcall(function()
		return (instance :: any)[candidate]
	end)
end

return isProperty
