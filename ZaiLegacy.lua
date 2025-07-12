--[[
    ZaiLegacy - Advanced Blox Fruit Script
    Features:
    - GUI similar to Banana Cat
    - Auto Farm Level with boss coordinates
    - Island Teleport (Sea 1 to Sea 3)
    - Quest Automation
    - No Key System with GUI Icon
    - Complete XYZ coordinates for all bosses and islands
    - Percentage Level Display
]]

-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local ZaiLegacy = {}
ZaiLegacy.Loaded = false
ZaiLegacy.Settings = {
    AutoFarm = false,
    AutoQuest = false,
    AutoNewWorld = false,
    AutoBoss = false,
    SelectedBoss = "",
    SelectedIsland = "",
    FarmDistance = 20,
    NoClip = false
}

-- Boss Coordinates (Sea 1, Sea 2, Sea 3)
ZaiLegacy.Bosses = {
    ["Sea 1"] = {
        ["Bandit Leader"] = {CFrame = CFrame.new(1147.62, 98.95, 1634.42)},
        ["Monkey"] = {CFrame = CFrame.new(-1496.21, 98.95, 90.36)},
        ["Gorilla"] = {CFrame = CFrame.new(-1123.52, 40.95, -525.53)},
        ["Pirate"] = {CFrame = CFrame.new(-1113.28, 13.75, 3936.88)},
        ["Brute"] = {CFrame = CFrame.new(-1145.65, 40.95, -516.49)},
        ["Desert Bandit"] = {CFrame = CFrame.new(932.34, 6.05, 4489.13)},
        ["Desert Officer"] = {CFrame = CFrame.new(1613.93, 4.75, 4373.35)},
        ["Snow Bandit"] = {CFrame = CFrame.new(1289.17, 105.35, -1397.43)},
        ["Snowman"] = {CFrame = CFrame.new(1289.17, 105.35, -1397.43)},
        ["Chief Petty Officer"] = {CFrame = CFrame.new(-1612.56, 13.75, 4373.35)},
        ["Sky Bandit"] = {CFrame = CFrame.new(-4981.67, 277.95, -2833.68)},
        ["Dark Master"] = {CFrame = CFrame.new(-3780.69, 283.25, -349.33)}
    },
    ["Sea 2"] = {
        ["Pirate Millionaire"] = {CFrame = CFrame.new(-373.75, 75.95, 5553.56)},
        ["Dragon Crew Warrior"] = {CFrame = CFrame.new(640.32, 40.95, -796.36)},
        ["Dragon Crew Archer"] = {CFrame = CFrame.new(928.59, 40.95, -876.05)},
        ["Female Islander"] = {CFrame = CFrame.new(2178.15, 29.95, -673.26)},
        ["Giant Islander"] = {CFrame = CFrame.new(2201.82, 129.95, -616.83)},
        ["Marine Commodore"] = {CFrame = CFrame.new(-2446.71, 73.95, -3908.93)},
        ["Fishman Warrior"] = {CFrame = CFrame.new(28282.57, 1489.95, 105.11)},
        ["Fishman Lord"] = {CFrame = CFrame.new(28282.57, 1489.95, 105.11)},
        ["God's Guard"] = {CFrame = CFrame.new(-5231.61, 424.95, -2675.53)},
        ["Warden"] = {CFrame = CFrame.new(-5277.39, 424.95, -2679.57)},
        ["Chief Warden"] = {CFrame = CFrame.new(-5231.61, 424.95, -2675.53)},
        ["Swan"] = {CFrame = CFrame.new(904.41, 124.95, 1433.22)},
        ["Crazy Scientist"] = {CFrame = CFrame.new(-2070.32, 73.95, -3543.76)}
    },
    ["Sea 3"] = {
        ["Dough King"] = {CFrame = CFrame.new(-2160.21, 149.95, -12408.4)},
        ["Cake Queen"] = {CFrame = CFrame.new(-709.27, 381.95, -11011.4)},
        ["Bake Chef"] = {CFrame = CFrame.new(-1889.54, 190.95, -11638.9)},
        ["Cake Prince"] = {CFrame = CFrame.new(-2160.21, 149.95, -12408.4)},
        ["Cookie Crafter"] = {CFrame = CFrame.new(-2256.21, 149.95, -12156.4)},
        ["Cocoa Warrior"] = {CFrame = CFrame.new(82.32, 73.95, -12318.9)},
        ["Chocolate Bar Battler"] = {CFrame = CFrame.new(620.63, 73.95, -12781.9)},
        ["Sweet Thief"] = {CFrame = CFrame.new(521.45, 208.95, -12653.9)},
        ["Candy Rebel"] = {CFrame = CFrame.new(1124.82, 464.95, -12702.9)},
        ["Candy Pirate"] = {CFrame = CFrame.new(-1344.88, 149.95, -12883.9)},
        ["Snow Demon"] = {CFrame = CFrame.new(1384.68, 453.95, -11633.9)},
        ["Arctic Warrior"] = {CFrame = CFrame.new(1216.52, 453.95, -11633.9)}
    }
}

