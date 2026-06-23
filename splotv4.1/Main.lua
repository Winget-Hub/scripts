-- Deobfuscated from Anundix obfuscation (sploit/exploit GUI v4.1)
-- Original: octal string escapes + random identifiers only; no hidden loaders.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- UI root
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 320, 0, 650)
mainFrame.Position = UDim2.new(0, 10, 0, 30)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = mainFrame
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "EXPLOIT GUI v4.1"
titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Parent = mainFrame
scrollFrame.Size = UDim2.new(1, 0, 1, -35)
scrollFrame.Position = UDim2.new(0, 0, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 5
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

local function createFeatureFrame(parent, titleText, yPos)
	local frame = Instance.new("Frame")
	frame.Parent = parent
	frame.Size = UDim2.new(0.95, 0, 0, 50)
	frame.Position = UDim2.new(0.025, 0, 0, yPos)
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	frame.BorderSizePixel = 0

	local label = Instance.new("TextLabel")
	label.Parent = frame
	label.Size = UDim2.new(0.55, 0, 0.5, 0)
	label.Position = UDim2.new(0.02, 0, 0.05, 0)
	label.Text = titleText
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.SourceSans
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	return frame
end

local function createToggle(parent, xPos)
	local button = Instance.new("TextButton")
	button.Parent = parent
	button.Size = UDim2.new(0.18, 0, 0.4, 0)
	button.Position = UDim2.new(xPos, 0, 0.5, 0)
	button.Text = "OFF"
	button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 11
	return button
end

local function createInput(parent, xPos)
	local box = Instance.new("TextBox")
	box.Parent = parent
	box.Size = UDim2.new(0.15, 0, 0.4, 0)
	box.Position = UDim2.new(xPos, 0, 0.5, 0)
	box.Text = ""
	box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.Font = Enum.Font.SourceSans
	box.TextSize = 12
	box.ClearTextOnFocus = false
	return box
end

local function createButton(parent, xPos, text, color)
	local button = Instance.new("TextButton")
	button.Parent = parent
	button.Size = UDim2.new(0.18, 0, 0.4, 0)
	button.Position = UDim2.new(xPos, 0, 0.5, 0)
	button.Text = text
	button.BackgroundColor3 = color or Color3.fromRGB(0, 100, 200)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSans
	button.TextSize = 10
	return button
end

-- Feature state
local flyEnabled = false
local spinEnabled = false
local noclipEnabled = false
local infiniteJumpEnabled = false
local flySpeed = 50
local spinSpeed = 100
local connections = {}

local keysHeld = {
	W = false,
	A = false,
	S = false,
	D = false,
	Space = false,
	LeftControl = false,
}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	local key = input.KeyCode
	if key == Enum.KeyCode.W then keysHeld.W = true end
	if key == Enum.KeyCode.A then keysHeld.A = true end
	if key == Enum.KeyCode.S then keysHeld.S = true end
	if key == Enum.KeyCode.D then keysHeld.D = true end
	if key == Enum.KeyCode.Space then keysHeld.Space = true end
	if key == Enum.KeyCode.LeftControl then keysHeld.LeftControl = true end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	local key = input.KeyCode
	if key == Enum.KeyCode.W then keysHeld.W = false end
	if key == Enum.KeyCode.A then keysHeld.A = false end
	if key == Enum.KeyCode.S then keysHeld.S = false end
	if key == Enum.KeyCode.D then keysHeld.D = false end
	if key == Enum.KeyCode.Space then keysHeld.Space = false end
	if key == Enum.KeyCode.LeftControl then keysHeld.LeftControl = false end
end)

-- 1. Fly (WASD + Space/LCtrl)
local flyFrame = createFeatureFrame(scrollFrame, "1. Fly (WASD + Space/LCtrl)", 5)
local flyToggle = createToggle(flyFrame, 0.6)
flyToggle.Text = "OFF"
flyToggle.MouseButton1Click:Connect(function()
	flyEnabled = not flyEnabled
	flyToggle.Text = flyEnabled and "ON" or "OFF"
	flyToggle.BackgroundColor3 = flyEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

	if flyEnabled then
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVelocity.Parent = humanoid

		local bodyGyro = Instance.new("BodyGyro")
		bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bodyGyro.P = 1000
		bodyGyro.D = 100
		bodyGyro.Parent = humanoid

		connections.fly = RunService.RenderStepped:Connect(function()
			if not flyEnabled or not rootPart then
				return
			end

			local moveDir = Vector3.new()
			local camera = workspace.CurrentCamera

			if keysHeld.W then
				moveDir += camera.CFrame.LookVector * Vector3.new(1, 0, 1)
			end
			if keysHeld.S then
				moveDir -= camera.CFrame.LookVector * Vector3.new(1, 0, 1)
			end
			if keysHeld.A then
				moveDir -= camera.CFrame.RightVector * Vector3.new(1, 0, 1)
			end
			if keysHeld.D then
				moveDir += camera.CFrame.RightVector * Vector3.new(1, 0, 1)
			end
			if keysHeld.Space then
				moveDir += Vector3.new(0, 1, 0)
			end
			if keysHeld.LeftControl then
				moveDir += Vector3.new(0, -1, 0)
			end

			if moveDir.Magnitude > 0 then
				bodyVelocity.Velocity = moveDir.Unit * flySpeed
				bodyGyro.CFrame = CFrame.lookAt(
					rootPart.Position,
					rootPart.Position + camera.CFrame.LookVector * Vector3.new(1, 0, 1)
				)
			else
				bodyVelocity.Velocity = Vector3.new(0, 0, 0)
			end
		end)
	else
		local bv = humanoid:FindFirstChildOfClass("BodyVelocity")
		if bv then
			bv:Destroy()
		end
		local bg = humanoid:FindFirstChildOfClass("BodyGyro")
		if bg then
			bg:Destroy()
		end
		if connections.fly then
			connections.fly:Disconnect()
		end
	end
end)

