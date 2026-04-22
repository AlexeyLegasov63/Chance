---------------- RIPPLE ----------------

local RippleTypes = require(script.Parent.RippleTypes)

export type Easing = RippleTypes.Easing

export type TweenOptions<T> = RippleTypes.TweenOptions<T>

export type SpringOptions<T> = RippleTypes.SpringOptions<T>

---------------------------------------

export type PreparedSpring<T> = {
	__type: "spring",
	callback: Derived<T>,
	config: RippleTypes.SpringOptions?,
}

export type PreparedTween<T> = {
	__type: "tween",
	callback: Derived<T>,
	config: RippleTypes.TweenOptions?,
}

export type PreparedInterval<T> = {
	__type: "interval",
	callback: Derived<T>,
	interval: Derivable<number>,
}

export type PreparedRendered<T> = {
	__type: "rendered",
	callback: (deltaTime: number) -> T,
	fps: number?,
}

export type PreparedChildren<K, V> = {
	__type: "children",
	children: () -> { [K]: V },
	callback: (value: V, key: K) -> Instance,
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
