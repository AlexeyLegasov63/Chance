--!strict

local Types = require(script.Parent.Parent.Types)

local createScope = require(script.Parent.createScope)
local hydrate = require(script.Parent.hydrate)

--[[
    Hydrates an instance with properties without manually creating a scope

    @param instance The instance to hydrate
    @param props The properties to hydrate
    @return A destroy function
]]
local function fastHydrate(instance: Instance, props: Types.Attributes): Types.Destroy
	return createScope(function(cleanup)
		hydrate(cleanup, instance, props)
	end)
end

return fastHydrate
