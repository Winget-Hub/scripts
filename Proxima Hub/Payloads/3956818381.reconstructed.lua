--!nocheck
-- Best-effort readable reconstruction of the Proxima Hub payload for
-- Roblox place 3956818381 / Ninja Legends.
--
-- Recovered from the MoonSec V2 payload in Dirty/Payloads/3956818381.lua.
-- The exact original source names/control flow were not fully recovered, but
-- the devirtualized constants and function prototypes map to this behavior.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local rEvents = ReplicatedStorage:WaitForChild("rEvents")

local state = {
	AutoSwing = false,
	AutoSell = false,
	AutoEgg = false,
	AutoSpin = false,
	AutoChi = false,
	AutoCoins = false,
	AutoSpam = false,
	AutoCollectSoul = false,
	AutoEvolve = false,
	AutoSellPets = false,
	HoopsFarm = false,
	RobotBossAutoFarm = false,
	AncientMagmaBossAutoFarm = false,
	EternalBossAutoFarm = false,
	CollectallChestsRewards = false,
	HideMaxNin = false,
	InfiniteJump = false,
	Xray = false,
	Fps = false,
	Mess = "",
	SelectedEgg = nil,
	SelectedPet = nil,
	SelectedIsland = nil,
	SelectedElement = nil,
}

local function loopWhile(flagName, callback)
	task.spawn(function()
		while state[flagName] do
			pcall(callback)
			task.wait()
		end
	end)
end

local function getNinjaEvent()
	return LocalPlayer:WaitForChild("ninjaEvent")
end

local function getRemote(name)
	return rEvents:WaitForChild(name)
end

local function teleportTo(cframe)
	HumanoidRootPart.CFrame = cframe
end

local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Proxima Hub",
			Text = tostring(text),
			Duration = 5,
		})
	end)
end

local function setMaxZoom()
	LocalPlayer.CameraMaxZoomDistance = math.huge
end

local function collectChests()
	local chestRewards = Workspace:WaitForChild("chestRewards")
	local checkChestRemote = getRemote("checkChestRemote")

	for _, chest in pairs(chestRewards:GetChildren()) do
		checkChestRemote:InvokeServer(chest.Name)
	end
end

local function collectTouchInterests()
	for _, descendant in pairs(Workspace:GetDescendants()) do
		if descendant:IsA("TouchTransmitter") and descendant.Parent then
			firetouchinterest(HumanoidRootPart, descendant.Parent, 0)
			task.wait()
			firetouchinterest(HumanoidRootPart, descendant.Parent, 1)
		end
	end
end

local function hatchSelectedEgg()
	if state.SelectedEgg then
		getRemote("openCrystalRemote"):InvokeServer("openCrystal", state.SelectedEgg)
	end
end

local function setWalkSpeed(speed)
	Humanoid.WalkSpeed = tonumber(speed) or Humanoid.WalkSpeed
end

local function setGravity(gravity)
	Workspace.Gravity = tonumber(gravity) or Workspace.Gravity
end

local function hideMaxNinjitsuPrompt(enabled)
	state.HideMaxNin = enabled
	local gameGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("gameGui")
	local menu = gameGui:FindFirstChild("maxNinjitsuMenu")
	if menu then
		menu.Visible = not enabled
	end
end

local function unlockElements()
	local elementMasteryEvent = getRemote("elementMasteryEvent")
	for _, element in pairs({
		"Electral Chaos",
		"Eternity Storm",
		"Shadowfire",
		"Frost",
		"Inferno",
		"Lightning",
		"Masterful Wrath",
	}) do
		elementMasteryEvent:FireServer(element)
	end
end

local function unlockSelectedElement()
	if state.SelectedElement then
		getRemote("elementMasteryEvent"):FireServer(state.SelectedElement)
	end
end

local function buyAllClasses()
	local ranks = ReplicatedStorage:WaitForChild("Ranks")
	for _, rank in pairs(ranks:GetChildren()) do
		getNinjaEvent():FireServer("buyRank", rank.Name)
		task.wait()
	end
end

local function autoSwing()
	loopWhile("AutoSwing", function()
		getNinjaEvent():FireServer("swingKatana")
	end)
