-- WingetHUB UI library (embedded; was remote obsf.lua)
local WingetHUB = (function()
	local WingetHUB = {}
	WingetHUB.__index = WingetHUB
	local Players = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local LocalPlayer = Players.LocalPlayer
	WingetHUB.Icons = {
		Swords = "rbxassetid://7733674079",
		Eye = "rbxassetid://7733799131",
		EyeOff = "rbxassetid://7733798951",
		Settings = "rbxassetid://7734068321",
		Check = "rbxassetid://7733674239",
		X = "rbxassetid://7733783424",
		Info = "rbxassetid://7733771960",
		Alert = "rbxassetid://7733658504",
		Success = "rbxassetid://7733674239",
		Error = "rbxassetid://7733783424",
		Warning = "rbxassetid://7733658504",
		Crosshair = "rbxassetid://7733715400",
		Shield = "rbxassetid://7734056608",
		Zap = "rbxassetid://7734053426",
		Trash = "rbxassetid://7734042326",
		Activity = "rbxassetid://7733911671",
	}
	local function tween(obj, props, time)
		local t = TweenService:Create(
			obj,
			TweenInfo.new(time or 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			props
		)
		t:Play()
		return t
	end
	function WingetHUB:ShowLoadingScreen(gameName, isSupported, onStart)
		local guiParent = (typeof(gethui) == "function" and gethui())
			or game:GetService("CoreGui")
			or LocalPlayer:WaitForChild("PlayerGui")
		local bg = Instance.new("ScreenGui")
		bg.Name = "WingetHUB_Loader"
		bg.ResetOnSpawn = false
		bg.IgnoreGuiInset = true
		pcall(function()
			bg.Parent = guiParent
		end)
		local loader = Instance.new("Frame", bg)
		loader.Size = UDim2.new(0, 320, 0, 180)
		loader.Position = UDim2.new(0.5, -160, 0.5, -90)
		loader.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
		loader.BorderSizePixel = 0
		Instance.new("UICorner", loader).CornerRadius = UDim.new(0, 10)
		local stroke = Instance.new("UIStroke", loader)
		stroke.Color = Color3.fromRGB(40, 40, 48)
		stroke.Thickness = 1.2
		loader.ClipsDescendants = true
		local title = Instance.new("TextLabel", loader)
		title.Size = UDim2.new(1, 0, 0, 40)
		title.Position = UDim2.new(0, 0, 0, 15)
		title.BackgroundTransparency = 1
		title.Text = "WingetHUB"
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.Font = Enum.Font.GothamBold
		title.TextSize = 22
		local subtitle = Instance.new("TextLabel", loader)
		subtitle.Size = UDim2.new(1, 0, 0, 20)
		subtitle.Position = UDim2.new(0, 0, 0, 110)
		subtitle.BackgroundTransparency = 1
		subtitle.Text = "Checking Game Compatibility..."
		subtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
		subtitle.Font = Enum.Font.GothamMedium
		subtitle.TextSize = 13
		local spinner = Instance.new("ImageLabel", loader)
		spinner.Size = UDim2.new(0, 36, 0, 36)
		spinner.Position = UDim2.new(0.5, -18, 0.5, -20)
		spinner.BackgroundTransparency = 1
		spinner.Image = self.Icons.Activity
		spinner.ImageColor3 = Color3.fromRGB(0, 170, 255)
		local spin = true
		task.spawn(function()
			while spin do
				pcall(function()
					spinner.Rotation = (spinner.Rotation + 6) % 360
				end)
				task.wait(0.01)
			end
		end)
		local btn = Instance.new("TextButton", loader)
		btn.Size = UDim2.new(1, -40, 0, 40)
		btn.Position = UDim2.new(0, 20, 1, -55)
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
		btn.Text = ""
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
		local btnStroke = Instance.new("UIStroke", btn)
		btnStroke.Color = Color3.fromRGB(45, 45, 50)
		btn.Visible = false
		local btnLbl = Instance.new("TextLabel", btn)
		btnLbl.Size = UDim2.new(1, 0, 1, 0)
		btnLbl.BackgroundTransparency = 1
		btnLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
		btnLbl.Font = Enum.Font.GothamBold
		btnLbl.TextSize = 13
		task.spawn(function()
			task.wait(1.8)
			spin = false
			spinner.Visible = false
			if isSupported then
				subtitle.Text = "Game Supported: " .. gameName
				subtitle.TextColor3 = Color3.fromRGB(80, 220, 120)
				btnLbl.Text = "Launch WingetHUB"
				btn.BackgroundColor3 = Color3.fromRGB(40, 140, 80)
			else
				subtitle.Text = "Unsupported Game Detected"
				subtitle.TextColor3 = Color3.fromRGB(255, 100, 100)
				btnLbl.Text = "Exit"
				btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
			end
			btn.Visible = true
			btn.Position = UDim2.new(0, 20, 1, -35)
			btn.BackgroundTransparency = 1
			btnLbl.TextTransparency = 1
			tween(btn, { Position = UDim2.new(0, 20, 1, -55), BackgroundTransparency = 0 }, 0.3)
			tween(btnLbl, { TextTransparency = 0 }, 0.3)
		end)
		btn.MouseButton1Click:Connect(function()
			if isSupported then
				tween(loader, { Size = UDim2.new(0, 320, 0, 0), BackgroundTransparency = 1 }, 0.35).Completed:Wait()
				bg:Destroy()
				if onStart then
					onStart()
				end
			else
				bg:Destroy()
			end
		end)
	end
	function WingetHUB:Create(titleText)
		local UI = {
			Theme = {
				Accent = Color3.fromRGB(0, 170, 255),
				Bg = Color3.fromRGB(16, 16, 20),
				Sidebar = Color3.fromRGB(11, 11, 14),
				ModuleOff = Color3.fromRGB(22, 22, 28),
				Text = Color3.fromRGB(245, 245, 250),
				TextDim = Color3.fromRGB(130, 135, 150),
				Border = Color3.fromRGB(32, 32, 42),
			},
			Tabs = {},
			CurrentTab = nil,
			Config = { Modules = {} },
			AccentColors = {},
			TogglesList = {},
			SlidersList = {},
		}
		setmetatable(UI, self)
		local guiParent = (typeof(gethui) == "function" and gethui())
			or game:GetService("CoreGui")
			or LocalPlayer:WaitForChild("PlayerGui")
		UI.ScreenGui = Instance.new("ScreenGui")
		UI.ScreenGui.Name = "WingetHUB_" .. tostring(math.random(1000, 9999))
		UI.ScreenGui.ResetOnSpawn = false
		UI.ScreenGui.IgnoreGuiInset = true
		pcall(function()
			UI.ScreenGui.Parent = guiParent
		end)
		local main = Instance.new("Frame", UI.ScreenGui)
		main.Size = UDim2.new(0, 560, 0, 370)
		main.Position = UDim2.new(0.5, -280, 0.5, -185)
		main.BackgroundColor3 = UI.Theme.Bg
		main.BorderSizePixel = 0
		main.Active = true
		main.ClipsDescendants = true
		Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
		local stroke = Instance.new("UIStroke", main)
		stroke.Color = UI.Theme.Border
		stroke.Thickness = 1.2
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UI.MainFrame = main
		local accentLine = Instance.new("Frame", main)
		accentLine.Size = UDim2.new(1, 0, 0, 2.5)
		accentLine.BackgroundColor3 = UI.Theme.Accent
		accentLine.BorderSizePixel = 0
		table.insert(UI.AccentColors, accentLine)
		local dragBtn = Instance.new("TextButton", main)
		dragBtn.Size = UDim2.new(1, 0, 0, 45)
		dragBtn.BackgroundTransparency = 1
		dragBtn.Text = ""
		local dragging, startPos, dragStart = false, nil, nil
		dragBtn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = main.Position
			end
		end)
		dragBtn.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local delta = input.Position - dragStart
				main.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end)
		local title = Instance.new("TextLabel", main)
		title.Size = UDim2.new(1, -120, 0, 45)
		title.Position = UDim2.new(0, 16, 0, 0)
		title.BackgroundTransparency = 1
		title.Text = titleText or "WingetHUB"
		title.TextColor3 = UI.Theme.Text
		title.Font = Enum.Font.GothamBold
		title.TextSize = 14
		title.TextXAlignment = Enum.TextXAlignment.Left
		local controls = Instance.new("Frame", main)
		controls.Size = UDim2.new(0, 56, 0, 22)
		controls.Position = UDim2.new(1, -72, 0, 11)
		controls.BackgroundColor3 = UI.Theme.Sidebar
		Instance.new("UICorner", controls).CornerRadius = UDim.new(0, 5)
		Instance.new("UIStroke", controls).Color = UI.Theme.Border
		local controlsLayout = Instance.new("UIListLayout", controls)
		controlsLayout.FillDirection = Enum.FillDirection.Horizontal
		controlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
		local minBtn = Instance.new("TextButton", controls)
		minBtn.Size = UDim2.new(0.5, 0, 1, 0)
		minBtn.BackgroundTransparency = 1
		minBtn.Text = "-"
		minBtn.TextColor3 = UI.Theme.TextDim
		minBtn.Font = Enum.Font.GothamBold
		minBtn.TextSize = 14
		minBtn.LayoutOrder = 1
		local closeBtn = Instance.new("TextButton", controls)
		closeBtn.Size = UDim2.new(0.5, 0, 1, 0)
		closeBtn.BackgroundTransparency = 1
		closeBtn.Text = "X"
		closeBtn.TextColor3 = UI.Theme.TextDim
		closeBtn.Font = Enum.Font.GothamBold
		closeBtn.TextSize = 10
		closeBtn.LayoutOrder = 2
		closeBtn.MouseButton1Click:Connect(function()
			main.Visible = false
		end)
		local sidebar = Instance.new("Frame", main)
		sidebar.Size = UDim2.new(0, 150, 1, -45)
		sidebar.Position = UDim2.new(0, 0, 0, 45)
		sidebar.BackgroundColor3 = UI.Theme.Sidebar
		sidebar.BorderSizePixel = 0
		Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 10)
		local sbCover = Instance.new("Frame", sidebar)
		sbCover.Size = UDim2.new(0, 10, 1, 0)
		sbCover.Position = UDim2.new(1, -10, 0, 0)
		sbCover.BackgroundColor3 = UI.Theme.Sidebar
		sbCover.BorderSizePixel = 0
		local sbCoverTop = Instance.new("Frame", sidebar)
		sbCoverTop.Size = UDim2.new(1, 0, 0, 10)
		sbCoverTop.BackgroundColor3 = UI.Theme.Sidebar
		sbCoverTop.BorderSizePixel = 0
		local tabList = Instance.new("ScrollingFrame", sidebar)
		tabList.Size = UDim2.new(1, 0, 1, -70)
		tabList.BackgroundTransparency = 1
		tabList.ScrollBarThickness = 0
		local tabLayout = Instance.new("UIListLayout", tabList)
		tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabLayout.Padding = UDim.new(0, 4)
		local tabPadding = Instance.new("UIPadding", tabList)
		tabPadding.PaddingLeft = UDim.new(0, 8)
		tabPadding.PaddingRight = UDim.new(0, 8)
		local profile = Instance.new("Frame", sidebar)
		profile.Size = UDim2.new(1, 0, 0, 60)
		profile.Position = UDim2.new(0, 0, 1, -60)
		profile.BackgroundTransparency = 1
		local divider = Instance.new("Frame", profile)
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.BackgroundColor3 = UI.Theme.Border
		divider.BorderSizePixel = 0
		local avatar = Instance.new("ImageLabel", profile)
		avatar.Size = UDim2.new(0, 30, 0, 30)
		avatar.Position = UDim2.new(0, 10, 0.5, -15)
		avatar.BackgroundColor3 = UI.Theme.ModuleOff
		Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
		pcall(function()
			avatar.Image = Players:GetUserThumbnailAsync(
				LocalPlayer.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size48x48
			)
		end)
		local uname = Instance.new("TextLabel", profile)
		uname.Size = UDim2.new(1, -50, 0, 16)
		uname.Position = UDim2.new(0, 46, 0.15, 0)
		uname.BackgroundTransparency = 1
		uname.Text = LocalPlayer.Name
		uname.TextColor3 = UI.Theme.Text
		uname.Font = Enum.Font.GothamBold
		uname.TextSize = 11
		uname.TextXAlignment = Enum.TextXAlignment.Left
		local perfLbl = Instance.new("TextLabel", profile)
		perfLbl.Size = UDim2.new(1, -50, 0, 14)
		perfLbl.Position = UDim2.new(0, 46, 0.5, 0)
		perfLbl.BackgroundTransparency = 1
		perfLbl.Text = "Ping: 0ms | FPS: 0"
		perfLbl.TextColor3 = UI.Theme.TextDim
		perfLbl.Font = Enum.Font.GothamMedium
		perfLbl.TextSize = 9
		perfLbl.TextXAlignment = Enum.TextXAlignment.Left
		local fpsCount = 0
		local currentFPS = 60
		local lastFPSUpdate = os.clock()
		local fpsConn = RunService.RenderStepped:Connect(function()
			fpsCount = fpsCount + 1
			local now = os.clock()
			if now - lastFPSUpdate >= 1 then
				currentFPS = fpsCount
				fpsCount = 0
				lastFPSUpdate = now
			end
		end)
		task.spawn(function()
			while task.wait(1) do
				if not perfLbl or not perfLbl.Parent then
					break
				end
				local ping = 0
				pcall(function()
					ping = math.round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
				end)
				perfLbl.Text = string.format("Ping: %dms | FPS: %d", ping, currentFPS)
			end
		end)
		UI.SidebarList = tabList
		UI.ContentContainer = Instance.new("Frame", main)
		UI.ContentContainer.Size = UDim2.new(1, -165, 1, -55)
		UI.ContentContainer.Position = UDim2.new(0, 155, 0, 45)
		UI.ContentContainer.BackgroundTransparency = 1
		local floatingBtn = Instance.new("ImageButton", UI.ScreenGui)
		floatingBtn.Size = UDim2.new(0, 44, 0, 44)
		floatingBtn.Position = UDim2.new(0, 20, 0.5, -22)
		floatingBtn.BackgroundColor3 = UI.Theme.Sidebar
		floatingBtn.Image = self.Icons.Settings
		floatingBtn.ImageColor3 = UI.Theme.Accent
		floatingBtn.ScaleType = Enum.ScaleType.Fit
		Instance.new("UICorner", floatingBtn).CornerRadius = UDim.new(0, 8)
		Instance.new("UIStroke", floatingBtn).Color = UI.Theme.Border
		floatingBtn.Visible = false
		table.insert(UI.AccentColors, floatingBtn)
		local toggleKey = true
		local function setUIState(state)
			toggleKey = state
			if toggleKey then
				main.Visible = true
				tween(main, { Size = UDim2.new(0, 560, 0, 370) }, 0.3)
				floatingBtn.Visible = false
			else
				tween(main, { Size = UDim2.new(0, 560, 0, 0) }, 0.3).Completed:Wait()
				main.Visible = false
				floatingBtn.Visible = true
			end
		end
		UserInputService.InputBegan:Connect(function(input, gp)
			if gp then
				return
			end
			if input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightShift then
				setUIState(not toggleKey)
			end
		end)
		floatingBtn.MouseButton1Click:Connect(function()
			setUIState(true)
		end)
		minBtn.MouseButton1Click:Connect(function()
			setUIState(false)
		end)
		function UI:SetThemeColor(newColor)
			UI.Theme.Accent = newColor
			for _, obj in ipairs(UI.AccentColors) do
				pcall(function()
					if obj:IsA("Frame") or obj:IsA("TextButton") then
						obj.BackgroundColor3 = newColor
					elseif obj:IsA("TextLabel") then
						obj.TextColor3 = newColor
					elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
						obj.ImageColor3 = newColor
					elseif obj:IsA("UIStroke") then
						obj.Color = newColor
					end
				end)
			end
			for _, item in ipairs(UI.TogglesList) do
				pcall(function()
					if item.getState() then
						tween(item.toggleFrame, { BackgroundColor3 = newColor }, 0.2)
					end
				end)
			end
			for _, item in ipairs(UI.SlidersList) do
				pcall(function()
					item.fill.BackgroundColor3 = newColor
					item.valLbl.TextColor3 = newColor
				end)
			end
		end
		main.Size = UDim2.new(0, 560, 0, 0)
		tween(main, { Size = UDim2.new(0, 560, 0, 370) }, 0.4)
		UI._Cleanup = function()
			pcall(function()
				fpsConn:Disconnect()
			end)
		end
		return UI
	end
	function WingetHUB:CreateWindow(name, iconId)
		local tabBtn = Instance.new("TextButton", self.SidebarList)
		tabBtn.Size = UDim2.new(1, 0, 0, 34)
		tabBtn.BackgroundTransparency = 1
		tabBtn.Text = ""
		local indicator = Instance.new("Frame", tabBtn)
		indicator.Size = UDim2.new(0, 3, 0, 0)
		indicator.Position = UDim2.new(0, 0, 0.5, 0)
		indicator.BackgroundColor3 = self.Theme.Accent
		indicator.BorderSizePixel = 0
		Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 4)
		table.insert(self.AccentColors, indicator)
		local icon = Instance.new("ImageLabel", tabBtn)
		icon.Size = UDim2.new(0, 16, 0, 16)
		icon.Position = UDim2.new(0, 10, 0.5, -8)
		icon.BackgroundTransparency = 1
		icon.Image = iconId or ""
		icon.ImageColor3 = self.Theme.TextDim
		local lbl = Instance.new("TextLabel", tabBtn)
		lbl.Size = UDim2.new(1, -38, 1, 0)
		lbl.Position = UDim2.new(0, 32, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = name
		lbl.TextColor3 = self.Theme.TextDim
		lbl.Font = Enum.Font.GothamMedium
		lbl.TextSize = 12
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		tabBtn.MouseEnter:Connect(function()
			if self.CurrentTab ~= name then
				tween(lbl, { TextColor3 = Color3.fromRGB(210, 215, 230) }, 0.15)
				tween(icon, { ImageColor3 = Color3.fromRGB(210, 215, 230) }, 0.15)
			end
		end)
		tabBtn.MouseLeave:Connect(function()
			if self.CurrentTab ~= name then
				tween(lbl, { TextColor3 = self.Theme.TextDim }, 0.15)
				tween(icon, { ImageColor3 = self.Theme.TextDim }, 0.15)
			end
		end)
		local content = Instance.new("ScrollingFrame", self.ContentContainer)
		content.Size = UDim2.new(1, -10, 1, -10)
		content.Position = UDim2.new(0, 5, 0, 0)
		content.BackgroundTransparency = 1
		content.ScrollBarThickness = 2
		content.ScrollBarImageColor3 = self.Theme.Border
		content.Visible = false
		content.AutomaticCanvasSize = Enum.AutomaticSize.Y
		local layout = Instance.new("UIListLayout", content)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 6)
		local padding = Instance.new("UIPadding", content)
		padding.PaddingBottom = UDim.new(0, 10)
		self.Tabs[name] =
			{ Button = tabBtn, Label = lbl, Icon = icon, Indicator = indicator, Content = content, Layout = layout }
		tabBtn.MouseButton1Click:Connect(function()
			self.CurrentTab = name
			for n, t in pairs(self.Tabs) do
				local active = (n == name)
				t.Content.Visible = active
				tween(t.Label, { TextColor3 = active and self.Theme.Text or self.Theme.TextDim }, 0.2)
				tween(t.Icon, { ImageColor3 = active and self.Theme.Text or self.Theme.TextDim }, 0.2)
				t.Label.Font = active and Enum.Font.GothamBold or Enum.Font.GothamMedium
				if active then
					t.Indicator.Position = UDim2.new(0, 0, 0.5, -8)
					tween(t.Indicator, { Size = UDim2.new(0, 3, 0, 16) }, 0.25)
				else
					t.Indicator.Position = UDim2.new(0, 0, 0.5, 0)
					tween(t.Indicator, { Size = UDim2.new(0, 3, 0, 0) }, 0.2)
				end
			end
		end)
		if not self.CurrentTab then
			self.CurrentTab = name
			content.Visible = true
			lbl.TextColor3 = self.Theme.Text
			lbl.Font = Enum.Font.GothamBold
			icon.ImageColor3 = self.Theme.Text
			indicator.Size = UDim2.new(0, 3, 0, 16)
			indicator.Position = UDim2.new(0, 0, 0.5, -8)
		end
		return self.Tabs[name]
	end
	function WingetHUB:AddModule(category, modName, defaultState, callback)
		local tab = self.Tabs[category]
		local mod = { Enabled = defaultState, Settings = {} }
		self.Config.Modules[modName] = mod
		local header = Instance.new("TextLabel", tab.Content)
		header.Size = UDim2.new(1, -10, 0, 20)
		header.BackgroundTransparency = 1
		header.Text = "✦  " .. string.upper(modName)
		header.TextColor3 = self.Theme.TextDim
		header.Font = Enum.Font.GothamBold
		header.TextSize = 10
		header.TextXAlignment = Enum.TextXAlignment.Left
		local row = Instance.new("Frame", tab.Content)
		row.Size = UDim2.new(1, -10, 0, 38)
		row.BackgroundColor3 = self.Theme.ModuleOff
		Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
		Instance.new("UIStroke", row).Color = self.Theme.Border
		local label = Instance.new("TextLabel", row)
		label.Size = UDim2.new(1, -60, 1, 0)
		label.Position = UDim2.new(0, 12, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = "Enable " .. modName
		label.TextColor3 = self.Theme.Text
		label.Font = Enum.Font.GothamBold
		label.TextSize = 12
		label.TextXAlignment = Enum.TextXAlignment.Left
		local toggleFrame = Instance.new("Frame", row)
		toggleFrame.Size = UDim2.new(0, 32, 0, 18)
		toggleFrame.Position = UDim2.new(1, -44, 0.5, -9)
		toggleFrame.BackgroundColor3 = defaultState and self.Theme.Accent or Color3.fromRGB(40, 40, 50)
		Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0.5, 0)
		local tfStroke = Instance.new("UIStroke", toggleFrame)
		tfStroke.Color = self.Theme.Border
		local knob = Instance.new("Frame", toggleFrame)
		knob.Size = UDim2.new(0, 14, 0, 14)
		knob.Position = defaultState and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
		knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Instance.new("UICorner", knob).CornerRadius = UDim.new(0.5, 0)
		table.insert(self.TogglesList, {
			toggleFrame = toggleFrame,
			getState = function()
				return mod.Enabled
			end,
		})
		local btn = Instance.new("TextButton", row)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.BackgroundTransparency = 1
		btn.Text = ""
		btn.MouseButton1Click:Connect(function()
			mod.Enabled = not mod.Enabled
			local targetColor = mod.Enabled and self.Theme.Accent or Color3.fromRGB(40, 40, 50)
			local targetPos = mod.Enabled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
			tween(toggleFrame, { BackgroundColor3 = targetColor }, 0.2)
			tween(knob, { Position = targetPos }, 0.2)
			if callback then
				callback(mod.Enabled)
			end
		end)
		mod.Container = tab.Content
		return mod
	end
	function WingetHUB:AddToggle(mod, name, default, callback)
		mod.Settings[name] = default
		local row = Instance.new("Frame", mod.Container)
		row.Size = UDim2.new(1, -10, 0, 32)
		row.BackgroundColor3 = self.Theme.ModuleOff
		Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
		Instance.new("UIStroke", row).Color = self.Theme.Border
		local label = Instance.new("TextLabel", row)
		label.Size = UDim2.new(1, -50, 1, 0)
		label.Position = UDim2.new(0, 12, 0, 0)
		label.BackgroundTransparency = 1
		label.Text = name
		label.TextColor3 = self.Theme.TextDim
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 11
		label.TextXAlignment = Enum.TextXAlignment.Left
		local toggleFrame = Instance.new("Frame", row)
		toggleFrame.Size = UDim2.new(0, 30, 0, 16)
		toggleFrame.Position = UDim2.new(1, -42, 0.5, -8)
		toggleFrame.BackgroundColor3 = default and self.Theme.Accent or Color3.fromRGB(40, 40, 50)
		Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0.5, 0)
		local tfStroke = Instance.new("UIStroke", toggleFrame)
		tfStroke.Color = self.Theme.Border
		local knob = Instance.new("Frame", toggleFrame)
		knob.Size = UDim2.new(0, 12, 0, 12)
		knob.Position = default and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
		knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Instance.new("UICorner", knob).CornerRadius = UDim.new(0.5, 0)
		table.insert(self.TogglesList, {
			toggleFrame = toggleFrame,
			getState = function()
				return mod.Settings[name]
			end,
		})
		local btn = Instance.new("TextButton", row)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.BackgroundTransparency = 1
		btn.Text = ""
		btn.MouseButton1Click:Connect(function()
			mod.Settings[name] = not mod.Settings[name]
			local targetColor = mod.Settings[name] and self.Theme.Accent or Color3.fromRGB(40, 40, 50)
			local targetPos = mod.Settings[name] and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
			tween(toggleFrame, { BackgroundColor3 = targetColor }, 0.2)
			tween(knob, { Position = targetPos }, 0.2)
			if callback then
				callback(mod.Settings[name])
			end
		end)
	end
	function WingetHUB:AddSlider(mod, name, min, max, default, isFloat, callback)
		mod.Settings[name] = default
		local row = Instance.new("Frame", mod.Container)
		row.Size = UDim2.new(1, -10, 0, 42)
		row.BackgroundColor3 = self.Theme.ModuleOff
		Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
		Instance.new("UIStroke", row).Color = self.Theme.Border
		local label = Instance.new("TextLabel", row)
		label.Size = UDim2.new(0, 120, 0, 14)
		label.Position = UDim2.new(0, 12, 0, 6)
		label.BackgroundTransparency = 1
		label.Text = name
		label.TextColor3 = self.Theme.TextDim
		label.Font = Enum.Font.GothamMedium
		label.TextSize = 11
		label.TextXAlignment = Enum.TextXAlignment.Left
		local valLbl = Instance.new("TextLabel", row)
		valLbl.Size = UDim2.new(0, 60, 0, 14)
		valLbl.Position = UDim2.new(1, -72, 0, 6)
		valLbl.BackgroundTransparency = 1
		valLbl.Text = tostring(default)
		valLbl.TextColor3 = self.Theme.Accent
		valLbl.Font = Enum.Font.GothamBold
		valLbl.TextSize = 10
		valLbl.TextXAlignment = Enum.TextXAlignment.Right
		local bg = Instance.new("Frame", row)
		bg.Size = UDim2.new(1, -24, 0, 6)
		bg.Position = UDim2.new(0, 12, 0, 26)
		bg.BackgroundColor3 = self.Theme.Bg
		bg.BorderSizePixel = 0
		Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 3)
		local fill = Instance.new("Frame", bg)
		fill.Size = UDim2.new(math.clamp((default - min) / (max - min), 0, 1), 0, 1, 0)
		fill.BackgroundColor3 = self.Theme.Accent
		fill.BorderSizePixel = 0
		Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 3)
		local knob = Instance.new("Frame", fill)
		knob.Size = UDim2.new(0, 12, 0, 12)
		knob.Position = UDim2.new(1, -6, 0.5, -6)
		knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		knob.BorderSizePixel = 0
		Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
		table.insert(self.SlidersList, { fill = fill, valLbl = valLbl })
		local btn = Instance.new("TextButton", bg)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.Position = UDim2.new(0, 0, 0, -5)
		btn.BackgroundTransparency = 1
		btn.Text = ""
		local dragging = false
		btn.InputBegan:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
			end
		end)
		UserInputService.InputEnded:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
		local function updateSlider(inpX)
			local pct = math.clamp((inpX - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(pct, 0, 1, 0)
			local val = min + pct * (max - min)
			if not isFloat then
				val = math.floor(val)
			end
			valLbl.Text = isFloat and string.format("%.2f", val) or tostring(val)
			mod.Settings[name] = val
			if callback then
				callback(val)
			end
		end
		btn.MouseButton1Down:Connect(function()
			updateSlider(UserInputService:GetMouseLocation().X)
		end)
		UserInputService.InputChanged:Connect(function(inp)
			if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
				updateSlider(inp.Position.X)
			end
		end)
	end
	function WingetHUB:AddButton(mod, name, iconId, callback)
		local row = Instance.new("Frame", mod.Container)
		row.Size = UDim2.new(1, -10, 0, 36)
		row.BackgroundColor3 = self.Theme.ModuleOff
		Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
		Instance.new("UIStroke", row).Color = self.Theme.Border
		local icon, label
		if iconId and iconId ~= "" then
			icon = Instance.new("ImageLabel", row)
			icon.Size = UDim2.new(0, 16, 0, 16)
			icon.Position = UDim2.new(0, 12, 0.5, -8)
			icon.BackgroundTransparency = 1
			icon.Image = iconId
			icon.ImageColor3 = Color3.fromRGB(255, 75, 75)
			label = Instance.new("TextLabel", row)
			label.Size = UDim2.new(1, -40, 1, 0)
			label.Position = UDim2.new(0, 36, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = name
			label.TextColor3 = Color3.fromRGB(255, 75, 75)
			label.Font = Enum.Font.GothamBold
			label.TextSize = 12
			label.TextXAlignment = Enum.TextXAlignment.Left
		else
			label = Instance.new("TextLabel", row)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.Text = name
			label.TextColor3 = Color3.fromRGB(255, 75, 75)
			label.Font = Enum.Font.GothamBold
			label.TextSize = 12
			label.TextXAlignment = Enum.TextXAlignment.Center
		end
		row.MouseEnter:Connect(function()
			tween(row, { BackgroundColor3 = Color3.fromRGB(32, 24, 28) }, 0.15)
		end)
		row.MouseLeave:Connect(function()
			tween(row, { BackgroundColor3 = self.Theme.ModuleOff }, 0.15)
		end)
		local btn = Instance.new("TextButton", row)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.BackgroundTransparency = 1
		btn.Text = ""
		btn.MouseButton1Click:Connect(callback)
	end
	function WingetHUB:Notify(title, text, duration, notifType)
		if not self.NotifContainer then
			self.NotifContainer = Instance.new("Frame", self.ScreenGui or game:GetService("CoreGui"))
			self.NotifContainer.Size = UDim2.new(0, 240, 1, -40)
			self.NotifContainer.Position = UDim2.new(1, -250, 0, 20)
			self.NotifContainer.BackgroundTransparency = 1
			local nl = Instance.new("UIListLayout", self.NotifContainer)
			nl.SortOrder = Enum.SortOrder.LayoutOrder
			nl.Padding = UDim.new(0, 8)
			nl.VerticalAlignment = Enum.VerticalAlignment.Bottom
		end
		local colors = {
			Info = Color3.fromRGB(0, 170, 255),
			Success = Color3.fromRGB(80, 220, 120),
			Warning = Color3.fromRGB(255, 180, 50),
			Error = Color3.fromRGB(255, 75, 75),
		}
		notifType = notifType or "Info"
		local accentColor = colors[notifType] or colors.Info
		local iconId = self.Icons[notifType] or self.Icons.Info
		local notif = Instance.new("Frame", self.NotifContainer)
		notif.Size = UDim2.new(1, 0, 0, 60)
		notif.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
		Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
		Instance.new("UIStroke", notif).Color = Color3.fromRGB(38, 38, 48)
		local accent = Instance.new("Frame", notif)
		accent.Size = UDim2.new(0, 4, 1, 0)
		accent.BackgroundColor3 = accentColor
		accent.BorderSizePixel = 0
		Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 8)
		local icon = Instance.new("ImageLabel", notif)
		icon.Size = UDim2.new(0, 18, 0, 18)
		icon.Position = UDim2.new(0, 12, 0, 10)
		icon.BackgroundTransparency = 1
		icon.Image = iconId
		icon.ImageColor3 = accentColor
		local tLbl = Instance.new("TextLabel", notif)
		tLbl.Size = UDim2.new(1, -40, 0, 20)
		tLbl.Position = UDim2.new(0, 36, 0, 8)
		tLbl.BackgroundTransparency = 1
		tLbl.Text = title
		tLbl.TextColor3 = accentColor
		tLbl.Font = Enum.Font.GothamBold
		tLbl.TextSize = 13
		tLbl.TextXAlignment = Enum.TextXAlignment.Left
		local dLbl = Instance.new("TextLabel", notif)
		dLbl.Size = UDim2.new(1, -16, 0, 20)
		dLbl.Position = UDim2.new(0, 12, 0, 30)
		dLbl.BackgroundTransparency = 1
		dLbl.Text = text
		dLbl.TextColor3 = Color3.fromRGB(150, 150, 160)
		dLbl.Font = Enum.Font.GothamMedium
		dLbl.TextSize = 11
		dLbl.TextXAlignment = Enum.TextXAlignment.Left
		notif.Position = UDim2.new(1, 260, 0, 0)
		tween(notif, { Position = UDim2.new(0, 0, 0, 0) }, 0.3)
		task.spawn(function()
			task.wait(duration or 3)
			tween(notif, { Position = UDim2.new(1, 260, 0, 0) }, 0.3).Completed:Wait()
			notif:Destroy()
		end)
	end
	function WingetHUB:Destroy()
		if self._Cleanup then
			self._Cleanup()
		end
		if self.ScreenGui then
			self.ScreenGui:Destroy()
		end
	end
	return WingetHUB
end)()

local function safeLoad()
	if _G._AimAssistCleanup then
		pcall(_G._AimAssistCleanup)
	end
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local CoreGui = game:GetService("CoreGui")
	local LocalPlayer = Players.LocalPlayer
	local Mouse = LocalPlayer:GetMouse()
	local Camera = workspace.CurrentCamera
	local SUPPORTED_GAMES = { [120851538706364] = "Sheriffs Duels" }
	local isSupported = SUPPORTED_GAMES[game.PlaceId] ~= nil or game.GameId == 9561553764
	local gameName = SUPPORTED_GAMES[game.PlaceId] or (game.GameId == 9561553764 and "Sheriffs Duels") or "Unknown Game"
	WingetHUB:ShowLoadingScreen(gameName, isSupported, function()
		local SilentAimTarget = nil
		local CachedPlayers = {}
		local ESPDrawings = {}
		local OriginalSizes = {}
		local UI = WingetHUB:Create("Sniper Assist - Sheriffs Duels")
		UI:CreateWindow("Combat", WingetHUB.Icons.Swords)
		UI:CreateWindow("Visuals", WingetHUB.Icons.Eye)
		UI:CreateWindow("Settings", WingetHUB.Icons.Settings)
		local function isAlive(char)
			if not char then
				return false
			end
			local hum = char:FindFirstChildOfClass("Humanoid")
			return hum and hum.Health > 0
		end
		local function getTargetPart(char, partName)
			if not char then
				return nil
			end
			return char:FindFirstChild(partName) or char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
		end
		local function isVisible(part)
			local mod = UI.Config.Modules["Aimbot"]
			if not mod or not mod.Settings["Wall Check"] then
				return true
			end
			if not part or not part.Parent then
				return false
			end
			local rayDir = part.Position - Camera.CFrame.Position
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = { LocalPlayer.Character, Camera }
			rayParams.FilterType = Enum.RaycastFilterType.Blacklist
			local result = workspace:Raycast(Camera.CFrame.Position, rayDir, rayParams)
			if result and result.Instance then
				return result.Instance:IsDescendantOf(part.Parent)
			end
			return true
		end
		local function getClosestToCrosshair(fov)
			local best, bestDist = nil, fov
			local mousePos = Vector2.new(Mouse.X, Mouse.Y)
			local aimbotMod = UI.Config.Modules["Aimbot"]
			local maxDistance = aimbotMod.Settings["Max Distance"] or 400
			for player, charData in pairs(CachedPlayers) do
				local char = charData.char
				local part = charData.head
				if char and part and part.Parent and isAlive(char) then
					if aimbotMod.Settings["Team Check"] and player.Team == LocalPlayer.Team then
						continue
					end
					local distToPlr = (Camera.CFrame.Position - part.Position).Magnitude
					if distToPlr > maxDistance then
						continue
					end
					local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
					if onScreen and isVisible(part) then
						local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
						if dist < bestDist then
							bestDist = dist
							best = { player = player, character = char, part = part }
						end
					end
				end
			end
			return best
		end
		local aimbotMod = UI:AddModule("Combat", "Aimbot", false)
		UI:AddToggle(aimbotMod, "Team Check", true)
		UI:AddToggle(aimbotMod, "Wall Check", true)
		UI:AddToggle(aimbotMod, "Sticky Aim", true)
		UI:AddToggle(aimbotMod, "Prediction", false)
		UI:AddSlider(aimbotMod, "Max Distance", 50, 1000, 300, false)
		UI:AddSlider(aimbotMod, "Proj Speed", 100, 5000, 1000, false)
		UI:AddSlider(aimbotMod, "Smoothness", 0.01, 1, 0.2, true)
		UI:AddSlider(aimbotMod, "FOV Radius", 10, 800, 150, false)
		local silentAimMod = UI:AddModule("Combat", "Silent Aim", false)
		UI:AddToggle(silentAimMod, "Universal Hook", true)
		local triggerBotMod = UI:AddModule("Combat", "TriggerBot", false)
		UI:AddSlider(triggerBotMod, "Delay (ms)", 0, 500, 50, false)
		local hitboxMod = UI:AddModule("Combat", "Hitbox Expander", false, function(state)
			if not state then
				for part, data in pairs(OriginalSizes) do
					if part and part.Parent then
						part.Size = data.Size
						part.Transparency = data.Trans
						part.CanCollide = data.Collide
					end
				end
				table.clear(OriginalSizes)
			end
		end)
		UI:AddSlider(hitboxMod, "Size", 2, 25, 8, false)
		UI:AddToggle(hitboxMod, "Visible", true)
		local espMod = UI:AddModule("Visuals", "ESP", true)
		UI:AddToggle(espMod, "Team Check", false)
		UI:AddToggle(espMod, "Boxes", true)
		UI:AddToggle(espMod, "Names", true)
		UI:AddToggle(espMod, "Health", true)
		UI:AddToggle(espMod, "Tracers", false)
		local chamsMod = UI:AddModule("Visuals", "Chams", false)
		UI:AddToggle(chamsMod, "Team Check", false)
		UI:AddToggle(chamsMod, "Outline", true)
		local fovMod = UI:AddModule("Visuals", "FOV Circle", true)
		local settingsMod = UI:AddModule("Settings", "Script Control", true)
		UI:AddButton(settingsMod, "Destroy Script", WingetHUB.Icons.X, function()
			if _G._AimAssistCleanup then
				pcall(_G._AimAssistCleanup)
			end
		end)
		WingetHUB:Notify("Success", "Loaded Sheriffs Duels Script", 4, "Success")
		local function getESPDrawing(char)
			if not ESPDrawings[char] then
				ESPDrawings[char] = {
					Box = Drawing.new("Square"),
					Name = Drawing.new("Text"),
					HealthBg = Drawing.new("Square"),
					Health = Drawing.new("Square"),
					Tracer = Drawing.new("Line"),
					Highlight = Instance.new("Highlight"),
				}
				local d = ESPDrawings[char]
				d.Box.Thickness = 1.5
				d.Box.Filled = false
				d.Name.Size = 14
				d.Name.Center = true
				d.Name.Outline = true
				d.Name.Color = Color3.fromRGB(255, 255, 255)
				d.HealthBg.Color = Color3.fromRGB(20, 20, 20)
				d.HealthBg.Filled = true
				d.Health.Filled = true
				d.Tracer.Thickness = 1.5
			end
			return ESPDrawings[char]
		end
		local FOVDraw = Drawing.new("Circle")
		FOVDraw.Thickness = 1
		FOVDraw.Filled = false
		local cacheLoop = task.spawn(function()
			while true do
				local currentPlayers = {}
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then
						local char = player.Character
						if isAlive(char) then
							local head = getTargetPart(char, "Head")
							local root = getTargetPart(char, "HumanoidRootPart")
							if head and root then
								currentPlayers[player] = { char = char, head = head, root = root }
							end
						end
					end
				end
				CachedPlayers = currentPlayers
				task.wait(0.2)
			end
		end)
		local lastTrigger = tick()
		local renderConn = RunService.RenderStepped:Connect(function(deltaTime)
			Camera = workspace.CurrentCamera
			if fovMod.Enabled then
				FOVDraw.Visible = true
				FOVDraw.Radius = aimbotMod.Settings["FOV Radius"]
				FOVDraw.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
				FOVDraw.Color = UI.Theme.Accent
			else
				FOVDraw.Visible = false
			end
			local targetData = getClosestToCrosshair(aimbotMod.Settings["FOV Radius"])
			if silentAimMod.Enabled then
				SilentAimTarget = targetData
			else
				SilentAimTarget = nil
			end
			if aimbotMod.Enabled and targetData then
				local part = targetData.part
				if part and part.Parent then
					local targetPos = part.Position
					if aimbotMod.Settings["Prediction"] and part.AssemblyLinearVelocity then
						local dist = (Camera.CFrame.Position - targetPos).Magnitude
						local timeToHit = dist / aimbotMod.Settings["Proj Speed"]
						targetPos = targetPos + (part.AssemblyLinearVelocity * timeToHit)
					end
					local lookAt = CFrame.lookAt(Camera.CFrame.Position, targetPos)
					if aimbotMod.Settings["Sticky Aim"] then
						Camera.CFrame = lookAt
					else
						local smoothFactor = math.clamp(1 - aimbotMod.Settings["Smoothness"], 0.01, 1)
						local lerpSpeed = math.clamp(deltaTime * 35 * smoothFactor, 0.01, 1)
						Camera.CFrame = Camera.CFrame:Lerp(lookAt, lerpSpeed)
					end
				end
			end
			if triggerBotMod.Enabled and tick() - lastTrigger >= (triggerBotMod.Settings["Delay (ms)"] / 1000) then
				local mouseTarget = Mouse.Target
				if mouseTarget and mouseTarget.Parent then
					local char = mouseTarget:FindFirstAncestorOfClass("Model")
					if char and Players:GetPlayerFromCharacter(char) and isAlive(char) then
						local plr = Players:GetPlayerFromCharacter(char)
						local valid = true
						if aimbotMod.Settings["Team Check"] and plr.Team == LocalPlayer.Team then
							valid = false
						end
						if valid then
							mouse1click()
							lastTrigger = tick()
						end
					end
				end
			end
			local activeChars = {}
			for player, charData in pairs(CachedPlayers) do
				local char = charData.char
				local root = charData.root
				if char and char.Parent and root and root.Parent then
					activeChars[char] = true
					if hitboxMod.Enabled then
						local valid = true
						if aimbotMod.Settings["Team Check"] and player.Team == LocalPlayer.Team then
							valid = false
						end
						if valid then
							if not OriginalSizes[root] then
								OriginalSizes[root] =
									{ Size = root.Size, Trans = root.Transparency, Collide = root.CanCollide }
							end
							local sz = hitboxMod.Settings["Size"]
							root.Size = Vector3.new(sz, sz, sz)
							root.Transparency = hitboxMod.Settings["Visible"] and 0.5 or 1
							root.CanCollide = false
						end
					end
					if espMod.Enabled or chamsMod.Enabled then
						local validESP = true
						if espMod.Settings["Team Check"] and player.Team == LocalPlayer.Team then
							validESP = false
						end
						if validESP then
							local d = getESPDrawing(char)
							local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)
							local teamColor = player.TeamColor and player.TeamColor.Color or UI.Theme.Accent
							if chamsMod.Enabled then
								d.Highlight.Parent = CoreGui
								d.Highlight.Adornee = char
								d.Highlight.FillColor = teamColor
								d.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
								d.Highlight.FillTransparency = 0.5
								d.Highlight.OutlineTransparency = chamsMod.Settings["Outline"] and 0 or 1
							else
								d.Highlight.Adornee = nil
							end
							if espMod.Enabled and onScreen then
								local _, size = char:GetBoundingBox()
								local bHeight = (Camera.ViewportSize.Y / screenPos.Z) * size.Y * 0.5
								local bWidth = bHeight * (size.X / size.Y)
								local bx = screenPos.X - bWidth / 2
								local by = screenPos.Y - bHeight / 2
								d.Box.Visible = espMod.Settings["Boxes"]
								d.Box.Size = Vector2.new(bWidth, bHeight)
								d.Box.Position = Vector2.new(bx, by)
								d.Box.Color = teamColor
								local hum = char:FindFirstChildOfClass("Humanoid")
								if espMod.Settings["Health"] and hum then
									local hpPct = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
									d.HealthBg.Visible = true
									d.HealthBg.Size = Vector2.new(3, bHeight)
									d.HealthBg.Position = Vector2.new(bx - 5, by)
									d.Health.Visible = true
									local hH = bHeight * hpPct
									d.Health.Size = Vector2.new(3, hH)
									d.Health.Position = Vector2.new(bx - 5, by + bHeight - hH)
									d.Health.Color = teamColor:Lerp(Color3.fromRGB(255, 0, 0), 1 - hpPct)
								else
									d.HealthBg.Visible = false
									d.Health.Visible = false
								end
								d.Name.Visible = espMod.Settings["Names"]
								d.Name.Text = player.DisplayName
								d.Name.Position = Vector2.new(screenPos.X, by - 16)
								d.Tracer.Visible = espMod.Settings["Tracers"]
								d.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
								d.Tracer.To = Vector2.new(bx + bWidth / 2, by + bHeight)
								d.Tracer.Color = teamColor
							else
								d.Box.Visible = false
								d.Name.Visible = false
								d.HealthBg.Visible = false
								d.Health.Visible = false
								d.Tracer.Visible = false
							end
						else
							if ESPDrawings[char] then
								local d = ESPDrawings[char]
								d.Box.Visible = false
								d.Name.Visible = false
								d.HealthBg.Visible = false
								d.Health.Visible = false
								d.Tracer.Visible = false
								d.Highlight.Adornee = nil
							end
						end
					end
				end
			end
			for char, d in pairs(ESPDrawings) do
				if not activeChars[char] then
					d.Box:Remove()
					d.Name:Remove()
					d.HealthBg:Remove()
					d.Health:Remove()
					d.Tracer:Remove()
					if d.Highlight then
						d.Highlight:Destroy()
					end
					ESPDrawings[char] = nil
				end
			end
		end)
		local oldNamecall, oldIndex
		if hookmetamethod then
			oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
				local method = getnamecallmethod()
				if silentAimMod and silentAimMod.Enabled and not checkcaller() then
					local targetData = SilentAimTarget
					if targetData and targetData.part and targetData.part.Parent then
						local targetPos = targetData.part.Position
						if aimbotMod.Settings["Prediction"] and targetData.part.AssemblyLinearVelocity then
							local dist = (workspace.CurrentCamera.CFrame.Position - targetPos).Magnitude
							targetPos = targetPos
								+ (targetData.part.AssemblyLinearVelocity * (dist / aimbotMod.Settings["Proj Speed"]))
						end
						local valid = {
							FindPartOnRayWithIgnoreList = true,
							FindPartOnRayWithWhitelist = true,
							FindPartOnRay = true,
							Raycast = true,
							ScreenPointToRay = true,
							ViewportPointToRay = true,
						}
						if valid[method] then
							local args = { ... }
							local argCount = select("#", ...)
							local isGun = false
							if method == "Raycast" and typeof(args[2]) == "Vector3" and args[2].Magnitude > 20 then
								isGun = true
							end
							if
								string.find(method, "FindPartOnRay")
								and typeof(args[1]) == "Ray"
								and args[1].Direction.Magnitude > 20
							then
								isGun = true
							end
							if method == "ScreenPointToRay" or method == "ViewportPointToRay" then
								isGun = true
							end
							if isGun then
								if method == "ScreenPointToRay" or method == "ViewportPointToRay" then
									local origin = self.CFrame.Position
									local direction = (targetPos - origin).Unit
									return Ray.new(origin, direction)
								elseif method == "Raycast" then
									args[2] = (targetPos - args[1]).Unit * args[2].Magnitude
									return oldNamecall(self, unpack(args, 1, argCount))
								else
									args[1] = Ray.new(
										args[1].Origin,
										(targetPos - args[1].Origin).Unit * args[1].Direction.Magnitude
									)
									return oldNamecall(self, unpack(args, 1, argCount))
								end
							end
						end
					end
				end
				return oldNamecall(self, ...)
			end)
			oldIndex = hookmetamethod(game, "__index", function(self, index)
				if silentAimMod and silentAimMod.Enabled and not checkcaller() and self == Mouse then
					if index == "Hit" or index == "Target" or index == "UnitRay" then
						local targetData = SilentAimTarget
						if targetData and targetData.part and targetData.part.Parent then
							local targetPos = targetData.part.Position
							if index == "Hit" then
								return CFrame.new(targetPos)
							elseif index == "Target" then
								return targetData.part
							elseif index == "UnitRay" then
								local origin = workspace.CurrentCamera.CFrame.Position
								return Ray.new(origin, (targetPos - origin).Unit)
							end
						end
					end
				end
				return oldIndex(self, index)
			end)
		end
		_G._AimAssistCleanup = function()
			pcall(function()
				renderConn:Disconnect()
			end)
			pcall(function()
				task.cancel(cacheLoop)
			end)
			pcall(function()
				if UI and UI.Destroy then
					UI:Destroy()
				end
			end)
			pcall(function()
				FOVDraw:Remove()
			end)
			pcall(function()
				for char, d in pairs(ESPDrawings) do
					d.Box:Remove()
					d.Name:Remove()
					d.HealthBg:Remove()
					d.Health:Remove()
					d.Tracer:Remove()
					if d.Highlight then
						d.Highlight:Destroy()
					end
				end
				for part, data in pairs(OriginalSizes) do
					if part and part.Parent then
						part.Size = data.Size
						part.Transparency = data.Trans
						part.CanCollide = data.Collide
					end
				end
			end)
		end
	end)
end
safeLoad()
