-- © 2025 Enes03232 — All rights reserved.
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Items klasörünü bul
local function findItemsFolder()
    if workspace:FindFirstChild("Items") then return workspace.Items end
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "Items" and (v:IsA("Folder") or v:IsA("Model")) then return v end
    end
    return nil
end

local function findRVBodyPart()
    for _, v in ipairs(workspace:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Model")) and v.Name == "Body" then
            local p = v.Parent
            while p do
                if p.Name == "RV" then
                    if v:IsA("Model") then return v.PrimaryPart or v:FindFirstChildOfClass("BasePart") end
                    return v
                end
                p = p.Parent
            end
        end
    end
    for _, v in ipairs(workspace:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Model")) and v.Name == "Body" then
            if v:IsA("Model") then return v.PrimaryPart or v:FindFirstChildOfClass("BasePart") end
            return v
        end
    end
    return nil
end

-- Remove old GUI if any
local existing = playerGui:FindFirstChild("ItemRVTracker")
if existing then existing:Destroy() end

-- CREATE GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ItemRVTracker"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local PANEL_W = 360
local PANEL_H_OPEN = 540
local PANEL_H_COLLAPSED = 52

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, PANEL_W, 0, PANEL_H_OPEN)
panel.Position = UDim2.new(0, 16, 0, 80)
panel.AnchorPoint = Vector2.new(0, 0)
panel.BackgroundTransparency = 1
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
panel.Parent = screenGui

-- Frosted / translucent background
local backdrop = Instance.new("Frame")
backdrop.Name = "Backdrop"
backdrop.Size = UDim2.new(1,0,1,0)
backdrop.Position = UDim2.new(0,0,0,0)
backdrop.BackgroundColor3 = Color3.fromRGB(18,18,22)
backdrop.BackgroundTransparency = 0.62 -- semi transparent (frosted feel)
backdrop.BorderSizePixel = 0
backdrop.ClipsDescendants = true
backdrop.Parent = panel

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(22,30,48)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12,18,30))
}
grad.Rotation = 10
grad.Parent = backdrop

-- subtle overlay texture imitation
local glass = Instance.new("Frame")
glass.Name = "Glass"
glass.Size = UDim2.new(1,-12,1,-12)
glass.Position = UDim2.new(0,6,0,6)
glass.BackgroundColor3 = Color3.fromRGB(255,255,255)
glass.BackgroundTransparency = 0.94
glass.BorderSizePixel = 0
glass.Parent = panel

-- glow stroke
local stroke = Instance.new("UIStroke")
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(30,30,36)
stroke.Transparency = 0.85
stroke.Parent = backdrop

-- header
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1,0,0,48)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(240,240,240)
title.Text = "  ENES HUB 📦 ITEM FINDER"
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = panel

local accent = Instance.new("Frame")
accent.Name = "Accent"
accent.Size = UDim2.new(1,-20,0,0)
accent.Position = UDim2.new(0,10,0,48)
accent.BackgroundColor3 = Color3.fromRGB(20,140,220)
accent.BorderSizePixel = 0
accent.Visible = false
accent.Parent = panel

-- toggle button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "Toggle"
toggleBtn.Size = UDim2.new(0,36,0,36)
toggleBtn.Position = UDim2.new(1, -46, 0, 6)
toggleBtn.BackgroundColor3 = Color3.fromRGB(26,26,30)
toggleBtn.Text = "˄"
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 18
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = panel

-- RV button
local rvBtn = Instance.new("TextButton")
rvBtn.Name = "RVButton"
rvBtn.Size = UDim2.new(1,-20,0,44)
rvBtn.Position = UDim2.new(0,10,0,56)
rvBtn.BackgroundColor3 = Color3.fromRGB(200,100,10)
rvBtn.TextColor3 = Color3.fromRGB(255,255,255)
rvBtn.Font = Enum.Font.GothamBold
rvBtn.TextSize = 15
rvBtn.Text = "🚙 RV"
rvBtn.BorderSizePixel = 0
rvBtn.Parent = panel

-- separator
local sep = Instance.new("Frame")
sep.Name = "Separator"
sep.Size = UDim2.new(1,-20,0,2)
sep.Position = UDim2.new(0,10,0,116)
sep.BackgroundColor3 = Color3.fromRGB(21,21,26)
sep.BorderSizePixel = 0
sep.Parent = panel

