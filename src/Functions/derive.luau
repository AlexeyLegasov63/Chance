--!strict
local Types = require(script.Parent.Parent.Types)

local isComputed = require(script.Parent.isComputed)

--[[
    Derives a value, whether it's a function or just a value
    @param deriveable The value to derive
    @return The derived value
]]
local function derive<T>(deriveable: Types.Derivable<T>?): T?
	if not deriveable then
		return nil
	end
	local value = deriveable
	if isComputed(value) then
		value = (value :: Types.Derived<T>)()
	end
	return value
end

return derive
