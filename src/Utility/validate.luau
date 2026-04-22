--!strict

-- Just an assertion
local function validate(expr: boolean, message: string)
	if not expr then
		error(message)
	end
end

return validate
