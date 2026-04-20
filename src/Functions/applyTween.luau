--!strict

local Charm = require(script.Parent.Parent.Packages.Charm)
local Ripple = require(script.Parent.Parent.Packages.Ripple)
local Types = require(script.Parent.Parent.Types)

local applyValue = require(script.Parent.applyValue)

local function applyTween<T>(
	cleanup: Types.Cleanup,
	instance: Instance,
	parameter: string,
	prepared: Types.PreparedTween<T>
)
	-- Compute initial value
	local initial = prepared.callback()
	local tween = Ripple.createTween(initial, prepared.config)

	-- Apply starting value
	applyValue(instance, parameter, initial)

	-- Start tweening
	tween:onChange(function(value)
		applyValue(instance, parameter, value)
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
		applyValue(instance, parameter, initial)
	end)
end

return applyTween
