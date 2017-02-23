
local A, Run;

A = setmetatable(
	{
		ClientFPS = {
			Number = 0,
			isRecording = false,
			runType = 'RenderStepped',
			Record = nil,
			recordFunction = function(rfps)return (1 / rfps);end;
		}, 
		ServerFPS = {
			Number = 0,
			isRecording = false,
			runType = 'Heartbeat',
			Record = nil,
			recordFunction = function(rfps)return (1 / rfps);end;
		}, 
		Ping = {
			Number = 0,
			isRecording = false,
			runType = 'RenderStepped',
			Record = nil,
			recordFunction = function() local recorded_ping = 300 - ((1 / wait()) * 10);if (recorded_ping < 1) then recorded_ping = 1;elseif (recorded_ping > 300) then recorded_ping = 300;end;return math.floor(recorded_ping);end;
		},
	}, 
	{
		__metatable = 'Invalid Access'
	}
);
Run = game:service'RunService';

function A:Stop_Record(record_name)
	assert(A[record_name] ~= nil, 'Performance.lua: record_name is not valid.');
	A[record_name].isRecording = false;
	A[record_name].Record:disconnect();
	A[record_name].Record = nil;
end;

function A:Start_Record(record_name, wait_sep)
	assert(A[record_name] ~= nil, 'Performance.lua: record_name is not valid.');
	A[record_name].isRecording = true;
	A[record_name].Record = Run[A[record_name].runType]:connect(function(rfps)
		if (A[record_name].isRecording == true) then
			wait(wait_sep);
			A[record_name].Number = A[record_name].recordFunction(rfps);
		end;
	end);
end;

function A:Get_RecordNumber(record_name)
	assert(A[record_name] ~= nil, 'Performance.lua: record_name is not valid.');
	return A[record_name].Number;
end;

function A:Get_RawRecordData(record_name)
	assert(A[record_name] ~= nil, 'Performance.lua: record_name is not valid.');
	return A[record_name];
end;

return A;
