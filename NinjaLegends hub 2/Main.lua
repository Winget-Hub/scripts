-- Best-effort readable reconstruction of NinjaLegends hub 2.
-- Generated from decrypted Luraph VM bytecode, constants, and sandbox runtime traces.
-- This is readable pseudocode: names/actions are recovered, but exact layout/order may differ.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "ilovecookiestm"
gui.Parent = game.CoreGui

local window = Instance.new("Frame")
window.Name = "MBF"
window.Parent = gui
-- The original script creates many frames, labels, and buttons for E-Hoax V2.0.2.

local function teleportTo(x, y, z)
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
end

local function ninjaEvent(action, areaOrName)
    if areaOrName ~= nil then
        LocalPlayer.ninjaEvent:FireServer(action, areaOrName)
    else
        LocalPlayer.ninjaEvent:FireServer(action)
    end
end

local function elementMastery(element)
    ReplicatedStorage.rEvents.elementMasteryEvent:FireServer(element)
end

local toggleByLabel = {
    ["Auto Buy Belts"] = "belt",
    ["Auto Buy Rank"] = "rank",
    ["Auto Buy Shurikens"] = "shuriken",
    ["Auto Buy Skill"] = "skill",
    ["Auto Buy Sword"] = "sword",
    ["Auto Chi"] = "chi",
    ["Auto Coin"] = "TpToCoins",
    ["Auto Sell"] = "sell",
    ["Auto Swing"] = "swing",
}

-- Callback 1: Enchanted Island
local function enchanted_island()
    teleportTo(80, 766, -188)
end

-- Callback 2: Mythical Souls Island
local function mythical_souls_island()
    teleportTo(175, 39317, 25)
end

-- Callback 3: Winter Wonder Island
local function winter_wonder_island()
    teleportTo(183, 46010, 36)
end

-- Callback 4: Dragon Legend Island
local function dragon_legend_island()
    teleportTo(188, 59594, 24)
end

-- Callback 5: Golden Master Island
local function golden_master_island()
    teleportTo(166, 52607, 34)
end

-- Callback 6: Midnight Shadow Island
local function midnight_shadow_island()
    teleportTo(180, 33206, 28)
end

-- Callback 7: Astral Island
local function astral_island()
    teleportTo(233, 2013, 331)
end

-- Callback 8: Mystical Island
local function mystical_island()
    teleportTo(165, 4047, 51)
end

-- Callback 9: Space Island
local function space_island()
    teleportTo(186, 5656, 76)
end

-- Callback 10: Tundra Island
local function tundra_island()
    teleportTo(189, 9284, 31)
end

-- Callback 11: Sandstorm Island
local function sandstorm_island()
    teleportTo(135, 17686, 61)
end

-- Callback 12: Ancient Inferno Island
local function ancient_inferno_island()
    teleportTo(171, 28255, 39)
end

-- Callback 13: Eternal Island
local function eternal_island()
    teleportTo(139, 13680, 74)
end

-- Callback 14: Thunderstorm Island
local function thunderstorm_island()
    teleportTo(108, 24069, 84)
end

-- Callback 15: Cybernetic Legends Island
local function cybernetic_legends_island()
    teleportTo(226, 66669, 15)
end

-- Callback 16: Skystorm Ultraus Island
local function skystorm_ultraus_island()
    teleportTo(197, 70270, 8)
end

-- Callback 17: Chaos Legends Island
local function chaos_legends_island()
    teleportTo(119, 74442, 52)
end

-- Callback 18: Soul Fusion Island
local function soul_fusion_island()
    teleportTo(193, 79746, 18)
end

-- Callback 19: Enchanted Island
local function enchanted_island_2()
    teleportTo(80, 766, -188)
end

-- Callback 20: Mythical Souls Island
local function mythical_souls_island_2()
    teleportTo(-128, 39439, 173)
end

-- Callback 21: Winter Wonder Island
local function winter_wonder_island_2()
    teleportTo(183, 46010, 36)
end

-- Callback 22: Dragon Legend Island
local function dragon_legend_island_2()
    teleportTo(188, 59594, 24)
end

-- Callback 23: Golden Master Island
local function golden_master_island_2()
    teleportTo(166, 52607, 34)
end

-- Callback 24: Midnight Shadow Island
local function midnight_shadow_island_2()
    teleportTo(180, 33206, 28)
end

-- Callback 25: Astral Island
local function astral_island_2()
    teleportTo(233, 2013, 331)
end

-- Callback 26: Mystical Island
local function mystical_island_2()
    teleportTo(165, 4047, 51)
end

-- Callback 27: Space Island
local function space_island_2()
    teleportTo(186, 5656, 76)
end

-- Callback 28: Tundra Island
local function tundra_island_2()
    teleportTo(189, 9284, 31)
