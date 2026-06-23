--!nocheck
--[[
    Ninja Legends Universal V1 - runtime-recovered behavior

    This is the readable behavior recovered from the Voltils VM by running the
    original dirty script inside a fake Roblox/Luau container in Scripts/Unhiding.

    It is not a full devirtualized source file. The original body is still a
    Voltils state machine, but the runtime path below was confirmed by traces.
]]

local Recovered = {}

function Recovered.run()
    local HttpService = game:GetService("HttpService")
    local RunService = game:GetService("RunService")

    local marker = Instance.new("NumberValue")
    marker.Archivable = false
    marker:Destroy()

    local ok = pcall(function()
        local jsonDecode = HttpService.JSONDecode
        if type(jsonDecode) ~= "function" then
            return false
        end

        if type(game.HttpGet) ~= "function" then
            return false
        end

        local fired = false
        local connection = RunService.RenderStepped:Connect(function()
            fired = true
        end)

        task.wait(0.03)

        if connection then
            connection:Disconnect()
        end

        return fired
    end)

    if not ok then
        warn("[Voltis Anti-Env Logger] validation failed")
        warn("Detected by Voltis Anti-Skid - .gg/78yYmtaeg4")
        return
    end

    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer

    if LocalPlayer == nil then
        warn("[Voltis Anti-Env Logger] Reason: LocalPlayer is nil")
        return
    end

    local character = LocalPlayer.Character
    if character == nil then
        warn("[Voltis Anti-Env Logger] Reason: Character is nil")
        return
    end

    local camera = workspace.CurrentCamera
    if camera == nil then
        warn("[Voltis Anti-Env Logger] Reason: Camera missing")
        return
    end

    if typeof(camera) ~= "Instance" then
        warn("[Voltis Anti-Env Logger] Reason: Camera is not an Instance")
        return
    end

    local cameraOk = pcall(function()
        return camera.CFrame
    end)
    if not cameraOk then
        warn("[Voltis Anti-Env Logger] Reason: Camera CFrame inaccessible")
        return
    end

    local mouseLocation = UserInputService:GetMouseLocation()
    if typeof(mouseLocation) ~= "Vector2" then
        warn("[Voltis Anti-Env Logger] Reason: MouseLocation is not Vector2")
        return
    end

    if mouseLocation.X <= 0 or mouseLocation.Y <= 0 then
        warn("[Voltis Anti-Env Logger] Reason: MouseLocation returned invalid coordinates")
        return
    end

    local ray = camera:ScreenPointToRay(mouseLocation.X, mouseLocation.Y)
    if typeof(ray) ~= "Ray" and typeof(ray) ~= "table" and typeof(ray) ~= "Instance" then
        warn("[Voltis Anti-Env Logger] Reason: ScreenPointToRay returned invalid value")
        return
    end

    print("you were 0% there of env logging this script, you failed, fuck you")
end

return Recovered
