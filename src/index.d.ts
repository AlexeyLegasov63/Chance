import { Animatable, SpringOptions, TweenOptions } from "@rbxts/ripple";

type CommonOptions = {
  readonly disabled?: Derived<boolean>;
};

type RenderedOptions = CommonOptions & {
  readonly fps?: Derivable<number>;
};

type IntervalOptions = CommonOptions & {
  readonly interval: Derivable<number>;
};

type PreparedSpring<T extends Animatable = any> = {
  readonly __type: "spring";
  readonly callback: Derived<T>;
  readonly config?: SpringOptions<T>;
};

type PreparedTween<T extends Animatable = any> = {
  readonly __type: "tween";
  readonly callback: Derived<T>;
  readonly config?: TweenOptions<T>;
};

type PreparedInterval<T> = {
  readonly __type: "interval";
  readonly callback: (steps: number) => T;
  readonly config: IntervalOptions;
};

type PreparedRendered<T> = {
  readonly __type: "rendered";
  readonly callback: (
    deltaTime: number,
    steps: number,
    accumulator: number,
  ) => T;
  readonly config: RenderedOptions;
};

type PreparedChildren<K, V> = {
  readonly __type: "children";
  readonly children: () => Map<K, V>;
  readonly callback: (value: V, key: K) => Instance;
};

/**
 * Represents a function that returns a value
 */
export type Derived<T> = () => T;

/**
 * Represents a value or a function that returns a value
 */
export type Derivable<T> = T | Derived<T>;

/**
 * Types that can be used as a cleanup task
 */
type CleanerTask =
  | Partial<{
      destroy: () => void;
      Destroy: () => void;
      cancel: () => void;
      Cancel: () => void;
      cleanup: () => void;
      Cleanup: () => void;
      disconnect: () => void;
      Disconnect: () => void;
    }>
  | Instance
  | RBXScriptConnection
  | thread
  | Callback;

/**
 * Represents a cleanup function that adds the task to the cleanup list and returns it back
 */
export type Cleanup = <T extends CleanerTask>(t: T) => T;

/**
 * Represents a function that destroys the scope
 */
export type Destroy = () => void;

/**
 * Represents a function that creates a scope
 */
export type Scope = (user: ScopeUser) => Destroy;

/**
 * Represents a function that receives the cleanup and extend functions
 */
export type ScopeUser = (cleanup: Cleanup, extend: Scope) => void;

/**
 * Represents the default properties of an instance
 * @template I The type of the instance
 */
export type DefaultProperties<I extends Instance> = {
  [K in keyof I]:
    | Derivable<I[K]>
    | PreparedInterval<I[K]>
    | PreparedRendered<I[K]>
    | PreparedSpring<I[K] | any>
    | PreparedTween<I[K] | any>;
};

/**
 * Represents the properties of an instance that can be hydrated
 */
export type Properties<I extends Instance> = DefaultProperties<I> & {
  Children?: Derivable<Instance[]> | PreparedChildren<any, any>;
};

/**
 * Creates a new scope that will be destroyed when the callback returns
 * @param callback The callback function that will receive the cleanup and extend functions
 * @returns A function that will destroy the scope
 */
export function createScope(callback: ScopeUser): Destroy;

/**
 * Hydrates an instance with properties
 * @param cleanup The cleanup function of the scope
 * @param instance The instance to hydrate
 * @param props The properties to hydrate
 */
export function hydrate(
  cleanup: Cleanup,
  instance: Instance,
  props: Properties<Instance>,
): void;

/**
 * Hydrates an instance with properties without manually creating a scope
 * @param instance The instance to hydrate
 * @param props The properties to hydrate
 */
export function fastHydrate<I extends Instance>(
  instance: I,
  props: Properties<I>,
): Destroy;

/**
 * Creates a prepared children selector
 * @param selector A function that returns an array or table of data
 * @param constructor A function that creates an instance from each data node
 * @returns A prepared children selector
 */
export function setChildren<K, V>(
  selector: Derivable<Map<K, V>>,
  constructor: (value: V, key: K) => Instance,
): PreparedChildren<K, V>;

/**
 * Creates a declarative, reactive interval task
 * @param callback A function that returns a value
 * @param config An optional interval configuration
 * @returns A prepared interval blueprint
 */
export function setInterval<T>(
  callback: Derived<T>,
  config: IntervalOptions,
): PreparedInterval<T>;

/**
 * Creates a declarative, reactive spring task
 * @param callback A function that returns a value
 * @param config An optional spring configuration
 * @returns A prepared spring blueprint
 */
export function setSpring<T extends Animatable = any>(
  callback: Derived<T>,
  config?: SpringOptions<T>,
): PreparedSpring<T>;

/**
 * Creates a declarative, reactive tween task
 * @param callback A function that returns a value
 * @param config An optional tween configuration
 * @returns A prepared tween blueprint
 */
export function setTween<T extends Animatable = any>(
  callback: Derived<T>,
  config?: TweenOptions<T>,
): PreparedTween<T>;

/**
 * Creates a declarative, reactive render hook
 * @param callback A function that returns a value
 * @param config An optional render hook configuration
 * @returns A prepared render hook blueprint
 */
export function setRendered<T>(
  callback: (dt: number, st: number) => T,
  config?: RenderedOptions,
): PreparedRendered<T>;

/**
 * Derives a value, whether it's a function or just a value
 * @param deriveable The value to derive
 * @return The derived value
 */
export function derive<T>(deriveable?: Derivable<T>): T;
