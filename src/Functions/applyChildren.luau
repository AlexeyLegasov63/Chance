--!strict

local validate = require(script.Parent.Parent.Utility.validate)

-- Simply applies children to an instance
local function applyChildren(parent: Instance, children: { Instance })
	validate(type(children) == "table", "Children must be an array")

	for _, child in children do
		child.Parent = parent
	end
end

return applyChildren
