-- HeliosHub Omniscan v11.0
-- Developed by HeliosHub

-- Config
local WATCHDOG_TIMEOUT = 3.5
local MODULE_TIMEOUT   = 1.2
local MAX_KEYS         = 100
local MAX_DEPTH        = 6
local CRAWL_MAX_DEPTH  = 12
local DUMP_TIMEOUT     = 2.5
local YIELD_FREQ       = 20
local BUFFER_FLUSH_AT  = 15
local BUFFER_HARD_CAP  = 500
local LOG_DIR          = "Omniscan_Results"

local SERVICES = {
    "ReplicatedStorage",
    "Workspace",
    "StarterGui",
    "StarterPlayer",
    "Lighting",
    "Teams",
}

local BLACKLIST = {
    "ProfileStore", "DataStoreService", "Roact", "Rodux", "Janitor", "Promise",
    "Fusion", "Vide", "React", "Jest", "Trove", "Signal", "Networker",
    "BridgeNet", "Knit", "Aero", "Matter", "ReplicaService", "SparkMod",
    "Cmdr", "CmdrClient", "CmdrInterface",
    "Tweener", "Spring", "Tween",
    "DamageMarker", "Lottie", "GuiAnimatorPlugin",
    "Packages", "_Index",
    "CustomPackAPI", "Character",
}

-- State
local buffer         = {}
local scanCount      = 0
local skipCount      = 0
local remoteCount    = 0
local moduleCount    = 0
local errorCount     = 0
local currentObj     = "Initializing..."
local currentSvc     = "None"
local lastMove       = tick()
local skipGen        = 0
local activeGen      = 0
local lastSkippedObj = ""
local scanFinished   = false
local startTime      = tick()

-- Seen remotes across the whole scan to avoid duplicate logs
local seenRemotes = {}
local seenTables  = setmetatable({}, {__mode = "k"})

local function shouldSkip()
    return skipGen ~= activeGen
end

-- UI
local gui, progressBar, svcLabel, objLabel, statsLabel

local function makeLabel(parent, size, pos, fontSize, color, align)
    local l = Instance.new("TextLabel")
    l.Size                  = size
    l.Position              = pos
    l.BackgroundTransparency = 1
    l.TextColor3            = color or Color3.fromRGB(200, 220, 255)
    l.Font                  = Enum.Font.Code
    l.TextSize              = fontSize or 11
    l.TextXAlignment        = align or Enum.TextXAlignment.Left
    l.TextWrapped           = true
    l.ZIndex                = 4
    l.Parent                = parent
    return l
end

