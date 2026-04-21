--!strict
local Cleaner = require(script.Parent.Parent.Classes.Cleaner)
local Types = require(script.Parent.Parent.Types)

local try = require(script.Parent.Parent.Utility.try)

local function createScopeWith(cleaner: Types.Cleaner, callback: Types.ScopeUser): Types.Destroy
	-- Add an item to the scope
	local function cleanup<T>(t: T): T
		return cleaner:add(t)
	end

	-- Create a subscope, that will be cleaned up with the main scope
	local function extend(callback: Types.ScopeUser): Types.Destroy
		local subCleaner = cleaner:extend()
		return createScopeWith(subCleaner, callback)
	end

	-- Lend it to the callback
	try(callback, "Failed to create scope", cleanup, extend)

	-- Return the cleanup function
	return function()
		cleaner:cleanup()
	end
end

--[[
    Create a scope that will be cleaned up when destroyed
    @param callback The callback function that will receive the cleanup and extend functions
    @return A destroy function
]]
local function createScope(callback: Types.ScopeUser): Types.Destroy
	return createScopeWith(Cleaner.new(), callback)
end

return createScope :: Types.Scope
