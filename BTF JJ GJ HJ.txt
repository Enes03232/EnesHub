-- LocalScript -> StarterPlayerScripts
-- Tam entegre script: JJ/GJ/HJ sistemi + RUN/STOP/RESET + Panel sürükleme
-- ChatLogs sistemi tamamen kaldırıldı

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local humanoid
local function bindCharacter(char)
    humanoid = char:WaitForChild("Humanoid")
end
bindCharacter(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(bindCharacter)

-- ====================================
-- PANEL (Ana)
-- ====================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BTF_JJ_GJ_Panel"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.3, 0.32) -- boy
frame.Position = UDim2.fromScale(0.05, 0.28)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.35
frame.BorderSizePixel = 0
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,15)

-- Başlık çubuğu
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1,0,0,34)
titleBar.BackgroundColor3 = Color3.fromRGB(0,0,0)
titleBar.BackgroundTransparency = 0.45
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,15)

local title = Instance.new("TextLabel", titleBar)
title.Text = "JJ-GJ-HJ Panel"
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- İçerik
local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -20, 1, -50)
content.Position = UDim2.new(0,10,0,40)
content.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", content)
UIList.Padding = UDim.new(0,12)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Top

-- Fonksiyonlar (UI)
local function makeBox(placeholder, default)
    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(0.9,0,0,36)
    tb.BackgroundColor3 = Color3.fromRGB(0,0,0)
    tb.BackgroundTransparency = 0.45
    tb.TextColor3 = Color3.new(1,1,1)
    tb.PlaceholderText = placeholder
    tb.Text = tostring(default or "0")
    tb.ClearTextOnFocus = false
    tb.TextScaled = true
    tb.Font = Enum.Font.Gotham
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0,10)
    return tb
end

local function makeButton(text)
    local b = Instance.new("TextButton")
    b.Text = text
    b.Size = UDim2.new(0.28,0,0,38)
    b.BackgroundColor3 = Color3.fromRGB(0,0,0)
    b.BackgroundTransparency = 0.45
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

    -- Hover efekti
    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.45}):Play()
    end)

    -- Click efekti (görsel)
    b.MouseButton1Click:Connect(function()
        b:TweenSize(UDim2.new(0.26,0,0,34), "Out", "Quad", 0.1, true, function()
            b:TweenSize(UDim2.new(0.28,0,0,38), "Out", "Quad", 0.1, true)
        end)
    end)

    return b
end

-- Inputlar
local jjBox = makeBox("JJ adet (BİR, İKİ...)", "0"); jjBox.Parent = content
local gjBox = makeBox("GJ adet (Bir., iki...)", "0"); gjBox.Parent = content
local hjBox = makeBox("HJ adet (B → İ → R → BİR)", "0"); hjBox.Parent = content
local hizBox = makeBox("Hız (saniye)", "0.5"); hizBox.Parent = content

-- Alt buton barı
local buttonRow = Instance.new("Frame", content)
buttonRow.Size = UDim2.new(0.95,0,0,42)
buttonRow.BackgroundTransparency = 1
local hLayout = Instance.new("UIListLayout", buttonRow)
hLayout.FillDirection = Enum.FillDirection.Horizontal
hLayout.Padding = UDim.new(0,10)
hLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local runBtn = makeButton("▶ RUN"); runBtn.Parent = buttonRow
local stopBtn = makeButton("STOP"); stopBtn.Parent = buttonRow
local resetBtn = makeButton("↻ RESET"); resetBtn.Parent = buttonRow
buttonRow.Parent = content

-- ====================================
-- SAYILAR (JJ / GJ / HJ)
-- ====================================
local onesUpper = {"BİR","İKİ","ÜÇ","DÖRT","BEŞ","ALTI","YEDİ","SEKİZ","DOKUZ"}
local tensUpper = {"ON","YİRMİ","OTUZ","KIRK","ELLİ","ALTMIŞ","YETMİŞ","SEKSEN","DOKSAN"}

local onesLower = {"bir","iki","üç","dört","beş","altı","yedi","sekiz","dokuz"}
local tensLower = {"on","yirmi","otuz","kırk","elli","altmış","yetmiş","seksen","doksan"}

local function below100_JJ(n)
    if n < 10 then return onesUpper[n] end
    local t = math.floor(n/10)
    local o = n % 10
    if o == 0 then return tensUpper[t] end
    return tensUpper[t] .. " " .. onesUpper[o]
end

local function below100_GJ_lower(n)
    if n < 10 then return onesLower[n] end
    local t = math.floor(n/10)
    local o = n % 10
    if o == 0 then return tensLower[t] end
    return tensLower[t] .. " " .. onesLower[o]
end

