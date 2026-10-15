--!strict

local RunService = game:GetService("RunService")

local Charm = require("../../Charm")

local Types = require("../Types")

local applyValue = require("./applyValue")
local cleanup = require("./cleanup")

local function applyInterval<T>(instance: Instance, property: Types.PossibleProperty, prepared: Types.PreparedInterval<T>)
	local config = prepared.config

	local interval: number
	-- Resolve interval
	if type(config.interval) == "function" then
		cleanup(Charm.effect(function()
			interval = (config.interval :: Types.Derived<number>)()
		end))
	else
		interval = config.interval :: number
	end

	local accumulator = 0
	local steps = 0

	-- Use renderstepped
	cleanup(RunService.Heartbeat:Connect(function(dt)
		accumulator += dt

		if accumulator < interval then
			return
		end

		steps += 1

		accumulator -= interval
		applyValue(instance, property, prepared.callback(steps))
	end))
end

return applyInterval
