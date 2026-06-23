-- Deobfuscated from Scripts/Skids/Arsenic Hub Free 2/Dirty/Main.lua
-- Original wrapper: remote loadstring.
-- Source was recovered from:
-- https://api.jnkie.com/api/v1/luascripts/public/d1a135ac03a36cad818c63a8b0671dc78fb0425bc825e276d43f63477eb4e505/download
--
-- The API initially redirected to:
-- https://cdn.jnkie.com/37c2a7c6619fec9a7d8c09e95a17ad597ab352f13dedc2b542c4eedf8555867f.lua
--
-- Later checks of the API endpoint returned 404, but the direct CDN GET still
-- returned the second-stage source. The recovered source is saved beside this
-- file as Clean/Loadstring.lua.
-- The fetched source contains readable Havoc/Junkie key-system glue followed by
-- a Luraph-protected payload tail that was preserved but not fully devirtualized.

local sourceUrl = "https://cdn.jnkie.com/37c2a7c6619fec9a7d8c09e95a17ad597ab352f13dedc2b542c4eedf8555867f.lua"

return loadstring(game:HttpGet(sourceUrl))()
