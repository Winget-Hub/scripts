--!nocheck
-- ServerScriptService script for games you own.
-- Resets unsafe currency values such as -math.huge, math.huge, NaN, negative
-- values, or values above MAX_SAFE_AMOUNT.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REMOTE_NAME = "ResetOwnMoneyToZero"
local MAX_SAFE_AMOUNT = 1_000_000_000_000
local CURRENCY_NAMES = {
    Coins = true,
    Coin = true,
    Money = true,
    Cash = true,
}

local resetRemote = ReplicatedStorage:FindFirstChild(REMOTE_NAME)
if not resetRemote then
    resetRemote = Instance.new("RemoteEvent")
    resetRemote.Name = REMOTE_NAME
    resetRemote.Parent = ReplicatedStorage
end

local function isBadNumber(value: number): boolean
    return value ~= value
        or value == math.huge
        or value == -math.huge
        or value < 0
        or value > MAX_SAFE_AMOUNT
end

local function resetIfUnsafe(stat: Instance)
    if not stat:IsA("NumberValue") and not stat:IsA("IntValue") then
        return
    end

    if not CURRENCY_NAMES[stat.Name] then
        return
    end

    local value = stat.Value
    if isBadNumber(value) then
        stat.Value = 0
    end
end

local function resetAllCurrency(player: Player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then
        return
    end

    for _, child in ipairs(leaderstats:GetChildren()) do
        if child:IsA("NumberValue") or child:IsA("IntValue") then
            if CURRENCY_NAMES[child.Name] then
                child.Value = 0
            end
        end
    end
end

local function watchStat(stat: Instance)
    resetIfUnsafe(stat)

    if stat:IsA("NumberValue") or stat:IsA("IntValue") then
        stat:GetPropertyChangedSignal("Value"):Connect(function()
            resetIfUnsafe(stat)
        end)
    end
end

local function watchPlayer(player: Player)
    local function watchLeaderstats(leaderstats: Instance)
        for _, child in ipairs(leaderstats:GetChildren()) do
            watchStat(child)
        end

        leaderstats.ChildAdded:Connect(watchStat)
    end

    local existingLeaderstats = player:FindFirstChild("leaderstats")
    if existingLeaderstats then
        watchLeaderstats(existingLeaderstats)
    end

    player.ChildAdded:Connect(function(child)
        if child.Name == "leaderstats" then
            watchLeaderstats(child)
        end
    end)
end

resetRemote.OnServerEvent:Connect(function(player)
    resetAllCurrency(player)
end)

for _, player in ipairs(Players:GetPlayers()) do
    watchPlayer(player)
end

Players.PlayerAdded:Connect(watchPlayer)
