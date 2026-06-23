--!nocheck
-- StarterPlayerScripts or StarterGui LocalScript for games you own.
-- Adds a small reset button that asks the server-side safeguard to reset your
-- own currency values to zero.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local resetRemote = ReplicatedStorage:WaitForChild("ResetOwnMoneyToZero")

local gui = Instance.new("ScreenGui")
gui.Name = "MoneyResetSafeguard"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "ResetMoneyToZero"
button.AnchorPoint = Vector2.new(1, 1)
button.Position = UDim2.fromScale(0.98, 0.96)
button.Size = UDim2.fromOffset(170, 38)
button.BackgroundColor3 = Color3.fromRGB(130, 20, 24)
button.BorderSizePixel = 0
button.Font = Enum.Font.GothamMedium
button.Text = "Reset Money to 0"
button.TextColor3 = Color3.fromRGB(255, 245, 245)
button.TextSize = 14
button.Parent = gui

button.Activated:Connect(function()
    resetRemote:FireServer()
end)
