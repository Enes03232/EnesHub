-- Enes HUB
-- Open/Close Right Alt

local SunHub = Instance.new("ScreenGui")
local MainPanel = Instance.new("Frame")
local GlassEffect = Instance.new("Frame")
local Header = Instance.new("Frame")
local Logo = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local Glow = Instance.new("Frame")
local TabContainer = Instance.new("Frame")
local UniversalTab = Instance.new("TextButton")
local ArsenalTab = Instance.new("TextButton")
local TabIndicator = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local UniversalContent = Instance.new("Frame")
local ArsenalContent = Instance.new("Frame")

-- Universal Buttons
local Esp = Instance.new("TextButton")
local Aimbot = Instance.new("TextButton")
local InfiniteYeild = Instance.new("TextButton")

-- Arsenal Buttons
local Speed = Instance.new("TextButton")
local Silentaim = Instance.new("TextButton")
local Infjump = Instance.new("TextButton")
local InfAmmo = Instance.new("TextButton")

-- Setup
SunHub.Name = "EnesHub"
SunHub.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
SunHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainPanel.Name = "MainPanel"
MainPanel.Parent = SunHub
MainPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainPanel.BackgroundTransparency = 0.15
MainPanel.BorderColor3 = Color3.fromRGB(100, 200, 255)
MainPanel.BorderSizePixel = 2
MainPanel.Position = UDim2.new(0.25, 0, 0.2, 0)
MainPanel.Size = UDim2.new(0, 600, 0, 450)

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 0)
Padding.Parent = MainPanel

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainPanel

GlassEffect.Name = "GlassEffect"
GlassEffect.Parent = MainPanel
GlassEffect.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
GlassEffect.BackgroundTransparency = 0.85
GlassEffect.BorderSizePixel = 0
GlassEffect.Position = UDim2.new(0, 0, 0, 0)
GlassEffect.Size = UDim2.new(1, 0, 0.15, 0)

local GlassCorner = Instance.new("UICorner")
GlassCorner.CornerRadius = UDim.new(0, 15)
GlassCorner.Parent = GlassEffect

Header.Name = "Header"
Header.Parent = MainPanel
Header.BackgroundTransparency = 1
Header.Size = UDim2.new(1, 0, 0, 60)
Header.ZIndex = 2

Logo.Name = "Logo"
Logo.Parent = Header
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0.03, 0, 0.15, 0)
Logo.Size = UDim2.new(0.5, 0, 0.7, 0)
Logo.Font = Enum.Font.GothamBold
Logo.Text = "ENES HUB - ARSENAL"
Logo.TextColor3 = Color3.fromRGB(100, 200, 255)
Logo.TextSize = 28
Logo.TextXAlignment = Enum.TextXAlignment.Left

Glow.Name = "Glow"
Glow.Parent = Logo
Glow.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
Glow.BackgroundTransparency = 0.7
Glow.BorderSizePixel = 0
Glow.Position = UDim2.new(0, 0, -0.2, 0)
Glow.Size = UDim2.new(1, 0, 1.4, 0)
Glow.ZIndex = 0

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 10)
GlowCorner.Parent = Glow

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
CloseBtn.BackgroundTransparency = 0.4
CloseBtn.BorderColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BorderSizePixel = 2
CloseBtn.Position = UDim2.new(0.92, 0, 0.2, 0)
CloseBtn.Size = UDim2.new(0, 40, 0, 35)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.ZIndex = 3

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

TabContainer.Name = "TabContainer"
TabContainer.Parent = MainPanel
TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TabContainer.BackgroundTransparency = 0.2
TabContainer.BorderColor3 = Color3.fromRGB(80, 150, 255)
TabContainer.BorderSizePixel = 1
TabContainer.Position = UDim2.new(0, 0, 0.13, 0)
TabContainer.Size = UDim2.new(1, 0, 0.08, 0)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 10)
TabCorner.Parent = TabContainer

UniversalTab.Name = "UniversalTab"
UniversalTab.Parent = TabContainer
UniversalTab.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
UniversalTab.BackgroundTransparency = 0.3
UniversalTab.BorderSizePixel = 0
UniversalTab.Position = UDim2.new(0.05, 0, 0.05, 0)
UniversalTab.Size = UDim2.new(0.4, 0, 0.9, 0)
UniversalTab.Font = Enum.Font.GothamBold
UniversalTab.Text = "UNIVERSAL"
UniversalTab.TextColor3 = Color3.fromRGB(100, 200, 255)
UniversalTab.TextSize = 14

