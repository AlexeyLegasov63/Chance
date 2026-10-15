--!strict

local Types = require("../Types")

local try = require("../Utility/try")

local applyChildren = require("./applyChildren")
local applyComputed = require("./applyComputed")
local applyComputedChildren = require("./applyComputedChildren")
local applyValue = require("./applyValue")

local isProperty = require("./isProperty")

local blueprints = {
	["spring"] = require("./applySpring"),
	["tween"] = require("./applyTween"),
	["interval"] = require("./applyInterval"),
	["rendered"] = require("./applyRendered"),
}

--[[
    Hydrates an instance with properties
    @param instance The instance to hydrate
    @param props The properties to hydrate
]]
local function hydrate(instance: Instance, props: { [Types.PossibleProperty]: any })
	for k: Types.PossibleProperty, v: any in props do
		try(function()
			-- Apply children
			if k == "Children" or k == "children" then
				if type(v) == "table" then
					applyComputedChildren(instance, v) -- Children are computed
				else
					applyChildren(instance, v) -- Just a table
				end
				return
			elseif not isProperty(instance, k) then -- Ignore parameters
				warn(`Ignored unknown property {k} for {instance.Name}`)
				return
			end

			-- Apply property
			if type(v) == "function" then
				applyComputed(instance, k, v)
			elseif type(v) == "table" then
				local blueprint = blueprints[(v :: Types.Prepared).__type]
				if blueprint then
					blueprint(instance, k, v)
				else
					warn(`Ignored unknown property {k} for {instance.Name}`)
				end
			else
				applyValue(instance, k, v)
			end
		end, `Failed to apply property {k} for {instance.Name}`)
	end
end

return hydrate
