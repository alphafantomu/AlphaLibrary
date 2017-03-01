
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
	
	if (RepStorage:FindFirstChild('AlphaLibrary', true) ~= nil) then
		RepStorage:FindFirstChild('AlphaLibrary', true):Destroy();
	end;
	
	if (game:FindFirstChild'AlphaLibrary' ~= nil) then
		game['AlphaLibrary']:Destroy();
	end;
	
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
	
	local Http_ModuleList = Http:JSONDecode(Http:GetAsync(RawRepository..Repository..ModuleList, false));
	for moduleIndex, moduleDirectory in next, Http_ModuleList do
		local Source = RawRepository..Repository..'/master/Modules'..moduleDirectory;
		local hasDirectory, directoryName = GetDirectory(moduleDirectory);
		
		if (hasDirectory == false) then
			local Module = Create(
				'ModuleScript',
				{
					Name = moduleDirectory:sub(2),
					Parent = PhysicalLibrary, 
					Archivable = true,
					Source = (function() 
						if (SourceValid(Source) == true) then
							return Http:GetAsync(Source, false); 
						else
							print('A source cannot be found for: '..moduleDirectory);
							return 'return {}';
						end;
					end)()
				}
			);
		else
			local hasDirectory2, directoryName2 = GetDirectory(moduleDirectory:sub(directoryName:len() + 3));
			if (PhysicalLibrary:FindFirstChild(directoryName) == nil) then
				local Folder = Create(
					'Folder',
					{
						Name = directoryName,
						Parent = PhysicalLibrary,
						Archivable = true
					}
				);
				if (hasDirectory2 == true) then
					if (PhysicalLibrary[directoryName]:FindFirstChild(directoryName2) == nil) then
						local Folder2 = Create(
							'Folder',
							{
								Name = directoryName2,
								Parent = PhysicalLibrary[directoryName]:FindFirstChild(directoryName2),
								Archivable = true
							}
						);
						local Module = Create(
							'ModuleScript',
							{
								Name = moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3),
								Parent = Folder2,
								Archivable = true,
								Source = (function() 
									if (SourceValid(Source) == true) then
										return Http:GetAsync(Source, false); 
									else
										print('A source cannot be found for: '..moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3));
										return 'return {}';
									end;
								end)();
							}
						);
					else
						local Module = Create(
							'ModuleScript',
							{
								Name = moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3),
								Parent = PhysicalLibrary[directoryName]:FindFirstChild(directoryName2),
								Archivable = true,
								Source = (function() 
									if (SourceValid(Source) == true) then
										return Http:GetAsync(Source, false); 
									else
										print('A source cannot be found for: '..moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3));
										return 'return {}';
									end;
								end)();
							}
						);
					end;
				else
					local Module = Create(
						'ModuleScript',
						{
							Name = moduleDirectory:sub(directoryName:len() + 3),
							Parent = PhysicalLibrary:FindFirstChild(directoryName),
							Archivable = true,
							Source = (function() 
								if (SourceValid(Source) == true) then
									return Http:GetAsync(Source, false); 
								else
									print('A source cannot be found for: '..moduleDirectory:sub(directoryName:len() + 3));
									return 'return {}';
								end;
							end)();
						}
					);
				end;
			else
				if (hasDirectory2 == true) then
					if (PhysicalLibrary[directoryName]:FindFirstChild(directoryName2) == nil) then
						local Folder1 = Create(
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
								Name = moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3),
								Parent = Folder1,
								Archivable = true,
								Source = (function() 
									if (SourceValid(Source) == true) then
										return Http:GetAsync(Source, false); 
									else
										print('A source cannot be found for: '..moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3));
										return 'return {}';
									end;
								end)();
							}
						);
					else
						local Module = Create(
							'ModuleScript',
							{
								Name = moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3),
								Parent = PhysicalLibrary[directoryName]:FindFirstChild(directoryName2),
								Archivable = true,
								Source = (function() 
									if (SourceValid(Source) == true) then
										return Http:GetAsync(Source, false); 
									else
										print('A source cannot be found for: '..moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3));
										return 'return {}';
									end;
								end)();
							}
						);
					end;
				else
					local Module = Create(
						'ModuleScript',
						{
							Name = moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3),
							Parent = PhysicalLibrary:FindFirstChild(directoryName),
							Archivable = true,
							Source = (function() 
								if (SourceValid(Source) == true) then
									return Http:GetAsync(Source, false); 
								else
									print('A source cannot be found for: '..moduleDirectory:sub(directoryName:len() + directoryName2:len() + 1 + 3));
									return 'return {}';
								end;
							end)();
						}
					);
				end;
			end;
		end;
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

Engine:AddEnvironmentPage('SourceValid', function(source)
	assert(source ~= nil, 'function Engine:AddEnvironmentPage"SourceValid": source is invalid');
	assert(type(source) == 'string', 'function Engine:AddEnvironmentPage"SourceValid": source is not a string');
	local Validation = true;
	local ran, result = ypcall(function()
		local Source = Http:GetAsync(source, false);
	end);
	if (not ran) then
		result = tostring(result);
		if (result == 'HTTP 404 (HTTP/1.1 404 Not Found)') then
			Validation = false;
		else
			print('Unknown get: '..result);
		end;
	end;
	return Validation;
end);

Engine:AddEnvironmentPage('GetDirectory', function(module_Directory)
	assert(module_Directory ~= nil, 'function Engine:AddEnvironmentPage"GetDirectory": module_Directory is invalid');
	assert(type(module_Directory) == 'string', 'function Engine:AddEnvironmentPage"GetDirectory": module_Directory is not a string');

	if (module_Directory:sub(1, 1) == '/') then
		local directoryName = module_Directory:sub(2);
		local currentSub = 0;
		local maxSubs = directoryName:len();
		repeat
			wait();
			currentSub = currentSub + 1;
		until
			directoryName:sub(currentSub, currentSub) == '/' or currentSub == maxSubs;
		directoryName = directoryName:sub(1, currentSub - 1);
		if (currentSub == maxSubs) then
			return false, 'Cannot be found';
		end;
		return true, directoryName;
	elseif (string.find(module_Directory, '/') ~= nil) then
		local directoryName = module_Directory;
		local currentSub = 0;
		local maxSubs = directoryName:len();
		repeat
			wait();
			currentSub = currentSub + 1;
		until
			directoryName:sub(currentSub, currentSub) == '/' or currentSub == maxSubs;
		directoryName = directoryName:sub(1, currentSub - 1);
		if (currentSub == maxSubs) then
			return false, 'Cannot be found';
		end;
		return true, directoryName;
	else
		return false, 'Invalid_Directory';
	end;
end);

return Engine;









