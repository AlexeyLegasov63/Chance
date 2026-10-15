--!strict

local Types = require("../Types")

local function attribute(attributeName: string): Types.InstanceAttribute
	return {
		__attribute = attributeName,
	}
end

return attribute
