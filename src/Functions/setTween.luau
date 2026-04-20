--!strict

local Types = require(script.Parent.Parent.Types)

--[[
    Creates a declarative tween

    @param callback - A derived function to be executed on tween updates
    @param config - A Ripple tween configuration

    @return A prepared tween blueprint for hydration
]]
local function setTween<T>(callback: Types.Derived<T>, config: Types.TweenOptions<T>?): Types.PreparedTween<T>
	return {
		__type = "tween",
		callback = callback,
		config = config,
	}
end

return setTween