local function JJ_spell(n)
    if n == 100 then return "YÜZ" end
    if n == 200 then return "İKİ YÜZ" end
    if n == 300 then return "ÜÇ YÜZ" end

    if n < 100 then
        return below100_JJ(n)
    end

    local h = math.floor(n/100) -- 1..3
    local rest = n % 100
    local parts = {}

    if h == 1 then
        table.insert(parts, "YÜZ")
    elseif h == 2 then
        table.insert(parts, "İKİ YÜZ")
    elseif h == 3 then
        table.insert(parts, "ÜÇ YÜZ")
    end

    if rest > 0 then
        table.insert(parts, below100_JJ(rest))
    end

    return table.concat(parts, " ")
end

-- UTF-8 güvenli ilk harfi büyük yapan fonksiyon
local function utf8_chars(str)
    local chars = {}
    for _, c in utf8.codes(str) do
        table.insert(chars, utf8.char(c))
    end
    return chars
end

local function capFirstTR(s)
    local chars = utf8_chars(tostring(s or ""))
    if #chars == 0 then return "" end
    local first = chars[1]
    local rest = ""
    if #chars > 1 then
        rest = table.concat(chars, "", 2)
    end
    local map = {
        ["i"] = "İ", ["ı"] = "I",
        ["ğ"] = "Ğ", ["ü"] = "Ü",
        ["ş"] = "Ş", ["ö"] = "Ö",
        ["ç"] = "Ç"
    }
    local firstUp = map[first] or first:upper()
    return firstUp .. rest
end

local function GJ_spell(n)
    if n == 100 then return "Yüz." end
    if n == 200 then return "İki yüz." end
    if n == 300 then return "Üç yüz." end

    if n < 100 then
        return capFirstTR(below100_GJ_lower(n)) .. "."
    end

    local h = math.floor(n/100)
    local rest = n % 100
    local parts = {}

    if h == 1 then
        table.insert(parts, "yüz")
    elseif h == 2 then
        table.insert(parts, "iki yüz")
    elseif h == 3 then
        table.insert(parts, "üç yüz")
    end

    if rest > 0 then
        table.insert(parts, below100_GJ_lower(rest))
    end

    local phraseLower = table.concat(parts, " ")
    return capFirstTR(phraseLower) .. "."
end

local function HJ_spell(n)
    local word = JJ_spell(n) -- büyük harfli hali
    local chars = utf8_chars(word)
    local parts = {}
    for _, c in ipairs(chars) do
        if c ~= " " then -- boşlukları atla
            table.insert(parts, c)
        end
    end
    table.insert(parts, word) -- son olarak tam hali
    return parts
end

-- Precompute 1..2000
local JJNumbers, GJNumbers, HJNumbers = {}, {}, {}
for i = 1, 2000 do
    JJNumbers[i] = JJ_spell(i)
    GJNumbers[i] = GJ_spell(i)
    HJNumbers[i] = HJ_spell(i)
end

-- ====================================
-- CHAT & JUMP (send)
-- ====================================
local function sendMessage(msg)
    local channels = TextChatService:FindFirstChild("TextChannels")
    if channels then
        local general = channels:FindFirstChild("RBXGeneral")
        if general then pcall(function() general:SendAsync(msg) end) return end
    end
    local defaultEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if defaultEvents then
        local say = defaultEvents:FindFirstChild("SayMessageRequest")
        if say then say:FireServer(msg,"All") return end
    end
    pcall(function() StarterGui:SetCore("ChatMakeSystemMessage",{Text=msg}) end)
end

local function jump()
    if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end

-- ====================================
-- KONTROL (RUN / STOP / RESET)
-- ====================================
local running = false
local currentJJ, currentGJ, currentHJ = 1, 1, 1

local function runLoop()
    local jjCount = tonumber(jjBox.Text) or 0
    local gjCount = tonumber(gjBox.Text) or 0
    local hjCount = tonumber(hjBox.Text) or 0
    local hiz = tonumber(hizBox.Text) or 1
    if hiz < 0.05 then hiz = 0.05 end

    while running and currentJJ <= math.min(jjCount, #JJNumbers) do
        sendMessage(JJNumbers[currentJJ]); jump()
        currentJJ += 1
        task.wait(hiz)
    end
    while running and currentGJ <= math.min(gjCount, #GJNumbers) do
        sendMessage(GJNumbers[currentGJ]); jump()
        currentGJ += 1
        task.wait(hiz)
    end
    while running and currentHJ <= math.min(hjCount, #HJNumbers) do
        for _, part in ipairs(HJNumbers[currentHJ]) do
            if not running then break end
            sendMessage(part); jump()
            task.wait(hiz)
        end
        currentHJ += 1
    end
    running = false
end

runBtn.MouseButton1Click:Connect(function()
    if running then return end
    running = true
    task.spawn(runLoop)
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
end)

resetBtn.MouseButton1Click:Connect(function()
    running = false
    currentJJ, currentGJ, currentHJ = 1, 1, 1
end)

-- ====================================
-- PANELİ SÜRÜKLE
-- ====================================
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- End of script