end

-- Callback 29: Sandstorm Island
local function sandstorm_island_2()
    teleportTo(135, 17686, 61)
end

-- Callback 30: Ancient Inferno Island
local function ancient_inferno_island_2()
    teleportTo(171, 28255, 39)
end

-- Callback 31: Eternal Island
local function eternal_island_2()
    teleportTo(139, 13680, 74)
end

-- Callback 32: Thunderstorm Island
local function thunderstorm_island_2()
    teleportTo(108, 24069, 84)
end

-- Callback 33: Cybernetic Legends Island
local function cybernetic_legends_island_2()
    teleportTo(226, 66669, 15)
end

-- Callback 34: Skystorm Ultraus Island
local function skystorm_ultraus_island_2()
    teleportTo(197, 70270, 8)
end

-- Callback 35: Chaos Legends Island
local function chaos_legends_island_2()
    teleportTo(119, 74442, 52)
end

-- Callback 36: Soul Fusion Island
local function soul_fusion_island_2()
    teleportTo(193, 79746, 18)
end

-- Callback 37: Get
local function get()
    elementMastery("Frost")
end

-- Callback 38: Get
local function get_2()
    elementMastery("Electral Chaos")
end

-- Callback 39: Get
local function get_3()
    elementMastery("Lightning")
end

-- Callback 40: Get
local function get_4()
    elementMastery("Inferno")
end

-- Callback 41: Get
local function get_5()
    elementMastery("Masterful Wrath")
end

-- Callback 42: Get
local function get_6()
    elementMastery("Shadow Charge")
end

-- Callback 43: Get
local function get_7()
    elementMastery("Shadowfire")
end

-- Callback 44: Get
local function get_8()
    elementMastery("Eternity Storm")
end

-- Callback 45: Infinity Stats Dojo
local function infinity_stats_dojo()
    teleportTo(-4109.91553, 122.94751, -5908.6845)
end

-- Callback 46: Altar Of Elements
local function altar_of_elements()
    teleportTo(732.294434, 122.947517, -5908.3461)
end

-- Callback 47: Pet Cloning Altar
local function pet_cloning_altar()
    teleportTo(4520.91943, 122.947517, 1401.6312)
end

-- Callback 48: King of the Hill
local function king_of_the_hill()
    teleportTo(227.120529, 89.8075867, -285.06219)
end

-- Callback 49: Mystical Waters
local function mystical_waters()
    teleportTo(344, 8824, 125)
end

-- Callback 50: Lava Pit
local function lava_pit()
    teleportTo(-128, 12952, 274)
end

-- Callback 51: Tornado
local function tornado()
    teleportTo(320, 16872, -17)
end

-- Callback 52: Sword of Legends
local function sword_of_legends()
    teleportTo(1831, 38, -140)
end

-- Callback 53: Sword of Ancients
local function sword_of_ancients()
    teleportTo(613, 38, 2411)
end

-- Callback 54: Elemental Tornado
local function elemental_tornado()
    teleportTo(323, 30383, -10)
end

-- Callback 55: Fallen Infinity Blade
local function fallen_infinity_blade()
    teleportTo(1859, 38, -6788)
end

-- Callback 56: Zen Master's Blade
local function zen_master_s_blade()
    teleportTo(5019, 38, 1614)
end

-- Callback 57: Auto Buy Belts
local function auto_buy_belts()
    -- Repeats while _G.belt is true.
    while _G.belt do
        ninjaEvent("buyAllBelts", "Soul Fusion Island")
        wait()
    end
end

-- Callback 58: Auto Buy Rank
local function auto_buy_rank()
    -- Repeats while _G.rank is true.
    while _G.rank do
        for _, rank in pairs(ReplicatedStorage.Ranks.Ground:GetChildren()) do
            ninjaEvent("buyRank", rank.Name)
        end
        wait()
    end
end

-- Callback 59: Auto Buy Shurikens
local function auto_buy_shurikens()
    -- Repeats while _G.shuriken is true.
    while _G.shuriken do
        ninjaEvent("buyAllShurikens", "Soul Fusion Island")
        wait()
    end
end

-- Callback 60: Auto Buy Skill
local function auto_buy_skill()
    -- Repeats while _G.skill is true.
    while _G.skill do
        ninjaEvent("buyAllSkills", "Soul Fusion Island")
        wait()
    end
end

-- Callback 61: Auto Buy Sword
local function auto_buy_sword()
    -- Repeats while _G.sword is true.
    while _G.sword do
        ninjaEvent("buyAllSwords", "Soul Fusion Island")
        wait()
    end
end

