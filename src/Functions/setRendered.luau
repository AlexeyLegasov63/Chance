--!strict

local Types = require(script.Parent.Parent.Types)

--[[
    Creates a declarative, reactive render hook

    @param callback - A derived function to be executed on each frame
    @return A prepared render hook blueprint for hydration
]]
local function setRendered<T>(callback: Types.Derived<T>): Types.PreparedRendered<T>
	return {
		__type = "rendered",
		callback = callback,
	}
end

return setRendered
