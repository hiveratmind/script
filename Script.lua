local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Undertale Boss Battles", "Synapse")
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main")

-- Godmode
MainSection:NewButton("Godmode", "Invincibility to all attacks", function()
    local BlockedRemotes = { "Functions", }
    local Events = { Fire = true, Invoke = true, FireServer = true, InvokeServer = true, }
    local gameMeta = getrawmetatable(game)
    local psuedoEnv = {
        ["__index"] = gameMeta.__index,
        ["__namecall"] = gameMeta.__namecall;
    }
    setreadonly(gameMeta, false)
    gameMeta.__index, gameMeta.__namecall = newcclosure(function(self, index, ...)
        if Events[index] then
            for i,v in pairs(BlockedRemotes) do
                if v == self.Name then return nil end
            end
        end
        return psuedoEnv.__index(self, index, ...)
    end)
    setreadonly(gameMeta, true)
end)

-- Function to find closest dummy
local function getClosestDummy()
    local player = game.Players.LocalPlayer
    local closestDummy = nil
    local closestDistance = math.huge

    for _, mob in ipairs(workspace.Game.Mobs:GetChildren()) do
        if mob.Name == "Dummy" and mob:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestDummy = mob
                closestDistance = distance
            end
        end
    end
    return closestDummy
end

-- Function to deal damage
local function dealDamage(amount)
    local target = getClosestDummy()
    if not target then return end

    local args = {
        [1] = "DustBone",
        [2] = target,
        [3] = amount,
        [4] = "Skill2",
        [5] = 0,
        [6] = "NormalDMG"
    }

    game:GetService("ReplicatedStorage").Skill:FireServer(unpack(args))
end

-- Damage Buttons
MainSection:NewButton("10000 Damage", "Deals 10,000 Damage", function() dealDamage(10000) end)
MainSection:NewButton("20000 Damage", "Deals 20,000 Damage", function() dealDamage(20000) end)
MainSection:NewButton("40000 Damage", "Deals 40,000 Damage", function() dealDamage(40000) end)
MainSection:NewButton("60000 Damage", "Deals 60,000 Damage", function() dealDamage(60000) end)
MainSection:NewButton("80000 Damage", "Deals 80,000 Damage", function() dealDamage(80000) end)
MainSection:NewButton("100000 Damage", "Deals 100,000 Damage", function() dealDamage(100000) end)

-- Heal Enemy
MainSection:NewButton("Heal Enemwy", "Heals The Closest Enemy [Good For Trolling]", function()
    local target = getClosestDummy()
    if not target then return end

    local args = {
        [1] = "DustBone",
        [2] = target,
        [3] = -10000,
        [4] = "Skill2",
        [5] = 0,
        [6] = "NormalDMG"
    }

    game:GetService("ReplicatedStorage").Skill:FireServer(unpack(args))
end)

-- Autofarm toggle
MainSection:NewToggle("Autofarm", "Disable Battle Invitations", function(state)
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cxmplexe/Undertale-Boss-Battles/refs/heads/Extra/Autofarm.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Cxmplexe/Undertale-Boss-Battles/refs/heads/Extra/AutofarmFalse.lua"))()
    end
end)

-- Misc Tab
local MiscTab = Window:NewTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

MiscSection:NewButton("Rejoin", "Rejoins The Game For You", function()
    local TeleportService = game:GetService("TeleportService")
    local PlaceID = "2848920787"
    TeleportService:Teleport(PlaceID)
end)

MiscSection:NewSlider("Walkspeed", "Changes Your Walkspeed", 200, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

MiscSection:NewSlider("Jumppower", "Changes Your Jumppower", 500, 0, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

MiscSection:NewTextBox("Teleport To Player", "Doesn't Need To Be Exact", function(PlayerName)
    local players = game.Players:GetPlayers()
    local localPlayer = game.Players.LocalPlayer
    local partialName = PlayerName
    local bestMatch = nil

    for _, player in ipairs(players) do
        if string.find(player.Name:lower(), partialName:lower()) then
            bestMatch = player
            break
        end
    end

    if bestMatch and bestMatch.Character and bestMatch.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = bestMatch.Character.HumanoidRootPart.CFrame
    end
end)

print("Thank You For Using My Script!")