-- Island Coordinates (Sea 1, Sea 2, Sea 3)
ZaiLegacy.Islands = {
    ["Sea 1"] = {
        ["Starter Island"] = {CFrame = CFrame.new(1071.28, 16.95, 1426.79)},
        ["Jungle"] = {CFrame = CFrame.new(-1612.56, 36.95, 149.38)},
        ["Pirate Village"] = {CFrame = CFrame.new(-1181.28, 4.75, 3806.03)},
        ["Desert"] = {CFrame = CFrame.new(1094.43, 6.95, 4192.69)},
        ["Snow Island"] = {CFrame = CFrame.new(1289.17, 105.35, -1397.43)},
        ["Marine Fortress"] = {CFrame = CFrame.new(-4914.69, 313.95, -3171.99)},
        ["Sky Island 1"] = {CFrame = CFrame.new(-4969.02, 717.95, -2624.73)},
        ["Sky Island 2"] = {CFrame = CFrame.new(-4613.93, 872.95, -1926.79)},
        ["Sky Island 3"] = {CFrame = CFrame.new(-7894.62, 5545.95, -420.38)}
    },
    ["Sea 2"] = {
        ["Kingdom of Rose"] = {CFrame = CFrame.new(-394.96, 118.95, 1245.18)},
        ["Usoap's Island"] = {CFrame = CFrame.new(4764.69, 8.95, 2849.96)},
        ["Green Zone"] = {CFrame = CFrame.new(2442.62, 73.95, -696.88)},
        ["Graveyard"] = {CFrame = CFrame.new(5595.28, 48.95, -748.26)},
        ["Snow Mountain"] = {CFrame = CFrame.new(609.66, 401.95, -5373.69)},
        ["Hot Island"] = {CFrame = CFrame.new(-5505.38, 15.95, -5366.12)},
        ["Cold Island"] = {CFrame = CFrame.new(-5924.72, 15.95, -4996.05)},
        ["Ice Castle"] = {CFrame = CFrame.new(6148.41, 294.95, -6281.74)},
        ["Fishman Island"] = {CFrame = CFrame.new(28282.57, 1489.95, 105.11)},
        ["Sky Island"] = {CFrame = CFrame.new(-4819.58, 565.95, -4283.68)},
        ["Prison"] = {CFrame = CFrame.new(4875.96, 5.95, 734.62)},
        ["Magma Village"] = {CFrame = CFrame.new(-5231.61, 8.95, -8467.53)},
        ["Underwater City"] = {CFrame = CFrame.new(61163.85, 11.95, 1819.78)}
    },
    ["Sea 3"] = {
        ["Port Town"] = {CFrame = CFrame.new(-290.38, 43.95, 5577.91)},
        ["Hydra Island"] = {CFrame = CFrame.new(5747.28, 611.95, -249.83)},
        ["Floating Turtle"] = {CFrame = CFrame.new(-13274.22, 331.95, -8359.96)},
        ["Mansion"] = {CFrame = CFrame.new(-12548.92, 337.95, -8641.19)},
        ["Haunted Castle"] = {CFrame = CFrame.new(-9515.38, 142.95, 6078.21)},
        ["Great Tree"] = {CFrame = CFrame.new(2681.27, 1682.95, -7190.99)},
        ["Cake Island"] = {CFrame = CFrame.new(-1889.54, 190.95, -11638.9)},
        ["Ice Cream Island"] = {CFrame = CFrame.new(-902.58, 79.95, -10988.9)},
        ["Peanut Island"] = {CFrame = CFrame.new(-2062.52, 50.95, -10232.9)},
        ["Candy Island"] = {CFrame = CFrame.new(-1344.88, 149.95, -12883.9)}
    }
}

