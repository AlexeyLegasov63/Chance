local Types = require(script.Types)

local functions = script.Functions

local createScope = require(functions.createScope)

local hydrate = require(functions.hydrate)
local fastHydrate = require(functions.fastHydrate)

local setChildren = require(functions.setChildren)
local setInterval = require(functions.setInterval)
local setRendered = require(functions.setRendered)
local setSpring = require(functions.setSpring)
local setTween = require(functions.setTween)

local derive = require(functions.derive)

export type Derivable<T> = Types.Derivable<T>
export type Derived<T> = Types.Derived<T>

export type SpringOptions<T> = Types.SpringOptions<T>
export type TweenOptions<T> = Types.TweenOptions<T>

export type Easing = Types.Easing

export type Attributes = Types.Attributes

export type Cleanup = Types.Cleanup
export type Scope = Types.Scope
export type ScopeUser = Types.ScopeUser
export type Destroy = Types.Destroy

return {
	createScope = createScope,
	hydrate = hydrate,
	fastHydrate = fastHydrate,
	setChildren = setChildren,
	setInterval = setInterval,
	setRendered = setRendered,
	setSpring = setSpring,
	setTween = setTween,
	derive = derive,
}
