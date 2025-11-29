local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then return end

local gameName = "Bilinmeyen Oyun"
local success, gameInfo = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId)
end)
if success and gameInfo then
    gameName = gameInfo.Name
end

local currentTime = os.date("%d/%m/%Y    %H:%M:%S")
local data = {
    name = player.Name,
    userid = tostring(player.UserId),
    game = gameName,
    server = game.JobId,
    time = currentTime
}
local jsonData = HttpService:JSONEncode(data)

pcall(function()
    httpRequest({
        Url = url,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = jsonData
    })
end)

local playerGui = player:WaitForChild("PlayerGui")

-- Ordered teleport
local TP_ORDER = {
    {name = "Spawn",    pos = Vector3.new(18.2, 250.5, -98.4)},
    {name = "Spawn 1",  pos = Vector3.new(381.1, 333.3, -1291.6)},
    {name = "Spawn 2",  pos = Vector3.new(-1137.2, 245.3, -1764.9)},
    {name = "Spawn 3",  pos = Vector3.new(173.8, 172.5, 160.3)},
    {name = "Spawn 4",  pos = Vector3.new(-596.9, 201.7, -464.6)},
    {name = "Spawn 5",  pos = Vector3.new(1258.8, 364.3, 1025.5)},
    {name = "Spawn 6",  pos = Vector3.new(-1205.9, 212.9, 814.4)},
    {name = "Spawn 7",  pos = Vector3.new(2558.1, 171.9, -1445.0)},
    {name = "Spawn 8",  pos = Vector3.new(2043.0, 225.4, 197.5)},
    {name = "Spawn 9",  pos = Vector3.new(2433.2, 98.1, 1615.9)},
    {name = "Spawn 10", pos = Vector3.new(116.3, 1033.3, 1961.0)},
    {name = "Spawn 11", pos = Vector3.new(1444.0, 1079.2, 1737.8)},
}

local function pulseButton(btn)
    local orig = btn.Size
    TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(orig.X.Scale, orig.X.Offset * 1.03, orig.Y.Scale, orig.Y.Offset * 1.03)}):Play()
    task.delay(0.08, function()
        TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = orig}):Play()
    end)
end

local function teleportTo(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EnesHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Glow background (orijinal boyutlara yakın)
local glow = Instance.new("Frame", screenGui)
glow.Name = "Glow"
glow.AnchorPoint = Vector2.new(0.5, 0)
glow.Position = UDim2.new(0.5, 0, 0.05, 0)
glow.Size = UDim2.new(0, 460, 0, 380)
glow.BackgroundTransparency = 1
local glowGradient = Instance.new("UIGradient", glow)
glowGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,100,120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100,180,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150,255,160))
}
glowGradient.Rotation = 0

-- Main panel (ESKİ boyut: 420x360)
local panel = Instance.new("Frame", screenGui)
panel.Name = "Main"
panel.AnchorPoint = Vector2.new(0.5, 0)
panel.Position = UDim2.new(0.5, 0, 0.05, 0)
panel.Size = UDim2.new(0, 420, 0, 360)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
panel.BorderSizePixel = 0
Instance.new("UICorner", panel)
local stroke = Instance.new("UIStroke", panel)
stroke.Color = Color3.fromRGB(100,180,255)
stroke.Thickness = 2
stroke.Transparency = 0.4

-- Title
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(0.6, -12, 0, 36)
title.Position = UDim2.new(0,12,0,8)
title.BackgroundTransparency = 1
title.Text = "Enes Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(230,230,240)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tab bar
local tabBar = Instance.new("Frame", panel)
tabBar.Size = UDim2.new(0, 200, 0, 36)
tabBar.AnchorPoint = Vector2.new(1, 0)
tabBar.Position = UDim2.new(1, -12, 0, 8)
tabBar.BackgroundTransparency = 1

local mainTab = Instance.new("TextButton", tabBar)
mainTab.Name = "MainTab"
mainTab.Size = UDim2.new(0.5, -6, 1, 0)
mainTab.Position = UDim2.new(0,0,0,0)
mainTab.Text = "Main"
mainTab.Font = Enum.Font.GothamBold
mainTab.TextSize = 14
mainTab.BackgroundColor3 = Color3.fromRGB(60,60,80)
mainTab.TextColor3 = Color3.fromRGB(240,240,240)
Instance.new("UICorner", mainTab)

