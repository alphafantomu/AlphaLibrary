
local Formula;

Formula = setmetatable({}, {__metatable = 'Invalid permissions'});

--Formula.Get_MaxExp(100)
Formula.Get_MaxExp = function(poke_level)
	
	assert(poke_level ~= nil, 'Formula.Get_MaxExp: poke_level is nil');
	assert(type(poke_level) == 'number', 'Formula.Get_MaxExp: poke_level is not a number');
	
	return (5 * poke_level ^ 3 / 4);
end;

--Formula.Get_GainedExp = function(game.Players.Player1, {battle_type = 'trainer', powerpoint_enabled = true}, {level = 100, OT = 'Player2', HeldItem = 'Lucky Egg'}, {base_exp = 255, level = 100});
Formula.Get_GainedExp = function(player, battle_data, poke_valuePlayer, poke_valueOpponent)
	
	local a = (function() if (battle_data.battle_type:lower() == 'trainer') then return 1.5;elseif (battle_data.battle_type:lower() == 'wild') then return 1;else return 1;end;end)();
	local b = poke_valueOpponent.base_exp;
	local oL = poke_valueOpponent.level;
	local s = (function()if (poke_valuePlayer.HeldItem:lower() == 'exp share' or poke_valuePlayer.HeldItem:lower() == 'expshare') then return 2;else return 1;end;end);
	local pL = poke_valuePlayer.level;
	local t = (function()if (poke_valuePlayer.OT ~= player.Name) then return 1.5;elseif (poke_valuePlayer.OT == player.Name) then return 1; else return 1;end;end)();
	local e = (function()if (poke_valuePlayer.HeldItem:lower() == 'lucky egg' or poke_valuePlayer.HeldItem:lower() == 'luckyegg') then return 1.5;else return 1;end;end);
	local v = 1; --Past the level of evolution, Generation IV only
	local p = (function() if (battle_data.powerpoint_enabled == true) then return 2; else return 1; end; end)(); --Power Point
	
	local Part1, Part2, Part3, Part4, Part5 = a * b * oL, 5 * s, (2 * oL + 10) ^ 2.5, (oL + pL + 10) ^ 2.5, t * e * p * v;
	
	return ((Part1 / Part2) * (Part3 / Part4) + 1) * Part5;
	
end;

--Formula.Attempt_BallCatch({CatchRate = 255, MaxHp = 100, CurrentHp = 100}, {Multiplier = 255, Name = 'Masterball'}, nil);
Formula.Attempt_BallCatch = function(poke_value, pokeball, all_else)
	
	local poke_catchrate, poke_maxhp, poke_currhp = unpack(poke_value);
	local item_multiplier, item_name = unpack(pokeball);

	assert(poke_catchrate ~= nil, 'Formula.Attempt_BallCatch: poke_value.CatchRate is nil');
	assert(poke_maxhp ~= nil, 'Formula.Attempt_BallCatch: poke_value.MaxHp is nil');
	assert(poke_currhp ~= nil, 'Formula.Attempt_BallCatch: poke_value.CurrentHp is nil');
	assert(item_multiplier ~= nil, 'Formula.Attempt_BallCatch: pokeball.Multiplier is nil');
	
	local x = (function()return ((3 * poke_maxhp - 2 * poke_currhp) * (poke_catchrate * item_multiplier) / 3 * poke_maxhp) * 1;end)();
	
	local item_level, item_result = 0, false;
	
	local shake_check = function()
		local b = 65536 / (255 / x) ^ .1875;
		for index = 1, 3 do
			local random_number = math.random(0, 65535);
			if (random_number >= b) then
				return false;
			else
				item_level = item_level + 1;
			end;
		end;
	end;
	
	shake_check();
	
	if (item_level >= 3) then
		item_result = true;
	else
		item_result = false;
	end;
	
	return item_result;
end;

return Formula;
