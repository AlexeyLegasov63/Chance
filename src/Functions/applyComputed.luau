--!strict

local Charm = require("../../Charm")
local Types = require("../Types")

local try = require("../Utility/try")

local applyValue = require("./applyValue")
local cleanup = require("./cleanup")

-- Applies a computed value to an instance after every change
local function applyComputed<T>(instance: Instance, property: Types.PossibleProperty, derived: Types.Derived<T>)
	local ok = try(function()
		applyValue(instance, property, derived())
	end, `Failed to apply initial computed value {property} to {instance.Name}`)

	if not ok then
		return -- We're cooked
	end

	-- Add subscription to cleanup
	cleanup(Charm.subscribe(derived, function(value)
		applyValue(instance, property, value)
	end))
end

return applyComputed
