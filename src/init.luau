local Types = require("@self/Types")

local attribute = require("@self/Functions/attribute")

local createScope = require("@self/Functions/createScope")
local subScope = require("@self/Functions/subScope")
local cleanup = require("@self/Functions/cleanup")

local hydrate = require("@self/Functions/hydrate")
local fastHydrate = require("@self/Functions/fastHydrate")

local setChildren = require("@self/Functions/setChildren")
local setInterval = require("@self/Functions/setInterval")
local setRendered = require("@self/Functions/setRendered")
local setSpring = require("@self/Functions/setSpring")
local setTween = require("@self/Functions/setTween")

local derive = require("@self/Functions/derive")

export type Derivable<T> = Types.Derivable<T>
export type Derived<T> = Types.Derived<T>

export type SpringOptions<T> = Types.SpringOptions<T>
export type TweenOptions<T> = Types.TweenOptions<T>

export type Easing = Types.Easing

export type CleanupTask = Types.CleanupTask
export type Destroy = Types.Destroy

return {
	attribute = attribute,
	createScope = createScope,
	subScope = subScope,
	cleanup = cleanup,
	hydrate = hydrate,
	fastHydrate = fastHydrate,
	setChildren = setChildren,
	setInterval = setInterval,
	setRendered = setRendered,
	setSpring = setSpring,
	setTween = setTween,
	derive = derive,
}
