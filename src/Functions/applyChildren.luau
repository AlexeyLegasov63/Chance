--!strict

local validate = require("../Utility/validate")

-- Simply applies children to an instance
local function applyChildren(parent: Instance, children: { Instance })
	validate(type(children) == "table", "Children must be an array")

	for _, child in children do
		validate(typeof(child) == "Instance", "Children must be an array of instances")
		child.Parent = parent
	end
end

return applyChildren