-- Callback 62: Auto Chi
local function auto_chi()
    -- Repeats while _G.chi is true.
    while _G.chi do
        for _, coin in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
            if coin.Name == "Blue Chi Crate" then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(coin.Position)
            end
        end
        wait(0.1)
    end
end

-- Callback 63: Auto Coin
local function auto_coin()
    -- Repeats while _G.TpToCoins is true.
    while _G.TpToCoins do
        for _, coin in pairs(game.Workspace.spawnedCoins.Valley:GetChildren()) do
            LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
            wait(0.1)
        end
    end
end

-- Callback 64: Auto Sell
local function auto_sell()
    -- Repeats while _G.sell is true.
    while _G.sell do
        game.workspace.sellAreaCircles.sellAreaCircle15.circleInner.CFrame = LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
        wait(0.1)
    end
end

-- Callback 65: Auto Swing
local function auto_swing()
    -- Repeats while _G.swing is true.
    while _G.swing do
        ninjaEvent("swingKatana")
        wait()
    end
end

-- Callback 66: Auto Stuff
local function auto_stuff()
    -- UI tab/toggle visibility and color changes.
    -- Frame#17(Instance.Frame Name=Credit BF).Visible=false
end

-- Callback 67: Credit
local function credit()
    -- No gameplay side effects observed in sandbox trace.
end

-- Callback 68: Teleport Island
local function teleport_island()
    -- No gameplay side effects observed in sandbox trace.
end

-- Callback 69: Teleports
local function teleports()
    -- No gameplay side effects observed in sandbox trace.
end

-- Callback 70: Settings
local function settings()
    -- No gameplay side effects observed in sandbox trace.
end

-- Callback 71: Misc
local function misc()
    -- No gameplay side effects observed in sandbox trace.
end

-- Callback 72: InputBegan#233(UserInputService#232(game#1(game).UserInputService).InputBegan)
local function inputbegan_233_userinputservice_232_game_1_game_()
    -- UI tab/toggle visibility and color changes.
    -- Frame#5(Instance.Frame Name=MBF).Visible=false
end

-- Button/callback labels recovered from runtime trace:
-- 01: Enchanted Island
-- 02: Mythical Souls Island
-- 03: Winter Wonder Island
-- 04: Dragon Legend Island
-- 05: Golden Master Island
-- 06: Midnight Shadow Island
-- 07: Astral Island
-- 08: Mystical Island
-- 09: Space Island
-- 10: Tundra Island
-- 11: Sandstorm Island
-- 12: Ancient Inferno Island
-- 13: Eternal Island
-- 14: Thunderstorm Island
-- 15: Cybernetic Legends Island
-- 16: Skystorm Ultraus Island
-- 17: Chaos Legends Island
-- 18: Soul Fusion Island
-- 19: Enchanted Island
-- 20: Mythical Souls Island
-- 21: Winter Wonder Island
-- 22: Dragon Legend Island
-- 23: Golden Master Island
-- 24: Midnight Shadow Island
-- 25: Astral Island
-- 26: Mystical Island
-- 27: Space Island
-- 28: Tundra Island
-- 29: Sandstorm Island
-- 30: Ancient Inferno Island
-- 31: Eternal Island
-- 32: Thunderstorm Island
-- 33: Cybernetic Legends Island
-- 34: Skystorm Ultraus Island
-- 35: Chaos Legends Island
-- 36: Soul Fusion Island
-- 37: Get
-- 38: Get
-- 39: Get
-- 40: Get
-- 41: Get
-- 42: Get
-- 43: Get
-- 44: Get
-- 45: Infinity Stats Dojo
-- 46: Altar Of Elements
-- 47: Pet Cloning Altar
-- 48: King of the Hill
-- 49: Mystical Waters
-- 50: Lava Pit
-- 51: Tornado
-- 52: Sword of Legends
-- 53: Sword of Ancients
-- 54: Elemental Tornado
-- 55: Fallen Infinity Blade
-- 56: Zen Master's Blade
-- 57: Auto Buy Belts
-- 58: Auto Buy Rank
-- 59: Auto Buy Shurikens
-- 60: Auto Buy Skill
-- 61: Auto Buy Sword
-- 62: Auto Chi
-- 63: Auto Coin
-- 64: Auto Sell
-- 65: Auto Swing
-- 66: Auto Stuff
-- 67: Credit
-- 68: Teleport Island
-- 69: Teleports
-- 70: Settings
-- 71: Misc
-- 72: InputBegan#233(UserInputService#232(game#1(game).UserInputService).InputBegan)

