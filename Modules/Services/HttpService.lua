
local H, Http, Run;

H = setmetatable(
	{
		
	},
	{
		__metatable = 'Invalid Access';
	}
);
Http = game:service'HttpService';
Run = game:service'RunService';

function H:GenerateCharacters(max_num)
	local endCharacters = '';	
	
	for index = 1, max_num do
		Run.RenderStepped:wait();
		endCharacters = endCharacters..string.char(math.random(95, 126));
	end;
	
	return endCharacters;
end;

function H:CheckHttp()
	local httpEnabled = false;
	
	local ran, result = ypcall(function()
		Http:GetAsync'google.com';
	end);
	if (not ran) then
		result = tostring(result);
		if (result == 'google.com: Trust check failed') then
			httpEnabled = true;
		else
			httpEnabled = false;
		end;
	end;
	
	return httpEnabled;
end;

return H;
