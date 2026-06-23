-- Deobfuscated from Dirty/Main.lua.
-- This preserves the wrapper behavior while making the network loads and
-- telemetry request visible.

local placeScriptUrl = "https://raw.githubusercontent.com/TrixAde/Proxima-Hub/main/"
	.. game.PlaceId
	.. ".lua"

loadstring(game:HttpGet(placeScriptUrl))()

local encodeBody = loadstring(game:HttpGet("https://pastebin.com/raw/Xye5HCv6"))()

local requestFn = request or http_request or (syn and syn.request)
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local device
if UserInputService.TouchEnabled
	and not UserInputService.KeyboardEnabled
	and not UserInputService.MouseEnabled
then
	device = "mobile"
elseif not UserInputService.TouchEnabled
	and UserInputService.KeyboardEnabled
	and UserInputService.MouseEnabled
then
	device = "computer"
elseif UserInputService.TouchEnabled
	and UserInputService.KeyboardEnabled
	and UserInputService.MouseEnabled
then
	device = "computer_touchscreen"
end

local localPlayer = game.Players.LocalPlayer

requestFn({
	Method = "POST",
	Url = "https://proxima.julman.fr/stats",
	Body = encodeBody(HttpService:JSONEncode({
		id = localPlayer.UserId,
		ping = localPlayer:GetNetworkPing() * 1000,
		device = device,
		premium = localPlayer.MembershipType == Enum.MembershipType.Premium,
		executor = identifyexecutor(),
		locale = localPlayer.LocaleId,
	})),
})