local UniversalCorner = Instance.new("UICorner")
UniversalCorner.CornerRadius = UDim.new(0, 8)
UniversalCorner.Parent = UniversalTab

ArsenalTab.Name = "ArsenalTab"
ArsenalTab.Parent = TabContainer
ArsenalTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ArsenalTab.BackgroundTransparency = 0.3
ArsenalTab.BorderSizePixel = 0
ArsenalTab.Position = UDim2.new(0.5, 0, 0.05, 0)
ArsenalTab.Size = UDim2.new(0.4, 0, 0.9, 0)
ArsenalTab.Font = Enum.Font.GothamBold
ArsenalTab.Text = "ARSENAL"
ArsenalTab.TextColor3 = Color3.fromRGB(150, 150, 150)
ArsenalTab.TextSize = 14

local ArsenalCorner = Instance.new("UICorner")
ArsenalCorner.CornerRadius = UDim.new(0, 8)
ArsenalCorner.Parent = ArsenalTab

TabIndicator.Name = "TabIndicator"
TabIndicator.Parent = TabContainer
TabIndicator.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
TabIndicator.BackgroundTransparency = 0.3
TabIndicator.BorderColor3 = Color3.fromRGB(150, 220, 255)
TabIndicator.BorderSizePixel = 2
TabIndicator.Position = UDim2.new(0.05, 0, 0.85, 0)
TabIndicator.Size = UDim2.new(0.4, 0, 0.15, 0)

local IndicatorCorner = Instance.new("UICorner")
IndicatorCorner.CornerRadius = UDim.new(0, 6)
IndicatorCorner.Parent = TabIndicator

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainPanel
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 0, 0.22, 0)
ContentFrame.Size = UDim2.new(1, 0, 0.78, 0)

UniversalContent.Name = "UniversalContent"
UniversalContent.Parent = ContentFrame
UniversalContent.BackgroundTransparency = 1
UniversalContent.BorderSizePixel = 0
UniversalContent.Size = UDim2.new(1, 0, 1, 0)
UniversalContent.Visible = true

Esp.Name = "Esp"
Esp.Parent = UniversalContent
Esp.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
Esp.BackgroundTransparency = 0.25
Esp.BorderColor3 = Color3.fromRGB(100, 150, 255)
Esp.BorderSizePixel = 1
Esp.Position = UDim2.new(0.05, 0, 0.08, 0)
Esp.Size = UDim2.new(0.9, 0, 0.22, 0)
Esp.Font = Enum.Font.GothamBold
Esp.Text = "ESP"
Esp.TextColor3 = Color3.fromRGB(100, 200, 255)
Esp.TextSize = 14

local EspCorner = Instance.new("UICorner")
EspCorner.CornerRadius = UDim.new(0, 8)
EspCorner.Parent = Esp

Esp.MouseButton1Down:connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
end)

Aimbot.Name = "Aimbot"
Aimbot.Parent = UniversalContent
Aimbot.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
Aimbot.BackgroundTransparency = 0.25
Aimbot.BorderColor3 = Color3.fromRGB(100, 150, 255)
Aimbot.BorderSizePixel = 1
Aimbot.Position = UDim2.new(0.05, 0, 0.38, 0)
Aimbot.Size = UDim2.new(0.9, 0, 0.22, 0)
Aimbot.Font = Enum.Font.GothamBold
Aimbot.Text = "AIMBOT"
Aimbot.TextColor3 = Color3.fromRGB(100, 200, 255)
Aimbot.TextSize = 14

local AimbotCorner = Instance.new("UICorner")
AimbotCorner.CornerRadius = UDim.new(0, 8)
AimbotCorner.Parent = Aimbot

