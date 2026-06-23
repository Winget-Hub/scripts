--[[
    Ninja Legends Universal V1 - cleaned analysis scaffold

    Source:
        Scripts/Skids/Ninja Legends Universal V1/Dirty/Main.lua

    Status:
        The dirty source is protected with Voltils Obfuscation v7.4. The outer
        packer, string table unpacking, base85 decoder, XOR stream, sparse table
        swaps, and resolver arithmetic were decoded. The remaining body is still
        a Voltils control-flow VM, so this file is intentionally a readable
        analysis artifact instead of a re-hosted working exploit.

    Important:
        This file does not execute the original hack. It records what could be
        recovered safely and makes the protection layout readable for later
        manual review.
]]

local Cleaned = {}

Cleaned.name = "Ninja Legends Universal V1"
Cleaned.protection = "Voltils Obfuscation v7.4"

Cleaned.observedRuntimeTouchpoints = {
    "game",
    "workspace",
    "Players",
    "LocalPlayer",
    "HttpService",
    "RunService",
    "UserInputService",
    "CurrentCamera",
    "Instance.new",
    "NumberValue",
    "loadstring",
    "HttpGet",
}

Cleaned.observedUiLibraryMethods = {
    "CreateWindow",
    "CreateTab",
    "CreateSection",
    "CreateButton",
    "CreateToggle",
    "CreateSlider",
}

Cleaned.observedGuardsAndErrors = {
    "LocalPlayer is nil",
    "Character is nil",
    "Camera missing",
    "Camera is not an Instance",
    "Camera CFrame inaccessible",
    "Camera.Focus.Position inaccessible",
    "MouseLocation is not Vector2",
    "MouseLocation returned invalid coordinates",
    "RenderStepped did not fire",
    "validation failed",
    "generic tamper",
}

Cleaned.decodedConstantSummary = {
    totalPackedChunks = 2903,
    totalKeyMapEntries = 1773,
    decodedResolverConstants = 1268,
    nonIntegerResolverEntries = 493,
    sparseMissingEntries = 12,
}

Cleaned.meaningfulConstants = {
    "%Y-%m-%d %H:%M:%S",
    "__gc",
    "__index",
    "__len",
    "__metatable",
    "_ENV",
    "_G",
    "Archivable",
    "byte",
    "CFrame",
    "ChangeState",
    "char",
    "Character",
    "Color3",
    "concat",
    "Connect",
    "Create",
    "date",
    "debug",
    "delay",
    "Destroy",
    "Disconnect",
    "dump",
    "Enum",
    "error",
    "find",
    "FindFirstChild",
    "FireServer",
    "floor",
    "Focus",
    "format",
    "function",
    "GenerateGUID",
    "GetAttribute",
    "GetChildren",
    "GetCollisionGroupId",
    "getfenv",
    "GetFullName",
    "GetGuiInset",
    "getinfo",
    "GetLastInputType",
    "GetMinutesAfterMidnight",
    "GetMouseLocation",
    "GetServerTimeNow",
    "GetService",
    "GetState",
    "GetTranslatorForPlayerAsync",
    "getupvalue",
    "GetUserCFrame",
    "gmatch",
    "gsub",
    "hookfunction",
    "hookmetamethod",
    "HttpGet",
    "HttpService",
    "Instance",
    "ipairs",
    "is_synapse_function",
    "IsA",
    "isexecutorclosure",
    "isfunctionhooked",
    "IsTenFootInterface",
    "JSONDecode",
    "loadstring",
    "LocalPlayer",
    "math",
    "new",
    "newcclosure",
    "NumberValue",
    "OverlapParams",
    "pairs",
    "pcall",
    "Players",
    "PointToObjectSpace",
    "PointToWorldSpace",
    "Position",
    "print",
    "random",
    "RaycastParams",
    "Region3int16",
    "remove",
    "RenderStepped",
    "RunService",
    "ScreenPointToRay",
    "setclipboard",
    "setmetatable",
    "string",
    "table",
    "task",
    "tonumber",
    "tostring",
    "traceback",
    "TweenInfo",
    "type",
    "typeof",
    "UDim",
    "UDim2",
    "Unknown",
    "unpack",
    "UserInputService",
    "Vector2",
    "Vector3",
    "Vector3int16",
    "wait",
    "warn",
    "workspace",
}