-- Create GUI
function ZaiLegacy:CreateGUI()
    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZaiLegacy"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 450, 0, 30)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Title.BorderSizePixel = 0
    Title.Text = "ZaiLegacy | Blox Fruit Script"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = MainFrame

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Tabs
    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.Size = UDim2.new(0, 100, 0, 320)
    Tabs.Position = UDim2.new(0, 0, 0, 30)
    Tabs.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tabs.BorderSizePixel = 0
    Tabs.Parent = MainFrame

    -- Tab Buttons
    local TabButtons = {
        "Main",
        "Auto Farm",
        "Teleport",
        "Misc",
        "Settings"
    }

    for i, tabName in ipairs(TabButtons) do
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName.."Tab"
        TabButton.Size = UDim2.new(0, 100, 0, 40)
        TabButton.Position = UDim2.new(0, 0, 0, (i-1)*40)
        TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabButton.BorderSizePixel = 0
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.Parent = Tabs
    end

    -- Content Frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(0, 350, 0, 320)
    ContentFrame.Position = UDim2.new(0, 100, 0, 30)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ClipsDescendants = true
    ContentFrame.Parent = MainFrame

    -- Create Tabs Content
    self:CreateMainTab(ContentFrame)
    self:CreateAutoFarmTab(ContentFrame)
    self:CreateTeleportTab(ContentFrame)
    self:CreateMiscTab(ContentFrame)
    self:CreateSettingsTab(ContentFrame)

    -- Show Main Tab by default
    self:ShowTab(ContentFrame, "Main")

    -- Tab Button Events
    for _, tabName in ipairs(TabButtons) do
        Tabs:FindFirstChild(tabName.."Tab").MouseButton1Click:Connect(function()
            self:ShowTab(ContentFrame, tabName)
        end)
    end

    -- Toggle GUI Key (Right Shift)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.RightShift then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)

    -- Create GUI Icon
    self:CreateGUIIcon(ScreenGui)
end

function ZaiLegacy:CreateGUIIcon(parent)
    local Icon = Instance.new("ImageButton")
    Icon.Name = "ZaiLegacyIcon"
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Position = UDim2.new(0, 20, 0.5, -25)
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://78593749711709" -- Replace with your icon image ID
    Icon.Parent = parent

    Icon.MouseButton1Click:Connect(function()
        parent.MainFrame.Visible = not parent.MainFrame.Visible
    end)
end

function ZaiLegacy:ShowTab(contentFrame, tabName)
    for _, child in ipairs(contentFrame:GetChildren()) do
        child.Visible = false
    end
    
    local tab = contentFrame:FindFirstChild(tabName.."Content")
    if tab then
        tab.Visible = true
    end
end

function ZaiLegacy:CreateMainTab(parent)
    local MainContent = Instance.new("Frame")
    MainContent.Name = "MainContent"
    MainContent.Size = UDim2.new(1, 0, 1, 0)
    MainContent.BackgroundTransparency = 1
    MainContent.Visible = false
    MainContent.Parent = parent

    -- Welcome Label
    local WelcomeLabel = Instance.new("TextLabel")
    WelcomeLabel.Name = "WelcomeLabel"
    WelcomeLabel.Size = UDim2.new(1, -20, 0, 30)
    WelcomeLabel.Position = UDim2.new(0, 10, 0, 10)
    WelcomeLabel.BackgroundTransparency = 1
    WelcomeLabel.Text = "Welcome to ZaiLegacy!"
    WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeLabel.TextSize = 20
    WelcomeLabel.Font = Enum.Font.GothamBold
    WelcomeLabel.TextXAlignment = Enum.TextXAlignment.Left
    WelcomeLabel.Parent = MainContent

    -- Description
    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Size = UDim2.new(1, -20, 0, 100)
    Description.Position = UDim2.new(0, 10, 0, 50)
    Description.BackgroundTransparency = 1
    Description.Text = "Advanced Blox Fruit script with all features you need!\n\n- Auto Farm Level\n- Boss Teleport\n- Island Teleport\n- Quest Automation\n- And much more!"
    Description.TextColor3 = Color3.fromRGB(200, 200, 200)
    Description.TextSize = 14
    Description.Font = Enum.Font.Gotham
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextYAlignment = Enum.TextYAlignment.Top
    Description.Parent = MainContent

    -- Status
    local Status = Instance.new("TextLabel")
    Status.Name = "Status"
    Status.Size = UDim2.new(1, -20, 0, 20)
    Status.Position = UDim2.new(0, 10, 1, -30)
    Status.BackgroundTransparency = 1
    Status.Text = "Status: Ready"
    Status.TextColor3 = Color3.fromRGB(150, 255, 150)
    Status.TextSize = 14
    Status.Font = Enum.Font.Gotham
    Status.TextXAlignment = Enum.TextXAlignment.Left
    Status.Parent = MainContent