-- items scroll
local scroll = Instance.new("ScrollingFrame")
scroll.Name = "ItemList"
scroll.Size = UDim2.new(1,-20,1,-136)
scroll.Position = UDim2.new(0,10,0,120)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 8
scroll.Parent = panel

local uiList = Instance.new("UIListLayout")
uiList.Padding = UDim.new(0,8)
uiList.Parent = scroll

uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scroll.CanvasSize = UDim2.new(0,0,0, uiList.AbsoluteContentSize.Y + 8)
end)

-- drag on title
do
    local dragging = false
    local dragStart = Vector2.new()
    local startPos = panel.Position
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = panel.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    title.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- item management
local itemsFolder = findItemsFolder()
local itemButtons = {}

local function createItemButton(item)
    if not item or itemButtons[item] then return end
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,36)
    btn.BackgroundColor3 = Color3.fromRGB(28,28,36)
    btn.BorderSizePixel = 0
    btn.TextColor3 = Color3.fromRGB(220,230,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Text = item.Name
    btn.Parent = scroll

    btn.MouseButton1Click:Connect(function()
        local ch = player.Character or player.CharacterAdded:Wait()
        local hrp = ch:FindFirstChild("HumanoidRootPart") or ch:WaitForChild("HumanoidRootPart", 5)
        if not hrp then return end
        local target
        if item:IsA("BasePart") then target = item
        elseif item:IsA("Model") then target = item.PrimaryPart or item:FindFirstChildOfClass("BasePart")
        else
            for _,d in ipairs(item:GetDescendants()) do if d:IsA("BasePart") then target = d break end end
        end
        if target and target.Parent then hrp.CFrame = target.CFrame + Vector3.new(0,3,0) end
    end)

    local conn
    conn = item.AncestryChanged:Connect(function(_, parent)
        if not parent or not item:IsDescendantOf(itemsFolder) then
            if itemButtons[item] then itemButtons[item]:Destroy() itemButtons[item] = nil end
            if conn then conn:Disconnect() end
        end
    end)

    itemButtons[item] = btn
end

local function removeItemButton(item)
    local b = itemButtons[item]
    if b then b:Destroy() itemButtons[item] = nil end
end

local function bindFolder(folder)
    if not folder then return end
    for k,v in pairs(itemButtons) do if v then v:Destroy() end itemButtons[k] = nil end
    for _,it in ipairs(folder:GetChildren()) do createItemButton(it) end
    folder.ChildAdded:Connect(function(it) createItemButton(it) end)
    folder.ChildRemoved:Connect(function(it) removeItemButton(it) end)
end

if itemsFolder then bindFolder(itemsFolder) else
    local conn
    conn = workspace.ChildAdded:Connect(function(c)
        if c.Name == "Items" and (c:IsA("Folder") or c:IsA("Model")) then
            itemsFolder = c
            bindFolder(itemsFolder)
            conn:Disconnect()
        end
    end)
end

-- RV TP
rvBtn.MouseButton1Click:Connect(function()
    local ch = player.Character or player.CharacterAdded:Wait()
    local hrp = ch:FindFirstChild("HumanoidRootPart") or ch:WaitForChild("HumanoidRootPart", 5)
    if not hrp then return end
    local rvPart = findRVBodyPart()
    if rvPart then hrp.CFrame = rvPart.CFrame + Vector3.new(0,3,0) end
end)

-- TOGGLE
local openSize = panel.Size
local openPos = panel.Position
local collapsedSize = UDim2.new(0, PANEL_W, 0, PANEL_H_COLLAPSED)
local collapsedPos = openPos
local isOpen = true
local tweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

toggleBtn.MouseButton1Click:Connect(function()
    if isOpen then
        -- collapse
        local t = TweenService:Create(panel, tweenInfo, {Size = collapsedSize})
        t:Play()
        task.delay(0.24, function()
            rvBtn.Visible = false
            sep.Visible = false
            scroll.Visible = false
            accent.Visible = false
        end)
        toggleBtn.Text = "˅"
        isOpen = false
    else
        -- open
        rvBtn.Visible = true
        sep.Visible = true
        scroll.Visible = true
        accent.Visible = false
        local t = TweenService:Create(panel, tweenInfo, {Size = openSize})
        t:Play()
        toggleBtn.Text = "˄"
        isOpen = true
    end
end)

-- initial bind
task.defer(function()
    itemsFolder = findItemsFolder()
    if itemsFolder then bindFolder(itemsFolder) end

end)



