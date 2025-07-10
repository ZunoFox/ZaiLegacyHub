-- ZaiLegacy Blox Fruit Script
-- Phiên bản hoàn chỉnh với icon mở GUI và các tính năng cơ bản

--[[
HƯỚNG DẪN SỬ DỤNG:
1. Nhấn phím RightShift để bật/tắt GUI
2. Hoặc click vào icon hình kiếm ở góc trái màn hình
3. Các tính năng chính:
   - Kill Aura, Auto Click
   - Fruit ESP, Auto Farm
   - Điều chỉnh Walk Speed, Jump Power
   - Teleport, Anti AFK
]]

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Kiểm tra xem script đã được inject chưa
if not game:IsLoaded() then
    game.Loaded:Wait()
end

if not LocalPlayer then
    LocalPlayer = Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
end

-- Tạo GUI Icon
local function createIcon()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZaiLegacyIcon"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Icon = Instance.new("ImageButton")
    Icon.Name = "Icon"
    Icon.Parent = ScreenGui
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0, 10, 0.5, -25)
    Icon.Size = UDim2.new(0, 50, 0, 50)
    Icon.Image = "rbxassetid://7072718362" -- Icon kiếm (có thể thay bằng ID khác)
    
    -- Hiệu ứng khi hover
    Icon.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(Icon, TweenInfo.new(0.2), {Size = UDim2.new(0, 55, 0, 55)}):Play()
    end)
    
    Icon.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(Icon, TweenInfo.new(0.2), {Size = UDim2.new(0, 50, 0, 50)}):Play()
    end)
    
    return Icon
end

