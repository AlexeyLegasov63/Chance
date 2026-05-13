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
	callback: Derived<T>,
	config: IntervalOptions,
}

export type PreparedRendered<T> = {
	__type: "rendered",
	callback: (deltaTime: number, steps: number) -> T,
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

export type Attributes = {
	[any]: any,
}

---------------------------------------

export type Cleaner = {
	add: <T>(self: Cleaner, item: T) -> T,
	cleanup: (self: Cleaner) -> (),
	extend: (self: Cleaner) -> Cleaner,
}

---------------------------------------

export type Cleanup = <T>(t: T) -> T

export type Destroy = () -> ()

export type Scope = (ScopeUser) -> Destroy

export type ScopeUser = (cleanup: Cleanup, extend: Scope) -> ()

return 0
