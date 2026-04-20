--!strict

local Types = require(script.Parent.Parent.Types)

--[[
    Creates a declarative, reactive interval task

    @param callback - A derived function to be executed on each tick
    @param interval - A derivable number representing the delay between ticks (in seconds)
    @return A prepared interval blueprint for hydration
]]
local function setInterval<T>(callback: Types.Derived<T>, interval: Types.Derivable<number>): Types.PreparedInterval<T>
	return {
		__type = "interval",
		callback = callback,
		interval = interval,
	}
end

return setInterval