local function createUI()
    pcall(function()
        if gui and gui.Parent then gui:Destroy() end
    end)

    local screen = Instance.new("ScreenGui")
    screen.Name         = "HeliosOmniscan"
    screen.ResetOnSpawn = false
    screen.DisplayOrder = 9999999

    -- Main frame
    local frame = Instance.new("Frame")
    frame.Size             = UDim2.new(0, 340, 0, 160)
    frame.Position         = UDim2.new(1, -360, 0, 60)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
    frame.BorderSizePixel  = 0
    frame.Active           = true
    frame.Draggable        = true
    frame.ClipsDescendants = true
    frame.Parent           = screen
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    -- Subtle border
    local border = Instance.new("UIStroke")
    border.Color     = Color3.fromRGB(60, 60, 100)
    border.Thickness = 1
    border.Parent    = frame

    -- Header bar
    local header = Instance.new("Frame")
    header.Size             = UDim2.new(1, 0, 0, 32)
    header.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
    header.BorderSizePixel  = 0
    header.ZIndex           = 3
    header.Parent           = frame
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)

    -- Header bottom fill (covers bottom radius of header)
    local headerFill = Instance.new("Frame")
    headerFill.Size             = UDim2.new(1, 0, 0, 8)
    headerFill.Position         = UDim2.new(0, 0, 1, -8)
    headerFill.BackgroundColor3 = Color3.fromRGB(18, 18, 32)
    headerFill.BorderSizePixel  = 0
    headerFill.ZIndex           = 3
    headerFill.Parent           = header

    -- Gold left accent
    local accent = Instance.new("Frame")
    accent.Size             = UDim2.new(0, 3, 1, 0)
    accent.BackgroundColor3 = Color3.fromRGB(255, 185, 30)
    accent.BorderSizePixel  = 0
    accent.ZIndex           = 4
    accent.Parent           = header
    Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 2)

    -- Title
    local title = makeLabel(header,
        UDim2.new(1, -14, 1, 0),
        UDim2.new(0, 12, 0, 0),
        12,
        Color3.fromRGB(255, 185, 30)
    )
    title.Text = "HELIOS HUB  •  OMNISCAN v11"

    -- Version badge
    local badge = makeLabel(header,
        UDim2.new(0, 60, 0, 16),
        UDim2.new(1, -68, 0.5, -8),
        9,
        Color3.fromRGB(120, 120, 160),
        Enum.TextXAlignment.Right
    )
    badge.Text = "HeliosHub"

    -- Body padding frame
    local body = Instance.new("Frame")
    body.Size             = UDim2.new(1, 0, 1, -32)
    body.Position         = UDim2.new(0, 0, 0, 32)
    body.BackgroundTransparency = 1
    body.Parent           = frame

    -- Current service
    svcLabel = makeLabel(body,
        UDim2.new(1, -16, 0, 16),
        UDim2.new(0, 10, 0, 8),
        10,
        Color3.fromRGB(255, 185, 30)
    )
    svcLabel.Text = "Service: —"

    -- Current object
    objLabel = makeLabel(body,
        UDim2.new(1, -16, 0, 14),
        UDim2.new(0, 10, 0, 26),
        10,
        Color3.fromRGB(160, 180, 220)
    )
    objLabel.Text = "Scanning..."

    -- Progress bar track
    local track = Instance.new("Frame")
    track.Size             = UDim2.new(1, -20, 0, 5)
    track.Position         = UDim2.new(0, 10, 0, 46)
    track.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    track.BorderSizePixel  = 0
    track.ZIndex           = 3
    track.Parent           = body
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    -- Progress bar fill
    progressBar = Instance.new("Frame")
    progressBar.Size             = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 185, 30)
    progressBar.BorderSizePixel  = 0
    progressBar.ZIndex           = 4
    progressBar.Parent           = track
    Instance.new("UICorner", progressBar).CornerRadius = UDim.new(1, 0)

    -- Stats row
    statsLabel = makeLabel(body,
        UDim2.new(1, -16, 0, 60),
        UDim2.new(0, 10, 0, 58),
        10,
        Color3.fromRGB(130, 150, 190)
    )
    statsLabel.Text = "Objects: 0  •  Remotes: 0  •  Modules: 0  •  Skips: 0"

    -- Parent GUI
    local parented = false

    if not parented then
        pcall(function()
            if gethui then
                screen.Parent = gethui()
                parented = true
            end
        end)
    end

    if not parented then
        pcall(function()
            screen.Parent = game:GetService("CoreGui")
            parented = true
        end)
    end

    if not parented then
        pcall(function()
            local lp = game:GetService("Players").LocalPlayer
            if lp then
                local pg = lp:FindFirstChildOfClass("PlayerGui") or lp:WaitForChild("PlayerGui", 5)
                if pg then
                    screen.Parent = pg
                    parented = true
                end
            end
        end)
    end

    return screen
end

gui = createUI()

-- File setup
local gameName = "Unknown"
pcall(function()
    local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    if info and info.Name then
        gameName = info.Name:gsub("[%c%p%s]", "_"):sub(1, 40)
    end
end)

local fileName = LOG_DIR .. "/" .. gameName .. "_HeliosHub_Omniscan.txt"
if makefolder then pcall(function() makefolder(LOG_DIR) end) end
if writefile  then pcall(function() writefile(fileName, "HeliosHub Omniscan v11.0\nGame: " .. gameName .. "\nDate: " .. os.date() .. "\n\n") end) end

-- I/O
local function flush()
    if #buffer == 0 then return end
    local content = table.concat(buffer, "\n") .. "\n"
    pcall(function()
        if appendfile then
            appendfile(fileName, content)
        elseif writefile then
            local ok, current = pcall(readfile, fileName)
            writefile(fileName, (ok and current or "") .. content)
        end
    end)
    table.clear(buffer)
end

