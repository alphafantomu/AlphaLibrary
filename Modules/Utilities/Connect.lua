
local C, RepStorage;


C = setmetatable(
	{
		
	}, 
	{
		__metatable = 'Invalid Perms';
	}
);

function C:SetConnection(connectionData)
	assert(C['Connection Database'] ~= nil, 'Connect.lua: Connections has not been set up, use "C:InitializeConnections()"');
	
	local connectionID, objectService, connectionName, connectCallback = unpack(connectionData);
	
	assert(
		connectionID ~= nil and 
		objectService ~= nil and 
		connectionName ~= nil and 
		connectCallback ~= nil and
		type(tostring(connectionID)) == 'string' and
		type(tostring(connectionName)) == 'string'
	, 
		'Connect.lua: connectionData has invalidated contents'
	);
	C['Connection Database'][connectionID] = objectService[connectionName]:connect(connectCallback);
	
end;

function C:CutConnection(connectionID)
	assert(C['Connection Database'] ~= nil, 'Connect.lua: Connections has not been set up, use "C:InitializeConnections()"');
	assert(C['Connection Database'][connectionID] ~= nil, 'Connect.lua: connectionID was not found');
	C['Connection Database'][connectionID]:disconnect();
	C['Connection Database'][connectionID] = nil;
end;

function C:InitializeConnections()
	C['Connection Database'] = setmetatable(
		{
			
		},
		{
			__metatable = 'Invalid Perms';
		}
	);
end;

return C;
