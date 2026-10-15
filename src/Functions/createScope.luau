--!strict

local Types = require("../Types")
local Graph = require("../Graph")

local try = require("../Utility/try")
local validate = require("../Utility/validate")

local refs = {} -- Keep strong references

--[[
    Create a scope that will be cleaned up when destroyed
    @param callback The callback function that will receive the cleanup and extend functions
    @return A destroy function
]]
local function createScope(callback: (destroy: () -> ()) -> ()): Types.Destroy
	local node = Graph.createNode()

	refs[node] = true

	local destroy = function()
		validate(refs[node] ~= nil, "Scope is already destroyed")
		refs[node] = nil
		Graph.destroyNode(node)
	end

	Graph.pushScope(node)
	try(callback, "Failed to create scope", destroy)
	Graph.popScope()

	return destroy
end

return createScope