local tpTab = Instance.new("TextButton", tabBar)
tpTab.Name = "TeleportTab"
tpTab.Size = UDim2.new(0.5, -6, 1, 0)
tpTab.Position = UDim2.new(0.5, 8, 0, 0)
tpTab.Text = "Teleport"
tpTab.Font = Enum.Font.Gotham
tpTab.TextSize = 14
tpTab.BackgroundColor3 = Color3.fromRGB(35,35,45)
tpTab.TextColor3 = Color3.fromRGB(200,200,210)
Instance.new("UICorner", tpTab)

-- Content Holder
local contentHolder = Instance.new("Frame", panel)
contentHolder.Position = UDim2.new(0,12,0,56)
contentHolder.Size = UDim2.new(1, -24, 1, -68)
contentHolder.BackgroundTransparency = 1

local walkFrame = Instance.new("Frame", contentHolder)
walkFrame.Size = UDim2.new(1,0,1,0)
walkFrame.BackgroundTransparency = 1

local tpFrame = Instance.new("Frame", contentHolder)
tpFrame.Size = UDim2.new(1,0,1,0)
tpFrame.BackgroundTransparency = 1
tpFrame.Visible = false

-- WALKBOOSTER UI
local speedToggle = Instance.new("TextButton", walkFrame)
speedToggle.Position = UDim2.new(0,0,0,0)
speedToggle.Size = UDim2.new(0,120,0,32)
speedToggle.Text = "SPEED: Close"
speedToggle.Font = Enum.Font.GothamBold
speedToggle.TextSize = 16
speedToggle.BackgroundColor3 = Color3.fromRGB(80, 30, 200)
speedToggle.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", speedToggle)

-- +/- buttons and display
local speedDec = Instance.new("TextButton", walkFrame)
speedDec.Position = UDim2.new(0,0,0,42)
speedDec.Size = UDim2.new(0,48,0,32)
speedDec.Text = "-"
speedDec.Font = Enum.Font.GothamBold
speedDec.TextSize = 20
speedDec.BackgroundColor3 = Color3.fromRGB(60,60,80)
speedDec.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", speedDec)

local speedInc = Instance.new("TextButton", walkFrame)
speedInc.Position = UDim2.new(0,56,0,42)
speedInc.Size = UDim2.new(0,48,0,32)
speedInc.Text = "+"
speedInc.Font = Enum.Font.GothamBold
speedInc.TextSize = 20
speedInc.BackgroundColor3 = Color3.fromRGB(60,60,80)
speedInc.TextColor3 = Color3.fromRGB(255,255,255)
Instance.new("UICorner", speedInc)

local speedDisplay = Instance.new("TextLabel", walkFrame)
speedDisplay.Position = UDim2.new(0,112,0,44)
speedDisplay.Size = UDim2.new(0,50,0,24)
speedDisplay.BackgroundTransparency = 1
speedDisplay.Text = "1x"
speedDisplay.Font = Enum.Font.GothamBold
speedDisplay.TextSize = 16
speedDisplay.TextColor3 = Color3.fromRGB(220,220,230)

-- XP Farm label
local xpLabel = Instance.new("TextLabel", walkFrame)
xpLabel.Position = UDim2.new(0,0,0,80)
xpLabel.Size = UDim2.new(0, 240, 0, 20)
xpLabel.BackgroundTransparency = 1
xpLabel.Text = "XP Farm"
xpLabel.Font = Enum.Font.GothamBold
xpLabel.TextSize = 16
xpLabel.TextColor3 = Color3.fromRGB(220,220,230)
xpLabel.TextXAlignment = Enum.TextXAlignment.Left

-- xpContainer: ScrollingFrame, panelin içinde kalarak taşmayı engeller
local xpContainer = Instance.new("ScrollingFrame", walkFrame)
xpContainer.Name = "XPContainer"
xpContainer.Position = UDim2.new(0,0,0,106)
xpContainer.Size = UDim2.new(1, 0, 0, 200)
xpContainer.BackgroundTransparency = 1
xpContainer.ScrollBarThickness = 8
xpContainer.CanvasSize = UDim2.new(0,0,0,0)

local xpLayout = Instance.new("UIListLayout", xpContainer)
xpLayout.FillDirection = Enum.FillDirection.Vertical
xpLayout.SortOrder = Enum.SortOrder.LayoutOrder
xpLayout.Padding = UDim.new(0,8)

