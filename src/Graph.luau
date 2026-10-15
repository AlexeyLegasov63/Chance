--!strict

local Cleaner = require("./Cleaner")
local Types = require("./Types")

export type Node = {
	destroyed: boolean?,
	subs: { Node }?,
	cleanups: { Types.CleanupTask }?,
}

local scopes = { n = 0 } :: { [number]: Node, n: number }

local function currentScope(): Node?
	return scopes[scopes.n]
end

local function pushScope(node: Node)
	local n = scopes.n + 1
	scopes.n = n
	scopes[n] = node
end

local function popScope()
	local n = scopes.n
	scopes.n = n - 1
	scopes[n] = nil
end

local function pushCleanup(node: Node, cleanup: Types.CleanupTask)
	if node.cleanups then
		table.insert(node.cleanups, cleanup)
	else
		node.cleanups = { cleanup }
	end
end

local function destroyNode(node: Node)
	if node.destroyed then
		return -- already destroyed
	end
	node.destroyed = true
	if node.cleanups then
		Cleaner.cleanup(node.cleanups)
	end
	if node.subs then
		for _, sub in node.subs do
			destroyNode(sub)
		end
	end
end

local function createNode(parent: Node?)
	local node = {} :: Node
	if parent then
		if parent.subs then
			table.insert(parent.subs, node)
		else
			parent.subs = { node }
		end
	end
	return node
end

return {
	createNode = createNode,
	currentScope = currentScope,
	pushCleanup = pushCleanup,
	pushScope = pushScope,
	popScope = popScope,
	destroyNode = destroyNode,
}
