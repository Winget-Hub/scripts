local invite_code = "d6B27J2uYm"
local invite_link = "https://discord.gg/" .. invite_code

local v1 = Instance.new("ScreenGui")
local v2 = Instance.new("Frame")
local v3 = Instance.new("UICorner")
local v6 = Instance.new("TextLabel")
local v7 = Instance.new("TextLabel")
local v4 = Instance.new("TextButton")
local v4_v1 = Instance.new("UICorner")
local v5 = Instance.new("TextButton")
local v5_v1 = Instance.new("UICorner")

v1.Name = "v1"
v1.Parent = game:GetService("CoreGui")
v1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

v2.Name = "v2"
v2.Parent = v1
v2.AnchorPoint = Vector2.new(0.5, 0.5)
v2.BackgroundColor3 = Color3.fromRGB(25, 26, 31)
v2.BorderColor3 = Color3.fromRGB(0, 0, 0)
v2.BorderSizePixel = 0
v2.Position = UDim2.new(0.5, 0, 0.450602412, 0)
v2.Size = UDim2.new(0, 233, 0, 200)

v3.Name = "v3"
v3.Parent = v2

v6.Name = "v6"
v6.Parent = v2
v6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v6.BackgroundTransparency = 1.000
v6.BorderColor3 = Color3.fromRGB(0, 0, 0)
v6.BorderSizePixel = 0
v6.Position = UDim2.new(-0.00429184549, 0, 0.0299999993, 0)
v6.Size = UDim2.new(0, 233, 0, 42)
v6.Font = Enum.Font.Unknown
v6.Text = "Discord"
v6.TextColor3 = Color3.fromRGB(255, 255, 255)
v6.TextScaled = true
v6.TextSize = 14.000
v6.TextWrapped = true

v7.Name = "v7"
v7.Parent = v2
v7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v7.BackgroundTransparency = 1.000
v7.BorderColor3 = Color3.fromRGB(0, 0, 0)
v7.BorderSizePixel = 0
v7.Position = UDim2.new(0.0515021458, 0, 0.274858087, 0)
v7.Size = UDim2.new(0, 208, 0, 90)
v7.Font = Enum.Font.Unknown
v7.Text = "Please join our discord. This not only helps us grow but also allows you to get support."
v7.TextColor3 = Color3.fromRGB(255, 255, 255)
v7.TextScaled = true
v7.TextSize = 14.000
v7.TextWrapped = true

v4.Name = "v4"
v4.Parent = v2
v4.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
v4.BorderColor3 = Color3.fromRGB(0, 0, 0)
v4.BorderSizePixel = 0
v4.Position = UDim2.new(0.0515021458, 0, 0.819999993, 0)
v4.Size = UDim2.new(0, 97, 0, 26)
v4.Font = Enum.Font.Ubuntu
v4.Text = "Copy Invite"
v4.TextColor3 = Color3.fromRGB(0, 0, 0)
v4.TextSize = 14.000

v4_v1.Name = "v4_v1"
v4_v1.Parent = v4

v5.Name = "v5"
v5.Parent = v2
v5.BackgroundColor3 = Color3.fromRGB(202, 76, 66)
v5.BorderColor3 = Color3.fromRGB(0, 0, 0)
v5.BorderSizePixel = 0
v5.Position = UDim2.new(0.519313276, 0, 0.819999993, 0)
v5.Size = UDim2.new(0, 99, 0, 26)
v5.Font = Enum.Font.Ubuntu
v5.Text = "Close"
v5.TextColor3 = Color3.fromRGB(0, 0, 0)
v5.TextSize = 14.000

v5_v1.Name = "v5_v1"
v5_v1.Parent = v5

v4.MouseButton1Click:Connect(function()
	setclipboard(invite_link)

	if not request then
		return
	end

	request({
		Url = "http://127.0.0.1:6463/rpc?v=1",
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json",
			Origin = "https://discord.com"
		},
		Body = game:GetService("HttpService"):JSONEncode({
			cmd = "INVITE_BROWSER",
			nonce = game:GetService("HttpService"):GenerateGUID(false),
			args = {
				code = invite_code
			}
		})
	})
end)

v5.MouseButton1Click:Connect(function()
	v1:Destroy()
end)