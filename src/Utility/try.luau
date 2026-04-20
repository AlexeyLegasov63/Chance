--!strict

local function printStackTrace(errorMessage: string, customMessage: string?)
	warn("[Error occurred]: ", customMessage or "Empty catch message", "\n\t", debug.traceback(errorMessage))
end

local function try<T...>(func: (T...) -> (), catchMessage: string?, ...: T...): boolean
	return xpcall(func, function(errorMessage)
		printStackTrace(errorMessage, catchMessage)
	end, ...)
end

return try
