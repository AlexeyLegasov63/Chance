--!strict

local Charm = require("../../Charm")
local Ripple = require("../../Ripple")

local Types = require("../Types")

local applyValue = require("./applyValue")
local cleanup = require("./cleanup")

local function applySpring<T>(instance: Instance, property: Types.PossibleProperty, prepared: Types.PreparedSpring<T>)
	-- Compute initial value
	local initial = prepared.callback()
	local spring = Ripple.createSpring(initial, prepared.config)

	-- Apply starting value
	applyValue(instance, property, initial)

	-- Start spring
	spring:onChange(function(value: T)
		applyValue(instance, property, value)
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
		applyValue(instance, property, initial)
	end)
end

return applySpring
