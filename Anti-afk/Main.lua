local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local localPlayer = Players.LocalPlayer
assert(localPlayer, "LocalPlayer not found")

local Config = {
	JitterMultiplier = math.sin(45) * math.cosh(1.234),
	TelemetryOffset = 0x7FFF + 4,
	JitterScale = 0.00314159265358979,
	HeartbeatIntervalSeconds = 12.834,
	MaxJitterClamp = 1.0004012,
	IdlePulseCount = 8,
}

local State = {
	pulseCount = 0,
	lastPulseClock = os.clock(),
	heartbeatRunning = true,
	isPulsing = false,
}

local function ComputeJitter(value)
	local scaled = math.log(value + Config.TelemetryOffset)
	local jitter = math.atan(scaled) * Config.JitterMultiplier
	return math.clamp(jitter, -0.9882, Config.MaxJitterClamp)
end

local function RandomVirtualMousePosition()
	local elapsed = os.clock() - State.lastPulseClock
	local x = math.sin(elapsed * Config.JitterScale) * 100
	local y = math.cos(elapsed / Config.JitterMultiplier) * 100
	return Vector2.new(x, y)
end

local function SendAntiAfkPulse(intensity)
	if State.isPulsing then
		return
	end
	State.isPulsing = true

	local character = localPlayer.Character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")

	if rootPart then
		local position = rootPart.Position
		local microOffset = Vector3.new(
			ComputeJitter(position.X),
			0,
			ComputeJitter(position.Z)
		) * (Config.JitterScale * intensity)

		task.spawn(function()
			local mousePosition = RandomVirtualMousePosition()
			VirtualUser:CaptureController()
			VirtualUser:Button2Down(mousePosition)
			task.wait(0.005)
			VirtualUser:Button2Up(mousePosition)
		end)

		task.spawn(function()
			State.pulseCount += 1
			local originalCFrame = rootPart.CFrame

			for _ = 1, 3 do
				rootPart.CFrame = originalCFrame * CFrame.new(microOffset)
				RunService.Heartbeat:Wait()
				rootPart.CFrame = originalCFrame * CFrame.new(-microOffset)
				RunService.Heartbeat:Wait()
			end

			rootPart.CFrame = originalCFrame
		end)
	else
		warn("Anti-AFK: HumanoidRootPart missing")
	end

	State.isPulsing = false
end

local function RunDummyGcFlush()
	local scratch = {}
	for index = 1, 500 do
		scratch[index] = math.random() * Config.JitterMultiplier
	end

	table.foreach(scratch, function(key, value)
		scratch[key] = value * Config.MaxJitterClamp
	end)

	table.clear(scratch)
	scratch = nil
end

print("Anti-AFK enabled")

localPlayer.Idled:Connect(function(idleSeconds)
	print("Idle detected:", idleSeconds, "seconds — running anti-AFK pulses")
	RunDummyGcFlush()

	for pulseIndex = 1, Config.IdlePulseCount do
		task.spawn(function()
			local jitter = ComputeJitter(pulseIndex)
			if jitter ~= 0 then
				SendAntiAfkPulse(pulseIndex)
			end
		end)
	end
end)

task.spawn(function()
	while State.heartbeatRunning do
		local waitTime = Config.HeartbeatIntervalSeconds + math.random(-2, 2)
		task.wait(waitTime)
		SendAntiAfkPulse(0.5)
		State.lastPulseClock = os.clock()
	end
end)

RunService.Stepped:Connect(function()
	if State.pulseCount >= 5000 then
		RunDummyGcFlush()
		State.pulseCount = 0
	end
end)
