--!strict

local RunService = game:GetService("RunService")

local Charm = require(script.Parent.Parent.Parent.Charm)
local Types = require(script.Parent.Parent.Types)

local applyValue = require(script.Parent.applyValue)
local isComputed = require(script.Parent.isComputed)

local function applyInterval<T>(
	cleanup: Types.Cleanup,
	instance: Instance,
	parameter: string,
	prepared: Types.PreparedInterval<T>
)
	local interval: number

	-- Resolve interval
	if isComputed(prepared.interval) then
		cleanup(Charm.effect(function()
			interval = (prepared.interval :: Types.Derived<number>)()
		end))
	else
		interval = prepared.interval :: number
	end

	local accumulator = 0

	-- Use renderstepped
	cleanup(RunService.Heartbeat:Connect(function(dt)
		accumulator += dt

		if accumulator < interval then
			return
		end

		accumulator -= interval
		applyValue(instance, parameter, prepared.callback())
	end))
end

return applyInterval
