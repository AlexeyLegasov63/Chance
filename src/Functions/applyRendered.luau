--!strict

local RunService = game:GetService("RunService")

local Types = require(script.Parent.Parent.Types)

local applyValue = require(script.Parent.applyValue)

local DEFAULT_FPS = 60

local function applyRendered<T>(
	cleanup: Types.Cleanup,
	instance: Instance,
	parameter: string,
	prepared: Types.PreparedRendered<T>
)
	local targetFps = prepared.fps or DEFAULT_FPS
	local frameTime = 1 / targetFps

	local last = nil
	local accumulator = 0 -- FPS accumulator

	-- Compute every frame
	cleanup(RunService.RenderStepped:Connect(function(dt)
		accumulator += dt

		-- Skip frames
		if accumulator < frameTime then
			return
		end

		-- Reset accumulator
		accumulator -= frameTime

		local new = prepared.callback(dt)

		if new == last then
			return
		end

		last = new

		applyValue(instance, parameter, new)
	end))
end

return applyRendered
