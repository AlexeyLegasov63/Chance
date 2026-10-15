--!strict

local Graph = require("../Graph")
local validate = require("../Utility/validate")

--[[
    Pushes a cleanup task to the current scope
    @param t A cleanup task
    @return The cleanup task
]]
local function cleanup<T>(t: T): T
	local node = Graph.currentScope()
	validate(node ~= nil, "Cannot cleanup outside a scope")

	-- Push cleanup task
	Graph.pushCleanup(node :: Graph.Node, t)

	return t
end

return cleanup
