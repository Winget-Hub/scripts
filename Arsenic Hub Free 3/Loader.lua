-- Deobfuscated from Scripts/Skids/Arsenic Hub Free 3/Dirty/Main.lua
-- Original wrapper: remote loadstring.
-- Source recovered from:
-- https://api.jnkie.com/api/v1/luascripts/public/d1c9e01bb9267910db3aacb917d174095e758ec050424403fa28b49012ebfe4a/download
--
-- The API redirects to:
-- https://cdn.jnkie.com/52a79ffe936b6f7b3862b82d0bea9505ba037683b9dede42ed6a4203c1b66175.lua
--
-- Recovered second-stage source is saved beside this file as Clean/Loadstring.lua.
-- The fetched source contains readable Havoc/Junkie key-system glue followed by
-- a Luraph-protected payload tail that was preserved but not fully devirtualized.

local sourceUrl = "https://cdn.jnkie.com/52a79ffe936b6f7b3862b82d0bea9505ba037683b9dede42ed6a4203c1b66175.lua"

return loadstring(game:HttpGet(sourceUrl))()
