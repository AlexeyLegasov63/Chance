--!strict

local Types = require("../Types")

--[[
    Derives a value, whether it's a function or just a value
    @param derivable The value to derive
    @return The derived value
]]
local function derive<T>(derivable: Types.Derivable<T>?): T?
	if not derivable then
		return nil
	end
	local value = derivable
	if type(value) == "function" then
		value = (value :: Types.Derived<T>)()
	end
	return value
end

return derive
