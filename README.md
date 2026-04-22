# Chance

Chance is a combination of `Charm` + `Instance`: a declarative approach to `Instance` properties and hierarchy in Roblox with reactivity, animation, and lifecycle management.

## About the project

Chance enables:

- declarative definition of any `Instance` properties
- binding values to reactive computations via `Charm`
- animating properties using `Ripple` (`spring`, `tween`)
- managing child instance lists with `setChildren`
- automatic resource cleanup using scopes (`createScope` / `fastHydrate`)

## Installation

### Wally

```bash
Chance = "alexeylegasov63/chance@latest"
```

## Quick start

```lua
local Chance = require(path.to.Chance)

local part = Instance.new("Part")

local destroy = Chance.fastHydrate(part, {
    Name = "AnimatedPart",
    Position = Vector3.new(0, 5, 0),
    Anchored = true,
})

-- When you need to remove all subscriptions and animations:
destroy()
```

## Main exports

- `Chance.createScope(callback)` — create a scope where cleanup can be registered
- `Chance.fastHydrate(instance, props)` — hydrate an instance and return a destroy function
- `Chance.hydrate(cleanup, instance, props)` — apply properties to an instance within an existing scope
- `Chance.setChildren(selector, constructor)` — declare a list of child `Instance`s
- `Chance.setSpring(callback, config?)` — bind a property to a spring animation
- `Chance.setTween(callback, config?)` — bind a property to a tween animation
- `Chance.derive(value)` — extract a value from a `Derivable`
- `Chance.setRendered`, `Chance.setInterval` — useful hooks (render / heartbeat interval)

## Props format

Chance supports plain values and computed functions.

```lua

local color = Charm.atom(Color3.new(1, 1, 1))
local big = Charm.atom(false)

local props = {
    -- Just values
    Name = "MyPart",
    Transparency = 0.5,
    Position = Vector3.new(1, 2, 3),

    Color = color, -- Computed
    Size = function()  -- Computed
        local isBig = big()
        return Vector3.one * (isBig and 30 or 3)
    end,
}
```

If a value is a function, Chance automatically computes it, subscribes to updates, and applies changes.

### TIP: Computed values are just Charm subscriptions

## Dynamic children

Use `setChildren` to manage a list of child instances.

```lua
local Chance = require(path.to.Chance)

local data = Charm.atom({
    { Name = "A", Position = Vector3.new(0, 5, 0) },
    { Name = "B", Position = Vector3.new(2, 5, 0) },
})

local root = Instance.new("Folder")

local destroy = Chance.fastHydrate(root, {
    Children = Chance.setChildren(function()
        return items
    end, function(data)
        local part = Instance.new("Part")
        part.Name = data.Name
        part.Position = data.Position
        part.Anchored = true
        return part -- Will be destroyed automatically
    end),
})

-- If `items` changes, Chance automatically updates the child instances.
```

### How it works

`setChildren` returns a prepared object with a `selector` and `constructor`.
Chance observes the `selector`, creates an `Instance` for each item, and destroys old objects when the list changes.

## Animation with `spring` and `tween`

Chance integrates `Ripple` for property animation.

```lua
local targetPosition = Vector3.new(0, 10, 0)

local destroy = Chance.fastHydrate(part, {
    Position = Chance.setSpring(function()
        return targetPosition
    end, {
        frequency = 4,
        dampingRatio = 0.8,
    }),
})

-- When targetPosition changes, the spring smoothly moves the part.
```

The `tween` syntax is the same:

```lua
local destroy = Chance.fastHydrate(part, {
    Position = Chance.setTween(function()
        return targetPosition + Vector3.new(1, 0, 3) -- Apply an offset for example
    end, { -- Just different configuration
        duration = 0.5,
        easing = "quadInOut",
    }),
})
```

## Scope management

A scope ensures that all subscriptions and resources are cleaned up when it is destroyed.

```lua
local Chance = require(path.to.Chance)

local destroy = Chance.createScope(function(cleanup)
    local part = Instance.new("Part")
    part.Parent = workspace

    cleanup(Chance.fastHydrate(part, {
        Position = Chance.setRendered(function()
            return Vector3.new(0, math.sin(os.clock()) * 5, 0)
        end),
    }))

    cleanup(function()
        part:Destroy()
    end)

    print("Hello world!")

    cleanup(function()
        print("Bye world!")
    end)
end)

-- When the scope is no longer needed:
destroy()
```

`createScope` passes two functions to the callback:

- `cleanup(item)` — register a resource for automatic cleanup
- `extend(callback)` — create a nested scope within the current one

## Usage examples

### Simple reactive `Part`

```lua
local Chance = require(path.to.Chance)

local position = Charm.atom(Vector3.zero)

local part = Instance.new("Part")
part.Anchored = true
part.Parent = workspace

local destroy = Chance.fastHydrate(part, {
    Position = Chance.setSpring(position, { -- Animated moving
        frequency = 10
    }),
    Color = function()
        local color = if position().Y > 0 then 1 else 0 -- White when above Y 0
        return Color3.new(color, color, color)
    end,
})

-- Move it every second
while task.wait(1) do
    position(Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5)))
end

```

## Why Chance?

Chance is a bridge between reactive `Charm` and Roblox's object model. It makes working with `Instance` declarative, manages the animations and subscriptions automatically.

## Thanks to:

Littensy (https://github.com/littensy) for the amazing libraries: Charm and Ripple :3
