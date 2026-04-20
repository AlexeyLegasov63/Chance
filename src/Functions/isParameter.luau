--!strict

-- Checks if the instance has the parameter
local function isParameter(instance: Instance, candidate: string): boolean
	-- The best way to check if it's a parameter I know
	-- Returns false if it's not
	return pcall(function()
		return (instance :: any)[candidate]
	end)
end

return isParameter