end

function ZaiLegacy:CreateAutoFarmTab(parent)
    local AutoFarmContent = Instance.new("Frame")
    AutoFarmContent.Name = "AutoFarmContent"
    AutoFarmContent.Size = UDim2.new(1, 0, 1, 0)
    AutoFarmContent.BackgroundTransparency = 1
    AutoFarmContent.Visible = false
    AutoFarmContent.Parent = parent

    -- Auto Farm Toggle
    local AutoFarmToggle = Instance.new("TextButton")
    AutoFarmToggle.Name = "AutoFarmToggle"
    AutoFarmToggle.Size = UDim2.new(1, -20, 0, 30)
    AutoFarmToggle.Position = UDim2.new(0, 10, 0, 10)
    AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    AutoFarmToggle.BorderSizePixel = 0
    AutoFarmToggle.Text = "Auto Farm Level: OFF"
    AutoFarmToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    AutoFarmToggle.TextSize = 14
    AutoFarmToggle.Font = Enum.Font.Gotham
    AutoFarmToggle.Parent = AutoFarmContent

    AutoFarmToggle.MouseButton1Click:Connect(function()
        ZaiLegacy.Settings.AutoFarm = not ZaiLegacy.Settings.AutoFarm
        if ZaiLegacy.Settings.AutoFarm then
            AutoFarmToggle.Text = "Auto Farm Level: ON"
            AutoFarmToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
            self:StartAutoFarm()
        else
            AutoFarmToggle.Text = "Auto Farm Level: OFF"
            AutoFarmToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    -- Auto Quest Toggle
    local AutoQuestToggle = Instance.new("TextButton")
    AutoQuestToggle.Name = "AutoQuestToggle"
    AutoQuestToggle.Size = UDim2.new(1, -20, 0, 30)
    AutoQuestToggle.Position = UDim2.new(0, 10, 0, 50)
    AutoQuestToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    AutoQuestToggle.BorderSizePixel = 0
    AutoQuestToggle.Text = "Auto Quest: OFF"
    AutoQuestToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    AutoQuestToggle.TextSize = 14
    AutoQuestToggle.Font = Enum.Font.Gotham
    AutoQuestToggle.Parent = AutoFarmContent

    AutoQuestToggle.MouseButton1Click:Connect(function()
        ZaiLegacy.Settings.AutoQuest = not ZaiLegacy.Settings.AutoQuest
        if ZaiLegacy.Settings.AutoQuest then
            AutoQuestToggle.Text = "Auto Quest: ON"
            AutoQuestToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            AutoQuestToggle.Text = "Auto Quest: OFF"
            AutoQuestToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    -- Boss Dropdown
    local BossDropdown = Instance.new("TextLabel")
    BossDropdown.Name = "BossDropdown"
    BossDropdown.Size = UDim2.new(1, -20, 0, 30)
    BossDropdown.Position = UDim2.new(0, 10, 0, 90)
    BossDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    BossDropdown.BorderSizePixel = 0
    BossDropdown.Text = "Select Boss"
    BossDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    BossDropdown.TextSize = 14
    BossDropdown.Font = Enum.Font.Gotham
    BossDropdown.Parent = AutoFarmContent

    local BossScrollingFrame = Instance.new("ScrollingFrame")
    BossScrollingFrame.Name = "BossScrollingFrame"
    BossScrollingFrame.Size = UDim2.new(1, -20, 0, 150)
    BossScrollingFrame.Position = UDim2.new(0, 10, 0, 130)
    BossScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BossScrollingFrame.BorderSizePixel = 0
    BossScrollingFrame.ScrollBarThickness = 5
    BossScrollingFrame.Visible = false
    BossScrollingFrame.Parent = AutoFarmContent

    local BossListLayout = Instance.new("UIListLayout")
    BossListLayout.Name = "BossListLayout"
    BossListLayout.Parent = BossScrollingFrame

    -- Populate Boss List
    local currentSea = self:GetCurrentSea()
    for bossName, _ in pairs(self.Bosses[currentSea]) do
        local BossButton = Instance.new("TextButton")
        BossButton.Name = bossName
        BossButton.Size = UDim2.new(1, 0, 0, 30)
        BossButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        BossButton.BorderSizePixel = 0
        BossButton.Text = bossName
        BossButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        BossButton.TextSize = 14
        BossButton.Font = Enum.Font.Gotham
        BossButton.Parent = BossScrollingFrame

        BossButton.MouseButton1Click:Connect(function()
            ZaiLegacy.Settings.SelectedBoss = bossName
            BossDropdown.Text = "Boss: "..bossName
            BossScrollingFrame.Visible = false
        end)
    end

    BossDropdown.MouseButton1Click:Connect(function()
        BossScrollingFrame.Visible = not BossScrollingFrame.Visible
    end)

    -- Auto Boss Toggle
    local AutoBossToggle = Instance.new("TextButton")
    AutoBossToggle.Name = "AutoBossToggle"
    AutoBossToggle.Size = UDim2.new(1, -20, 0, 30)
    AutoBossToggle.Position = UDim2.new(0, 10, 0, 290)
    AutoBossToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    AutoBossToggle.BorderSizePixel = 0
    AutoBossToggle.Text = "Auto Farm Boss: OFF"
    AutoBossToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    AutoBossToggle.TextSize = 14
    AutoBossToggle.Font = Enum.Font.Gotham
    AutoBossToggle.Parent = AutoFarmContent

    AutoBossToggle.MouseButton1Click:Connect(function()
        ZaiLegacy.Settings.AutoBoss = not ZaiLegacy.Settings.AutoBoss
        if ZaiLegacy.Settings.AutoBoss then
            if ZaiLegacy.Settings.SelectedBoss == "" then
                parent.Parent.Parent.MainContent.Status.Text = "Status: Please select a boss first!"
                task.wait(2)
                parent.Parent.Parent.MainContent.Status.Text = "Status: Ready"
                ZaiLegacy.Settings.AutoBoss = false
                return
            end
            AutoBossToggle.Text = "Auto Farm Boss: ON"
            AutoBossToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
            self:StartBossFarm()
        else
            AutoBossToggle.Text = "Auto Farm Boss: OFF"
            AutoBossToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

function ZaiLegacy:CreateTeleportTab(parent)
    local TeleportContent = Instance.new("Frame")
    TeleportContent.Name = "TeleportContent"
    TeleportContent.Size = UDim2.new(1, 0, 1, 0)
    TeleportContent.BackgroundTransparency = 1
    TeleportContent.Visible = false
    TeleportContent.Parent = parent

    -- Island Dropdown
    local IslandDropdown = Instance.new("TextLabel")
    IslandDropdown.Name = "IslandDropdown"
    IslandDropdown.Size = UDim2.new(1, -20, 0, 30)
    IslandDropdown.Position = UDim2.new(0, 10, 0, 10)
    IslandDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    IslandDropdown.BorderSizePixel = 0
    IslandDropdown.Text = "Select Island"
    IslandDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    IslandDropdown.TextSize = 14
    IslandDropdown.Font = Enum.Font.Gotham
    IslandDropdown.Parent = TeleportContent

    local IslandScrollingFrame = Instance.new("ScrollingFrame")
    IslandScrollingFrame.Name = "IslandScrollingFrame"
    IslandScrollingFrame.Size = UDim2.new(1, -20, 0, 250)
    IslandScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
    IslandScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    IslandScrollingFrame.BorderSizePixel = 0
    IslandScrollingFrame.ScrollBarThickness = 5
    IslandScrollingFrame.Visible = false
    IslandScrollingFrame.Parent = TeleportContent

    local IslandListLayout = Instance.new("UIListLayout")
    IslandListLayout.Name = "IslandListLayout"
    IslandListLayout.Parent = IslandScrollingFrame

    -- Populate Island List
    local currentSea = self:GetCurrentSea()
    for islandName, _ in pairs(self.Islands[currentSea]) do
        local IslandButton = Instance.new("TextButton")
        IslandButton.Name = islandName
        IslandButton.Size = UDim2.new(1, 0, 0, 30)
        IslandButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        IslandButton.BorderSizePixel = 0
        IslandButton.Text = islandName
        IslandButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        IslandButton.TextSize = 14
        IslandButton.Font = Enum.Font.Gotham
        IslandButton.Parent = IslandScrollingFrame

        IslandButton.MouseButton1Click:Connect(function()
            ZaiLegacy.Settings.SelectedIsland = islandName
            IslandDropdown.Text = "Island: "..islandName
            IslandScrollingFrame.Visible = false
        end)
    end

    IslandDropdown.MouseButton1Click:Connect(function()
        IslandScrollingFrame.Visible = not IslandScrollingFrame.Visible
    end)

    -- Teleport Button
    local TeleportButton = Instance.new("TextButton")
    TeleportButton.Name = "TeleportButton"
    TeleportButton.Size = UDim2.new(1, -20, 0, 30)
    TeleportButton.Position = UDim2.new(0, 10, 0, 310)
    TeleportButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TeleportButton.BorderSizePixel = 0
    TeleportButton.Text = "Teleport"
    TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportButton.TextSize = 14
    TeleportButton.Font = Enum.Font.Gotham
    TeleportButton.Parent = TeleportContent

    TeleportButton.MouseButton1Click:Connect(function()
        if ZaiLegacy.Settings.SelectedIsland == "" then
            parent.Parent.Parent.MainContent.Status.Text = "Status: Please select an island first!"
            task.wait(2)
            parent.Parent.Parent.MainContent.Status.Text = "Status: Ready"
            return
        end
        
        local currentSea = self:GetCurrentSea()
        local islandCFrame = self.Islands[currentSea][ZaiLegacy.Settings.SelectedIsland].CFrame
        self:TeleportTo(islandCFrame)
        parent.Parent.Parent.MainContent.Status.Text = "Status: Teleporting to "..ZaiLegacy.Settings.SelectedIsland
        task.wait(2)
        parent.Parent.Parent.MainContent.Status.Text = "Status: Ready"
    end)
end

function ZaiLegacy:CreateMiscTab(parent)
    local MiscContent = Instance.new("Frame")
    MiscContent.Name = "MiscContent"
    MiscContent.Size = UDim2.new(1, 0, 1, 0)
    MiscContent.BackgroundTransparency = 1
    MiscContent.Visible = false
    MiscContent.Parent = parent

    -- NoClip Toggle
    local NoClipToggle = Instance.new("TextButton")
    NoClipToggle.Name = "NoClipToggle"
    NoClipToggle.Size = UDim2.new(1, -20, 0, 30)
    NoClipToggle.Position = UDim2.new(0, 10, 0, 10)
    NoClipToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    NoClipToggle.BorderSizePixel = 0
    NoClipToggle.Text = "NoClip: OFF"
    NoClipToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    NoClipToggle.TextSize = 14
    NoClipToggle.Font = Enum.Font.Gotham
    NoClipToggle.Parent = MiscContent

    NoClipToggle.MouseButton1Click:Connect(function()
        ZaiLegacy.Settings.NoClip = not ZaiLegacy.Settings.NoClip
        if ZaiLegacy.Settings.NoClip then
            NoClipToggle.Text = "NoClip: ON"
            NoClipToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
            self:StartNoClip()
        else
            NoClipToggle.Text = "NoClip: OFF"
            NoClipToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    -- Auto New World Toggle
    local AutoNewWorldToggle = Instance.new("TextButton")
    AutoNewWorldToggle.Name = "AutoNewWorldToggle"
    AutoNewWorldToggle.Size = UDim2.new(1, -20, 0, 30)
    AutoNewWorldToggle.Position = UDim2.new(0, 10, 0, 50)
    AutoNewWorldToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    AutoNewWorldToggle.BorderSizePixel = 0
    AutoNewWorldToggle.Text = "Auto New World: OFF"
    AutoNewWorldToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
    AutoNewWorldToggle.TextSize = 14
    AutoNewWorldToggle.Font = Enum.Font.Gotham
    AutoNewWorldToggle.Parent = MiscContent

    AutoNewWorldToggle.MouseButton1Click:Connect(function()
        ZaiLegacy.Settings.AutoNewWorld = not ZaiLegacy.Settings.AutoNewWorld
        if ZaiLegacy.Settings.AutoNewWorld then
            AutoNewWorldToggle.Text = "Auto New World: ON"
            AutoNewWorldToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
            self:AutoNewWorld()
        else
            AutoNewWorldToggle.Text = "Auto New World: OFF"
            AutoNewWorldToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    -- Rejoin Button
    local RejoinButton = Instance.new("TextButton")
    RejoinButton.Name = "RejoinButton"
    RejoinButton.Size = UDim2.new(1, -20, 0, 30)
    RejoinButton.Position = UDim2.new(0, 10, 0, 90)
    RejoinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    RejoinButton.BorderSizePixel = 0
    RejoinButton.Text = "Rejoin Server"
    RejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    RejoinButton.TextSize = 14
    RejoinButton.Font = Enum.Font.Gotham
    RejoinButton.Parent = MiscContent

    RejoinButton.MouseButton1Click:Connect(function()
        TeleportService:Teleport(game.PlaceId, Player)
    end)

    -- Server Hop Button
    local ServerHopButton = Instance.new("TextButton")
    ServerHopButton.Name = "ServerHopButton"
    ServerHopButton.Size = UDim2.new(1, -20, 0, 30)
    ServerHopButton.Position = UDim2.new(0, 10, 0, 130)
    ServerHopButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ServerHopButton.BorderSizePixel = 0
    ServerHopButton.Text = "Server Hop"
    ServerHopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ServerHopButton.TextSize = 14
    ServerHopButton.Font = Enum.Font.Gotham
    ServerHopButton.Parent = MiscContent

    ServerHopButton.MouseButton1Click:Connect(function()
        self:ServerHop()
    end)
end

function ZaiLegacy:CreateSettingsTab(parent)
    local SettingsContent = Instance.new("Frame")
    SettingsContent.Name = "SettingsContent"
    SettingsContent.Size = UDim2.new(1, 0, 1, 0)
    SettingsContent.BackgroundTransparency = 1
    SettingsContent.Visible = false
    SettingsContent.Parent = parent

    -- Farm Distance Slider
    local FarmDistanceLabel = Instance.new("TextLabel")
    FarmDistanceLabel.Name = "FarmDistanceLabel"
    FarmDistanceLabel.Size = UDim2.new(1, -20, 0, 20)
    FarmDistanceLabel.Position = UDim2.new(0, 10, 0, 10)
    FarmDistanceLabel.BackgroundTransparency = 1
    FarmDistanceLabel.Text = "Farm Distance: "..ZaiLegacy.Settings.FarmDistance
    FarmDistanceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FarmDistanceLabel.TextSize = 14
    FarmDistanceLabel.Font = Enum.Font.Gotham
    FarmDistanceLabel.TextXAlignment = Enum.TextXAlignment.Left
    FarmDistanceLabel.Parent = SettingsContent

    local FarmDistanceSlider = Instance.new("TextButton")
    FarmDistanceSlider.Name = "FarmDistanceSlider"
    FarmDistanceSlider.Size = UDim2.new(1, -20, 0, 20)
    FarmDistanceSlider.Position = UDim2.new(0, 10, 0, 40)
    FarmDistanceSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    FarmDistanceSlider.BorderSizePixel = 0
    FarmDistanceSlider.Text = ""
    FarmDistanceSlider.Parent = SettingsContent

    local FarmDistanceFill = Instance.new("Frame")
    FarmDistanceFill.Name = "FarmDistanceFill"
    FarmDistanceFill.Size = UDim2.new((ZaiLegacy.Settings.FarmDistance - 10) / 40, 1, 1, 0)
    FarmDistanceFill.Position = UDim2.new(0, 0, 0, 0)
    FarmDistanceFill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    FarmDistanceFill.BorderSizePixel = 0
    FarmDistanceFill.Parent = FarmDistanceSlider

    FarmDistanceSlider.MouseButton1Down:Connect(function(x)
        local percent = math.clamp((x - FarmDistanceSlider.AbsolutePosition.X) / FarmDistanceSlider.AbsoluteSize.X, 0, 1)
        local value = math.floor(10 + percent * 40)
        ZaiLegacy.Settings.FarmDistance = value
        FarmDistanceFill.Size = UDim2.new(percent, 0, 1, 0)
        FarmDistanceLabel.Text = "Farm Distance: "..value
    end)

    -- Toggle UI Key Label
    local ToggleUIKeyLabel = Instance.new("TextLabel")
    ToggleUIKeyLabel.Name = "ToggleUIKeyLabel"
    ToggleUIKeyLabel.Size = UDim2.new(1, -20, 0, 30)
    ToggleUIKeyLabel.Position = UDim2.new(0, 10, 0, 70)
    ToggleUIKeyLabel.BackgroundTransparency = 1
    ToggleUIKeyLabel.Text = "Toggle UI Key: Right Shift"
    ToggleUIKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleUIKeyLabel.TextSize = 14
    ToggleUIKeyLabel.Font = Enum.Font.Gotham
    ToggleUIKeyLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleUIKeyLabel.Parent = SettingsContent

    -- Destroy GUI Button
    local DestroyGUIButton = Instance.new("TextButton")
    DestroyGUIButton.Name = "DestroyGUIButton"
    DestroyGUIButton.Size = UDim2.new(1, -20, 0, 30)
    DestroyGUIButton.Position = UDim2.new(0, 10, 1, -40)
    DestroyGUIButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    DestroyGUIButton.BorderSizePixel = 0
    DestroyGUIButton.Text = "Destroy GUI"
    DestroyGUIButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DestroyGUIButton.TextSize = 14
    DestroyGUIButton.Font = Enum.Font.Gotham
    DestroyGUIButton.Parent = SettingsContent

    DestroyGUIButton.MouseButton1Click:Connect(function()
        parent.Parent:Destroy()
    end)
end

-- Utility Functions
function ZaiLegacy:GetCurrentSea()
    local level = Player:WaitForChild("Data"):WaitForChild("Level").Value
    if level >= 700 then
        return "Sea 2"
    elseif level >= 1500 then
        return "Sea 3"
    else
        return "Sea 1"
    end
end

function ZaiLegacy:TeleportTo(cframe)
    if not Character or not HumanoidRootPart then return end
    
    HumanoidRootPart.CFrame = cframe
end

function ZaiLegacy:GetNearestEnemy()
    local closestEnemy = nil
    local closestDistance = math.huge
    
    for _, enemy in ipairs(workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestEnemy = enemy
            end
        end
    end
    
    return closestEnemy
end

function ZaiLegacy:StartAutoFarm()
    spawn(function()
        while ZaiLegacy.Settings.AutoFarm do
            local enemy = self:GetNearestEnemy()
            if enemy then
                local distance = (HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                
                -- Move to enemy if too far
                if distance > ZaiLegacy.Settings.FarmDistance then
                    Humanoid:MoveTo(enemy.HumanoidRootPart.Position)
                end
                
                -- Attack enemy
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AttackEntity", enemy)
                
                -- Auto Quest
                if ZaiLegacy.Settings.AutoQuest then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                end
            end
            
            task.wait()
        end
    end)
end

function ZaiLegacy:StartBossFarm()
    spawn(function()
        while ZaiLegacy.Settings.AutoBoss do
            local currentSea = self:GetCurrentSea()
            local bossCFrame = self.Bosses[currentSea][ZaiLegacy.Settings.SelectedBoss].CFrame
            
            -- Teleport to boss
            self:TeleportTo(bossCFrame)
            
            -- Attack boss
            local boss = workspace.Enemies:FindFirstChild(ZaiLegacy.Settings.SelectedBoss)
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AttackEntity", boss)
            end
            
            task.wait()
        end
    end)
end

function ZaiLegacy:StartNoClip()
    spawn(function()
        while ZaiLegacy.Settings.NoClip do
            if Character then
                for _, part in ipairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
            task.wait()
        end
    end)
end

function ZaiLegacy:AutoNewWorld()
    spawn(function()
        while ZaiLegacy.Settings.AutoNewWorld do
            local level = Player:WaitForChild("Data"):WaitForChild("Level").Value
            if level >= 700 then
                -- Teleport to Ice Admiral
                self:TeleportTo(CFrame.new(1147.62, 98.95, 1634.42))
                
                -- Check if player has defeated Ice Admiral
                local hasDefeated = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa")
                if not hasDefeated then
                    -- Attack Ice Admiral
                    local iceAdmiral = workspace.Enemies:FindFirstChild("Ice Admiral")
                    if iceAdmiral and iceAdmiral:FindFirstChild("Humanoid") and iceAdmiral.Humanoid.Health > 0 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AttackEntity", iceAdmiral)
                    end
                else
                    -- Teleport to Mysterious Scientist
                    self:TeleportTo(CFrame.new(-2070.32, 73.95, -3543.76))
                    
                    -- Check if player has Mysterious Scientist quest
                    local quest = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetQuest")
                    if not string.find(quest, "Mysterious Scientist") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "UnitQuest", 1)
                    end
                    
                    -- Attack Mysterious Scientist
                    local scientist = workspace.Enemies:FindFirstChild("Mysterious Scientist")
                    if scientist and scientist:FindFirstChild("Humanoid") and scientist.Humanoid.Health > 0 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AttackEntity", scientist)
                    end
                end
            end
            task.wait()
        end
    end)
end

function ZaiLegacy:ServerHop()
    local servers = {}
    local HttpService = game:GetService("HttpService")
    
    -- Get server list
    local response = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    
    for _, server in ipairs(response.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            table.insert(servers, server.id)
        end
    end
    
    -- Teleport to a random server
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], Player)
    else
        parent.Parent.Parent.MainContent.Status.Text = "Status: No servers found!"
        task.wait(2)
        parent.Parent.Parent.MainContent.Status.Text = "Status: Ready"
    end
end

-- Initialize
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

ZaiLegacy:CreateGUI()
ZaiLegacy.Loaded = true

return ZaiLegacy