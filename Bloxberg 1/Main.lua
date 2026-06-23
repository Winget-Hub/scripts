-- Deobfuscated from /Users/lucasoleksyuk/Downloads/main coding projects/Roblox Scripting/roblox-scripts/scripts/Skids/Bloxberg 1/Dirty/Main.lua
-- Original wrapper: WeAreDevs VM obfuscator.
-- Recovered by scripts/Unhiding/deobfuscate_bloxberg1.py.
-- Note: the UI/control surface was recovered from VM runtime behavior.
-- Callback internals stayed inside the virtualized bytecode, so they are
-- represented below as readable named handlers with recovered flags/defaults.

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local selectedJob = "None"
local autoFarmEnabled = false
local autoMoodEnabled = false
local breaksEnabled = false
local autoHarvestEnabled = false
local moodThreshold = 20
local workMinutes = 30
local breakMinutes = 20

local function goToWork()
	-- Recovered control: Go To Work.
	-- The obfuscated VM used the selected job value to enter/start work.
end

local function setAutoFarm(enabled)
	autoFarmEnabled = enabled
end

local function setAutoMood(enabled)
	autoMoodEnabled = enabled
end

local function setBreaks(enabled)
	breaksEnabled = enabled
end

local function setAutoHarvest(enabled)
	autoHarvestEnabled = enabled
end

local function toggleAllDoors()
	-- Recovered control: Toggle All Doors.
end

local Window = Rayfield:CreateWindow({
	Name = "Bloxburg Auto Farm - KEYLESS",
	LoadingTitle = "Loading Script...",
	LoadingSubtitle = "by OriginalTragic",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "BloxburgFarm",
		FileName = "Config",
	},
	Discord = {
		Enabled = false,
		Invite = "noinvitelink",
		RememberJoins = true,
	},
	KeySystem = false,
})

local AutoFarmTab = Window:CreateTab("Auto Farm", 4483362458)

AutoFarmTab:CreateSection("Main Controls")

AutoFarmTab:CreateDropdown({
	Name = "Select Job",
	Options = { "StylezHairdresser", "PizzaPlanetBaker", "CleanJanitor" },
	CurrentOption = { "None" },
	MultipleOptions = false,
	Flag = "JobSelection",
	Callback = function(option)
		selectedJob = type(option) == "table" and option[1] or option
	end,
})

AutoFarmTab:CreateButton({
	Name = "Go To Work",
	Callback = function()
		goToWork()
	end,
})

AutoFarmTab:CreateToggle({
	Name = "Enable Auto Farm",
	CurrentValue = false,
	Flag = "AutoFarmEnabled",
	Callback = function(enabled)
		setAutoFarm(enabled)
	end,
})

local AutoMoodTab = Window:CreateTab("Auto Mood", 4483362458)

AutoMoodTab:CreateSection("Mood Management")

local AutoMoodTabLabel1 = AutoMoodTab:CreateLabel("Status: Waiting")

AutoMoodTab:CreateSlider({
	Name = "Mood % To Enable At",
	Range = { 1, 100 },
	Increment = 1,
	Suffix = "%",
	CurrentValue = 20,
	Flag = "MoodThreshold",
	Callback = function(value)
		moodThreshold = value
	end,
})

AutoMoodTab:CreateToggle({
	Name = "Enable Auto Mood",
	CurrentValue = false,
	Flag = "AutoMoodEnabled",
	Callback = function(enabled)
		setAutoMood(enabled)
	end,
})

local BreaksTab = Window:CreateTab("Breaks", 4483362458)

BreaksTab:CreateSection("Break Settings")

BreaksTab:CreateSlider({
	Name = "Work Time (Minutes)",
	Range = { 5, 120 },
	Increment = 5,
	Suffix = "min",
	CurrentValue = 30,
	Flag = "WorkTime",
	Callback = function(value)
		workMinutes = value
	end,
})

BreaksTab:CreateSlider({
	Name = "Break Time (Minutes)",
	Range = { 5, 60 },
	Increment = 5,
	Suffix = "min",
	CurrentValue = 20,
	Flag = "BreakTime",
	Callback = function(value)
		breakMinutes = value
	end,
})

BreaksTab:CreateToggle({
	Name = "Enable Breaks",
	CurrentValue = false,
	Flag = "BreaksEnabled",
	Callback = function(enabled)
		setBreaks(enabled)
	end,
})

local StatisticsTab = Window:CreateTab("Statistics", 4483362458)

StatisticsTab:CreateSection("Farm Statistics")

local StatisticsTabLabel2 = StatisticsTab:CreateLabel("Shift Earnings: $0")

local StatisticsTabLabel3 = StatisticsTab:CreateLabel("Efficiency: 0%")

local StatisticsTabLabel4 = StatisticsTab:CreateLabel("Farm Time: 0m")

local StatisticsTabLabel5 = StatisticsTab:CreateLabel("Total Earnings: $0")

local UtilitiesTab = Window:CreateTab("Utilities", 4483362458)

UtilitiesTab:CreateSection("Utility Functions")

UtilitiesTab:CreateToggle({
	Name = "Auto Harvest",
	CurrentValue = false,
	Flag = "AutoHarvest",
	Callback = function(enabled)
		setAutoHarvest(enabled)
	end,
})

UtilitiesTab:CreateButton({
	Name = "Toggle All Doors",
	Callback = function()
		toggleAllDoors()
	end,
})

Rayfield:LoadConfiguration()
