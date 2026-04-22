--!strict

local Charm = require(script.Parent.Parent.Parent.Charm)
local Types = require(script.Parent.Parent.Types)
local validate = require(script.Parent.Parent.Utility.validate)

-- Observes children and applies them to an instance, destroying them when they change
local function applyComputedChildren<K, V>(cleanup: Types.Cleanup, parent: Instance, prepared: Types.PreparedChildren<K, V>)
	local weak = setmetatable({}, { __mode = "k" }) :: { [Instance]: boolean }

	cleanup(Charm.observe(prepared.children, function(value: V, key: K)
		local instance = prepared.callback(value, key)
		validate(
			typeof(instance) == "Instance",
			"Only instances are supported, please ensure that the callback returns a valid instance"
		)

		-- Ignore instances that are already parented somewhere :/
		if not instance.Parent then
			instance.Parent = parent
		end

		-- Let's track the instance without a strong reference
		weak[instance] = true

		return function()
			instance:Destroy()
		end
	end))

	-- And clean up when the scope is destroyed
	cleanup(function()
		for instance in pairs(weak) do
			local ok, err = pcall(instance.Destroy, instance)

			if not ok then
				warn(err)
			end
		end
	end)
end

return applyComputedChildren
