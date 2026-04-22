--!strict

local Types = require(script.Parent.Parent.Types)
local validate = require(script.Parent.Parent.Utility.validate)

--[[
    Creates a declarative, reactive render hook

    @param callback - A derived function to be executed on each frame
    @return A prepared render hook blueprint for hydration
]]
local function setRendered<T>(callback: (dt: number) -> T, fps: number?): Types.PreparedRendered<T>
	validate(type(callback) == "function", "Callback must be a function")
	if fps then
		validate(type(fps) == "number", "FPS must be a number")
		validate(fps > 0, "FPS must be greater than 0")
	end

	return {
		__type = "rendered",
		callback = callback,
		fps = fps,
	}
end

return setRendered
