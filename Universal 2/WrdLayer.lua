-- Readable reconstruction of the first WeAreDevs VM-obfuscated layer in
-- Scripts/Skids/Universal 2/Clean/Loadstring.lua.
--
-- This was recovered with a sandbox that stubbed Roblox/executor APIs. The WRD
-- layer reached the Junkie/Havoc key-system fetches below before the sandboxed
-- placeholder library caused execution to stop at a `.service` assignment.

local havocUrl = "https://cdn.jnkie.com/havoc.lua"
local junkieSdkUrl = "https://jnkie.com/sdk/library.lua"

local Hub = loadstring(game:HttpGet(havocUrl))()
local junkieLibrary = loadstring(game:HttpGet(junkieSdkUrl))()

return {
	Hub = Hub,
	JunkieLibrary = junkieLibrary,
}
