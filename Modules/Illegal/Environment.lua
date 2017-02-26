
local env;

env = setmetatable(
	{
		scriptEnv = getfenv(1);
	}, 
	{
		__metatable = 'Invalid Access';
	}
);

function env:IndexEnvironment(index, value)
	env.scriptEnv[index] = value;
	setfenv(1, env.ScriptEnv);
	env.scriptEnv = getfenv(1);
end;

function env:AchieveAllArguments(toUse, toAchieveType, extraData)
	assert(toAchieveType ~= nil, 'Environment.lua: toAchieveType is nil');
	assert(toUse ~= nil, 'Environment.lua: toUse is nil');
	assert(type(toAchieveType) == 'number', 'Environment.lua: toAchieveType is not a number');
	if (toAchieveType == 0) then --function
		local randomArguments = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
		local ran, result = ypcall(toUse, unpack(randomArguments));
		print'Unfinished';
		return env:AchieveAllArguments(toUse, 1);
	elseif (toAchieveType == 1) then --connection
		assert(extraData ~= nil, 'Environment.lua: extraData is nil');
		local connectionName = unpack(extraData);
		local recordedArguments = {};
		local connector;
		connector = toUse[connectionName]:connect(function(...)
			recordedArguments = {...};
			connector:disconnect();
			connector = nil;
		end);
		return recordedArguments;
	else
		return env:AchieveAllArguments(toUse, 1);
	end;
end;

function env:ReloadEnvironment(senv)
	if (senv == nil) then
		env.scriptEnv = getfenv(1);
	else
		env.scriptEnv = senv;
	end;
	setfenv(1, env.scriptEnv);
end;

return env;
