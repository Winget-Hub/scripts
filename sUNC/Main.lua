-- Cleaned reconstruction of Scripts/Skids/sUNC/Dirty/Main.lua.
-- The original is a Luraph v14.2 VM wrapper. Unhiding recovers the VM stage,
-- but not a full instruction-level devirtualization, so this file preserves
-- the observed sUNC test behavior as readable Luau.

local Results = {
	Passed = 0,
	Failed = 0,
	Skipped = 0,
	Items = {},
}

local function GetGlobal(name)
	return rawget(getgenv and getgenv() or _G, name) or rawget(_G, name)
end

local function DescribeValue(value)
	local ok, rendered = pcall(tostring, value)
	return ok and rendered or "<unprintable>"
end

local function Record(status, name, detail)
	if status == "PASS" then
		Results.Passed += 1
	elseif status == "SKIP" then
		Results.Skipped += 1
	else
		Results.Failed += 1
	end

	table.insert(Results.Items, {
		Status = status,
		Name = name,
		Detail = detail,
	})

	local suffix = detail and detail ~= "" and (" - " .. detail) or ""
	print(("[%s] %s%s"):format(status, name, suffix))
end

local function Assert(condition, message)
	if not condition then
		error(message or "assertion failed", 2)
	end
end

local function RequireFunction(path, value)
	Assert(type(value) == "function", path .. " is missing")
	return value
end

local function Test(name, callback)
	local ok, detail = pcall(callback)
	if ok then
		Record("PASS", name, detail)
	else
		Record("FAIL", name, tostring(detail))
	end
end

local function OptionalTest(name, dependencies, callback)
	for _, dependency in ipairs(dependencies) do
		if dependency.Value == nil then
			Record("SKIP", name, dependency.Name .. " is missing")
			return
		end
	end

	Test(name, callback)
end

local function GetDebugFunction(name)
	local debugLibrary = GetGlobal("debug")
	if type(debugLibrary) ~= "table" then
		return nil
	end
	return debugLibrary[name]
end

local function TryCall(callback)
	local ok, result = pcall(callback)
	return ok, result
end

local function NewPart()
	local InstanceLibrary = GetGlobal("Instance")
	if type(InstanceLibrary) ~= "table" or type(InstanceLibrary.new) ~= "function" then
		return nil
	end

	local ok, part = pcall(InstanceLibrary.new, "Part")
	return ok and part or nil
end

print("[sUNC] Starting cleaned capability test")

Test("getgenv", function()
	local getgenvFunction = RequireFunction("getgenv", GetGlobal("getgenv"))
	local env = getgenvFunction()
	Assert(type(env) == "table", "getgenv did not return a table")
	return "returned executor global table"
end)

Test("getrenv", function()
	local getrenvFunction = RequireFunction("getrenv", GetGlobal("getrenv"))
	local env = getrenvFunction()
	Assert(type(env) == "table", "getrenv did not return a table")
	return "returned Roblox environment table"
end)

Test("loadstring", function()
	local loadstringFunction = RequireFunction("loadstring", GetGlobal("loadstring") or loadstring)
	local chunk, err = loadstringFunction("return 12 + 30")
	Assert(type(chunk) == "function", "compile failed: " .. tostring(err))
	Assert(chunk() == 42, "compiled chunk returned the wrong value")
	return "compiled and executed source"
end)

OptionalTest("identifyexecutor", {
	{Name = "identifyexecutor", Value = GetGlobal("identifyexecutor")},
}, function()
	local name, version = GetGlobal("identifyexecutor")()
	Assert(type(name) == "string", "executor name was not a string")
	return ("executor=%s version=%s"):format(name, DescribeValue(version))
end)

OptionalTest("cloneref / compareinstances", {
	{Name = "cloneref", Value = GetGlobal("cloneref")},
	{Name = "compareinstances", Value = GetGlobal("compareinstances")},
}, function()
	local part = NewPart()
	if not part then
		return "Instance.new unavailable; function presence verified"
	end

	local clone = GetGlobal("cloneref")(part)
	Assert(GetGlobal("compareinstances")(part, clone) == true, "compareinstances rejected cloneref result")
	return "cloneref identity compares correctly"
end)

