--!strict
local Charm = require(script.Parent.Parent.Packages.Charm)
local Types = require(script.Parent.Parent.Types)

local try = require(script.Parent.Parent.Utility.try)

local applyValue = require(script.Parent.applyValue)

-- Applies a computed value to an instance after every change
local function applyComputed<T>(cleanup: Types.Cleanup, instance: Instance, parameter: string, derived: Types.Derived<T>)
	local ok = try(function()
		applyValue(instance, parameter, derived())
	end, `Failed to apply initial computed value {parameter} to {instance.Name}`)

	if not ok then
		return -- We're cooked
	end

	-- Add subscription to cleanup
	cleanup(Charm.subscribe(derived, function(value)
		applyValue(instance, parameter, value)
	end))
end

return applyComputed
