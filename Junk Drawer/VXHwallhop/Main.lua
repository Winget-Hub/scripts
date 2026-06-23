--[[
    VXHwallhop deobfuscation status

    Dirty source:
      Scripts/Skids/VXHwallhop/Dirty/Main.lua

    Current result:
      The script is protected with MoonSec V3. The first-stage wrapper has been
      beautified and runtime-probed, but the original payload source has not
      been recovered yet.

    What was confirmed:
      - The file is a MoonSec V3 VM wrapper.
      - Normal text search does not expose the Roblox payload.
      - The wrapper decodes its MoonSec constants correctly under LuaJIT.
      - The stock Lua-Deobfuscator only supports the older MoonSec V2 shape and
        fails on this V3 wrapper.
      - A sandbox runner was created so Roblox/executor APIs are logged instead
        of executed.

    Current blocker:
      The VM reaches its anti-tamper/selector setup and then fails before any
      Roblox APIs are called:

        attempt to perform arithmetic on local 'g' (a nil value)

      Forcing the line-delta anti-tamper value and selector branch did not reach
      the payload. Continue from:

        Scripts/Unhiding/vxhwallhop_artifacts/

    This file is intentionally not a runnable replacement yet. It is a marker
    for the current clean-side recovery state.
]]

