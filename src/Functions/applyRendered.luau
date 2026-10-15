--!strict

local RunService = game:GetService("RunService")

local Charm = require("../../Charm")

local Types = require("../Types")

local applyValue = require("./applyValue")
local cleanup = require("./cleanup")

local DEFAULT_FPS = 60

local function applyRendered<T>(instance: Instance, property: Types.PossibleProperty, prepared: Types.PreparedRendered<T>)
	local config = prepared.config

	local frameTime: number
	if config.fps and type(config.fps) == "function" then
		local selector = config.fps :: Types.Derived<number>
		cleanup(Charm.effect(function()
			frameTime = 1 / selector()
		end))
	else
		frameTime = 1 / (config.fps :: number or DEFAULT_FPS)
	end

	local last = nil
	local accumulator = 0 -- FPS accumulator
	local permaAccumulator = 0

	local steps = 0

	-- Compute every frame
	cleanup(RunService.RenderStepped:Connect(function(dt)
		accumulator += dt
		permaAccumulator += dt

		-- Skip frames
		if accumulator < frameTime then
			return
		end

		steps += 1

		-- Reset accumulator
		accumulator -= frameTime

		local new = prepared.callback(dt, steps, permaAccumulator)

		if new == last then
			return
		end

		last = new

		applyValue(instance, property, new)
	end))
end

return applyRendered