local function log(t)
    if #buffer >= BUFFER_HARD_CAP then flush() end
    table.insert(buffer, tostring(t))
    if #buffer >= BUFFER_FLUSH_AT then flush() end
end

local function section(t)
    log("\n\n[ " .. tostring(t):upper() .. " ]")
end

-- Watchdog
task.spawn(function()
    while not scanFinished do
        task.wait(0.5)
        if currentObj ~= "Initializing..." then
            if tick() - lastMove > WATCHDOG_TIMEOUT then
                if currentObj ~= lastSkippedObj then
                    lastSkippedObj = currentObj
                    skipGen    = skipGen + 1
                    skipCount  = skipCount + 1
                    warn("[HeliosHub] Watchdog skipped: " .. tostring(currentObj))
                end
                lastMove = tick()
            end
        end
    end
end)

-- UI update loop
local SERVICE_ORDER = {}
for i, s in ipairs(SERVICES) do SERVICE_ORDER[s] = i end

task.spawn(function()
    while not scanFinished do
        if not gui or not gui.Parent then
            gui = createUI()
        end

        pcall(function()
            local svcIdx  = SERVICE_ORDER[currentSvc] or 0
            local progress = svcIdx / #SERVICES
            progressBar.Size = UDim2.new(math.clamp(progress, 0, 1), 0, 1, 0)

            svcLabel.Text  = "Service: " .. currentSvc
            objLabel.Text  = tostring(currentObj):sub(1, 46)
            statsLabel.Text = string.format(
                "Objects: %d  •  Remotes: %d  •  Modules: %d  •  Skips: %d",
                scanCount, remoteCount, moduleCount, skipCount
            )
        end)

        task.wait(0.25)
    end
end)

-- Safe call
local function safeCall(f, timeout)
    local done, cancelled, results = false, false, nil

    task.spawn(function()
        local ok, r = pcall(f)
        if not cancelled then
            results = {ok, r}
            done = true
        end
    end)

    local start = tick()
    while not done do
        task.wait(0.1)
        if shouldSkip() then
            cancelled = true
            return false, "SKIPPED"
        end
        if tick() - start > timeout then
            cancelled = true
            return false, "TIMEOUT"
        end
    end

    return table.unpack(results)
end

-- Deep table dump
local function deepDump(tbl, depth, prefix, dumpStart)
    if type(tbl) ~= "table"             then return end
    if depth > MAX_DEPTH                then return end
    if seenTables[tbl]                  then return end
    if shouldSkip()                     then return end
    if tick() - dumpStart > DUMP_TIMEOUT then return "TRUNCATED" end

    seenTables[tbl] = true
    prefix = prefix or ""
    local count = 0

    for k, v in pairs(tbl) do
        if shouldSkip() then break end

        count = count + 1
        if count > MAX_KEYS then
            log(prefix .. "  [truncated at " .. MAX_KEYS .. " keys]")
            break
        end

        scanCount = scanCount + 1
        if scanCount % YIELD_FREQ == 0 then task.wait() end

        local vtype = type(v)

        if vtype == "table" then
            log(prefix .. "  [table] " .. tostring(k))
            local r = deepDump(v, depth + 1, prefix .. "  ", dumpStart)
            if r == "TRUNCATED" then
                log(prefix .. "  [dump timed out]")
                break
            end
        elseif vtype == "function" then
            log(prefix .. "  [fn] " .. tostring(k))
        else
            local ok, str = pcall(tostring, v)
            if not ok then str = "[error]" end
            if #str > 120 then str = str:sub(1, 120) .. "..." end
            log(prefix .. "  " .. tostring(k) .. " = " .. str)
        end
    end
end

-- Blacklist check
local function isBlacklisted(name)
    for _, entry in ipairs(BLACKLIST) do
        if name:find(entry, 1, true) then return true end
    end
    return false
end