end

local function buyAllBelts()
	loopWhile("AutoSell", function()
		getNinjaEvent():FireServer("buyAllBelts", "Ground")
	end)
end

local function buyAllSkills()
	loopWhile("AutoSell", function()
		getNinjaEvent():FireServer("buyAllSkills", "Ground")
	end)
end

local function buyAllShurikens()
	loopWhile("AutoSell", function()
		getNinjaEvent():FireServer("buyAllShurikens", "Ground")
	end)
end

local function buyAllSwords()
	loopWhile("AutoSell", function()
		getNinjaEvent():FireServer("buyAllSwords", "Ground")
	end)
end

local function autoEvolvePets()
	loopWhile("AutoEvolve", function()
		getRemote("autoEvolveRemote"):InvokeServer()
	end)
end

local function sellSelectedPets()
	local petsFolder = LocalPlayer:WaitForChild("petsFolder")
	local sellPetEvent = getRemote("sellPetEvent")

	for _, pet in pairs(petsFolder:GetChildren()) do
		if state.AutoSellPets and pet.Name == state.SelectedPet then
			sellPetEvent:FireServer(pet)
			task.wait()
		end
	end
end

local function teleportToBoss(bossName)
	local bossFolder = Workspace:WaitForChild("bossFolder")
	local boss = bossFolder:FindFirstChild(bossName)
	if boss and boss:FindFirstChild("HumanoidRootPart") then
		teleportTo(boss.HumanoidRootPart.CFrame)
	end
end

local function farmAncientMagmaBoss()
	loopWhile("AncientMagmaBossAutoFarm", function()
		teleportToBoss("Ancient Magma Boss")
		getRemote("bossDamageEvent"):FireServer("Ancient Magma Boss")
	end)
end

local function farmRobotBoss()
	loopWhile("RobotBossAutoFarm", function()
		teleportToBoss("Robot Boss")
		getRemote("bossDamageEvent"):FireServer("Robot Boss")
	end)
end

local function farmEternalBoss()
	loopWhile("EternalBossAutoFarm", function()
		teleportToBoss("Eternal Boss")
		getRemote("bossDamageEvent"):FireServer("Eternal Boss")
	end)
end

local function teleportIsland()
	local islandParts = Workspace:WaitForChild("islandUnlockParts")
	local island = islandParts:FindFirstChild(state.SelectedIsland)
	if island and island:FindFirstChild("islandSignPart") then
		teleportTo(island.islandSignPart.CFrame)
	end
end

local function collectSpawnedCoins(kind)
	local valley = Workspace:WaitForChild("Valley")
	local spawnedCoins = valley:WaitForChild("spawnedCoins")

	for _, coin in pairs(spawnedCoins:GetChildren()) do
		if coin.Name == kind and coin:FindFirstChild("TouchInterest") then
			teleportTo(coin.CFrame)
			task.wait()
		end
	end
end

local function autoChi()
	loopWhile("AutoChi", function()
		collectSpawnedCoins("Chi")
	end)
end

local function autoCoins()
	loopWhile("AutoCoins", function()
		collectSpawnedCoins("Coin")
	end)
end

local function hoopsFarm()
	loopWhile("HoopsFarm", function()
		for _, hoop in pairs(Workspace:WaitForChild("Hoops"):GetDescendants()) do
			if hoop.Name == "Hoop" and hoop:IsA("BasePart") then
				teleportTo(hoop.CFrame)
				task.wait()
			end
		end
	end)
end

local function getAllWeapons()
	local weapons = Workspace:WaitForChild("Weapons")
	local backpack = LocalPlayer:WaitForChild("Backpack")
	for _, weapon in pairs(weapons:GetDescendants()) do
		if weapon.ClassName == "Tool" then
			weapon.Parent = backpack
		end
	end
end

