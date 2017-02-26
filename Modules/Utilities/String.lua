
local S, Run;

S = setmetatable(
	{
		
	}, 
	{
		__metatable = 'Invalid Access'
	}
);

Run = game:service'RunService';

S.multi_gsub = function(str, to_re, be_re)
	assert(str ~= nil, 'String.lua: str is nil');
	assert(to_re ~= nil, 'String.lua: to_re is nil');
	assert(be_re ~= nil, 'String.lua: be_re is nil');
	assert(type(to_re) ~= 'table', 'String.lua: to_re is not a table');
	assert(type(be_re) ~= 'table', 'String.lua: be_re is not a table');
	local currentMsg = str;
	for toChangeIndex = 1, #be_re do
		Run.Heartbeat:wait();
		for changeIndex = 1, #to_re do
			Run.Heartbeat:wait();
			currentMsg = string.gsub(currentMsg, to_re[changeIndex], be_re[toChangeIndex]);
		end;
	end;
	return currentMsg;
end;

S.convert_ToAsciiChar = function(s)
	assert(s ~= nil, 'String.lua: s is nil');
	local new_string = '';
	
	--invalid
	
	return searchAsciiNum(s);
end;

S.convert_ToAsciiNum = function(s)
	assert(s ~= nil, 'String.lua: s is nil');
	local max_letters = s:len();
	local new_string = '';
	for index = 1, max_letters do
		Run.Heartbeat:wait();
		new_string = new_string..string.byte(s:sub(index, index));
		if (index ~= max_letters) then
			new_string = new_string..','
		end;
	end;
	return new_string;
end;

return S;
