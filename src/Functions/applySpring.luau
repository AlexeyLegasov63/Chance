--!strict

local Charm = require(script.Parent.Parent.Parent.Charm)
local Ripple = require(script.Parent.Parent.Parent.Ripple)
local Types = require(script.Parent.Parent.Types)

local applyValue = require(script.Parent.applyValue)

local function applySpring<T>(
	cleanup: Types.Cleanup,
	instance: Instance,
	parameter: string,
	prepared: Types.PreparedSpring<T>
)
	-- Compute initial value
	local initial = prepared.callback()
	local spring = Ripple.createSpring(initial, prepared.config)

	-- Apply starting value
	applyValue(instance, parameter, initial)

	-- Start spring
	spring:onChange(function(value: T)
		applyValue(instance, parameter, value)
	end)
	spring:start()

	-- Update spring target
	cleanup(Charm.subscribe(prepared.callback, function(value)
		spring:setGoal(value)
	end))

	-- Destroy spring on cleanup
	cleanup(spring)

	-- Return initial value
	cleanup(function()
		applyValue(instance, parameter, initial)
	end)
end

return applySpring
