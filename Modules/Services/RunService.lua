
local R, Run;

R = setmetatable(
	{
		ServerStepped = {
			connectEnable = false;			
		};
	},
	{
		__metatable = 'Invalid Access';
	}
);

Run = game:service'RunService';

function R.ServerStepped:connect(func)
	R.ServerStepped.connectEnable = true;
	for eternalIndex = 1, math.huge do
		if (R.ServerStepped.connectEnable == true) then
			local nowTick = tick();
			for i = 1, 5 do
				local pt = Instance.new'Part';
				pt.Parent = game;
				pt:Destroy();
			end;
			local rfps = math.floor(1 / tick() - nowTick);
			func(rfps);
		else
			break;
		end;
	end;
end;

return R;