-- 2. Fly speed
local flySpeedFrame = createFeatureFrame(scrollFrame, "2. Fly Speed", 60)
local flySpeedInput = createInput(flySpeedFrame, 0.6)
flySpeedInput.Text = "50"
local flySpeedApply = createButton(flySpeedFrame, 0.78, "Apply", Color3.fromRGB(0, 150, 50))
flySpeedApply.MouseButton1Click:Connect(function()
	local value = tonumber(flySpeedInput.Text)
	if value and value > 0 then
		flySpeed = value
	end
end)

-- 3. Jump power
local jumpFrame = createFeatureFrame(scrollFrame, "3. Jump Power", 115)
local jumpInput = createInput(jumpFrame, 0.6)
jumpInput.Text = "50"
local jumpApply = createButton(jumpFrame, 0.78, "Apply", Color3.fromRGB(0, 100, 200))
jumpApply.MouseButton1Click:Connect(function()
	local value = tonumber(jumpInput.Text)
	if value and value > 0 then
		humanoid.JumpPower = value
	end
end)

-- 4. Walk speed
local walkFrame = createFeatureFrame(scrollFrame, "4. Walk Speed", 170)
local walkInput = createInput(walkFrame, 0.6)
walkInput.Text = "16"
local walkApply = createButton(walkFrame, 0.78, "Apply", Color3.fromRGB(0, 150, 100))
walkApply.MouseButton1Click:Connect(function()
	local value = tonumber(walkInput.Text)
	if value and value > 0 then
		humanoid.WalkSpeed = value
	end
end)

-- 5. Noclip
local noclipFrame = createFeatureFrame(scrollFrame, "5. Noclip", 225)
local noclipToggle = createToggle(noclipFrame, 0.6)
noclipToggle.Text = "OFF"
noclipToggle.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
noclipToggle.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	noclipToggle.Text = noclipEnabled and "ON" or "OFF"
	noclipToggle.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(128, 0, 128)

	if noclipEnabled then
		connections.noclip = RunService.Stepped:Connect(function()
			if not noclipEnabled then
				return
			end
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = false
				end
			end
		end)
	else
		if connections.noclip then
			connections.noclip:Disconnect()
		end
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end)

-- 6. Fast spin
local spinFrame = createFeatureFrame(scrollFrame, "6. Fast Spin", 280)
local spinToggle = createToggle(spinFrame, 0.6)
spinToggle.Text = "OFF"
spinToggle.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
spinToggle.MouseButton1Click:Connect(function()
	spinEnabled = not spinEnabled
	spinToggle.Text = spinEnabled and "ON" or "OFF"
	spinToggle.BackgroundColor3 = spinEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 165, 0)

	if spinEnabled then
		connections.spin = RunService.RenderStepped:Connect(function()
			if not spinEnabled or not rootPart then
				return
			end
			rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
		end)
	else
		if connections.spin then
			connections.spin:Disconnect()
		end
	end
end)

-- 7. Spin speed
local spinSpeedFrame = createFeatureFrame(scrollFrame, "7. Spin Speed", 335)
local spinSpeedInput = createInput(spinSpeedFrame, 0.6)
spinSpeedInput.Text = "100"
local spinSpeedApply = createButton(spinSpeedFrame, 0.78, "Apply", Color3.fromRGB(200, 100, 0))
spinSpeedApply.MouseButton1Click:Connect(function()
	local value = tonumber(spinSpeedInput.Text)
	if value and value > 0 then
		spinSpeed = value
	end
end)

-- 8. Infinite jump
local infJumpFrame = createFeatureFrame(scrollFrame, "8. Infinite Jump", 390)
local infJumpToggle = createToggle(infJumpFrame, 0.6)
infJumpToggle.Text = "OFF"
infJumpToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 200)
infJumpToggle.MouseButton1Click:Connect(function()
	infiniteJumpEnabled = not infiniteJumpEnabled
	infJumpToggle.Text = infiniteJumpEnabled and "ON" or "OFF"
	infJumpToggle.BackgroundColor3 = infiniteJumpEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 200, 200)

	if infiniteJumpEnabled then
		connections.infJump = UserInputService.JumpRequest:Connect(function()
			if infiniteJumpEnabled then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	else
		if connections.infJump then
			connections.infJump:Disconnect()
		end
	end
end)

-- 9. Teleport to mouse
local tpFrame = createFeatureFrame(scrollFrame, "9. Teleport to Mouse", 445)
local tpButton = createButton(tpFrame, 0.6, "TELEPORT", Color3.fromRGB(200, 0, 0))
tpButton.MouseButton1Click:Connect(function()
	local mouse = player:GetMouse()
	local hit = mouse.Hit
	if hit and rootPart then
		rootPart.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
	end
end)

-- 10. Reset character
local resetFrame = createFeatureFrame(scrollFrame, "10. Reset Character", 500)
local resetButton = createButton(resetFrame, 0.6, "RESET", Color3.fromRGB(150, 0, 0))
resetButton.MouseButton1Click:Connect(function()
	character:BreakJoints()
	wait(0.5)
	character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
end)

scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 560)

-- Draggable main window
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

print("Exploit GUI v4.1 loaded! All textboxes and buttons properly separated.")
