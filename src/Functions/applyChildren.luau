--!strict

-- Applies children to an instance
local function applyChildren(parent: Instance, children: { Instance })
	for _, child in children do
		child.Parent = parent
	end
end

return applyChildren