-- Scan a single object — only logs what's actually interesting
local function scanObject(obj)
    local name = "?"
    pcall(function() name = obj.Name end)

    local className = "?"
    pcall(function() className = obj.ClassName end)

    local fullName = "?"
    pcall(function() fullName = obj:GetFullName() end)

    local logged = false

    local function ensureHeader()
        if not logged then
            log("\n[" .. className .. "] " .. fullName)
            logged = true
        end
    end

    -- Attributes: only log if the object actually has some
    local attrOk, attrs = pcall(function() return obj:GetAttributes() end)
    if attrOk and attrs and next(attrs) then
        ensureHeader()
        log("  attributes:")
        for k, v in pairs(attrs) do
            log("    " .. tostring(k) .. " = " .. tostring(v))
        end
    end

    -- Tags: only log if present
    local tagOk, tags = pcall(function()
        return game:GetService("CollectionService"):GetTags(obj)
    end)
    if tagOk and tags and #tags > 0 then
        ensureHeader()
        log("  tags: " .. table.concat(tags, ", "))
    end

    -- ValueBase: log its value
    if obj:IsA("ValueBase") then
        local ok, val = pcall(function() return tostring(obj.Value) end)
        if ok then
            ensureHeader()
            log("  value: " .. val)
        end
    end

    -- Remotes: deduplicated by full path across the whole scan
    if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
        if not seenRemotes[fullName] then
            seenRemotes[fullName] = true
            remoteCount = remoteCount + 1
            ensureHeader()
            local rtype = obj:IsA("RemoteEvent") and "RemoteEvent" or "RemoteFunction"
            local call  = obj:IsA("RemoteEvent") and ":FireServer(...)" or ":InvokeServer(...)"
            log("  [" .. rtype .. "] game." .. fullName .. call)
        end
        return
    end

    -- Bindables
    if obj:IsA("BindableEvent") or obj:IsA("BindableFunction") then
        ensureHeader()
        log("  [bindable] " .. fullName)
        return
    end

    -- Modules: require and dump
    if obj:IsA("ModuleScript") then
        if isBlacklisted(name) then
            return
        end
        local ok, result = safeCall(function() return require(obj) end, MODULE_TIMEOUT)
        if ok and type(result) == "table" then
            moduleCount = moduleCount + 1
            ensureHeader()
            log("  [module]")
            deepDump(result, 1, "  ", tick())
        elseif not ok then
            errorCount = errorCount + 1
            ensureHeader()
            log("  [module error: " .. tostring(result) .. "]")
        end
    end
end

-- Crawler
local function crawl(parent, depth)
    depth = depth or 0
    if depth > CRAWL_MAX_DEPTH then return end

    local ok, children = pcall(function() return parent:GetChildren() end)
    if not ok or not children then return end

    for _, obj in ipairs(children) do
        if shouldSkip() then activeGen = skipGen end

        local name = "?"
        pcall(function() name = obj.Name end)

        lastSkippedObj = ""
        currentObj     = name
        lastMove       = tick()
        activeGen      = skipGen
        scanCount      = scanCount + 1

        if scanCount % YIELD_FREQ == 0 then task.wait() end

        pcall(function() scanObject(obj) end)
        crawl(obj, depth + 1)
    end
end

-- Summary writer
local function writeSummary()
    local elapsed = math.floor(tick() - startTime)
    log("\n\n[ SUMMARY ]")
    log("Game:          " .. gameName)
    log("Scan time:     " .. elapsed .. "s")
    log("Total objects: " .. scanCount)
    log("Remotes found: " .. remoteCount)
    log("Modules dumped:" .. moduleCount)
    log("Errors:        " .. errorCount)
    log("Watchdog skips:" .. skipCount)
    log("Output file:   " .. fileName)
end

-- Main
task.spawn(function()
    for _, svcName in ipairs(SERVICES) do
        currentSvc = svcName
        local ok, svc = pcall(game.GetService, game, svcName)
        if ok and svc then
            section(svcName)
            table.clear(seenTables)
            crawl(svc, 0)
            flush()
        else
            log("[error] failed to get service: " .. svcName)
        end
    end

    writeSummary()
    flush()

    scanFinished = true
    currentObj   = "FINISHED"

    local elapsed = math.floor(tick() - startTime)

    pcall(function()
        progressBar.Size             = UDim2.new(1, 0, 1, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        svcLabel.Text  = "Scan complete  (" .. elapsed .. "s)"
        objLabel.Text  = fileName
        statsLabel.Text = string.format(
            "Objects: %d  •  Remotes: %d  •  Modules: %d  •  Skips: %d",
            scanCount, remoteCount, moduleCount, skipCount
        )
    end)

    task.wait(20)
    pcall(function() gui:Destroy() end)
end)