Aimbot.MouseButton1Down:connect(function()
    local teamCheck = false
    local fov = 90
    local smoothing = 1
    local predictionFactor = 0.08
    local highlightEnabled = false
    local lockPart = "Head"

    local Toggle = false
    local ToggleKey = Enum.KeyCode.E

    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local StarterGui = game:GetService("StarterGui")
    local Players = game:GetService("Players")

    StarterGui:SetCore("SendNotification", {
        Title = "Aimbot Aktif";
        Text = "Fare2 ile kontrol et";
        Duration = 5;
    })

    local FOVring = Drawing.new("Circle")
    FOVring.Visible = true
    FOVring.Thickness = 1
    FOVring.Radius = fov
    FOVring.Transparency = 0.8
    FOVring.Color = Color3.fromRGB(100, 200, 255)
    FOVring.Position = workspace.CurrentCamera.ViewportSize / 2

    local currentTarget = nil
    local aimbotEnabled = true
    local toggleState = false
    local debounce = false

    local function getClosest(cframe)
        local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
        local target = nil
        local mag = math.huge
        local screenCenter = workspace.CurrentCamera.ViewportSize / 2

        for i, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild(lockPart) and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= Players.LocalPlayer and (v.Team ~= Players.LocalPlayer.Team or (not teamCheck)) then
                local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character[lockPart].Position)
                local distanceFromCenter = (Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter).Magnitude

                if onScreen and distanceFromCenter <= fov then
                    local magBuf = (v.Character[lockPart].Position - ray:ClosestPoint(v.Character[lockPart].Position)).Magnitude

                    if magBuf < mag then
                        mag = magBuf
                        target = v
                    end
                end
            end
        end

        return target
    end

    local function updateFOVRing()
        FOVring.Position = workspace.CurrentCamera.ViewportSize / 2
    end

    local function highlightTarget(target)
        if highlightEnabled and target and target.Character then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = target.Character
            highlight.FillColor = Color3.fromRGB(100, 200, 255)
            highlight.OutlineColor = Color3.fromRGB(150, 220, 255)
            highlight.Parent = target.Character
        end
    end

    local function removeHighlight(target)
        if highlightEnabled and target and target.Character and target.Character:FindFirstChildOfClass("Highlight") then
            target.Character:FindFirstChildOfClass("Highlight"):Destroy()
        end
    end

    local function predictPosition(target)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local velocity = target.Character.HumanoidRootPart.Velocity
            local position = target.Character[lockPart].Position
            local predictedPosition = position + (velocity * predictionFactor)
            return predictedPosition
        end
        return nil
    end

    local function handleToggle()
        if debounce then return end
        debounce = true
        toggleState = not toggleState
        wait(0.3)
        debounce = false
    end

    loop = RunService.RenderStepped:Connect(function()
        if aimbotEnabled then
            updateFOVRing()

            local localPlayer = Players.LocalPlayer.Character
            local cam = workspace.CurrentCamera
            local screenCenter = workspace.CurrentCamera.ViewportSize / 2

            if Toggle then
                if UserInputService:IsKeyDown(ToggleKey) then
                    handleToggle()
                end
            else
                toggleState = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
            end

            if toggleState then
                if not currentTarget then
                    currentTarget = getClosest(cam.CFrame)
                    highlightTarget(currentTarget)
                end

                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild(lockPart) then
                    local predictedPosition = predictPosition(currentTarget)
                    if predictedPosition then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(cam.CFrame.Position, predictedPosition), smoothing)
                    end
                    FOVring.Color = Color3.fromRGB(0, 255, 100)
                else
                    FOVring.Color = Color3.fromRGB(100, 200, 255)
                end
            else
                if currentTarget and highlightEnabled then
                    removeHighlight(currentTarget)
                end
                currentTarget = nil
                FOVring.Color = Color3.fromRGB(100, 200, 255)
            end
        end
    end)
end)

InfiniteYeild.Name = "InfiniteYeild"
InfiniteYeild.Parent = UniversalContent
InfiniteYeild.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
InfiniteYeild.BackgroundTransparency = 0.25
InfiniteYeild.BorderColor3 = Color3.fromRGB(100, 150, 255)
InfiniteYeild.BorderSizePixel = 1
InfiniteYeild.Position = UDim2.new(0.05, 0, 0.68, 0)
InfiniteYeild.Size = UDim2.new(0.9, 0, 0.22, 0)
InfiniteYeild.Font = Enum.Font.GothamBold
InfiniteYeild.Text = "INFINITE YIELD"
InfiniteYeild.TextColor3 = Color3.fromRGB(100, 200, 255)
InfiniteYeild.TextSize = 14

