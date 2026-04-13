local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "EnesPanel_FIX"

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 420, 0, 280)
main.Position = UDim2.new(0.5, -210, 0.5, -140)
main.BackgroundColor3 = Color3.fromRGB(10,10,10)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0

Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255,0,0)
stroke.Transparency = 0.3

-- TOP
local top = Instance.new("Frame", main)
top.Size = UDim2.new(1,0,0,40)
top.BackgroundTransparency = 1

local title = Instance.new("TextLabel", top)
title.Size = UDim2.new(0,150,1,0)
title.Position = UDim2.new(0,15,0,0)
title.Text = "Enes HUB"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

-- DISCORD
local copyright = Instance.new("TextLabel", main)
copyright.Size = UDim2.new(0,150,0,20)
copyright.Position = UDim2.new(0,10,1,-25)
copyright.Text = "Open / Close (K)"
copyright.TextColor3 = Color3.fromRGB(100,100,100)
copyright.BackgroundTransparency = 1
copyright.Font = Enum.Font.Gotham
copyright.TextSize = 11
copyright.TextXAlignment = Enum.TextXAlignment.Left

local discord = Instance.new("TextLabel", main)
discord.Size = UDim2.new(0,150,0,20)
discord.Position = UDim2.new(1,-160,1,-25)
discord.Text = "Discord: HQwtwteA"
discord.TextColor3 = Color3.fromRGB(100,100,100)
discord.BackgroundTransparency = 1
discord.Font = Enum.Font.Gotham
discord.TextSize = 11
discord.TextXAlignment = Enum.TextXAlignment.Right

-- DRAG
local dragging, startPos, startInput

top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = main.Position
        startInput = i.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - startInput
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- TAB BUTTONS
local function tab(text,x)
    local b = Instance.new("TextButton", top)
    b.Size = UDim2.new(0,80,1,0)
    b.Position = UDim2.new(0,x,0,0)
    b.Text = text
    b.BackgroundTransparency = 1
    b.TextColor3 = Color3.fromRGB(180,180,180)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    return b
end

local espTab = tab("ESP",120)
local tpTab = tab("TP",200)

-- underline
local line = Instance.new("Frame", top)
line.Size = UDim2.new(0,60,0,2)
line.BackgroundColor3 = Color3.fromRGB(255,0,0)

-- PAGES
local espPage = Instance.new("Frame", main)
espPage.Size = UDim2.new(1,0,1,-40)
espPage.Position = UDim2.new(0,0,0,40)
espPage.BackgroundTransparency = 1

local tpPage = espPage:Clone()
tpPage.Parent = main
tpPage.Visible = false

local function switch(tabName)
    espPage.Visible = tabName=="ESP"
    tpPage.Visible = tabName=="TP"

    local targetPos = tabName=="ESP" and UDim2.new(0,135,1,-2) or UDim2.new(0,215,1,-2)
    TweenService:Create(line,TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{
        Position = targetPos
    }):Play()
end

espTab.MouseButton1Click:Connect(function() switch("ESP") end)
tpTab.MouseButton1Click:Connect(function() switch("TP") end)

-- BUTTON
local function button(parent,text,y)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0,380,0,40)
    b.Position = UDim2.new(0,20,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(20,20,20)
    b.TextColor3 = Color3.fromRGB(255,255,255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14

    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(255,0,0)
    s.Transparency = 0.5

    return b
end

-- STATES
local killerESP, aliveESP, genESP = false,false,false

-- HIGHLIGHT SYSTEM
local highlightedObjects = {}

local function updateHighlight(obj, shouldHighlight, color)
    if shouldHighlight then
        if not highlightedObjects[obj] then
            local h = Instance.new("Highlight")
            h.Name = "HL"
            h.FillColor = color
            h.OutlineColor = color
            h.FillTransparency = 0.3
            h.Parent = obj
            highlightedObjects[obj] = h
        else
            -- Highlight zaten var, rengini güncelle
            highlightedObjects[obj].FillColor = color
            highlightedObjects[obj].OutlineColor = color
        end
    else
        if highlightedObjects[obj] then
            highlightedObjects[obj]:Destroy()
            highlightedObjects[obj] = nil
        end
    end
end

-- ESP BUTTONLARI
button(espPage,"Killer ESP",10).MouseButton1Click:Connect(function(btn)
    killerESP = not killerESP
    btn.Text = "Killer ESP: "..(killerESP and "ON" or "OFF")
end)

button(espPage,"Alive ESP",60).MouseButton1Click:Connect(function(btn)
    aliveESP = not aliveESP
    btn.Text = "Alive ESP: "..(aliveESP and "ON" or "OFF")
end)

button(espPage,"Generator ESP",110).MouseButton1Click:Connect(function(btn)
    genESP = not genESP
    btn.Text = "Generator ESP: "..(genESP and "ON" or "OFF")
end)

-- TP SYSTEM WITH COOLDOWN
local tpCooldown = false

local function teleport(part)
    if tpCooldown then
        return
    end
    
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0,5,0)
        tpCooldown = true
        
        task.spawn(function()
            task.wait(5)
            tpCooldown = false
        end)
    end
end

local tpList = {}
local tpScrollFrame = nil

local function refreshTP()
    for _,v in pairs(tpList) do v:Destroy() end
    tpList = {}
    
    if tpScrollFrame then tpScrollFrame:Destroy() end

    local y = 10
    local buttons = {}

    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("generator") then
            local b = button(tpPage,v.Name,y)
            y += 50
            table.insert(buttons, b)
            table.insert(tpList,b)

            b.MouseButton1Click:Connect(function()
                local p = v:FindFirstChildWhichIsA("BasePart")
                if p then teleport(p) end
            end)
        end
    end
    
    if y > 200 then
        tpScrollFrame = Instance.new("ScrollingFrame", tpPage)
        tpScrollFrame.Size = UDim2.new(1,0,1,-40)
        tpScrollFrame.Position = UDim2.new(0,0,0,40)
        tpScrollFrame.BackgroundTransparency = 1
        tpScrollFrame.CanvasSize = UDim2.new(0,0,0,y + 20)
        tpScrollFrame.ScrollBarThickness = 5
        
        for _,btn in pairs(buttons) do
            btn.Parent = tpScrollFrame
        end
    end
end

-- LOOP
task.spawn(function()
    while true do
        -- KILLER ESP
        local killer = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("KILLER")
        if killer then
            for _,v in pairs(killer:GetChildren()) do
                updateHighlight(v, killerESP, Color3.fromRGB(255,0,0))
            end
        end

        -- ALIVE ESP
        local alive = workspace:FindFirstChild("PLAYERS") and workspace.PLAYERS:FindFirstChild("ALIVE")
        if alive then
            for _,v in pairs(alive:GetChildren()) do
                updateHighlight(v, aliveESP, Color3.fromRGB(0,255,0))
            end
        end

        -- GENERATOR ESP
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name:lower():find("generator") then
                updateHighlight(v, genESP, Color3.fromRGB(139,69,19))
            end
        end

        task.wait(0.5) 
    end
end)

task.spawn(function()
    while true do
        refreshTP()
        task.wait(5)
    end
end)

-- OPEN CLOSE
local open = true

UIS.InputBegan:Connect(function(i,gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.K then
        open = not open
        main.Visible = open
    end
end)

-- INIT
switch("ESP")
