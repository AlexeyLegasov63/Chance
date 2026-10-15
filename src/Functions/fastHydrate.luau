--!strict

local Types = require("../Types")

local createScope = require("./createScope")
local hydrate = require("./hydrate")

--[[
    Hydrates an instance with properties without manually creating a scope

    @param instance The instance to hydrate
    @param props The properties to hydrate
    @return A destroy function
]]
local function fastHydrate(instance: Instance, props: any): Types.Destroy
	return createScope(function()
		hydrate(instance, props)
	end)
end

return fastHydrate
