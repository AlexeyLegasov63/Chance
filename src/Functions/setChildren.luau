--!strict

local Types = require(script.Parent.Parent.Types)

--[[
    Observes children and applies them to an instance, destroying them automatically

    @param selector A function that returns an array or table of data
    @param constructor A function that creates an instance from each data node

    @return The prepared children
]]
local function setChildren<K, V>(selector: () -> { [K]: V }, constructor: (V, K) -> Instance): Types.PreparedChildren<K, V>
	return {
		__type = "children",
		children = selector,
		callback = constructor,
	}
end

return setChildren
