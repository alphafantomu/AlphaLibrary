
--[[
	[
		"lol",
		"lole"
	]
	
	
--]]
wait();
local Engine, RepStorage, Http, Environment, Run;

Engine = setmetatable({}, {__metatable = 'Invalid access'});
RepStorage = game:service'ReplicatedStorage';
Http = game:service'HttpService';
Run = game:service'RunService';
Environment = getfenv(1);
Repository = '/alphafantomu/AlphaLibrary';

assert(Repository ~= nil, 'httpURL "Repository" cannot be found');
assert(RepStorage ~= nil, 'service "ReplicatedStorage" cannot be found');
assert(Engine ~= nil, 'script "Engine" cannot be found');
assert(Http ~= nil, 'service "HttpService" cannot be found');
assert(Run ~= nil, 'service "RunService" cannot be found');
assert(Environment ~= nil, 'script "Environment" cannot be found');

function Engine:AddEnvironmentPage(index, value) Environment[index] = value; setfenv(1, Environment); Environment = getfenv(1); end;

assert(Engine.AddEnvironmentPage ~= nil, 'Engine:AddEnvironmentPage cannot be found');
function Engine:Install_Library(Installed_Environment)
	assert(Http.HttpEnabled, 'Engine: Http requests are not enabled');
	
	local RawRepository = 'https://raw.githubusercontent.com';
	local SafeRepository = 'https://github.com';
	
	local LibraryLua = '/master/App/AlphaLibrary.lua';
	
	local ModuleList = '/master/Modules/ModuleList.json';
	
	local Library = Create(
		'ModuleScript', 
		{
			Name = 'AlphaLibrary',
			Parent = RepStorage,
			Archivable = true,
			Source = Http:GetAsync(RawRepository..Repository..LibraryLua, false)
		}
	);
	
	local PhysicalLibrary = Create(
		'Folder',
		{
			Name = 'AlphaLibrary',
			Archivable = true,
			Parent = game
		}
	);
	
	for moduleIndex, moduleDirectory in next, Http:JSONDecode(Http:GetAsync(RawRepository..Repository..ModuleList, false)) do
		spawn(function()
		local Source = RawRepository..Repository..'/master/'..moduleDirectory;
		local hasDirectory, directoryName = GetDirectory(moduleDirectory);
		repeat
			--json.lua
			if (hasDirectory == false or hasDirectory == nil) then
				local Module = Create(
					'ModuleScript',
					{
						Name = moduleDirectory,
						Parent = PhysicalLibrary, --make sure to set parent
						Archivable = true,
						Source = Http:GetAsync(Source, false);
					}
				);
			--/haha/json.lua
			else
				--if haha isn't available
				if (PhysicalLibrary:FindFirstChild(directoryName, false) == nil) then
					local Folder = Create(
						'Folder',
						{
							Name = directoryName,
							Parent = PhysicalLibrary,
							Archivable = true
						}
					);
					local hasDirectory2, directoryName2 = GetDirectory(directoryName);
					if (hasDirectory == true) then
						local Folder2 = Create(
							'Folder',
							{
								Name = directoryName2,
								Parent = Folder,
								Archivable = true
							}
						);
						local Module = Create(
							'ModuleScript',
							{
								Name = moduleDirectory,
								Parent = Folder2,
								Archivable = true,
								Source = Http:GetAsync(Source, false);
							}
						);
					else
						local Module = Create(
							'ModuleScript',
							{
								Name = moduleDirectory,
								Parent = Folder,
								Archivable = true,
								Source = Http:GetAsync(Source, false);
							}
						);
					end;
				--if haha was already made
				else
					local hasDirectory2, directoryName2 = GetDirectory(directoryName);
					if (hasDirectory2 == true) then
						if (PhysicalLibrary[directoryName]:FindFirstChild(directoryName2) == nil) then
							local Folder2 = Create(
								'Folder',
								{
									Name = directoryName2,
									Parent = PhysicalLibrary[directoryName],
									Archivable = true
								}
							);
							local Module = Create(
								'ModuleScript',
								{
									Name = moduleDirectory,
									Parent = Folder2,
									Archivable = true,
									Source = Http:GetAsync(Source, false);
								}
							);
						else
							local Module = Create(
								'ModuleScript',
								{
									Name = moduleDirectory,
									Parent = PhysicalLibrary[directoryName]:FindFirstChild(directoryName2), --make sure to set parent
									Archivable = true,
									Source = Http:GetAsync(Source, false);
								}
							);
						end;
					else
						local Module = Create(
							'ModuleScript',
							{
								Name = moduleDirectory,
								Parent = PhysicalLibrary:FindFirstChild(directoryName), --make sure to set parent
								Archivable = true,
								Source = Http:GetAsync(Source, false);
							}
						);
					end;
				end;
			end;
		until
			not string.find(directoryName, '/');
		
		
		end);
	end;
	print'Successfully loaded AlphaLibrary.';
end;

assert(Engine.Install_Library ~= nil, 'Engine:Install_Library cannot be found');

Engine:AddEnvironmentPage('Create', function(roblox_Classname, roblox_Properties)
	assert(roblox_Classname ~= nil, 'function Engine:AddEnvironmentPage"Create": roblox_Classname is invalid');
	assert(roblox_Properties ~= nil, 'function Engine:AddEnvironmentPage"Create": roblox_Properties is invalid');
	local roblox_Instance = Instance.new(roblox_Classname);
	assert(roblox_Instance ~= nil, 'function Engine:AddEnvironmentPage"Create": roblox_Instance is invalid');
	for className, classValue in next, roblox_Properties do
		ypcall(function()
			roblox_Instance[className] = classValue;
		end);
	end;
	return roblox_Instance;
end);

Engine:AddEnvironmentPage('GetDirectory', function(module_Directory)
	assert(module_Directory ~= nil, 'function Engine:AddEnvironmentPage"GetDirectory": module_Directory is invalid');
	assert(type(module_Directory) == 'string', 'function Engine:AddEnvironmentPage"GetDirectory": module_Directory is not a string');
	
	if (module_Directory:sub(1, 1) == '/' ~= nil) then
		--/haha/json.lua
		local directoryName = module_Directory:sub(2);
		local currentSub = 0;
		repeat
			currentSub = currentSub + 1;
		until
			directoryName:sub(currentSub, currentSub) == '/';
		directoryName = directoryName:sub(2, currentSub - 1);
		return directoryName;
	elseif (string.find(module_Directory, '/') ~= nil) then
		--haha/json.lua
		
		local directoryName = module_Directory;
		local currentSub = 0;
		repeat
			currentSub = currentSub + 1;
		until
			directoryName:sub(currentSub, currentSub) == '/';
		directoryName = directoryName:sub(2, currentSub - 1);
		return directoryName;
	else
		return false, 'Invalid_Directory';
	end;
end);

return Engine;