local BASE85_ALPHABET = {
    j = 0x47,
    h = 0x06,
    ["6"] = 0x03,
    T = 0x1D,
    ["<"] = 0x10,
    g = 0x0A,
    ["?"] = 0x43,
    I = 0x3C,
    p = 0x02,
    ["("] = 0x12,
    c = 0x05,
    u = 0x2A,
    ["3"] = 0x31,
    ["2"] = 0x19,
    H = 0x37,
    ["0"] = 0x46,
    [","] = 0x4A,
    ["/"] = 0x39,
    n = 0x0E,
    ["%"] = 0x35,
    ["+"] = 0x0D,
    ["&"] = 0x33,
    ["!"] = 0x4C,
    Q = 0x1F,
    ["*"] = 0x45,
    J = 0x20,
    f = 0x49,
    ["'"] = 0x53,
    ["#"] = 0x0B,
    Z = 0x41,
    ["="] = 0x42,
    [")"] = 0x00,
    S = 0x4B,
    t = 0x3A,
    K = 0x3D,
    [";"] = 0x0C,
    _ = 0x3B,
    O = 0x54,
    k = 0x2F,
    ["7"] = 0x40,
    ["^"] = 0x34,
    N = 0x50,
    P = 0x25,
    b = 0x24,
    D = 0x44,
    ['"'] = 0x0F,
    ["@"] = 0x2E,
    F = 0x27,
    ["`"] = 0x52,
    m = 0x15,
    C = 0x23,
    [":"] = 0x21,
    ["4"] = 0x36,
    ["8"] = 0x14,
    ["\\"] = 0x07,
    ["9"] = 0x4D,
    o = 0x3E,
    d = 0x38,
    A = 0x28,
    B = 0x16,
    s = 0x51,
    ["-"] = 0x1E,
    E = 0x48,
    ["."] = 0x08,
    ["1"] = 0x29,
    L = 0x1B,
    G = 0x30,
    a = 0x01,
    V = 0x4F,
    U = 0x04,
    M = 0x32,
    r = 0x18,
    [">"] = 0x4E,
    ["5"] = 0x26,
    e = 0x3F,
    i = 0x2D,
    ["["] = 0x22,
    ["]"] = 0x2C,
    l = 0x09,
    Y = 0x13,
    R = 0x17,
    X = 0x1A,
    q = 0x2B,
    ["$"] = 0x1C,
    W = 0x11,
}

local function xorByte(left, right)
    local result = 0
    local bit = 1

    while left > 0 or right > 0 do
        if left % 2 ~= right % 2 then
            result += bit
        end

        left = math.floor(left / 2)
        right = math.floor(right / 2)
        bit *= 2
    end

    return result
end

local function decodeBase85(encoded, xorKey)
    local bytes = {}
    local index = 1

    while index <= #encoded do
        local remaining = #encoded - index + 1
        local blockSize = remaining >= 5 and 5 or remaining
        local packed = 0
        local valid = blockSize > 1

        for offset = 0, 4 do
            local value

            if offset < blockSize then
                value = BASE85_ALPHABET[string.sub(encoded, index + offset, index + offset)]
                if value == nil then
                    valid = false
                    break
                end
            else
                value = 84
            end

            packed = packed * 85 + value
        end

        if valid then
            local block = {
                math.floor(packed / 0x1000000) % 0x100,
                math.floor(packed / 0x10000) % 0x100,
                math.floor(packed / 0x100) % 0x100,
                packed % 0x100,
            }

            for byteIndex = 1, blockSize - 1 do
                table.insert(bytes, block[byteIndex])
            end
        end

        index += blockSize
    end

    if xorKey and xorKey ~= 0 then
        for byteIndex, byte in ipairs(bytes) do
            local mask = xorKey % 0x100
            xorKey = (xorKey * 0xFB + 0x11) % 0xFFF1
            bytes[byteIndex] = xorByte(byte, mask)
        end
    end

    local chars = {}
    for _, byte in ipairs(bytes) do
        table.insert(chars, string.char(byte))
    end

    return table.concat(chars)
end

local function decodeResolverEntry(logicalId, encodedChunkIndex, encodedXorKey)
    local chunkIndex = (encodedChunkIndex - (logicalId % 0xDF) * 4 - 0xF36) / 6
    local xorKey = (encodedXorKey - (logicalId % 0xDF) * 6 - 0xA44) / 4

    return chunkIndex, xorKey
end

Cleaned.decoder = {
    decodeBase85 = decodeBase85,
    decodeResolverEntry = decodeResolverEntry,
}

Cleaned.notes = {
    "The dirty file starts by storing a Voltils marker in __voltils_plrNklCCttayuV.",
    "The first packed string table expands to 2903 chunks.",
    "After unpacking, the obfuscator reverses sparse table ranges 1..0xB57, 1..0x9E5, and 2534..0xB57.",
    "Resolver entries are guarded by arithmetic keyed on the logical id, then decoded with the custom base85 table and XOR stream.",
    "Sandbox execution observed HttpService, RunService, NumberValue, and several randomized environment canary names before the VM stopped.",
}

return Cleaned
