--!strict

local Types = require(script.Parent.Parent.Types)
local validate = require(script.Parent.Parent.Utility.validate)

--[[
    Observes children and applies them to an instance, destroying them automatically

    @param selector A function that returns an array or table of data
    @param constructor A function that creates an instance from each data node

    @return The prepared children
]]
local function setChildren<K, V>(selector: () -> { [K]: V }, constructor: (V, K) -> Instance?): Types.PreparedChildren<K, V>
	validate(type(selector) == "function", "Selector must be a function")
	validate(type(constructor) == "function", "Constructor must be a function")

	return {
		__type = "children",
		children = selector,
		callback = constructor,
	}
end

return setChildren
