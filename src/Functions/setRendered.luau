--!strict

local Types = require("../Types")
local validate = require("../Utility/validate")

--[[
    Creates a declarative, reactive render hook

    @param callback - A derived function to be executed on each frame
    @return A prepared render hook blueprint for hydration
]]
local function setRendered<T>(
	callback: (delta: number, steps: number, accumulated: number) -> T,
	config: Types.RenderedOptions?
): Types.PreparedRendered<T>
	validate(type(callback) == "function", "Callback must be a function")

	return {
		__type = "rendered",
		callback = callback,
		config = config or {},
	}
end

return setRendered