local xpPadding = Instance.new("UIPadding", xpContainer)
xpPadding.PaddingLeft = UDim.new(0,4)
xpPadding.PaddingRight = UDim.new(0,4)
xpPadding.PaddingTop = UDim.new(0,4)
xpPadding.PaddingBottom = UDim.new(0,4)

-- Level list (tanımlar)
local XP_LOCATIONS = {
    {level = 200,
     start = Vector3.new(-921.3, 60.0, -1312.1),
     finish = Vector3.new(-895.6, 136.2, 2000.0)
    },
    {level = 40,
     start = Vector3.new(2987.5, 270.2, 2052.6),
     finish = Vector3.new(-1589.5, 634.6, 1913.0)
    },
    {level = 25,
     start = Vector3.new(123.5, 235.6, -644.0),
     finish = Vector3.new(165.3, 461.8, -475.0)
    },
    {level = 15,
     start = Vector3.new(-263.6, 423.9, -366.4),
     finish = Vector3.new(58.4, 165.0, -544.6)
    },
    {level = 6,
     start = Vector3.new(2503.4, 29.8, 1482.9),
     finish = Vector3.new(2718.5, 100.0, 1826.4)
    },
}


table.sort(XP_LOCATIONS, function(a,b) return a.level < b.level end)

for _, info in ipairs(XP_LOCATIONS) do
    local row = Instance.new("Frame", xpContainer)
    row.Size = UDim2.new(1, 0, 0, 40)
    row.BackgroundTransparency = 1

    local lvlLabel = Instance.new("TextLabel", row)
    lvlLabel.Size = UDim2.new(0.45, 0, 1, 0)
    lvlLabel.Position = UDim2.new(0, 0, 0, 0)
    lvlLabel.BackgroundTransparency = 1
    lvlLabel.Text = "Level " .. tostring(info.level)
    lvlLabel.Font = Enum.Font.GothamBold
    lvlLabel.TextSize = 14
    lvlLabel.TextColor3 = Color3.fromRGB(220,220,230)
    lvlLabel.TextXAlignment = Enum.TextXAlignment.Left

    local startBtn = Instance.new("TextButton", row)
    startBtn.Size = UDim2.new(0.22, 0, 0, 30)
    startBtn.Position = UDim2.new(0.52, 0, 0.5, -15)
    startBtn.Text = "Start"
    startBtn.Font = Enum.Font.Gotham
    startBtn.TextSize = 14
    startBtn.BackgroundColor3 = Color3.fromRGB(100,180,255)
    startBtn.TextColor3 = Color3.fromRGB(255,255,255)
    startBtn.BorderSizePixel = 0
    Instance.new("UICorner", startBtn)

    local endBtn = Instance.new("TextButton", row)
    endBtn.Size = UDim2.new(0.22, 0, 0, 30)
    endBtn.Position = UDim2.new(0.78, 0, 0.5, -15)
    endBtn.Text = "End"
    endBtn.Font = Enum.Font.Gotham
    endBtn.TextSize = 14
    endBtn.BackgroundColor3 = Color3.fromRGB(120,200,120)
    endBtn.TextColor3 = Color3.fromRGB(255,255,255)
    endBtn.BorderSizePixel = 0
    Instance.new("UICorner", endBtn)

    startBtn.MouseButton1Click:Connect(function()
        pulseButton(startBtn)
        teleportTo(info.start)
    end)
    endBtn.MouseButton1Click:Connect(function()
        pulseButton(endBtn)
        teleportTo(info.finish)
    end)
end

-- xpContainer canvas
xpLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    xpContainer.CanvasSize = UDim2.new(0, 0, 0, xpLayout.AbsoluteContentSize.Y + 8)
end)
xpContainer.CanvasSize = UDim2.new(0, 0, 0, xpLayout.AbsoluteContentSize.Y + 8)

-- Teleport list
local tpTitle = Instance.new("TextLabel", tpFrame)
tpTitle.Position = UDim2.new(0,0,0,0)
tpTitle.Size = UDim2.new(1,0,0,20)
tpTitle.BackgroundTransparency = 1
tpTitle.Text = "Teleport Locations"
tpTitle.Font = Enum.Font.GothamBold
tpTitle.TextSize = 16
tpTitle.TextColor3 = Color3.fromRGB(220,220,230)
tpTitle.TextXAlignment = Enum.TextXAlignment.Left

