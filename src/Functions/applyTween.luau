--!strict

local Charm = require("../../Charm")
local Ripple = require("../../Ripple")

local Types = require("../Types")

local applyValue = require("./applyValue")
local cleanup = require("./cleanup")

local function applyTween<T>(instance: Instance, property: Types.PossibleProperty, prepared: Types.PreparedTween<T>)
	-- Compute initial value
	local initial = prepared.callback()
	local tween = Ripple.createTween(initial, prepared.config)

	-- Apply starting value
	applyValue(instance, property, initial)

	-- Start tweening
	tween:onChange(function(value)
		applyValue(instance, property, value)
	end)
	tween:start()

	-- Update tween target
	cleanup(Charm.subscribe(prepared.callback, function(value)
		tween:setGoal(value)
	end))

	-- Cleanup
	cleanup(tween)

	-- Return initial value
	cleanup(function()
		applyValue(instance, property, initial)
	end)
end

return applyTween
