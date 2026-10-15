--!strict

local Types = require("../Types")

-- Applies a value to an instance
local function applyValue<T>(instance: Instance, property: Types.PossibleProperty, value: T)
	if type(property) == "table" then
		local attribute = (property :: Types.InstanceAttribute).__attribute
		instance:SetAttribute(attribute, value)
		return
	end

	(instance :: any)[property :: string] = value
end

return applyValue
