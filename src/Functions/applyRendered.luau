--!strict
local RunService = game:GetService("RunService")

local Types = require(script.Parent.Parent.Types)

local applyValue = require(script.Parent.applyValue)

local function applyRendered<T>(
	cleanup: Types.Cleanup,
	instance: Instance,
	parameter: string,
	prepared: Types.PreparedRendered<T>
)
	local last = nil

	-- Compute every frame
	cleanup(RunService.RenderStepped:Connect(function()
		local new = prepared.callback()

		if new == last then
			return
		end

		last = new

		applyValue(instance, parameter, new)
	end))
end

return applyRendered
