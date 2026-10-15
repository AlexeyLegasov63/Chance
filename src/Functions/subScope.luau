--!strict

local Types = require("../Types")
local Graph = require("../Graph")

local try = require("../Utility/try")
local validate = require("../Utility/validate")

--[[
    Create a scope that will be cleaned up when destroyed
    @param callback The callback function that will receive the cleanup and extend functions
    @return A destroy function
]]
local function subScope(callback: (destroy: () -> ()) -> ()): Types.Destroy
	local current = Graph.currentScope()
	validate(current ~= nil, "There is no current scope, call createScope first")

	local node = Graph.createNode(current)

	local destroy = function()
		Graph.destroyNode(node)
	end

	Graph.pushScope(node)
	try(callback, "Failed to create scope", destroy)
	Graph.popScope()

	return destroy
end

return subScope
