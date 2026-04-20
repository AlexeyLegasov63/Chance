--!strict

local Types = require(script.Parent.Parent.Types)

--[[
    Creates a declarative spring

    @param callback - A derived function to be executed on spring updates
    @param config - A Ripple spring configuration

    @return A prepared spring blueprint for hydration
]]
local function setSpring<T>(callback: Types.Derived<T>, config: Types.SpringOptions<T>?): Types.PreparedSpring<T>
	return {
		__type = "spring",
		callback = callback,
		config = config,
	}
end

return setSpring