-- Constants of interest recovered from the VM:
--   Instance
--   new
--   ScreenGui
--   Frame
--   TextLabel
--   TextButton
--   Name
--   ilovecookiestm
--   Parent
--   game
--   CoreGui
--   MBF
--   Active
--   BackgroundColor3
--   Color3
--   fromRGB
--   BackgroundTransparency
--   Position
--   UDim2
--   Size
--   BorderColor3
--   Gui Name
--   BorderSizePixel
--   Font
--   Enum
--   SourceSans
--   Text
--   E-Hoax V2.0.2   |   ElfuJnenKDUjJdyHb
--   TextColor3
--   TextSize
--   TextWrapped
--   TextXAlignment
--   Left
--   Instrucitons
--   'F' to Toggle
--   Tabs
--   Credit
--   Auto Stuff
--   Teleport Isalnd
--   Teleport Island
--   Teleports
--   Misc
--   Settings
--   BF
--   Credit BF
--   c1
--      E-Hoax V2
--   c2
--   -- by Saitama The Great#3784  
--   Auto Stuff BF
--   Visible
--   Main Functions
--    --Main Functions--
--   Auto Buy
--      --Auto Buy--
--   Auto Thingies
--     Auto Swing
--   TextYAlignment
--   Top
--   Auto Buy Shurikens
--   Auto Swing
--     Auto Sell
--   Selectable
--     Auto Coin
--   Auto Buy Sword
--     Auto Chi
--   Auto Sell
--     Auto Buy Skills
--     Auto Buy Swords
--     Auto Buy Shurikens
--     Auto Buy Ranks
--     Auto Buy Belts
--   Auto Buy Belts
--   Auto Coin
--   Auto Chi 
--   Auto Buy Skill
--   Auto Buy Rank
--   Teleports BF
--   Bad Karma Area
--     --Bad Karma Area--
--   Lava Pit
--     Lava Pit
--   Tornado
--     Tornado
--   Sword of Ancients
--     Sword of Ancients
--   Fallen Infinity Blade
--     Fallen Infinity Blade
--   Good Karma Area
--     --Good Karma Area--
--   Mystical Waters
--     Mystical Waters
--   Sword of Legends
--     Sword of Legends
--   Elemental Tornado
--     Elemental Tornado
--   Zen Master's Blade
--     Zen Master's Blade
--   Important Places
--     --Important Places--
--   Altar Of Elements
--     Altar Of Elements
--   Infinity Stats Dojo
--     Infinity Stats Dojo
--   King of the Hill
--     King of the Hill
--   Pet Cloning Altar
--     Pet Cloning Altar
--   Misc BF
--   ElementsName
--     --Elements--
--   Elements
--     Electral Chaos Element
--     Eternity Storm Element
--     Shadowfire Element
--     Frost Element
--     Inferno Element
--     Lightning Element
--     Masterful Wrath Element
--     Shadow Charge Element
--   Electral Chaos Element
--   Style
--   ButtonStyle
--   RobloxRoundButton
--   Get
--   Eternity Storm Element
--   Shadowfire Element
--   Frost Element
--   Inferno Element
--   Lightning Element
--   Masterful Wrath Element
--   Shadow Charge Element
--   Settings BF
--   Anti Kick
--   Teleport Island BF
--   Tp Islands 2nd
--      --Tp Islands--
--   Tp Islands 1st
--   Divider
--   Winter Wonder Island
--     Winter Wonder Island
--   Tundra Island
--     Tundra Island
--   Thunderstorm Island
--     Thunderstorm Island
--   Space Island
--     Space Island
--   Soul Fusion Island
--     Soul Fusion Island
--   Skystorm Ultraus Island
--     Skystorm Ultraus Island
--   Sandstorm Island
--     Sandstorm Island
--   Mythical Souls Island
--     Mythical Souls Island
--   Mystical Island
--     Mystical Island
--   Midnight Shadow Island
--     Midnight Shadow Island
--   Golden Master Island
--     Golden Master Island
--   Eternal Island
--     Eternal Island
--   Enchanted Island
--     Enchanted Island
--   Dragon Legend Island
--     Dragon Legend Island
--   Cybernetic Legends Island
--     Cybernetic Legends Island
--   Chaos Legends Island
--     Chaos Legends Island
--   Astral Island
--     Astral Island
--   Ancient Inferno Island
--     Ancient Inferno Island
--   MouseButton1Down
--   connect
--   MouseButton1Click
--   onKeyPress
--   GetService
--   UserInputService
--   InputBegan
--   game
--   Players
--   LocalPlayer
--   Character
--   HumanoidRootPart
--   CFrame
--   new
--   game
--   Players
--   LocalPlayer
--   Character
--   HumanoidRootPart
--   CFrame
--   new
--   game
--   Players
--   LocalPlayer
--   Character
--   HumanoidRootPart
--   CFrame
--   new
--   game
--   Players
--   LocalPlayer
--   Character
--   HumanoidRootPart
--   CFrame
--   new
--   game
--   Players
--   LocalPlayer
--   Character
