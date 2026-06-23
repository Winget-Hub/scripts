--[[
    backdoor-darkz / DarkX readable reconstruction

    Source: Scripts/Skids/backdoor-darkz/Dirty/Main.lua
    Dirty file type: MoonSec-style VM obfuscation with an embedded key gate.

    What was recovered:
      - A DarkX key GUI is created on load.
      - The GUI points users to a Work.ink key page.
      - Pressing Copy Link writes that page URL to the clipboard.
      - Pressing Validate calls the Work.ink token validation API.
      - If the token response decodes to { valid = true }, the key GUI is
        destroyed and execution moves into an embedded post-unlock payload.

    What was not fully recovered:
      - The post-unlock embedded payload did not expose readable source during
        static/VM probing. The sandbox reached it after ScreenGui:Destroy(), then
        stopped on executor/metatable behavior that the fake runtime could not
        emulate. No external loadstring/require/request/GetObjects call was
        observed before that stop.
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local KEY_LINK = "https://work.ink/2jwC/darkx-key-system"
local TOKEN_ID = "darkx-key-system"
local TOKEN_CHECK_URL = "https://work.ink/_api/v2/token/isValid/" .. TOKEN_ID
local SETTINGS_FILE = "darkx_settings.json"

local function protectGui(gui)
    if typeof(syn) == "table" and typeof(syn.protect_gui) == "function" then
        syn.protect_gui(gui)
    elseif typeof(protectgui) == "function" then
        protectgui(gui)
    end
end

local function getGuiParent()
    if typeof(gethui) == "function" then
        local ok, hui = pcall(gethui)
        if ok and hui then
            return hui
        end
    end

    if CoreGui then
        return CoreGui
    end

    local player = Players.LocalPlayer
    return player and player:FindFirstChildOfClass("PlayerGui")
end

local function setStatus(label, text, color)
    label.Text = text
    label.TextColor3 = color
end

local function extractToken(input)
    input = tostring(input or ""):gsub("^%s+", ""):gsub("%s+$", "")

    if input == "" then
        return nil
    end

    local tokenFromUrl = input:match("work%.ink/[^/]+/([^%s%?/#]+)")
    if tokenFromUrl then
        return tokenFromUrl
    end

    return input
end

local function checkWorkInkToken(token)
    local url = token == TOKEN_ID
        and TOKEN_CHECK_URL
        or "https://work.ink/_api/v2/token/isValid/" .. token

    local body = game:HttpGet(url)
    local decoded = HttpService:JSONDecode(body)

    return decoded and decoded.valid == true
end

local function startUnlockedDarkX()
    -- This is where the obfuscated file continues after a valid key.
    --
    -- Runtime probing confirmed the transition into this branch, but the
    -- embedded VM did not reveal the original Luau source. Keep this function
    -- as the handoff point for any further manual bytecode/VM reconstruction.
    warn("DarkX post-unlock payload was not fully recovered from the VM wrapper.")
end

local function createKeyGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DarkX_KeyGUI"
    screenGui.ResetOnSpawn = false

    local parent = getGuiParent()
    if parent then
        protectGui(screenGui)
        screenGui.Parent = parent
    end

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 12)
    frameCorner.Parent = mainFrame

    local frameStroke = Instance.new("UIStroke")
    frameStroke.Color = Color3.fromRGB(60, 30, 120)
    frameStroke.Thickness = 1.5
    frameStroke.Transparency = 0.5
    frameStroke.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "DarkX Executor \226\128\147 Key Required"
    title.TextColor3 = Color3.fromRGB(139, 92, 246)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = mainFrame

    local instructions = Instance.new("TextLabel")
    instructions.Name = "Instructions"
    instructions.Size = UDim2.new(1, -20, 0, 50)
    instructions.Position = UDim2.new(0, 10, 0, 55)
    instructions.BackgroundTransparency = 1
    instructions.Text = "Get your key from the link below.\nKeys expire every 2 days \226\128\147 save it."
    instructions.TextColor3 = Color3.fromRGB(200, 200, 200)
    instructions.Font = Enum.Font.Gotham
    instructions.TextSize = 14
    instructions.TextWrapped = true
    instructions.Parent = mainFrame

    local linkLabel = Instance.new("TextLabel")
    linkLabel.Name = "KeyLink"
    linkLabel.Size = UDim2.new(1, -20, 0, 30)
    linkLabel.Position = UDim2.new(0, 10, 0, 110)
    linkLabel.BackgroundTransparency = 1
    linkLabel.Text = KEY_LINK
    linkLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    linkLabel.Font = Enum.Font.Gotham
    linkLabel.TextSize = 12
    linkLabel.TextWrapped = true
    linkLabel.Parent = mainFrame

    local copyButton = Instance.new("TextButton")
    copyButton.Name = "CopyLink"
    copyButton.Size = UDim2.new(0, 100, 0, 25)
    copyButton.Position = UDim2.new(0.5, -50, 0, 145)
    copyButton.BackgroundColor3 = Color3.fromRGB(30, 28, 50)
    copyButton.Text = "Copy Link"
    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyButton.Font = Enum.Font.Gotham
    copyButton.TextSize = 12
    copyButton.Parent = mainFrame

    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 6)
    copyCorner.Parent = copyButton

    local keyInput = Instance.new("TextBox")
    keyInput.Name = "KeyInput"
    keyInput.Size = UDim2.new(0, 300, 0, 35)
    keyInput.Position = UDim2.new(0.5, -150, 0, 175)
    keyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    keyInput.Text = ""
    keyInput.PlaceholderText = "Enter your key or URL"
    keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextSize = 14
    keyInput.ClearTextOnFocus = false
    keyInput.Parent = mainFrame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = keyInput

    local validateButton = Instance.new("TextButton")
    validateButton.Name = "Validate"
    validateButton.Size = UDim2.new(0, 150, 0, 35)
    validateButton.Position = UDim2.new(0.5, -75, 0, 215)
    validateButton.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    validateButton.Text = "Validate"
    validateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    validateButton.Font = Enum.Font.GothamBold
    validateButton.TextSize = 16
    validateButton.Parent = mainFrame

    local validateCorner = Instance.new("UICorner")
    validateCorner.CornerRadius = UDim.new(0, 6)
    validateCorner.Parent = validateButton

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(1, -20, 0, 30)
    statusLabel.Position = UDim2.new(0, 10, 0, 255)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 12
    statusLabel.Parent = mainFrame

    copyButton.MouseButton1Click:Connect(function()
        if typeof(setclipboard) == "function" then
            setclipboard(KEY_LINK)
            setStatus(statusLabel, "Copied key link to clipboard.", Color3.fromRGB(100, 255, 100))
        else
            setStatus(statusLabel, "Clipboard API is not available.", Color3.fromRGB(255, 100, 100))
        end
    end)

    validateButton.MouseButton1Click:Connect(function()
        local token = extractToken(keyInput.Text)
        if not token then
            setStatus(statusLabel, "Enter a key or Work.ink URL.", Color3.fromRGB(255, 100, 100))
            return
        end

        validateButton.Active = false
        validateButton.Text = "Checking..."
        setStatus(statusLabel, "Checking key...", Color3.fromRGB(200, 200, 200))

        local ok, valid = pcall(checkWorkInkToken, token)
        validateButton.Active = true
        validateButton.Text = "Validate"

        if not ok then
            setStatus(statusLabel, "Key check failed.", Color3.fromRGB(255, 100, 100))
            return
        end

        if not valid then
            setStatus(statusLabel, "Invalid or expired key.", Color3.fromRGB(255, 100, 100))
            return
        end

        setStatus(statusLabel, "Key valid. Loading...", Color3.fromRGB(100, 255, 100))
        screenGui:Destroy()
        startUnlockedDarkX()
    end)

    return screenGui
end

-- Observed in the obfuscated script. It checks for saved settings before/while
-- showing the key gate, but the exact settings schema was not exposed.
local _hasSavedSettings = typeof(isfile) == "function" and isfile(SETTINGS_FILE)

createKeyGui()
