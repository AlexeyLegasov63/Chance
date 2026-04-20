local functions = script.Functions

local Types = require(script.Types)
local createScope = require(functions.createScope)

local hydrate = require(functions.hydrate)
local fastHydrate = require(functions.fastHydrate)

local setInterval = require(functions.setInterval)
local setRendered = require(functions.setRendered)
local setSpring = require(functions.setSpring)
local setTween = require(functions.setTween)

export type Derivable<T> = Types.Derivable<T>
export type Derived<T> = Types.Derived<T>

export type SpringOptions<T> = Types.SpringOptions<T>
export type TweenOptions<T> = Types.TweenOptions<T>

export type Easing = Types.Easing

export type Attributes = Types.Attributes

export type Cleanup = Types.Cleanup
export type ExtendScope = Types.ExtendScope
export type Destroy = Types.Destroy

return {
	createScope = createScope,
	hydrate = hydrate,
	fastHydrate = fastHydrate,
	setInterval = setInterval,
	setRendered = setRendered,
	setSpring = setSpring,
	setTween = setTween,
}
