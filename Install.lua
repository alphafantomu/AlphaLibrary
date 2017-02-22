
--[[
	Install.lua is ment to be used by loadstring()
	loadstring(game.HttpService:GetAsync('https://raw.githubusercontent.com/alphafantomu/AlphaLibrary/master/Install.lua', false))()
	local Http = game:service'HttpService';
	local Install = 'https://raw.githubusercontent.com/alphafantomu/AlphaLibrary/master/Install.lua';
	loadstring(Http:GetAsync(Install))();
--]]
wait();
local script, Install, RepStorage, Http, Environment, Run, Respository,isPlugin;

script = script;
Install = setmetatable({}, {__metatable = 'Invalid access'});
RepStorage = game:service'ReplicatedStorage';
Http = game:service'HttpService';
Run = game:service'RunService';
Environment = getfenv(1);
Repository = '/alphafantomu/AlphaLibrary';
isPlugin = (function()if (plugin == nil) then return false;else return true;end;end)();

assert(isPlugin ~= nil, 'variable "isPlugin" cannot be found');
assert(Repository ~= nil, 'httpURL "Repository" cannot be found');
assert(Install ~= nil, 'script "Install" cannot be found');
assert(RepStorage ~= nil, 'service "ReplicatedStorage" cannot be found');
assert(Http ~= nil, 'service "HttpService" cannot be found');
assert(Run ~= nil, 'service "RunService" cannot be found');
assert(Environment ~= nil, 'script "Environment" cannot be found');

if (isPlugin == false) then
	Http.HttpEnabled = true;	
end;

function Install:AddEnvironmentPage(index, value) Environment[index] = value; setfenv(1, Environment); Environment = getfenv(1); end;

assert(Install.AddEnvironmentPage ~= nil, 'Install:AddEnvironmentPage cannot be found');
function Install:CreateEngine()
	assert(Http.HttpEnabled, 'Install: Http requests are not enabled');
	local EngineLua = '/master/App/AlphaEngine.lua';
	local RawRepository = 'https://raw.githubusercontent.com';
	assert(Http:GetAsync(RawRepository..Repository..EngineLua, true) ~= nil, 'Install: "AlphaEngine.lua" has an invalid format');
	if (RepStorage:FindFirstChild'AlphaEngine') then
		RepStorage:FindFirstChild'AlphaEngine':Destroy();
	end;
	local Engine = Create(
		'ModuleScript', 
		{
			Name = 'AlphaEngine',
			Parent = RepStorage,
			Archivable = false,
			Source = Http:GetAsync(RawRepository..Repository..EngineLua, false)
		}
	);
	Engine = require(Engine);
	return Engine;
end;

assert(Install.CreateEngine ~= nil, 'Install:CreateEngine cannot be found');
Install:AddEnvironmentPage('Create', function(roblox_Classname, roblox_Properties)
	assert(roblox_Classname ~= nil, 'function Install:AddEnvironmentPage"Create": roblox_Classname is invalid');
	assert(roblox_Properties ~= nil, 'function Install:AddEnvironmentPage"Create": roblox_Properties is invalid');
	local roblox_Instance = Instance.new(roblox_Classname);
	assert(roblox_Instance ~= nil, 'function Install:AddEnvironmentPage"Create": roblox_Instance is invalid');
	for className, classValue in next, roblox_Properties do
		ypcall(function()
			roblox_Instance[className] = classValue;
		end);
	end;
	return roblox_Instance;
end);

local AlphaEngine = Install:CreateEngine();
AlphaEngine:Install_Library(Environment);







