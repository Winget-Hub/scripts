--[[
    ShizukiWallHop readable reconstruction

    Source: Scripts/Skids/ShizukiWallHop/Dirty/Main.lua
    Obfuscator banner: LuaObfuscator.com Alpha 0.10.8

    This was not VM obfuscated. It was mostly minified and variable-renamed.
    The only external code path is the "Shiftlock M" button, which calls
    loadstring(game:HttpGet(...)) on the URL below.
]]

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local SHIFTLOCK_URL = "https://raw.githubusercontent.com/Unknownproooolucky/Unknown-Hub-X-Universal-Games/main/Universal/Permanent-Shiftlock-V2"
local DISCORD_URL = "https://discord.gg/FA3eVAdtfw"

local function createButton(text, position, parent)
    local button = Instance.new("TextButton")
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Size = UDim2.new(0.8, 0, 0.2, 0)
    button.Position = position
    button.BackgroundTransparency = 0.3
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    button.BorderSizePixel = 2
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Parent = parent

    return button
end

local function createCopiedNotice(parent)
    local notice = Instance.new("TextLabel")
    notice.Text = "Discord link copied to clipboard!"
    notice.Size = UDim2.new(0.3, 0, 0.1, 0)
    notice.Position = UDim2.new(0.7, 0, 0.8, 0)
    notice.BackgroundTransparency = 0.5
    notice.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    notice.TextColor3 = Color3.fromRGB(255, 255, 255)
    notice.Font = Enum.Font.GothamBold
    notice.TextScaled = true
    notice.Parent = parent

    wait(2)
    notice:Destroy()
end

local function flickCameraRight()
    local camera = workspace.CurrentCamera
    local originalCFrame = camera.CFrame
    local flickedCFrame = originalCFrame * CFrame.Angles(0, math.rad(90), 0)

    camera.CFrame = flickedCFrame
    wait(0.05)
    camera.CFrame = originalCFrame
end

local function runShiftlockLoader()
    local source = game:HttpGet(SHIFTLOCK_URL)
    local chunk = loadstring(source)

    chunk()
end

local function createWallhopGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0.2, 0, 0.3, 0)
    mainFrame.Position = UDim2.new(0.4, 0, 0.35, 0)
    mainFrame.BackgroundTransparency = 0.3
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderSizePixel = 2
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Size = UDim2.new(1, 0, 0.9, 0)
    scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0)
    scrollingFrame.ScrollBarThickness = 5
    scrollingFrame.BackgroundTransparency = 1
    scrollingFrame.Parent = mainFrame

    local flickButton = createButton("Flick", UDim2.new(0.1, 0, 0.05, 0), scrollingFrame)
    local autoFlickButton = createButton("Autoflick: Off", UDim2.new(0.1, 0, 0.3, 0), scrollingFrame)

    local intervalBox = Instance.new("TextBox")
    intervalBox.Size = UDim2.new(0.8, 0, 0.2, 0)
    intervalBox.Position = UDim2.new(0.1, 0, 0.55, 0)
    intervalBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    intervalBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    intervalBox.PlaceholderText = "Interval (seconds)"
    intervalBox.Parent = scrollingFrame

    local wallhopButton = createButton("Wallhop: Off", UDim2.new(0.1, 0, 0.8, 0), scrollingFrame)
    local shiftlockButton = createButton("Shiftlock M", UDim2.new(0.1, 0, 1.05, 0), scrollingFrame)

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
    minimizeButton.Position = UDim2.new(0.9, -5, 0, 5)
    minimizeButton.BackgroundTransparency = 0.3
    minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    minimizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    minimizeButton.BorderSizePixel = 2
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextScaled = true
    minimizeButton.Parent = mainFrame

    local showButton = Instance.new("TextButton")
    showButton.Text = "Show"
    showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    showButton.Size = UDim2.new(0.05, 0, 0.05, 0)
    showButton.Position = UDim2.new(0, 5, 0.5, -25)
    showButton.BackgroundTransparency = 0.3
    showButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    showButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    showButton.BorderSizePixel = 2
    showButton.Font = Enum.Font.GothamBold
    showButton.TextScaled = true
    showButton.Visible = false
    showButton.Active = true
    showButton.Draggable = true
    showButton.Parent = screenGui

    local copyDiscordButton = Instance.new("TextButton")
    copyDiscordButton.Text = "Copy Discord Link"
    copyDiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyDiscordButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    copyDiscordButton.Position = UDim2.new(0.7, 0, 0.9, 0)
    copyDiscordButton.BackgroundTransparency = 0.3
    copyDiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    copyDiscordButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    copyDiscordButton.BorderSizePixel = 2
    copyDiscordButton.Font = Enum.Font.GothamBold
    copyDiscordButton.TextScaled = true
    copyDiscordButton.Parent = mainFrame

    local wallhopModeIndex = 0
    local wallhopModes = {
        "Off",
        "Mode logiT",
        "Mode ray",
    }

    local autoFlickEnabled = false
    local autoFlickInterval = 0.1

    flickButton.MouseButton1Click:Connect(flickCameraRight)

    autoFlickButton.MouseButton1Click:Connect(function()
        autoFlickEnabled = not autoFlickEnabled
        autoFlickButton.Text = "Autoflick: " .. (autoFlickEnabled and "On" or "Off")

        if autoFlickEnabled then
            while autoFlickEnabled do
                flickCameraRight()
                wait(autoFlickInterval)
            end
        end
    end)

    intervalBox.FocusLost:Connect(function(enterPressed)
        if not enterPressed then
            return
        end

        local newInterval = tonumber(intervalBox.Text)
        if newInterval and newInterval > 0 then
            autoFlickInterval = newInterval
        else
            intervalBox.Text = tostring(autoFlickInterval)
        end
    end)

    wallhopButton.MouseButton1Click:Connect(function()
        wallhopModeIndex = (wallhopModeIndex + 1) % 3
        wallhopButton.Text = "Wallhop: " .. wallhopModes[wallhopModeIndex + 1]
    end)

    coroutine.wrap(function()
        while true do
            wait(0.05)

            if wallhopModeIndex > 0 then
                local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
                local humanoid = character:FindFirstChild("Humanoid")
                local rootPart = character:FindFirstChild("HumanoidRootPart")

                if humanoid and rootPart then
                    local ray = Ray.new(rootPart.Position, rootPart.CFrame.LookVector * 5)
                    local hitPart = workspace:FindPartOnRayWithIgnoreList(ray, { character })

                    if hitPart and hitPart.Position.Y > rootPart.Position.Y then
                        humanoid.Jump = true
                        wait(0.15)

                        if wallhopModeIndex == 2 then
                            wait(0.07)
                        end

                        flickCameraRight()
                    end
                end
            end
        end
    end)()

    minimizeButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        showButton.Visible = true
    end)

    showButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = true
        showButton.Visible = false
    end)

    shiftlockButton.MouseButton1Click:Connect(runShiftlockLoader)

    copyDiscordButton.MouseButton1Click:Connect(function()
        setclipboard(DISCORD_URL)
        createCopiedNotice(mainFrame)
    end)
end

createWallhopGui()