-- Tạo main GUI
local function createMainGUI()
    local ZaiLegacy = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TabSelector = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local TabButtons = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local CombatButton = Instance.new("TextButton")
    local BloxFruitButton = Instance.new("TextButton")
    local PlayerButton = Instance.new("TextButton")
    local TeleportButton = Instance.new("TextButton")
    local MiscButton = Instance.new("TextButton")
    local TabContent = Instance.new("Frame")
    local CombatTab = Instance.new("ScrollingFrame")
    local BloxFruitTab = Instance.new("ScrollingFrame")
    local PlayerTab = Instance.new("ScrollingFrame")
    local TeleportTab = Instance.new("ScrollingFrame")
    local MiscTab = Instance.new("ScrollingFrame")

    -- GUI Properties
    ZaiLegacy.Name = "ZaiLegacy"
    ZaiLegacy.Parent = game.CoreGui
    ZaiLegacy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ZaiLegacy
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Active = true
    MainFrame.Draggable = true

    TabSelector.Name = "TabSelector"
    TabSelector.Parent = MainFrame
    TabSelector.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabSelector.BorderSizePixel = 0
    TabSelector.Size = UDim2.new(0, 120, 0, 350)

    Title.Name = "Title"
    Title.Parent = TabSelector
    Title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Title.BackgroundTransparency = 1.0
    Title.BorderSizePixel = 0
    Title.Size = UDim2.new(0, 120, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "ZaiLegacy"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20.000

    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TabSelector
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(0, 0, 0, 310)
    CloseButton.Size = UDim2.new(0, 120, 0, 40)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "Close"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14.000

    TabButtons.Name = "TabButtons"
    TabButtons.Parent = TabSelector
    TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabButtons.BackgroundTransparency = 1.0
    TabButtons.Position = UDim2.new(0, 0, 0, 40)
    TabButtons.Size = UDim2.new(0, 120, 0, 270)

    UIListLayout.Parent = TabButtons
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    CombatButton.Name = "CombatButton"
    CombatButton.Parent = TabButtons
    CombatButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CombatButton.BorderSizePixel = 0
    CombatButton.Size = UDim2.new(0, 110, 0, 30)
    CombatButton.Font = Enum.Font.Gotham
    CombatButton.Text = "Combat"
    CombatButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CombatButton.TextSize = 14.000

    BloxFruitButton.Name = "BloxFruitButton"
    BloxFruitButton.Parent = TabButtons
    BloxFruitButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    BloxFruitButton.BorderSizePixel = 0
    BloxFruitButton.Size = UDim2.new(0, 110, 0, 30)
    BloxFruitButton.Font = Enum.Font.Gotham
    BloxFruitButton.Text = "Blox Fruit"
    BloxFruitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    BloxFruitButton.TextSize = 14.000

    PlayerButton.Name = "PlayerButton"
    PlayerButton.Parent = TabButtons
    PlayerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    PlayerButton.BorderSizePixel = 0
    PlayerButton.Size = UDim2.new(0, 110, 0, 30)
    PlayerButton.Font = Enum.Font.Gotham
    PlayerButton.Text = "Player"
    PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerButton.TextSize = 14.000

    TeleportButton.Name = "TeleportButton"
    TeleportButton.Parent = TabButtons
    TeleportButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TeleportButton.BorderSizePixel = 0
    TeleportButton.Size = UDim2.new(0, 110, 0, 30)
    TeleportButton.Font = Enum.Font.Gotham
    TeleportButton.Text = "Teleport"
    TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportButton.TextSize = 14.000

    MiscButton.Name = "MiscButton"
    MiscButton.Parent = TabButtons
    MiscButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MiscButton.BorderSizePixel = 0
    MiscButton.Size = UDim2.new(0, 110, 0, 30)
    MiscButton.Font = Enum.Font.Gotham
    MiscButton.Text = "Misc"
    MiscButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MiscButton.TextSize = 14.000

    TabContent.Name = "TabContent"
    TabContent.Parent = MainFrame
    TabContent.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabContent.BackgroundTransparency = 1.0
    TabContent.BorderSizePixel = 0
    TabContent.Position = UDim2.new(0, 120, 0, 0)
    TabContent.Size = UDim2.new(0, 380, 0, 350)

    -- Combat Tab
    CombatTab.Name = "CombatTab"
    CombatTab.Parent = TabContent
    CombatTab.Active = true
    CombatTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CombatTab.BackgroundTransparency = 1.0
    CombatTab.BorderSizePixel = 0
    CombatTab.Size = UDim2.new(0, 380, 0, 350)
    CombatTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    CombatTab.ScrollBarThickness = 5
    CombatTab.Visible = true

    local KillAura = Instance.new("TextButton")
    KillAura.Name = "KillAura"
    KillAura.Parent = CombatTab
    KillAura.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    KillAura.BorderSizePixel = 0
    KillAura.Position = UDim2.new(0.05, 0, 0.05, 0)
    KillAura.Size = UDim2.new(0, 150, 0, 30)
    KillAura.Font = Enum.Font.Gotham
    KillAura.Text = "Kill Aura [OFF]"
    KillAura.TextColor3 = Color3.fromRGB(255, 255, 255)
    KillAura.TextSize = 14.000

    local AutoClick = Instance.new("TextButton")
    AutoClick.Name = "AutoClick"
    AutoClick.Parent = CombatTab
    AutoClick.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AutoClick.BorderSizePixel = 0
    AutoClick.Position = UDim2.new(0.55, 0, 0.05, 0)
    AutoClick.Size = UDim2.new(0, 150, 0, 30)
    AutoClick.Font = Enum.Font.Gotham
    AutoClick.Text = "Auto Click [OFF]"
    AutoClick.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoClick.TextSize = 14.000

    -- Blox Fruit Tab
    BloxFruitTab.Name = "BloxFruitTab"
    BloxFruitTab.Parent = TabContent
    BloxFruitTab.Active = true
    BloxFruitTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    BloxFruitTab.BackgroundTransparency = 1.0
    BloxFruitTab.BorderSizePixel = 0
    BloxFruitTab.Size = UDim2.new(0, 380, 0, 350)
    BloxFruitTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    BloxFruitTab.ScrollBarThickness = 5
    BloxFruitTab.Visible = false

    local FruitESP = Instance.new("TextButton")
    FruitESP.Name = "FruitESP"
    FruitESP.Parent = BloxFruitTab
    FruitESP.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    FruitESP.BorderSizePixel = 0
    FruitESP.Position = UDim2.new(0.05, 0, 0.05, 0)
    FruitESP.Size = UDim2.new(0, 150, 0, 30)
    FruitESP.Font = Enum.Font.Gotham
    FruitESP.Text = "Fruit ESP [OFF]"
    FruitESP.TextColor3 = Color3.fromRGB(255, 255, 255)
    FruitESP.TextSize = 14.000

    local AutoFarm = Instance.new("TextButton")
    AutoFarm.Name = "AutoFarm"
    AutoFarm.Parent = BloxFruitTab
    AutoFarm.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AutoFarm.BorderSizePixel = 0
    AutoFarm.Position = UDim2.new(0.55, 0, 0.05, 0)
    AutoFarm.Size = UDim2.new(0, 150, 0, 30)
    AutoFarm.Font = Enum.Font.Gotham
    AutoFarm.Text = "Auto Farm [OFF]"
    AutoFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoFarm.TextSize = 14.000

    -- Player Tab
    PlayerTab.Name = "PlayerTab"
    PlayerTab.Parent = TabContent
    PlayerTab.Active = true
    PlayerTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    PlayerTab.BackgroundTransparency = 1.0
    PlayerTab.BorderSizePixel = 0
    PlayerTab.Size = UDim2.new(0, 380, 0, 350)
    PlayerTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    PlayerTab.ScrollBarThickness = 5
    PlayerTab.Visible = false

    local WalkSpeed = Instance.new("TextButton")
    WalkSpeed.Name = "WalkSpeed"
    WalkSpeed.Parent = PlayerTab
    WalkSpeed.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    WalkSpeed.BorderSizePixel = 0
    WalkSpeed.Position = UDim2.new(0.05, 0, 0.05, 0)
    WalkSpeed.Size = UDim2.new(0, 150, 0, 30)
    WalkSpeed.Font = Enum.Font.Gotham
    WalkSpeed.Text = "Walk Speed [16]"
    WalkSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
    WalkSpeed.TextSize = 14.000

    local JumpPower = Instance.new("TextButton")
    JumpPower.Name = "JumpPower"
    JumpPower.Parent = PlayerTab
    JumpPower.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    JumpPower.BorderSizePixel = 0
    JumpPower.Position = UDim2.new(0.55, 0, 0.05, 0)
    JumpPower.Size = UDim2.new(0, 150, 0, 30)
    JumpPower.Font = Enum.Font.Gotham
    JumpPower.Text = "Jump Power [50]"
    JumpPower.TextColor3 = Color3.fromRGB(255, 255, 255)
    JumpPower.TextSize = 14.000

    -- Teleport Tab
    TeleportTab.Name = "TeleportTab"
    TeleportTab.Parent = TabContent
    TeleportTab.Active = true
    TeleportTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TeleportTab.BackgroundTransparency = 1.0
    TeleportTab.BorderSizePixel = 0
    TeleportTab.Size = UDim2.new(0, 380, 0, 350)
    TeleportTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    TeleportTab.ScrollBarThickness = 5
    TeleportTab.Visible = false

    local TeleportToIsland = Instance.new("TextButton")
    TeleportToIsland.Name = "TeleportToIsland"
    TeleportToIsland.Parent = TeleportTab
    TeleportToIsland.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TeleportToIsland.BorderSizePixel = 0
    TeleportToIsland.Position = UDim2.new(0.05, 0, 0.05, 0)
    TeleportToIsland.Size = UDim2.new(0, 150, 0, 30)
    TeleportToIsland.Font = Enum.Font.Gotham
    TeleportToIsland.Text = "Teleport to Island"
    TeleportToIsland.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportToIsland.TextSize = 14.000

    local TeleportToPlayer = Instance.new("TextButton")
    TeleportToPlayer.Name = "TeleportToPlayer"
    TeleportToPlayer.Parent = TeleportTab
    TeleportToPlayer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TeleportToPlayer.BorderSizePixel = 0
    TeleportToPlayer.Position = UDim2.new(0.55, 0, 0.05, 0)
    TeleportToPlayer.Size = UDim2.new(0, 150, 0, 30)
    TeleportToPlayer.Font = Enum.Font.Gotham
    TeleportToPlayer.Text = "Teleport to Player"
    TeleportToPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportToPlayer.TextSize = 14.000

    -- Misc Tab
    MiscTab.Name = "MiscTab"
    MiscTab.Parent = TabContent
    MiscTab.Active = true
    MiscTab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MiscTab.BackgroundTransparency = 1.0
    MiscTab.BorderSizePixel = 0
    MiscTab.Size = UDim2.new(0, 380, 0, 350)
    MiscTab.CanvasSize = UDim2.new(0, 0, 2, 0)
    MiscTab.ScrollBarThickness = 5
    MiscTab.Visible = false

    local AntiAFK = Instance.new("TextButton")
    AntiAFK.Name = "AntiAFK"
    AntiAFK.Parent = MiscTab
    AntiAFK.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    AntiAFK.BorderSizePixel = 0
    AntiAFK.Position = UDim2.new(0.05, 0, 0.05, 0)
    AntiAFK.Size = UDim2.new(0, 150, 0, 30)
    AntiAFK.Font = Enum.Font.Gotham
    AntiAFK.Text = "Anti AFK [OFF]"
    AntiAFK.TextColor3 = Color3.fromRGB(255, 255, 255)
    AntiAFK.TextSize = 14.000

    local NoClip = Instance.new("TextButton")
    NoClip.Name = "NoClip"
    NoClip.Parent = MiscTab
    NoClip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    NoClip.BorderSizePixel = 0
    NoClip.Position = UDim2.new(0.55, 0, 0.05, 0)
    NoClip.Size = UDim2.new(0, 150, 0, 30)
    NoClip.Font = Enum.Font.Gotham
    NoClip.Text = "No Clip [OFF]"
    NoClip.TextColor3 = Color3.fromRGB(255, 255, 255)
    NoClip.TextSize = 14.000

    -- Tab Switching Functionality
    local function switchTab(tab)
        CombatTab.Visible = false
        BloxFruitTab.Visible = false
        PlayerTab.Visible = false
        TeleportTab.Visible = false
        MiscTab.Visible = false
        
        tab.Visible = true
    end

    CombatButton.MouseButton1Click:Connect(function()
        switchTab(CombatTab)
    end)

    BloxFruitButton.MouseButton1Click:Connect(function()
        switchTab(BloxFruitTab)
    end)

    PlayerButton.MouseButton1Click:Connect(function()
        switchTab(PlayerTab)
    end)

    TeleportButton.MouseButton1Click:Connect(function()
        switchTab(TeleportTab)
    end)

    MiscButton.MouseButton1Click:Connect(function()
        switchTab(MiscTab)
    end)

    -- Toggle GUI Visibility
    local GuiVisible = true

    local function toggleGui()
        GuiVisible = not GuiVisible
        MainFrame.Visible = GuiVisible
    end

    CloseButton.MouseButton1Click:Connect(toggleGui)

    -- Keybind to toggle GUI (Right Shift)
    UIS.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.RightShift and not gameProcessed then
            toggleGui()
        end
    end)

    -- Feature Implementations
    local KillAuraActive = false
    KillAura.MouseButton1Click:Connect(function()
        KillAuraActive = not KillAuraActive
        if KillAuraActive then
            KillAura.Text = "Kill Aura [ON]"
            KillAura.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            
            spawn(function()
                while KillAuraActive and task.wait(0.1) do
                    -- Giả lập Kill Aura
                    local character = LocalPlayer.Character
                    if character then
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                            for _, player in ipairs(Players:GetPlayers()) do
                                if player ~= LocalPlayer then
                                    local targetCharacter = player.Character
                                    if targetCharacter then
                                        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
                                        if targetRoot and (humanoidRootPart.Position - targetRoot.Position).Magnitude < 20 then
                                            -- Giả lập tấn công
                                            local args = {
                                                [1] = targetRoot.Position,
                                                [2] = targetRoot
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(unpack(args))
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            KillAura.Text = "Kill Aura [OFF]"
            KillAura.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)

    -- Walk Speed Changer
    local WalkSpeedValue = 16
    WalkSpeed.MouseButton1Click:Connect(function()
        local newSpeed = WalkSpeedValue + 4
        if newSpeed > 100 then newSpeed = 16 end
        WalkSpeedValue = newSpeed
        
        WalkSpeed.Text = "Walk Speed ["..tostring(WalkSpeedValue).."]"
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeedValue
        end
    end)

    -- Anti AFK
    local AntiAFKActive = false
    AntiAFK.MouseButton1Click:Connect(function()
        AntiAFKActive = not AntiAFKActive
        if AntiAFKActive then
            AntiAFK.Text = "Anti AFK [ON]"
            AntiAFK.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            
            local con
            con = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
            
            AntiAFK.MouseButton1Click:Connect(function()
                con:Disconnect()
            end)
        else
            AntiAFK.Text = "Anti AFK [OFF]"
            AntiAFK.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)

    -- No Clip
    local NoClipActive = false
    NoClip.MouseButton1Click:Connect(function()
        NoClipActive = not NoClipActive
        if NoClipActive then
            NoClip.Text = "No Clip [ON]"
            NoClip.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            
            spawn(function()
                while NoClipActive do
                    task.wait()
                    if LocalPlayer.Character then
                        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        else
            NoClip.Text = "No Clip [OFF]"
            NoClip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)

    -- Auto Click
    local AutoClickActive = false
    AutoClick.MouseButton1Click:Connect(function()
        AutoClickActive = not AutoClickActive
        if AutoClickActive then
            AutoClick.Text = "Auto Click [ON]"
            AutoClick.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            
            spawn(function()
                while AutoClickActive and task.wait(0.1) do
                    mouse1click()
                end
            end)
        else
            AutoClick.Text = "Auto Click [OFF]"
            AutoClick.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)

    -- Teleport to Island
    TeleportToIsland.MouseButton1Click:Connect(function()
        local islands = {
            Vector3.new(-100, 50, 100),  -- Ví dụ vị trí đảo
            Vector3.new(200, 50, -150),   -- Thay bằng vị trí thực tế
            Vector3.new(-300, 50, -200)
        }
        
        if LocalPlayer.Character then
            local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local randomIsland = islands[math.random(1, #islands)]
                humanoidRootPart.CFrame = CFrame.new(randomIsland)
            end
        end
    end)

    -- Teleport to Player
    TeleportToPlayer.MouseButton1Click:Connect(function()
        local playersList = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(playersList, player.Name)
            end
        end
        
        if #playersList > 0 then
            local selectedPlayer = playersList[math.random(1, #playersList)]
            local target = Players[selectedPlayer]
            
            if target and target.Character then
                local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and LocalPlayer.Character then
                    local humanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        humanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 5)
                    end
                end
            end
        end
    end)

    -- Initialization
    switchTab(CombatTab)
    
    return {
        GUI = ZaiLegacy,
        Toggle = toggleGui
    }
end

-- Khởi tạo GUI và Icon
local mainGUI = createMainGUI()
local icon = createIcon()

icon.MouseButton1Click:Connect(function()
    mainGUI.Toggle()
end)

-- Thông báo khi script load xong
game.StarterGui:SetCore("SendNotification", {
    Title = "ZaiLegacy",
    Text = "Script loaded! Press RightShift or click icon to open GUI",
    Duration = 5
})