local function setXray(enabled)
	state.Xray = enabled
	for _, descendant in pairs(game:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.LocalTransparencyModifier = enabled and 0.75 or 0
		end
	end
end

local function deleteMapFolders()
	for _, item in pairs(Workspace:GetChildren()) do
		if item.Name ~= "Terrain" and item.Name ~= "Camera" then
			item:Destroy()
		end
	end
end

local function applyBrightLighting()
	Lighting.Saturation = 0
	Lighting.Contrast = 0
	Lighting.TintColor = Color3.fromRGB(255, 255, 255)

	for _, child in pairs(Lighting:GetChildren()) do
		if child:IsA("Sky") or child:IsA("ColorCorrectionEffect") then
			child:Destroy()
		end
	end

	local sky = Instance.new("Sky")
	sky.SkyboxBk = ""
	sky.SkyboxDn = ""
	sky.SkyboxFt = ""
	sky.SkyboxLf = ""
	sky.SkyboxRt = ""
	sky.SkyboxUp = ""
	sky.MoonTextureId = ""
	sky.SunTextureId = ""
	sky.Parent = Lighting
end

local function infiniteJump()
	loopWhile("InfiniteJump", function()
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		Humanoid.Jump = true
	end)
end

local function spinFortuneWheel()
	loopWhile("AutoSpin", function()
		Workspace:WaitForChild("openFortuneWheelRemote"):InvokeServer()
	end)
end

local function autoSell()
	loopWhile("AutoSell", function()
		teleportTo(CFrame.new(85, 9123, 129))
	end)
end

local function spamChat()
	loopWhile("AutoSpam", function()
		local sayMessage = ReplicatedStorage
			:WaitForChild("DefaultChatSystemChatEvents")
			:WaitForChild("SayMessageRequest")
		sayMessage:FireServer(state.Mess, "All")
	end)
end

local function copyDiscord()
	setclipboard("discord.gg/gQEH2uZxUk")
end

local function setFpsCap(value)
	if setfpscap then
		setfpscap(tonumber(value) or 60)
	end
end

-- The original script built a UI through a remote UI library loaded with
-- loadstring(game:HttpGet(...)). The decrypted constants show these controls:
-- CreateWindow, CreateTab, CreateToggle, CreateButton, CreateDropdown,
-- CreateSlider, CreateTextbox, and CreateLabel.
--
-- Main controls included:
-- AutoSwing, AutoSell, AutoEgg, AutoSpin, AutoChi, AutoCoins, AutoSpam,
-- AutoCollectSoul, AutoEvolve, AutoSellPets, HoopsFarm, GetAllWeapons,
-- RobotBossAutoFarm, AncientMagmaBossAutoFarm, EternalBossAutoFarm,
-- CollectallChestsRewards, HideMaxNin, InfiniteJump, Xray, Fps, selected egg,
-- selected pet, selected island, selected element, walk speed, gravity,
-- field of view, chat message text, copy Discord, delete folders, and lighting.

return {
	state = state,
	setMaxZoom = setMaxZoom,
	collectChests = collectChests,
	collectTouchInterests = collectTouchInterests,
	hatchSelectedEgg = hatchSelectedEgg,
	setWalkSpeed = setWalkSpeed,
	setGravity = setGravity,
	hideMaxNinjitsuPrompt = hideMaxNinjitsuPrompt,
	unlockElements = unlockElements,
	unlockSelectedElement = unlockSelectedElement,
	buyAllClasses = buyAllClasses,
	autoSwing = autoSwing,
	buyAllBelts = buyAllBelts,
	buyAllSkills = buyAllSkills,
	buyAllShurikens = buyAllShurikens,
	buyAllSwords = buyAllSwords,
	autoEvolvePets = autoEvolvePets,
	sellSelectedPets = sellSelectedPets,
	farmAncientMagmaBoss = farmAncientMagmaBoss,
	farmRobotBoss = farmRobotBoss,
	farmEternalBoss = farmEternalBoss,
	teleportIsland = teleportIsland,
	autoChi = autoChi,
	autoCoins = autoCoins,
	hoopsFarm = hoopsFarm,
	getAllWeapons = getAllWeapons,
	setXray = setXray,
	deleteMapFolders = deleteMapFolders,
	applyBrightLighting = applyBrightLighting,
	infiniteJump = infiniteJump,
	spinFortuneWheel = spinFortuneWheel,
	autoSell = autoSell,
	spamChat = spamChat,
	copyDiscord = copyDiscord,
	setFpsCap = setFpsCap,
	notify = notify,
}
