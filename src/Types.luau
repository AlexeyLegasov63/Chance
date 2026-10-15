---------------- RIPPLE ----------------

local RippleTypes = require(script.Parent.RippleTypes)

export type Easing = RippleTypes.Easing

export type TweenOptions<T> = RippleTypes.TweenOptions<T>

export type SpringOptions<T> = RippleTypes.SpringOptions<T>

---------------------------------------

export type CommonOptions = {
	disabled: Derived<boolean>?,
}

export type RenderedOptions = CommonOptions & {
	fps: Derivable<number>?,
}

export type IntervalOptions = CommonOptions & {
	interval: Derivable<number>,
}

export type Prepared = {
	__type: string,
}

export type PreparedSpring<T> = {
	__type: "spring",
	callback: Derived<T>,
	config: SpringOptions<T>?,
}

export type PreparedTween<T> = {
	__type: "tween",
	callback: Derived<T>,
	config: TweenOptions<T>?,
}

export type PreparedInterval<T> = {
	__type: "interval",
	callback: (steps: number) -> T,
	config: IntervalOptions,
}

export type PreparedRendered<T> = {
	__type: "rendered",
	callback: (delta: number, steps: number, accumulated: number) -> T,
	config: RenderedOptions,
}

export type PreparedChildren<K, V> = {
	__type: "children",
	children: () -> { [K]: V },
	callback: (value: V, key: K) -> Instance?,
}

---------------------------------------

export type Derived<T> = () -> T

export type Derivable<T> = T | Derived<T>

---------------------------------------

export type InstanceAttribute = {
	__attribute: string,
}

export type PossibleProperty = InstanceAttribute | string

---------------------------------------

export type Cleaner = {
	add: <T>(self: Cleaner, item: T) -> T,
	cleanup: (self: Cleaner) -> (),
	extend: (self: Cleaner) -> Cleaner,
}

---------------------------------------

--[[
    Possible cleanup task
]]
export type CleanupTask = {
	destroy: (() -> ())?,
	Destroy: (() -> ())?,
	cancel: (() -> ())?,
	Cancel: (() -> ())?,
	cleanup: (() -> ())?,
	Cleanup: (() -> ())?,
	disconnect: (() -> ())?,
	Disconnect: (() -> ())?,
} | Instance | RBXScriptConnection | thread | () -> ()

--[[
    Cleanup function
]]
export type Destroy = () -> ()

return 0
