--!strict
local RunService = game:GetService("RunService")

local Charm = require(script.Parent.Parent.Packages.Charm)
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

	local acumulator = 0

	-- Use renderstepped
	cleanup(RunService.RenderStepped:Connect(function(dt)
		acumulator += dt

		if acumulator < interval then
			return
		end

		acumulator -= interval
		applyValue(instance, parameter, prepared.callback())
	end))
end

return applyInterval
