--!strict

local Types = require("./Types")
local try = require("./Utility/try")

local CLEANER_ALLOWED_TYPES = {
	["Instance"] = true,
	["RBXScriptConnection"] = true,
	["thread"] = true,
	["table"] = true,
	["function"] = true,
}

local CLEANER_CLEAN_METHODS = {
	"Cancel",
	"cancel",
	"Cleanup",
	"cleanup",
	"Destroy",
	"destroy",
	"Disconnect",
	"disconnect",
}

--[[
    Checks if a value is 'cleanable' (has a Destroy/Disconnect method or is a thread/connection).
    @param value The value to check
    @return True if the value can be cleaned up, otherwise false
]]
local function checkIfCleanable(value: any): boolean
	local primaryType = type(value)

	-- Check custom types
	if primaryType == "table" then
		for _, method in CLEANER_CLEAN_METHODS do
			if not value[method] then
				continue
			end

			return true
		end

		return false
	end

	return CLEANER_ALLOWED_TYPES[primaryType] -- For primitive types
		or CLEANER_ALLOWED_TYPES[typeof(value) :: any] -- For Roblox types
end

--[[
    Clears a cleanable item (RBXScriptConnection, Instance, Thread, etc.)
    @param item The item to be cleaned up
]]
local function clearItem(item: any)
	local primaryType = type(item)

	if primaryType == "function" then
		item() -- Call the function
		return
	elseif primaryType == "thread" then
		task.cancel(item) -- Cancel the thread

		local cancelled
		if coroutine.running() ~= item then
			cancelled = pcall(function()
				task.cancel(item)
			end)
		end

		if not cancelled then
			local toCancel = item
			task.defer(function()
				task.cancel(toCancel)
			end)
		end

		return
	elseif primaryType == "table" then
		for _, method in CLEANER_CLEAN_METHODS do
			if not item[method] then
				return
			end

			item[method](item) -- Call the method

			return
		end
	end

	local secondaryType = typeof(item)

	if secondaryType == "RBXScriptConnection" then
		item:Disconnect()
	elseif secondaryType == "Instance" then
		item:Destroy()
	end
end

local function cleanup(tasks: { Types.CleanupTask })
	-- Clear the garbage list
	local index, item = next(tasks)
	while item ~= nil do
		tasks[index :: number] = nil

		try(clearItem, "Unable to clean up the item", item)

		index, item = next(tasks)
	end
end

return {
	checkIfCleanable = checkIfCleanable,
	cleanup = cleanup,
}