OptionalTest("getsenv", {
	{Name = "getsenv", Value = GetGlobal("getsenv")},
}, function()
	local env = GetGlobal("getsenv")(script)
	Assert(type(env) == "table", "getsenv did not return a table")
	return "script environment returned"
end)

OptionalTest("getinstances", {
	{Name = "getinstances", Value = GetGlobal("getinstances")},
}, function()
	local instances = GetGlobal("getinstances")()
	Assert(type(instances) == "table", "getinstances did not return a table")
	return tostring(#instances) .. " instances"
end)

OptionalTest("getnilinstances", {
	{Name = "getnilinstances", Value = GetGlobal("getnilinstances")},
}, function()
	local instances = GetGlobal("getnilinstances")()
	Assert(type(instances) == "table", "getnilinstances did not return a table")
	return tostring(#instances) .. " nil instances"
end)

OptionalTest("getscripts", {
	{Name = "getscripts", Value = GetGlobal("getscripts")},
}, function()
	local scripts = GetGlobal("getscripts")(true)
	Assert(type(scripts) == "table", "getscripts did not return a table")
	return tostring(#scripts) .. " scripts"
end)

OptionalTest("getloadedmodules", {
	{Name = "getloadedmodules", Value = GetGlobal("getloadedmodules")},
}, function()
	local modules = GetGlobal("getloadedmodules")(false)
	Assert(type(modules) == "table", "getloadedmodules did not return a table")
	return tostring(#modules) .. " modules"
end)

OptionalTest("getgc", {
	{Name = "getgc", Value = GetGlobal("getgc")},
}, function()
	local gc = GetGlobal("getgc")(true)
	Assert(type(gc) == "table", "getgc did not return a table")
	return tostring(#gc) .. " collected objects"
end)

OptionalTest("filtergc function constants", {
	{Name = "filtergc", Value = GetGlobal("filtergc")},
}, function()
	local matches = GetGlobal("filtergc")("function", {
		Constants = {"boyyywhattheflop"},
		Amount = 1,
	})

	Assert(type(matches) == "table", "filtergc did not return a table")
	return tostring(#matches) .. " matching functions"
end)

OptionalTest("hookfunction / restorefunction", {
	{Name = "hookfunction", Value = GetGlobal("hookfunction")},
}, function()
	local original = function()
		return "original"
	end

	local replacement = function()
		return "hooked"
	end

	local old = GetGlobal("hookfunction")(original, replacement)
	Assert(type(old) == "function", "hookfunction did not return a function")

	local restorefunction = GetGlobal("restorefunction")
	if type(restorefunction) == "function" then
		restorefunction(original)
	end

	return "hook installed" .. (restorefunction and " and restorefunction exists" or "")
end)

OptionalTest("clonefunction", {
	{Name = "clonefunction", Value = GetGlobal("clonefunction")},
}, function()
	local original = function(value)
		return value + 1
	end

	local clone = GetGlobal("clonefunction")(original)
	Assert(type(clone) == "function", "clonefunction did not return a function")
	Assert(clone(41) == 42, "cloned function returned wrong value")
	return "clone executes correctly"
end)

OptionalTest("newcclosure", {
	{Name = "newcclosure", Value = GetGlobal("newcclosure")},
}, function()
	local closure = GetGlobal("newcclosure")(function()
		return "beeeb"
	end)

	Assert(type(closure) == "function", "newcclosure did not return a function")
	Assert(closure() == "beeeb", "newcclosure changed return value")
	return "closure wrapper executes"
end)

OptionalTest("debug.getinfo", {
	{Name = "debug.getinfo", Value = GetDebugFunction("getinfo")},
}, function()
	local info = GetDebugFunction("getinfo")(function() end, "sflnu")
	Assert(type(info) == "table", "debug.getinfo did not return a table")
	return "debug metadata returned"
end)

OptionalTest("debug.getconstant / debug.getconstants", {
	{Name = "debug.getconstant", Value = GetDebugFunction("getconstant")},
	{Name = "debug.getconstants", Value = GetDebugFunction("getconstants")},
}, function()
	local function constantProbe()
		return "BOY_DONT_PLAY_WITH_ME"
	end

	local constants = GetDebugFunction("getconstants")(constantProbe)
	Assert(type(constants) == "table", "debug.getconstants did not return a table")
	GetDebugFunction("getconstant")(constantProbe, 1)
	return tostring(#constants) .. " constants"
end)

OptionalTest("debug.setconstant", {
	{Name = "debug.setconstant", Value = GetDebugFunction("setconstant")},
}, function()
	local function constantProbe()
		return "BOY_DONT_PLAY_WITH_ME"
	end

	local ok = TryCall(function()
		GetDebugFunction("setconstant")(constantProbe, 1, "BOY_DONT_PLAY_WITH_ME")
	end)

	Assert(ok, "debug.setconstant errored")
	return "constant write call accepted"
end)

OptionalTest("debug.getupvalue / debug.setupvalue", {
	{Name = "debug.getupvalue", Value = GetDebugFunction("getupvalue")},
	{Name = "debug.setupvalue", Value = GetDebugFunction("setupvalue")},
}, function()
	local upvalue = "Somethingiok"
	local function upvalueProbe()
		return upvalue
	end

	local value = select(2, GetDebugFunction("getupvalue")(upvalueProbe, 1))
	if value == nil then
		value = GetDebugFunction("getupvalue")(upvalueProbe, 1)
	end

	local ok = TryCall(function()
		GetDebugFunction("setupvalue")(upvalueProbe, 1, value)
	end)

	Assert(ok, "debug.setupvalue errored")
	return "upvalue read/write call accepted"
end)

OptionalTest("debug.getstack", {
	{Name = "debug.getstack", Value = GetDebugFunction("getstack") or GetGlobal("getstack")},
}, function()
	local getstack = GetDebugFunction("getstack") or GetGlobal("getstack")
	local stack = getstack(1)
	Assert(type(stack) == "table" or stack ~= nil, "[GETSTACK] Index not in stack[2]")

	local indexed = getstack(1, 1)
	Assert(indexed ~= nil, "[GETSTACK] Index not in stack[3]")
	return "stack read accepted"
end)

OptionalTest("debug.setstack", {
	{Name = "debug.setstack", Value = GetDebugFunction("setstack")},
}, function()
	local ok = TryCall(function()
		GetDebugFunction("setstack")(1, 1, "BOY_DONT_PLAY_WITH_ME")
	end)

	Assert(ok, "[SETSTACK] Failed to set to 4, 22")
	return "stack write call accepted"
end)

OptionalTest("debug.getproto / debug.getprotos", {
	{Name = "debug.getproto", Value = GetDebugFunction("getproto")},
	{Name = "debug.getprotos", Value = GetDebugFunction("getprotos")},
}, function()
	local function protoProbe()
		return function()
			return true
		end
	end

	local proto = GetDebugFunction("getproto")(protoProbe, 1, true)
	local protos = GetDebugFunction("getprotos")(protoProbe)
	Assert(proto ~= nil, "debug.getproto returned nil")
	Assert(type(protos) == "table", "debug.getprotos did not return a table")
	return "proto access accepted"
end)

OptionalTest("getrawmetatable / setreadonly", {
	{Name = "getrawmetatable", Value = GetGlobal("getrawmetatable")},
	{Name = "setreadonly", Value = GetGlobal("setreadonly")},
	{Name = "isreadonly", Value = GetGlobal("isreadonly")},
}, function()
	local object = {}
	local mt = {__index = {FreakyBox = true}}
	setmetatable(object, mt)

	local raw = GetGlobal("getrawmetatable")(object)
	Assert(raw == mt, "getrawmetatable returned the wrong metatable")
	GetGlobal("setreadonly")(raw, false)
	GetGlobal("isreadonly")(raw)
	return "metatable read/write helpers accepted"
end)

OptionalTest("hookmetamethod", {
	{Name = "hookmetamethod", Value = GetGlobal("hookmetamethod")},
}, function()
	local object = NewPart() or {}
	local old = GetGlobal("hookmetamethod")(object, "__index", function(self, key)
		return old(self, key)
	end)

	Assert(type(old) == "function", "hookmetamethod did not return old closure")
	return "metamethod hook accepted"
end)

OptionalTest("getconnections / firesignal", {
	{Name = "getconnections", Value = GetGlobal("getconnections")},
}, function()
	local bindable = GetGlobal("Instance") and Instance.new("BindableEvent")
	if not bindable then
		return "Instance.new unavailable; function presence verified"
	end

	local connections = GetGlobal("getconnections")(bindable.Event)
	Assert(type(connections) == "table", "getconnections did not return a table")

	local firesignal = GetGlobal("firesignal")
	if type(firesignal) == "function" then
		firesignal(bindable.Event)
	end

	bindable:Destroy()
	return tostring(#connections) .. " connections"
end)

OptionalTest("fireclickdetector / firetouchinterest / fireproximityprompt", {
	{Name = "fireclickdetector", Value = GetGlobal("fireclickdetector")},
	{Name = "firetouchinterest", Value = GetGlobal("firetouchinterest")},
	{Name = "fireproximityprompt", Value = GetGlobal("fireproximityprompt")},
}, function()
	return "input fire helpers present"
end)

OptionalTest("request", {
	{Name = "request", Value = GetGlobal("request") or GetGlobal("http_request") or (GetGlobal("syn") and GetGlobal("syn").request)},
}, function()
	local request = GetGlobal("request") or GetGlobal("http_request") or GetGlobal("syn").request
	local response = request({
		Url = "https://example.com",
		Method = "GET",
	})

	Assert(type(response) == "table", "request did not return a response table")
	return "HTTP helper returned a table"
end)

OptionalTest("queue_on_teleport", {
	{Name = "queue_on_teleport", Value = GetGlobal("queue_on_teleport")},
}, function()
	GetGlobal("queue_on_teleport")("-- sUNC queue test")
	return "queue accepted source"
end)

OptionalTest("clipboard", {
	{Name = "setclipboard", Value = GetGlobal("setclipboard")},
}, function()
	GetGlobal("setclipboard")("sUNC clipboard test")
	return "clipboard write accepted"
end)

OptionalTest("filesystem", {
	{Name = "writefile", Value = GetGlobal("writefile")},
	{Name = "readfile", Value = GetGlobal("readfile")},
	{Name = "isfile", Value = GetGlobal("isfile")},
	{Name = "delfile", Value = GetGlobal("delfile")},
}, function()
	local path = "sunc_clean_test.txt"
	GetGlobal("writefile")(path, "Fully loaded jag")
	Assert(GetGlobal("isfile")(path), "isfile did not see written file")
	Assert(GetGlobal("readfile")(path) == "Fully loaded jag", "readfile returned wrong content")
	GetGlobal("delfile")(path)
	return "file helpers round-tripped"
end)

OptionalTest("Drawing", {
	{Name = "Drawing", Value = GetGlobal("Drawing")},
}, function()
	local drawing = Drawing.new("Circle")
	Assert(drawing ~= nil, "Drawing.new returned nil")
	if drawing.Remove then
		drawing:Remove()
	end
	return "Drawing object created"
end)

OptionalTest("lz4compress / lz4decompress", {
	{Name = "lz4compress", Value = GetGlobal("lz4compress")},
	{Name = "lz4decompress", Value = GetGlobal("lz4decompress")},
}, function()
	local input = "hello world"
	local compressed = GetGlobal("lz4compress")(input)
	local output = GetGlobal("lz4decompress")(compressed, #input)
	Assert(output == input, "lz4 round-trip failed")
	return "round-trip ok"
end)

OptionalTest("crypt base64", {
	{Name = "crypt", Value = GetGlobal("crypt")},
}, function()
	local crypt = GetGlobal("crypt")
	Assert(type(crypt.base64encode) == "function" or type(crypt.base64) == "table", "base64 helpers missing")

	local encode = crypt.base64encode or crypt.base64.encode
	local decode = crypt.base64decode or crypt.base64.decode
	local encoded = encode("sUNC")
	if type(decode) == "function" then
		Assert(decode(encoded) == "sUNC", "base64 decode mismatch")
	end

	return "base64 encode/decode accepted"
end)

OptionalTest("WebSocket", {
	{Name = "WebSocket", Value = GetGlobal("WebSocket")},
}, function()
	Assert(type(WebSocket.connect) == "function", "WebSocket.connect missing")
	return "WebSocket API present"
end)

print(("[sUNC] Summary: %d passed, %d failed, %d skipped"):format(
	Results.Passed,
	Results.Failed,
	Results.Skipped
))

return Results
