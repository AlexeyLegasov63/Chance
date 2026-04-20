--!strict

local root = script.Parent

local Types = require(root.Parent.Types)

local try = require(root.Parent.Utility.try)

local applyChildren = require(root.applyChildren)
local applyComputed = require(root.applyComputed)
local applyValue = require(root.applyValue)

local applyInterval = require(root.applyInterval)
local applyRendered = require(root.applyRendered)
local applySpring = require(root.applySpring)
local applyTween = require(root.applyTween)

local isComputed = require(root.isComputed)
local isParameter = require(root.isParameter)

local isInterval = require(root.isInterval)
local isRendered = require(root.isRendered)
local isSpring = require(root.isSpring)
local isTween = require(root.isTween)
--[[
    Hydrates an instance with properties
    @param instance The instance to hydrate
    @param props The properties to hydrate
]]
local function hydrate(cleanup: Types.Cleanup, instance: Instance, props: Types.Attributes)
	for k: string, v: any in props do
		try(function()
			-- Apply children
			if k == "_Children" or k == "_children" then
				applyChildren(instance, v)
				return
			elseif not isParameter(instance, k) then -- Ignore parameters
				warn(`Ignored unknown property {k} for {instance.Name}`)
				return
			end

			-- Apply property
			if isComputed(v) then
				applyComputed(cleanup, instance, k, v)
			elseif isRendered(v) then
				applyRendered(cleanup, instance, k, v)
			elseif isInterval(v) then
				applyInterval(cleanup, instance, k, v)
			elseif isSpring(v) then
				applySpring(cleanup, instance, k, v)
			elseif isTween(v) then
				applyTween(cleanup, instance, k, v)
			else
				applyValue(instance, k, v)
			end
		end, `Failed to apply property {k} for {instance.Name}`)
	end
end

return hydrate