local scroll = Instance.new("ScrollingFrame", tpFrame)
scroll.Name = "TeleportList"
scroll.Position = UDim2.new(0,0,0,26)
scroll.Size = UDim2.new(1,0,1,-30)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
local layout = Instance.new("UIListLayout", scroll)
layout.FillDirection = Enum.FillDirection.Vertical
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0,8)
local padding = Instance.new("UIPadding", scroll)
padding.PaddingLeft = UDim.new(0,4)
padding.PaddingRight = UDim.new(0,4)
padding.PaddingTop = UDim.new(0,4)

for i,v in ipairs(TP_ORDER) do
    local btn = Instance.new("TextButton")
    btn.Name = v.name
    btn.Text = v.name
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(70,70,90)
    btn.TextColor3 = Color3.fromRGB(240,240,240)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn)
    btn.Parent = scroll

    btn.MouseButton1Click:Connect(function()
        pulseButton(btn)
        teleportTo(v.pos)
    end)
end

local function updateCanvas()
    scroll.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 8)
end
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
updateCanvas()

-- TAB SYSTEM
local function setActiveTab(tabName)
    if tabName == "Main" then
        mainTab.BackgroundColor3 = Color3.fromRGB(60,60,80)
        mainTab.Font = Enum.Font.GothamBold
        tpTab.BackgroundColor3 = Color3.fromRGB(35,35,45)
        tpTab.Font = Enum.Font.Gotham
        walkFrame.Visible = true
        tpFrame.Visible = false
    else
        tpTab.BackgroundColor3 = Color3.fromRGB(60,60,80)
        tpTab.Font = Enum.Font.GothamBold
        mainTab.BackgroundColor3 = Color3.fromRGB(35,35,45)
        mainTab.Font = Enum.Font.Gotham
        walkFrame.Visible = false
        tpFrame.Visible = true
    end
end

mainTab.MouseButton1Click:Connect(function()
    pulseButton(mainTab)
    setActiveTab("Main")
end)
tpTab.MouseButton1Click:Connect(function()
    pulseButton(tpTab)
    setActiveTab("Teleport")
end)
setActiveTab("Main")

-- PANEL OPEN ANIMATION
panel.Position = UDim2.new(0.5, 0, -0.4, 0)
panel.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(panel, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5,0,0.05,0), Size = UDim2.new(0,420,0,360)}):Play()
TweenService:Create(glow, TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,460,0,380)}):Play()

-- DRAGGING SYSTEM
local dragging, dragInput, dragStart, startPos
panel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
panel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        glow.Position = panel.Position
    end
end)

-- SPEED BOOSTER
local speedEnabled = false
local speedMultiplier = 1

speedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        speedToggle.Text = "SPEED: Open ("..tostring(speedMultiplier).."x)"
        speedToggle.BackgroundColor3 = Color3.fromRGB(0,150,255)
    else
        speedToggle.Text = "HIZ: Kapalı"
        speedToggle.BackgroundColor3 = Color3.fromRGB(80,30,200)
    end
end)

speedDec.MouseButton1Click:Connect(function()
    pulseButton(speedDec)
    speedMultiplier = math.clamp((speedMultiplier or 1) - 1, 1, 10)
    speedDisplay.Text = tostring(speedMultiplier) .. "x"
    if speedEnabled then
        speedToggle.Text = "HIZ: Açık ("..tostring(speedMultiplier).."x)"
    end
end)

speedInc.MouseButton1Click:Connect(function()
    pulseButton(speedInc)
    speedMultiplier = math.clamp((speedMultiplier or 1) + 1, 1, 10)
    speedDisplay.Text = tostring(speedMultiplier) .. "x"
    if speedEnabled then
        speedToggle.Text = "HIZ: Açık ("..tostring(speedMultiplier).."x)"
    end
end)

speedMultiplier = math.clamp(speedMultiplier or 1, 1, 10)
speedDisplay.Text = tostring(speedMultiplier) .. "x"

-- HIZ BOOSTER loop
task.spawn(function()
    while true do
        if speedEnabled then
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                if hrp and hum then
                    if hum.MoveDirection.Magnitude > 0 then
                        hrp.Velocity = hum.MoveDirection * (hum.WalkSpeed * speedMultiplier)
                    end
                end
            end
        end
        task.wait(0.05)
    end
end)

