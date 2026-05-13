--!strict

local RunService = game:GetService("RunService")

local Charm = require(script.Parent.Parent.Parent.Charm)
local Types = require(script.Parent.Parent.Types)

local applyValue = require(script.Parent.applyValue)
local isComputed = require(script.Parent.isComputed)

local DEFAULT_FPS = 60

local function applyRendered<T>(
	cleanup: Types.Cleanup,
	instance: Instance,
	parameter: string,
	prepared: Types.PreparedRendered<T>
)
	local config = prepared.config

	local frameTime: number
	if config.fps and isComputed(config.fps) then
		local selector = config.fps :: Types.Derived<number>
		cleanup(Charm.effect(function()
			frameTime = 1 / selector()
		end))
	else
		frameTime = 1 / (config.fps :: number or DEFAULT_FPS)
	end

	local last = nil
	local accumulator = 0 -- FPS accumulator

	local steps = 0

	-- Compute every frame
	cleanup(RunService.RenderStepped:Connect(function(dt)
		accumulator += dt

		-- Skip frames
		if accumulator < frameTime then
			return
		end

		steps += 1

		-- Reset accumulator
		accumulator -= frameTime

		local new = prepared.callback(dt, steps)

		if new == last then
			return
		end

		last = new

		applyValue(instance, parameter, new)
	end))
end

return applyRendered