local InfiniteCorner = Instance.new("UICorner")
InfiniteCorner.CornerRadius = UDim.new(0, 8)
InfiniteCorner.Parent = InfiniteYeild

InfiniteYeild.MouseButton1Down:connect(function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

ArsenalContent.Name = "ArsenalContent"
ArsenalContent.Parent = ContentFrame
ArsenalContent.BackgroundTransparency = 1
ArsenalContent.BorderSizePixel = 0
ArsenalContent.Size = UDim2.new(1, 0, 1, 0)
ArsenalContent.Visible = false

Speed.Name = "Speed"
Speed.Parent = ArsenalContent
Speed.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
Speed.BackgroundTransparency = 0.25
Speed.BorderColor3 = Color3.fromRGB(100, 150, 255)
Speed.BorderSizePixel = 1
Speed.Position = UDim2.new(0.05, 0, 0.08, 0)
Speed.Size = UDim2.new(0.9, 0, 0.2, 0)
Speed.Font = Enum.Font.GothamBold
Speed.Text = "SPEED"
Speed.TextColor3 = Color3.fromRGB(100, 200, 255)
Speed.TextSize = 14

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = Speed

Speed.MouseButton1Down:connect(function()
    _G.WS = "100";
    local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
    Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        Humanoid.WalkSpeed = _G.WS;
    end)
    Humanoid.WalkSpeed = _G.WS;
end)

Silentaim.Name = "Silentaim"
Silentaim.Parent = ArsenalContent
Silentaim.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
Silentaim.BackgroundTransparency = 0.25
Silentaim.BorderColor3 = Color3.fromRGB(100, 150, 255)
Silentaim.BorderSizePixel = 1
Silentaim.Position = UDim2.new(0.05, 0, 0.33, 0)
Silentaim.Size = UDim2.new(0.9, 0, 0.2, 0)
Silentaim.Font = Enum.Font.GothamBold
Silentaim.Text = "SILENT AIM"
Silentaim.TextColor3 = Color3.fromRGB(100, 200, 255)
Silentaim.TextSize = 14

local SilentaimCorner = Instance.new("UICorner")
SilentaimCorner.CornerRadius = UDim.new(0, 8)
SilentaimCorner.Parent = Silentaim

Silentaim.MouseButton1Down:connect(function()
    function getplrsname()
        for i,v in pairs(game:GetChildren()) do
            if v.ClassName == "Players" then
                return v.Name
            end
        end
    end
    local players = getplrsname()
    local plr = game[players].LocalPlayer
    coroutine.resume(coroutine.create(function()
        while  wait(1) do
            coroutine.resume(coroutine.create(function()
                for _,v in pairs(game[players]:GetPlayers()) do
                    if v.Name ~= plr.Name and v.Character then
                        v.Character.RightUpperLeg.CanCollide = false
                        v.Character.RightUpperLeg.Transparency = 10
                        v.Character.RightUpperLeg.Size = Vector3.new(13,13,13)

                        v.Character.LeftUpperLeg.CanCollide = false
                        v.Character.LeftUpperLeg.Transparency = 10
                        v.Character.LeftUpperLeg.Size = Vector3.new(13,13,13)

                        v.Character.HeadHB.CanCollide = false
                        v.Character.HeadHB.Transparency = 10
                        v.Character.HeadHB.Size = Vector3.new(13,13,13)

                        v.Character.HumanoidRootPart.CanCollide = false
                        v.Character.HumanoidRootPart.Transparency = 10
                        v.Character.HumanoidRootPart.Size = Vector3.new(13,13,13)
                    end
                end
            end))
        end
    end))
end)

Infjump.Name = "Infjump"
Infjump.Parent = ArsenalContent
Infjump.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
Infjump.BackgroundTransparency = 0.25
Infjump.BorderColor3 = Color3.fromRGB(100, 150, 255)
Infjump.BorderSizePixel = 1
Infjump.Position = UDim2.new(0.05, 0, 0.58, 0)
Infjump.Size = UDim2.new(0.9, 0, 0.2, 0)
Infjump.Font = Enum.Font.GothamBold
Infjump.Text = "INF JUMP"
Infjump.TextColor3 = Color3.fromRGB(100, 200, 255)
Infjump.TextSize = 14

