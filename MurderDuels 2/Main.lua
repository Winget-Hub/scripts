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
	local WingetHUB = nil
	local success, result = pcall(function()
		return loadstring(
			game:HttpGet(
				"https://raw.githubusercontent.com/AkramStation/LuauProjects/main/build/obsf.lua?t="
					.. tostring(math.random(100000, 999999))
			)
		)()
	end)
	if success and result then
		WingetHUB = result
	else
		warn("Sniper Assist: Failed to load UI Library: " .. tostring(result))
		return
	end
	local SUPPORTED_GAMES = { [120851538706364] = "Sheriffs Duels" }
	local isSupported = SUPPORTED_GAMES[game.PlaceId] ~= nil or game.GameId == 9561553764
	local gameName = SUPPORTED_GAMES[game.PlaceId] or (game.GameId == 9561553764 and "Sheriffs Duels") or "Unknown Game"
	WingetHUB:ShowLoadingScreen(gameName, isSupported, function()
		local SilentAimTarget = nil
		local CachedPlayers = {}
		local ESPDrawings = {}
		local OriginalSizes = {}
		local UI = WingetHUB:Create("Sniper Assist - Sheriffs Duels")
		UI:CreateWindow("Combat", WingetHUB.Icons.Crosshair)
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
			local targetPartName = aimbotMod.Settings["Target Torso"] and "HumanoidRootPart" or "Head"
			for player, charData in pairs(CachedPlayers) do
				local char = charData.char
				local part = getTargetPart(char, targetPartName)
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
		UI:AddToggle(aimbotMod, "Target Torso", false)
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
		UI:AddButton(settingsMod, "Destroy Script", WingetHUB.Icons.Trash, function()
			if _G._AimAssistCleanup then
				pcall(_G._AimAssistCleanup)
			end
		end)
		local themeMod = UI:AddModule("Settings", "UI Accent Color", true)
		UI:AddButton(themeMod, "Classic Cyan", "", function()
			UI:SetThemeColor(Color3.fromRGB(0, 170, 255))
		end)
		UI:AddButton(themeMod, "Emerald Green", "", function()
			UI:SetThemeColor(Color3.fromRGB(80, 220, 120))
		end)
		UI:AddButton(themeMod, "Crimson Red", "", function()
			UI:SetThemeColor(Color3.fromRGB(255, 75, 75))
		end)
		UI:AddButton(themeMod, "Royal Violet", "", function()
			UI:SetThemeColor(Color3.fromRGB(160, 80, 255))
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
				local targetPartName = aimbotMod.Settings["Target Torso"] and "HumanoidRootPart" or "Head"
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer then
						local char = player.Character
						if isAlive(char) then
							local targetPart = getTargetPart(char, targetPartName)
							local root = getTargetPart(char, "HumanoidRootPart")
							if targetPart and root then
								currentPlayers[player] = { char = char, head = targetPart, root = root }
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
