
wait();
local script, Library, RepStorage, Http, Environment, PhysicalLibrary, Run;

script = script;
Library = setmetatable({}, {__metatable = 'Invalid access'});
RepStorage = game:service'ReplicatedStorage';
Http = game:service'HttpService';
Run = game:service'RunService';
PhysicalLibrary = game:WaitForChild('AlphaLibrary', 10);
Environment = getfenv(1);

assert(script ~= nil, 'script "AlphaLibrary" cannot be found');
assert(Library ~= nil, 'table "Library" cannot be found');
assert(RepStorage ~= nil, 'service "ReplicatedStorage" cannot be found');
assert(Http ~= nil, 'service "HttpService" cannot be found');
assert(Run ~= nil, 'service "RunService" cannot be found');
assert(Environment ~= nil, 'script "Environment" cannot be found');
assert(PhysicalLibrary ~= nil, 'Physical Library "AlphaLibrary" cannot be found');
assert(script.Name == 'AlphaLibrary', 'Custom Library "AlphaLibrary" is not named AlphaLibrary.');
assert(script.ClassName == 'ModuleScript', 'Custom Library "AlphaLibrary" is not a Module Script.');
assert(script.Parent == RepStorage, 'Custom Library "AlphaLibrary" is not the parent of ReplicatedStorage.');

function Library:AddEnvironmentPage(index, value) Environment[index] = value; setfenv(1, Environment); Environment = getfenv(1); end;

assert(Library.AddEnvironmentPage ~= nil, 'Library:AddEnvironmentPage cannot be found');
function Library:LoadLibrary(Library, Level)
	assert(Library ~= nil, 'function Library:LoadLibrary: Library is invalid');
	assert(Level ~= nil, 'function Library:LoadLibrary: Level is invalid');
	(function() if (IsNot(Level, {0, 1}) == true) then Library:LoadLibrary(Library, 0);return;end;end)();
	local LibraryDirectory = (function() if (Level == 0) then return PhysicalLibrary:FindFirstChild(Library, true); elseif (Level == 1) then return Library; end; end)();
	assert(LibraryDirectory ~= nil, 'function Library:LoadLibrary: Library cannot be found');
	assert(ConfirmClass(LibraryDirectory, 'ModuleScript'), 'function Library:LoadLibrary: Library is not a ModuleScript');
	return require(LibraryDirectory);
end;

assert(Library.LoadLibrary ~= nil, 'Library:LoadLibrary cannot be found');
Library:AddEnvironmentPage('NumberTable', function(roblox_Table)
	assert(roblox_Table ~= nil, 'function Library:AddEnvironmentPage"NumberTable": roblox_Table is invalid');
	local Number = 0;
	for tableIndex, tableValue in next, roblox_Table do
		Number = Number + 1;
	end;
	return Number;
end);

Library:AddEnvironmentPage('ConfirmClass', function(roblox_Instance, roblox_Classname)
	assert(roblox_Instance ~= nil, 'function Library:AddEnvironmentPage"ConfirmClass": roblox_Instance is invalid');
	assert(roblox_Classname ~= nil, 'function Library:AddEnvironmentPage"ConfirmClass": roblox_Classname is invalid');
	return roblox_Instance:IsA(roblox_Classname);
end);

Library:AddEnvironmentPage('IsNot', function(roblox_Variable, roblox_Value, roblox_Level)
	assert(roblox_Variable ~= nil, 'function Library:AddEnvironmentPage"IsNot": roblox_Variable is invalid');
	assert(roblox_Value ~= nil, 'function Library:AddEnvironmentPage"IsNot": roblox_Value is invalid');
	assert(roblox_Level ~= nil, 'function Library:AddEnvironmentPage"IsNot": roblox_Level is invalid');
	if (type(roblox_Value) == 'table' and roblox_Level == 1) then
		local numberValues = NumberTable(roblox_Value);
		local currentNumbers = 0;
		for valueIndex, valueValue in next, roblox_Value do
			if (roblox_Variable == valueValue) then
				currentNumbers = currentNumbers + 1;
			end;
		end;
		return currentNumbers == numberValues;
	else
		return roblox_Variable == roblox_Value;
	end;
end);

return Library;