local InfjumpCorner = Instance.new("UICorner")
InfjumpCorner.CornerRadius = UDim.new(0, 8)
InfjumpCorner.Parent = Infjump

Infjump.MouseButton1Down:connect(function()
    local InfiniteJumpEnabled = true

    game:GetService("UserInputService").JumpRequest:Connect(function()
        if InfiniteJumpEnabled then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

InfAmmo.Name = "InfAmmo"
InfAmmo.Parent = ArsenalContent
InfAmmo.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
InfAmmo.BackgroundTransparency = 0.25
InfAmmo.BorderColor3 = Color3.fromRGB(100, 150, 255)
InfAmmo.BorderSizePixel = 1
InfAmmo.Position = UDim2.new(0.05, 0, 0.83, 0)
InfAmmo.Size = UDim2.new(0.9, 0, 0.12, 0)
InfAmmo.Font = Enum.Font.GothamBold
InfAmmo.Text = "INF AMMO"
InfAmmo.TextColor3 = Color3.fromRGB(100, 200, 255)
InfAmmo.TextSize = 14

local InfAmmoCorner = Instance.new("UICorner")
InfAmmoCorner.CornerRadius = UDim.new(0, 8)
InfAmmoCorner.Parent = InfAmmo

InfAmmo.MouseButton1Down:connect(function()
    local replicationstorage = game.ReplicatedStorage

    while wait() do
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount.Value = 999
        game:GetService("Players").LocalPlayer.PlayerGui.GUI.Client.Variables.ammocount2.Value = 999
    end
end)

-- Hover Effects
local function addHoverEffect(button)
    button.MouseEnter:Connect(function()
        button:TweenSize(button.Size + UDim2.new(0, 5, 0, 2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        button.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
        button.BackgroundTransparency = 0.15
        button.BorderColor3 = Color3.fromRGB(150, 220, 255)
    end)
    
    button.MouseLeave:Connect(function()
        button:TweenSize(button.Size - UDim2.new(0, 5, 0, 2), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        button.BackgroundTransparency = 0.25
        button.BorderColor3 = Color3.fromRGB(100, 150, 255)
    end)
end

addHoverEffect(Esp)
addHoverEffect(Aimbot)
addHoverEffect(InfiniteYeild)
addHoverEffect(Speed)
addHoverEffect(Silentaim)
addHoverEffect(Infjump)
addHoverEffect(InfAmmo)

-- Tab Switching
UniversalTab.MouseButton1Down:Connect(function()
    UniversalContent.Visible = true
    ArsenalContent.Visible = false
    UniversalTab.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    UniversalTab.BackgroundTransparency = 0.3
    ArsenalTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    ArsenalTab.BackgroundTransparency = 0.3
    UniversalTab.TextColor3 = Color3.fromRGB(100, 200, 255)
    ArsenalTab.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabIndicator:TweenPosition(UDim2.new(0.05, 0, 0.85, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
end)

ArsenalTab.MouseButton1Down:Connect(function()
    UniversalContent.Visible = false
    ArsenalContent.Visible = true
    UniversalTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    UniversalTab.BackgroundTransparency = 0.3
    ArsenalTab.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    ArsenalTab.BackgroundTransparency = 0.3
    UniversalTab.TextColor3 = Color3.fromRGB(150, 150, 150)
    ArsenalTab.TextColor3 = Color3.fromRGB(100, 200, 255)
    TabIndicator:TweenPosition(UDim2.new(0.5, 0, 0.85, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
end)

-- Close Button
CloseBtn.MouseButton1Down:Connect(function()
    MainPanel:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
    wait(0.3)
    MainPanel.Visible = false
end)

-- SAĞ ALT TUŞU İLE AÇ/KAPA
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightAlt then
        if MainPanel.Visible then
            MainPanel:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
            wait(0.3)
            MainPanel.Visible = false
        else
            MainPanel.Visible = true
            MainPanel.Size = UDim2.new(0, 0, 0, 0)
            MainPanel:TweenSize(UDim2.new(0, 600, 0, 450), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        end
    end
end)

-- Drag Script
local dragging = false
local dragStart = nil
local startPos = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = game:GetService("UserInputService"):GetMouseLocation()
        startPos = MainPanel.Position
    end
end)

Header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = game:GetService("UserInputService"):GetMouseLocation() - dragStart
        MainPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)



