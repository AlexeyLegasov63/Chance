export type Easing =
	| "linear"
	| "instant"
	| "smoothstep"
	| "sineIn"
	| "sineOut"
	| "sineInOut"
	| "backIn"
	| "backOut"
	| "backInOut"
	| "quadIn"
	| "quadOut"
	| "quadInOut"
	| "quartIn"
	| "quartOut"
	| "quartInOut"
	| "quintIn"
	| "quintOut"
	| "quintInOut"
	| "bounceIn"
	| "bounceOut"
	| "bounceInOut"
	| "elasticIn"
	| "elasticOut"
	| "elasticInOut"
	| "expoIn"
	| "expoOut"
	| "expoInOut"
	| "circIn"
	| "circOut"
	| "circInOut"
	| "cubicIn"
	| "cubicOut"
	| "cubicInOut"

export type TweenOptions<Value = any> = {
	start: boolean?,
	easing: Easing?,
	duration: number?,
	repeats: number?,
	reverses: boolean?,
	position: Value?,
}

export type SpringOptions<Value = any> = {
	start: boolean?,
	tension: number?,
	friction: number?,
	mass: number?,
	dampingRatio: number?,
	frequency: number?,
	precision: number?,
	restVelocity: number?,
	position: Value?,
	velocity: Value?,
	impulse: Value?,
}

return 0
