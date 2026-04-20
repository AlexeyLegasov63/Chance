--!strict

-- Applies a value to an instance
local function applyValue<T>(instance: Instance, parameter: string, value: T)
	(instance :: any)[parameter] = value
end

return applyValue
