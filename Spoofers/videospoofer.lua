local ReplicatedStorage = game:GetService("ReplicatedStorage")

local gui = Instance.new("ScreenGui")
gui.Name = "SpooferUI"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 110)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
title.Text = "Spoofer"
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.9, 0, 0, 25)
button.Position = UDim2.new(0.05, 0, 0.35, 0)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.Text = "Disabled"
button.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.9, 0, 0, 25)
textBox.Position = UDim2.new(0.05, 0, 0.65, 0)
textBox.PlaceholderText = "FPS"
textBox.Text = ""
textBox.Parent = frame


local enabled = false

local function updateButton()
	if enabled then
		button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		button.Text = "Enabled"
	else
		button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		button.Text = "Disabled"
	end
end

updateButton()

button.MouseButton1Click:Connect(function()
	enabled = not enabled
	updateButton()
end)

ReplicatedStorage:WaitForChild("meow").OnClientEvent:Connect(function(data)
	if not enabled then return end

	local fpsInput = tonumber(textBox.Text)
	if not fpsInput then return end

	ReplicatedStorage:WaitForChild("nya"):FireServer({
		token = data.token,
		fps = fpsInput,
		mem = 1032322,
		t = "metrics",
		res = Vector2.new(132232, 1323232),
		gfx = Enum.SavedQualitySetting.QualityLevel10
	})
end)