--!strict

local Types = require(script.Parent.Parent.Types)
local validate = require(script.Parent.Parent.Utility.validate)

--[[
    Creates a declarative, reactive interval task

    @param callback - A derived function to be executed on each tick
    @return A prepared interval blueprint for hydration
]]
local function setInterval<T>(callback: Types.Derived<T>, config: Types.IntervalOptions): Types.PreparedInterval<T>
	validate(type(callback) == "function", "Callback must be a function")
    validate(config ~= nil and config.interval ~= nil, "Interval must be specified in the options")

	return {
		__type = "interval",
		callback = callback,
		config = config
	}
end

return setInterval
