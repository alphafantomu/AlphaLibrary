
local Formula;

Formula = setmetatable({}, {__metatable = 'Invalid permissions'});

Formula.Get_MaxExp = function(poke_level)
	assert(poke_level ~= nil, 'Formula.Get_MaxExp: poke_level is nil');
	assert(type(poke_level) == 'number', 'Formula.Get_MaxExp: poke_level is not a number');
	return (5 * poke_level ^ 3 / 4);
end;

Formula.Attempt_BallCatch = function(poke_value, pokeball, all_else)
	
end;

return Formula;
