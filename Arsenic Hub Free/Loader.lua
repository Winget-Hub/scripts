-- Deobfuscated from Scripts/Skids/Arsenic Hub Free/Dirty/Main.lua
-- Original wrapper: remote loadstring.
-- Source recovered from:
-- https://api.jnkie.com/api/v1/luascripts/public/ae6d3e6163817a447ddd82c645b024589c3b7c8ec872d44a86c3789f9f604cdf/download
--
-- The API redirects to:
-- https://cdn.jnkie.com/a53707746564fc4b83bf00b328e656e226bc637b9a142d1893dc13fba1e63a8f.lua
--
-- Recovered second-stage source is saved beside this file as Clean/Loadstring.lua.
-- The fetched source contains readable Havoc/Junkie key-system glue followed by
-- a Luraph-protected payload tail that was preserved but not fully devirtualized.

local sourceUrl = "https://cdn.jnkie.com/a53707746564fc4b83bf00b328e656e226bc637b9a142d1893dc13fba1e63a8f.lua"

return loadstring(game:HttpGet(sourceUrl))()
