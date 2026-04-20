--!strict
local Cleaner = require(script.Parent.Parent.Classes.Cleaner)
local Types = require(script.Parent.Parent.Types)

local try = require(script.Parent.Parent.Utility.try)

--[[
    Create a scope that will be cleaned up when destroyed
    @param callback The callback function that will receive the cleanup and extend functions
    @return A destroy function
]]
local function createScope(callback: (cleanup: Types.Cleanup, extend: Types.ExtendScope) -> ()): Types.Destroy
	local cleaner = Cleaner.new()

	-- Add an item to the scope
	local function cleanup<T>(t: T): T
		return cleaner:add(t)
	end

	-- Create a subscope, that will be cleaned up with the main scope
	local function extend(): Types.Cleanup
		local subCleaner = cleaner:extend()
		return function(t: any)
			return subCleaner:add(t)
		end
	end

	-- Lend it to the callback
	try(callback, "Failed to create scope", cleanup, extend)

	-- Return the cleanup function
	return function()
		cleaner:cleanup()
	end
end

return createScope
