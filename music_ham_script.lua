local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local SoundService     = game:GetService("SoundService")
local GuiService       = game:GetService("GuiService")

local player    = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function isMobile(): boolean
	return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local BASE_W, BASE_H = 420, 620

local function panelScale(): number
	local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
	local marginY = isMobile() and 40 or 24
	local marginX = 20
	local sx = (vp.X - marginX * 2) / BASE_W
	local sy = (vp.Y - marginY * 2) / BASE_H
	return math.clamp(math.min(sx, sy, 1), 0.55, 1)
end

local UI_SCALE = panelScale()
local PANEL_W  = math.floor(BASE_W * UI_SCALE)
local PANEL_H  = math.floor(BASE_H * UI_SCALE)

local ANA_KLASOR = "EnesScript"
local MUZIK_KLASOR = ANA_KLASOR .. "/Music"
local LOGO_KLASOR = ANA_KLASOR .. "/Logo"

local function klasorOlustur(yol: string)
	if not isfolder or not makefolder then return end
	local parcalar = string.split(yol, "/")
	local birikim = ""
	for _, p in ipairs(parcalar) do
		birikim = (birikim == "") and p or (birikim .. "/" .. p)
		if not isfolder(birikim) then
			pcall(function() makefolder(birikim) end)
		end
	end
end

klasorOlustur(ANA_KLASOR)
klasorOlustur(MUZIK_KLASOR)
klasorOlustur(LOGO_KLASOR)

local gorselCache: {[string]: string} = {}

local function gorselIndir(url: string, isim: string): string?
	if gorselCache[isim] then return gorselCache[isim] end
	local yol = LOGO_KLASOR .. "/" .. isim

	if isfile then
		local ok, var = pcall(function() return isfile(yol) end)
		if ok and var and getcustomasset then
			local ok2, asset = pcall(function() return getcustomasset(yol) end)
			if ok2 and type(asset) == "string" then
				gorselCache[isim] = asset
				return asset
			end
		end
	end

	if not writefile then return nil end
	local ok, veri = pcall(function() return game:HttpGet(url, true) end)
	if not ok or type(veri) ~= "string" or #veri < 100 then return nil end
	local yazOk = pcall(function() writefile(yol, veri) end)
	if not yazOk then return nil end
	if getcustomasset then
		local ok2, asset = pcall(function() return getcustomasset(yol) end)
		if ok2 and type(asset) == "string" then
			gorselCache[isim] = asset
			return asset
		end
	end
	return nil
end

type Logo = {ad: string, url: string, dosya: string}

local LOGOLAR: {Logo} = {
	{ad = "play",     url = "https://files.catbox.moe/nechhw.png", dosya = "btn_play.png"},
	{ad = "pause",    url = "https://files.catbox.moe/818ifv.png", dosya = "btn_pause.png"},
	{ad = "next",     url = "https://files.catbox.moe/vu4007.png", dosya = "btn_next.png"},
	{ad = "previous", url = "https://files.catbox.moe/glgpcu.png", dosya = "btn_previous.png"},
	{ad = "volume",   url = "https://files.catbox.moe/md5bou.png", dosya = "btn_volume.png"},
	{ad = "expand",   url = "https://files.catbox.moe/a6235k.png", dosya = "btn_expand.png"},
	{ad = "chevron",  url = "https://files.catbox.moe/4je03k.png", dosya = "btn_chevron.png"},
	{ad = "repeat",   url = "https://files.catbox.moe/x6pfrq.png", dosya = "btn_repeat.png"},
}

local logoAssets: {[string]: string} = {}

task.spawn(function()
	for _, logo in ipairs(LOGOLAR) do
		local asset = gorselIndir(logo.url, logo.dosya)
		if asset then logoAssets[logo.ad] = asset end
	end
end)

type Sarki = {ad: string, url: string, dosya: string, gorsel: string, gorselAd: string}

local SARKILAR: {Sarki} = {
	{ad = "1 Miguel", url = "https://files.catbox.moe/svtvsw.mp3", dosya = "1_miguel.mp3", gorsel = "https://files.catbox.moe/7qokz8.png", gorselAd = "img_miguel.png"},
	{ad = "2 EFN", url = "https://files.catbox.moe/zbxoqs.mp3", dosya = "2_efn.mp3", gorsel = "https://files.catbox.moe/vo4697.png", gorselAd = "img_efn.png"},
	{ad = "3 Cala Bonita", url = "https://files.catbox.moe/p7cf0i.mp3", dosya = "3_cala_bonita.mp3", gorsel = "https://files.catbox.moe/allq11.png", gorselAd = "img_cala.png"},
	{ad = "4 Neckhurt Techno", url = "https://files.catbox.moe/wmrbuy.mp3", dosya = "4_neckhurt_techno.mp3", gorsel = "https://files.catbox.moe/izv1ym.png", gorselAd = "img_neckhurt.png"},
	{ad = "5 Unreleased Ahh", url = "https://files.catbox.moe/vxd9kw.mp3", dosya = "5_unreleased_ahh.mp3", gorsel = "https://files.catbox.moe/eiicmi.png", gorselAd = "img_unreleased.png"},
	{ad = "6 Montagem Neck Hurt", url = "https://files.catbox.moe/gmdb95.mp3", dosya = "6_montagem_neck_hurt.mp3", gorsel = "https://files.catbox.moe/blw7cd.png", gorselAd = "img_montagem.png"},
	{ad = "7 Neck Hurts Remix", url = "https://files.catbox.moe/1y93lx.mp3", dosya = "7_neck_hurts_remix.mp3", gorsel = "https://files.catbox.moe/g9hn5p.png", gorselAd = "img_remix.png"},
	{ad = "8 Passo Bem Solto", url = "https://files.catbox.moe/w3w4be.mp3", dosya = "8_passo_bem_solto.mp3", gorsel = "https://files.catbox.moe/ptl6jf.png", gorselAd = "img_passo.png"},
	{ad = "9 DJ Melon - Neck Hurt", url = "https://files.catbox.moe/itbewk.mp3", dosya = "9_dj_melon_neck_hurt.mp3", gorsel = "https://files.catbox.moe/ofscvs.png", gorselAd = "img_melon.png"},
	{ad = "10 LIL BLACKOUT", url = "https://files.catbox.moe/6hikun.mp3", dosya = "10_lil_blackout.mp3", gorsel = "https://files.catbox.moe/swlg40.png", gorselAd = "img_blackout.png"},
	{ad = "11 Kneegirl Boi", url = "https://files.catbox.moe/sv25sf.mp3", dosya = "11_kneegirl_boi.mp3", gorsel = "https://files.catbox.moe/7c85wo.png", gorselAd = "img_kneegirl.png"},
	{ad = "12 Montagem Bailao", url = "https://files.catbox.moe/p54rc3.mp3", dosya = "12_montagem_bailao.mp3", gorsel = "https://files.catbox.moe/1ctqco.png", gorselAd = "img_bailao.png"},
	{ad = "13 Volkswagen Snickers", url = "https://files.catbox.moe/z57x3r.mp3", dosya = "13_volkswagen_snickers.mp3", gorsel = "https://files.catbox.moe/7dx08t.jpg", gorselAd = "img_volkswagen.jpg"},
}

local function dosyaGecerli(yol: string): boolean
	if not isfile then return false end
	local ok, var = pcall(function() return isfile(yol) end)
	if not ok or not var then return false end
	if readfile then
		local ok2, icerik = pcall(function() return readfile(yol) end)
		if ok2 and type(icerik) == "string" and #icerik > 1024 then
			local ilk = icerik:sub(1, 3)
			if ilk == "ID3" then return true end
			local b1 = string.byte(icerik, 1)
			local b2 = string.byte(icerik, 2)
			if b1 == 0xFF and (b2 == 0xFB or b2 == 0xF3 or b2 == 0xF2 or b2 == 0xFA) then
				return true
			end
		end
	end
	return false
end

local function sarkiIndir(index: number): boolean
	local sarki = SARKILAR[index]
	if not sarki then return false end
	local yol = MUZIK_KLASOR .. "/" .. sarki.dosya

	if dosyaGecerli(yol) then return true end
	if not writefile then return false end
	local ok, veri = pcall(function() return game:HttpGet(sarki.url, true) end)
	if not ok or type(veri) ~= "string" or #veri < 1024 then return false end
	local yazOk = pcall(function() writefile(yol, veri) end)
	if not yazOk then return false end
	return dosyaGecerli(yol)
end

local function sarkiAsset(index: number): string?
	if not getcustomasset then return nil end
	local sarki = SARKILAR[index]
	if not sarki then return nil end
	local yol = MUZIK_KLASOR .. "/" .. sarki.dosya
	if not dosyaGecerli(yol) then return nil end
	local ok, asset = pcall(function() return getcustomasset(yol) end)
	if ok and type(asset) == "string" then return asset end
	return nil
end

local PANEL_CORNER      = math.max(16, math.floor(30 * UI_SCALE))
local GLASS_COLOR       = Color3.fromRGB(28, 28, 34)
local GLASS_TRANSP      = 0.42
local OPEN_TIME         = 0.55
local CLOSE_TIME        = 0.32
local BTN_CENTER_X      = 56
local DRAG_THRESHOLD    = isMobile() and 10 or 6

local HOME_BAR_W        = math.floor(140 * UI_SCALE)
local HOME_BAR_H        = 5
local HOME_BAR_TRANSP   = 0.55
local HOME_OFFSET_Y     = math.floor(22 * UI_SCALE)
local HOME_LERP         = 9
local PANEL_LERP        = 9

local SCALE_STIFF       = 520
local SCALE_DAMP        = 16

local SMALL_VIEWPORT    = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.Y < 500

local sound: Sound? = nil
local caliyor = false
local aktifIndex: number? = nil
local sesSeviyesi = 1
local onayAcik = false
local kucultulmus = false
local sarkiBitti = false

local function corner(parent: Instance, r: number): UICorner
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r); c.Parent = parent; return c
end

local function addStroke(parent: Instance, transparency: number?, thickness: number?, color: Color3?): UIStroke
	local s = Instance.new("UIStroke")
	s.Color = color or Color3.new(1, 1, 1)
	s.Thickness = thickness or 1
	s.Transparency = transparency or 0.7
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.Parent = parent
	return s
end

local function addGradient(parent: Instance, colorSeq: ColorSequence, transSeq: NumberSequence, rotation: number?): UIGradient
	local g = Instance.new("UIGradient")
	g.Color = colorSeq; g.Transparency = transSeq; g.Rotation = rotation or 0
	g.Parent = parent
	return g
end

local function viewport(): Vector2 return workspace.CurrentCamera.ViewportSize end

local function spring(cur: number, vel: number, tgt: number, stiff: number, damp: number, dt: number, settleDist: number?, settleVel: number?): (number, number)
	settleDist = settleDist or 0.05
	settleVel  = settleVel  or 0.8
	if math.abs(tgt - cur) < settleDist and math.abs(vel) < settleVel then return tgt, 0 end
	local F = (tgt - cur) * stiff - vel * damp
	vel = vel + F * dt
	cur = cur + vel * dt
	return cur, vel
end

local function formatSure(s: number): string
	s = math.floor(s or 0)
	return string.format("%d:%02d", math.floor(s / 60), s % 60)
end

local function clampPanelPos(cx: number, cy: number): (number, number)
	local vp = viewport()
	local halfW = PANEL_W / 2
	local halfH = PANEL_H / 2
	local minX = halfW + 4
	local maxX = vp.X - halfW - 4
	local minY = halfH + 4
	local maxY = vp.Y - halfH - 4
	if minX > maxX then minX, maxX = vp.X / 2, vp.X / 2 end
	if minY > maxY then minY, maxY = vp.Y / 2, vp.Y / 2 end
	return math.clamp(cx, minX, maxX), math.clamp(cy, minY, maxY)
end

local function clampBarPos(cx: number, cy: number): (number, number)
	local vp = viewport()
	local halfW = HOME_BAR_W / 2
	local halfH = HOME_BAR_H / 2
	return math.clamp(cx, halfW + 4, vp.X - halfW - 4),
	       math.clamp(cy, halfH + 4, vp.Y - halfH - 4)
end

local function clampSmallPos(cx: number, cy: number): (number, number)
	local vp = viewport()
	local halfW = 160
	local halfH = 32
	return math.clamp(cx, halfW + 4, vp.X - halfW - 4),
	       math.clamp(cy, halfH + 4, vp.Y - halfH - 4)
end

local gui = Instance.new("ScreenGui")
gui.Name = "LiquidGlassUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local wrapper = Instance.new("Frame")
wrapper.Name = "Wrapper"
wrapper.AnchorPoint = Vector2.new(0.5, 0.5)
wrapper.Size = UDim2.fromOffset(0, 0)
wrapper.BackgroundTransparency = 1
wrapper.ClipsDescendants = true
wrapper.Visible = false
wrapper.ZIndex = 1
wrapper.Parent = gui

local glass = Instance.new("Frame")
glass.Name = "Glass"
glass.Size = UDim2.fromScale(1, 1)
glass.BackgroundColor3 = GLASS_COLOR
glass.BackgroundTransparency = GLASS_TRANSP
glass.BorderSizePixel = 0
glass.ZIndex = 2
glass.Parent = wrapper
corner(glass, PANEL_CORNER)
addStroke(glass, 0.55, 1, Color3.new(1, 1, 1))

local sheen = Instance.new("Frame")
sheen.Size = UDim2.fromScale(1, 1)
sheen.BackgroundColor3 = Color3.new(1, 1, 1)
sheen.BorderSizePixel = 0
sheen.ZIndex = 3
sheen.Parent = glass
corner(sheen, PANEL_CORNER)
addGradient(sheen,
	ColorSequence.new(Color3.new(1, 1, 1)),
	NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, 0.82),
		NumberSequenceKeypoint.new(0.40, 0.96),
		NumberSequenceKeypoint.new(1.00, 1.00),
	}), 90)

local prism = Instance.new("Frame")
prism.Size = UDim2.fromScale(1, 1)
prism.BackgroundColor3 = Color3.new(1, 1, 1)
prism.BorderSizePixel = 0
prism.ZIndex = 4
prism.Parent = glass
corner(prism, PANEL_CORNER)
addGradient(prism,
	ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(180, 140, 255)),
		ColorSequenceKeypoint.new(0.40, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(0.60, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(130, 220, 255)),
	}),
	NumberSequence.new({
		NumberSequenceKeypoint.new(0.00, 0.90),
		NumberSequenceKeypoint.new(0.40, 1.00),
		NumberSequenceKeypoint.new(0.60, 1.00),
		NumberSequenceKeypoint.new(1.00, 0.90),
	}), 45)

local content = Instance.new("CanvasGroup")
content.Size = UDim2.fromScale(1, 1)
content.BackgroundTransparency = 1
content.GroupTransparency = 1
content.ZIndex = 10
content.Parent = glass

local contentScale = Instance.new("UIScale")
contentScale.Scale = UI_SCALE
contentScale.Parent = content

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 0, 32)
title.Position = UDim2.new(0, 20, 0, 22)
title.BackgroundTransparency = 1
title.Text = "Enes HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 11
title.Parent = content

local kucultBtn = Instance.new("TextButton")
kucultBtn.Size = UDim2.new(0, 28, 0, 28)
kucultBtn.Position = UDim2.new(1, -72, 0, 24)
kucultBtn.BackgroundColor3 = Color3.new(1, 1, 1)
kucultBtn.BackgroundTransparency = 0.85
kucultBtn.Text = "-"
kucultBtn.TextColor3 = Color3.new(1, 1, 1)
kucultBtn.TextSize = 18
kucultBtn.Font = Enum.Font.GothamBold
kucultBtn.AutoButtonColor = false
kucultBtn.ZIndex = 12
kucultBtn.Parent = content
corner(kucultBtn, 14)
addStroke(kucultBtn, 0.7, 1, Color3.new(1, 1, 1))

local kapatBtn = Instance.new("TextButton")
kapatBtn.Size = UDim2.new(0, 28, 0, 28)
kapatBtn.Position = UDim2.new(1, -38, 0, 24)
kapatBtn.BackgroundColor3 = Color3.new(1, 1, 1)
kapatBtn.BackgroundTransparency = 0.85
kapatBtn.Text = "x"
kapatBtn.TextColor3 = Color3.new(1, 1, 1)
kapatBtn.TextSize = 14
kapatBtn.Font = Enum.Font.GothamBold
kapatBtn.AutoButtonColor = false
kapatBtn.ZIndex = 12
kapatBtn.Parent = content
corner(kapatBtn, 14)
addStroke(kapatBtn, 0.7, 1, Color3.new(1, 1, 1))

local kapakFrame = Instance.new("Frame")
kapakFrame.Size = UDim2.new(1, -40, 0, 130)
kapakFrame.Position = UDim2.new(0, 20, 0, 70)
kapakFrame.BackgroundColor3 = Color3.new(1, 1, 1)
kapakFrame.BackgroundTransparency = 0.85
kapakFrame.BorderSizePixel = 0
kapakFrame.ClipsDescendants = true
kapakFrame.ZIndex = 11
kapakFrame.Parent = content
corner(kapakFrame, 18)
addStroke(kapakFrame, 0.7, 1, Color3.new(1, 1, 1))

local kapakImg = Instance.new("ImageLabel")
kapakImg.Size = UDim2.new(0, 110, 0, 110)
kapakImg.Position = UDim2.new(0, 10, 0, 10)
kapakImg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
kapakImg.BorderSizePixel = 0
kapakImg.Image = ""
kapakImg.ScaleType = Enum.ScaleType.Crop
kapakImg.ZIndex = 12
kapakImg.Parent = kapakFrame
corner(kapakImg, 14)

local kapakPlaceholder = Instance.new("TextLabel")
kapakPlaceholder.Size = UDim2.fromScale(1, 1)
kapakPlaceholder.BackgroundTransparency = 1
kapakPlaceholder.Text = "♪"
kapakPlaceholder.TextColor3 = Color3.new(1, 1, 1)
kapakPlaceholder.TextSize = 40
kapakPlaceholder.Font = Enum.Font.GothamBold
kapakPlaceholder.ZIndex = 13
kapakPlaceholder.Parent = kapakImg

local sarkiAd = Instance.new("TextLabel")
sarkiAd.Size = UDim2.new(1, -140, 0, 24)
sarkiAd.Position = UDim2.new(0, 132, 0, 16)
sarkiAd.BackgroundTransparency = 1
sarkiAd.Text = "Sarki sec"
sarkiAd.TextColor3 = Color3.new(1, 1, 1)
sarkiAd.TextSize = 16
sarkiAd.Font = Enum.Font.GothamBold
sarkiAd.TextXAlignment = Enum.TextXAlignment.Left
sarkiAd.TextTruncate = Enum.TextTruncate.AtEnd
sarkiAd.ZIndex = 12
sarkiAd.Parent = kapakFrame

local sarkiDurum = Instance.new("TextLabel")
sarkiDurum.Size = UDim2.new(1, -140, 0, 16)
sarkiDurum.Position = UDim2.new(0, 132, 0, 42)
sarkiDurum.BackgroundTransparency = 1
sarkiDurum.Text = "Hazir"
sarkiDurum.TextColor3 = Color3.new(1, 1, 1)
sarkiDurum.TextTransparency = 0.5
sarkiDurum.TextSize = 11
sarkiDurum.Font = Enum.Font.Gotham
sarkiDurum.TextXAlignment = Enum.TextXAlignment.Left
sarkiDurum.ZIndex = 12
sarkiDurum.Parent = kapakFrame

local progArka = Instance.new("Frame")
progArka.Size = UDim2.new(1, -140, 0, 5)
progArka.Position = UDim2.new(0, 132, 0, 68)
progArka.BackgroundColor3 = Color3.new(1, 1, 1)
progArka.BackgroundTransparency = 0.75
progArka.BorderSizePixel = 0
progArka.ZIndex = 12
progArka.Parent = kapakFrame
corner(progArka, 3)

local progDolu = Instance.new("Frame")
progDolu.Size = UDim2.new(0, 0, 1, 0)
progDolu.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
progDolu.BorderSizePixel = 0
progDolu.ZIndex = 13
progDolu.Parent = progArka
corner(progDolu, 3)

local progTop = Instance.new("Frame")
progTop.Size = UDim2.new(0, 10, 0, 10)
progTop.AnchorPoint = Vector2.new(0.5, 0.5)
progTop.Position = UDim2.new(1, 0, 0.5, 0)
progTop.BackgroundColor3 = Color3.new(1, 1, 1)
progTop.BorderSizePixel = 0
progTop.ZIndex = 14
progTop.Parent = progDolu
corner(progTop, 5)

local gecenSure = Instance.new("TextLabel")
gecenSure.Size = UDim2.new(0, 40, 0, 14)
gecenSure.Position = UDim2.new(0, 132, 0, 80)
gecenSure.BackgroundTransparency = 1
gecenSure.Text = "0:00"
gecenSure.TextColor3 = Color3.new(1, 1, 1)
gecenSure.TextTransparency = 0.5
gecenSure.TextSize = 11
gecenSure.Font = Enum.Font.Gotham
gecenSure.TextXAlignment = Enum.TextXAlignment.Left
gecenSure.ZIndex = 12
gecenSure.Parent = kapakFrame

local toplamSure = Instance.new("TextLabel")
toplamSure.Size = UDim2.new(0, 40, 0, 14)
toplamSure.Position = UDim2.new(1, -52, 0, 80)
toplamSure.BackgroundTransparency = 1
toplamSure.Text = "0:00"
toplamSure.TextColor3 = Color3.new(1, 1, 1)
toplamSure.TextTransparency = 0.5
toplamSure.TextSize = 11
toplamSure.Font = Enum.Font.Gotham
toplamSure.TextXAlignment = Enum.TextXAlignment.Right
toplamSure.ZIndex = 12
toplamSure.Parent = kapakFrame

local kontrol = Instance.new("Frame")
kontrol.Size = UDim2.new(1, -40, 0, 56)
kontrol.Position = UDim2.new(0, 20, 0, 212)
kontrol.BackgroundTransparency = 1
kontrol.ZIndex = 11
kontrol.Parent = content

local function gorselButon(name: string, boyut: number): TextButton
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.fromOffset(boyut, boyut)
	btn.AnchorPoint = Vector2.new(0.5, 0.5)
	btn.BackgroundColor3 = Color3.new(1, 1, 1)
	btn.BackgroundTransparency = 0.85
	btn.Text = ""
	btn.AutoButtonColor = false
	btn.ZIndex = 12
	btn.Parent = kontrol
	corner(btn, boyut / 2)
	addStroke(btn, 0.7, 1, Color3.new(1, 1, 1))

	local img = Instance.new("ImageLabel")
	img.Name = "Img"
	img.Size = UDim2.fromScale(0.6, 0.6)
	img.Position = UDim2.fromScale(0.2, 0.2)
	img.BackgroundTransparency = 1
	img.Image = ""
	img.ImageColor3 = Color3.new(1, 1, 1)
	img.ScaleType = Enum.ScaleType.Fit
	img.ZIndex = 13
	img.Parent = btn
	return btn
end

local geriBtn = gorselButon("Previous", 44)
geriBtn.Position = UDim2.new(0.5, -70, 0.5, 0)

local oynatBtn = gorselButon("PlayPause", 56)
oynatBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
oynatBtn.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
oynatBtn.BackgroundTransparency = 0.15

local ileriBtn = gorselButon("Next", 44)
ileriBtn.Position = UDim2.new(0.5, 70, 0.5, 0)

local sesKutu = Instance.new("Frame")
sesKutu.Size = UDim2.new(1, -40, 0, 30)
sesKutu.Position = UDim2.new(0, 20, 0, 278)
sesKutu.BackgroundTransparency = 1
sesKutu.ZIndex = 11
sesKutu.Parent = content

local sesIkon = Instance.new("ImageLabel")
sesIkon.Size = UDim2.fromOffset(20, 20)
sesIkon.Position = UDim2.new(0, 0, 0, 5)
sesIkon.BackgroundTransparency = 1
sesIkon.Image = ""
sesIkon.ScaleType = Enum.ScaleType.Fit
sesIkon.ZIndex = 12
sesIkon.Parent = sesKutu

local sesTutucu = Instance.new("TextButton")
sesTutucu.Size = UDim2.new(1, -70, 0, 24)
sesTutucu.Position = UDim2.new(0, 30, 0, 3)
sesTutucu.BackgroundTransparency = 1
sesTutucu.Text = ""
sesTutucu.AutoButtonColor = false
sesTutucu.ZIndex = 20
sesTutucu.Parent = sesKutu

local sesArka = Instance.new("Frame")
sesArka.Size = UDim2.new(1, -70, 0, 4)
sesArka.Position = UDim2.new(0, 30, 0, 13)
sesArka.BackgroundColor3 = Color3.new(1, 1, 1)
sesArka.BackgroundTransparency = 0.75
sesArka.BorderSizePixel = 0
sesArka.ZIndex = 12
sesArka.Parent = sesKutu
corner(sesArka, 2)

local sesDolu = Instance.new("Frame")
sesDolu.Size = UDim2.new(1, 0, 1, 0)
sesDolu.BackgroundColor3 = Color3.new(1, 1, 1)
sesDolu.BackgroundTransparency = 0.2
sesDolu.BorderSizePixel = 0
sesDolu.ZIndex = 13
sesDolu.Parent = sesArka
corner(sesDolu, 2)

local sesTop = Instance.new("Frame")
sesTop.Size = UDim2.new(0, 10, 0, 10)
sesTop.AnchorPoint = Vector2.new(0.5, 0.5)
sesTop.Position = UDim2.new(1, 0, 0.5, 0)
sesTop.BackgroundColor3 = Color3.new(1, 1, 1)
sesTop.BorderSizePixel = 0
sesTop.ZIndex = 14
sesTop.Parent = sesDolu
corner(sesTop, 5)
addStroke(sesTop, 0.4, 1, Color3.new(1, 1, 1))

local sesYazi = Instance.new("TextLabel")
sesYazi.Size = UDim2.new(0, 40, 0, 16)
sesYazi.Position = UDim2.new(1, -40, 0, 8)
sesYazi.BackgroundTransparency = 1
sesYazi.Text = "100%"
sesYazi.TextColor3 = Color3.new(1, 1, 1)
sesYazi.TextTransparency = 0.4
sesYazi.TextSize = 11
sesYazi.Font = Enum.Font.Gotham
sesYazi.TextXAlignment = Enum.TextXAlignment.Right
sesYazi.ZIndex = 12
sesYazi.Parent = sesKutu

task.spawn(function()
	for _ = 1, 50 do
		if logoAssets["play"] and logoAssets["next"] and logoAssets["previous"] then
			local oynatImg = oynatBtn:FindFirstChild("Img") :: ImageLabel?
			if oynatImg then oynatImg.Image = logoAssets["play"] or "" end
			local geriImg = geriBtn:FindFirstChild("Img") :: ImageLabel?
			if geriImg then geriImg.Image = logoAssets["previous"] or "" end
			local ileriImg = ileriBtn:FindFirstChild("Img") :: ImageLabel?
			if ileriImg then ileriImg.Image = logoAssets["next"] or "" end
			oynatBtn:SetAttribute("PauseAsset", logoAssets["pause"] or "")
		end
		if logoAssets["volume"] then
			sesIkon.Image = logoAssets["volume"]
		end
		task.wait(0.1)
	end
end)

local listeKutu = Instance.new("Frame")
listeKutu.Size = UDim2.new(1, -40, 1, -330)
listeKutu.Position = UDim2.new(0, 20, 0, 324)
listeKutu.BackgroundTransparency = 1
listeKutu.ClipsDescendants = true
listeKutu.ZIndex = 11
listeKutu.Parent = content

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.fromScale(1, 1)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = isMobile() and 5 or 3
scroll.ScrollBarImageColor3 = Color3.new(1, 1, 1)
scroll.ScrollBarImageTransparency = 0.7
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollingDirection = Enum.ScrollingDirection.Y
scroll.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
scroll.ZIndex = 11
scroll.Parent = listeKutu

local listeLayout = Instance.new("UIListLayout")
listeLayout.Padding = UDim.new(0, 6)
listeLayout.SortOrder = Enum.SortOrder.LayoutOrder
listeLayout.Parent = scroll

local FADE_RENK = GLASS_COLOR

local ustFade = Instance.new("Frame")
ustFade.Size = UDim2.new(1, 0, 0, 30)
ustFade.Position = UDim2.new(0, 0, 0, 0)
ustFade.BackgroundColor3 = FADE_RENK
ustFade.BackgroundTransparency = 0
ustFade.BorderSizePixel = 0
ustFade.ZIndex = 20
ustFade.Parent = listeKutu
addGradient(ustFade,
	ColorSequence.new(FADE_RENK),
	NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.85),
		NumberSequenceKeypoint.new(1, 1.0),
	}), 90)

local altFade = Instance.new("Frame")
altFade.Size = UDim2.new(1, 0, 0, 30)
altFade.Position = UDim2.new(0, 0, 1, -30)
altFade.BackgroundColor3 = FADE_RENK
altFade.BackgroundTransparency = 0
altFade.BorderSizePixel = 0
altFade.ZIndex = 20
altFade.Parent = listeKutu
addGradient(altFade,
	ColorSequence.new(FADE_RENK),
	NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1.0),
		NumberSequenceKeypoint.new(1, 0.85),
	}), 90)

local satirlar: {any} = {}

local function satirSec(index: number)
	for j, s in pairs(satirlar) do
		local aktif = (j == index)
		TweenService:Create(s.satir, TweenInfo.new(0.2), {
			BackgroundTransparency = aktif and 0.6 or 0.85,
		}):Play()

		if aktif then
			s.calIkon.Image = logoAssets["repeat"] or ""
			s.calIkon.ImageTransparency = 0
		else
			s.calIkon.Image = logoAssets["chevron"] or ""
			s.calIkon.ImageTransparency = 0.3
		end
	end
end

local homeBar = Instance.new("TextButton")
homeBar.Name = "HomeIndicator"
homeBar.AnchorPoint = Vector2.new(0.5, 0.5)
homeBar.Size = UDim2.fromOffset(HOME_BAR_W, HOME_BAR_H)
homeBar.BackgroundColor3 = Color3.new(1, 1, 1)
homeBar.BackgroundTransparency = HOME_BAR_TRANSP
homeBar.BorderSizePixel = 0
homeBar.Text = ""
homeBar.AutoButtonColor = false
homeBar.Visible = false
homeBar.ZIndex = 500
homeBar.Parent = gui
corner(homeBar, HOME_BAR_H / 2)
addStroke(homeBar, 0.72, 1, Color3.new(1, 1, 1))
addGradient(homeBar,
	ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 205, 220)),
	}),
	NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.35),
		NumberSequenceKeypoint.new(1, 0.70),
	}), 90)

local TOGGLE_SIZE = isMobile() and 62 or 56
local toggle = Instance.new("TextButton")
toggle.Name = "Toggle"
toggle.AnchorPoint = Vector2.new(0.5, 0.5)
toggle.Position = UDim2.new(0, BTN_CENTER_X, 0.5, 0)
toggle.Size = UDim2.fromOffset(TOGGLE_SIZE, TOGGLE_SIZE)
toggle.BackgroundColor3 = GLASS_COLOR
toggle.BackgroundTransparency = 0.35
toggle.BorderSizePixel = 0
toggle.Text = ""
toggle.AutoButtonColor = false
toggle.ZIndex = 100
toggle.Parent = gui
corner(toggle, TOGGLE_SIZE / 2)
addStroke(toggle, 0.6, 1, Color3.new(1, 1, 1))

local tSheen = Instance.new("Frame")
tSheen.Size = UDim2.fromScale(1, 1)
tSheen.BackgroundColor3 = Color3.new(1, 1, 1)
tSheen.BorderSizePixel = 0
tSheen.ZIndex = 1
tSheen.Parent = toggle
corner(tSheen, TOGGLE_SIZE / 2)
addGradient(tSheen,
	ColorSequence.new(Color3.new(1, 1, 1)),
	NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.82),
		NumberSequenceKeypoint.new(1, 1.00),
	}), 90)

local icon = Instance.new("TextLabel")
icon.Size = UDim2.fromScale(1, 1)
icon.BackgroundTransparency = 1
icon.Text = "+"
icon.TextColor3 = Color3.new(1, 1, 1)
icon.TextSize = isMobile() and 34 or 30
icon.Font = Enum.Font.GothamMedium
icon.Rotation = 0
icon.ZIndex = 5
icon.Parent = toggle

if not isMobile() then
	toggle.MouseEnter:Connect(function()
		TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Size = UDim2.fromOffset(TOGGLE_SIZE + 6, TOGGLE_SIZE + 6) }):Play()
	end)
	toggle.MouseLeave:Connect(function()
		TweenService:Create(toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Size = UDim2.fromOffset(TOGGLE_SIZE, TOGGLE_SIZE) }):Play()
	end)
end

local panelCx, panelCy = 0, 0
local barCx,   barCy   = 0, 0

local function applyPanelPos() wrapper.Position = UDim2.fromOffset(panelCx, panelCy) end
local function applyBarPos()   homeBar.Position = UDim2.fromOffset(barCx, barCy)    end

local function getButtonPos(): (number, number)
	local vp = viewport(); return BTN_CENTER_X, vp.Y / 2
end

local function getCenterPos(): (number, number)
	local vp = viewport(); return vp.X / 2, vp.Y / 2
end

local BAR_DY = PANEL_H / 2 + HOME_OFFSET_Y + HOME_BAR_H / 2

local isOpen      = false
local isAnimating = false
local PANEL_SIZE  = UDim2.fromOffset(PANEL_W, PANEL_H)
local mode: string = "panel"
local dragging: string? = nil
local savedCx: number?, savedCy: number? = nil, nil
local justDragged = false

local onayFrame = Instance.new("Frame")
onayFrame.Size = UDim2.fromOffset(260, 120)
onayFrame.AnchorPoint = Vector2.new(0.5, 0.5)
onayFrame.Position = UDim2.fromScale(0.5, 0.5)
onayFrame.BackgroundColor3 = GLASS_COLOR
onayFrame.BackgroundTransparency = 0.1
onayFrame.BorderSizePixel = 0
onayFrame.Visible = false
onayFrame.ZIndex = 200
onayFrame.Parent = gui
corner(onayFrame, 16)
addStroke(onayFrame, 0.5, 1, Color3.new(1, 1, 1))

local onayYazi = Instance.new("TextLabel")
onayYazi.Size = UDim2.new(1, -20, 0, 50)
onayYazi.Position = UDim2.new(0, 10, 0, 15)
onayYazi.BackgroundTransparency = 1
onayYazi.Text = "Muzik panelini kapatmak istediginizden emin misiniz?"
onayYazi.TextColor3 = Color3.new(1, 1, 1)
onayYazi.TextSize = 14
onayYazi.Font = Enum.Font.GothamMedium
onayYazi.TextWrapped = true
onayYazi.ZIndex = 201
onayYazi.Parent = onayFrame

local evetBtn = Instance.new("TextButton")
evetBtn.Size = UDim2.fromOffset(90, 28)
evetBtn.AnchorPoint = Vector2.new(0.5, 0.5)
evetBtn.Position = UDim2.new(0.25, 0, 1, -30)
evetBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
evetBtn.BackgroundTransparency = 0.2
evetBtn.Text = "Evet"
evetBtn.TextColor3 = Color3.new(1, 1, 1)
evetBtn.TextSize = 13
evetBtn.Font = Enum.Font.GothamBold
evetBtn.AutoButtonColor = false
evetBtn.ZIndex = 201
evetBtn.Parent = onayFrame
corner(evetBtn, 8)
addStroke(evetBtn, 0.5, 1, Color3.new(1, 1, 1))

local hayirBtn = Instance.new("TextButton")
hayirBtn.Size = UDim2.fromOffset(90, 28)
hayirBtn.AnchorPoint = Vector2.new(0.5, 0.5)
hayirBtn.Position = UDim2.new(0.75, 0, 1, -30)
hayirBtn.BackgroundColor3 = Color3.new(1, 1, 1)
hayirBtn.BackgroundTransparency = 0.85
hayirBtn.Text = "Hayir"
hayirBtn.TextColor3 = Color3.new(1, 1, 1)
hayirBtn.TextSize = 13
hayirBtn.Font = Enum.Font.GothamBold
hayirBtn.AutoButtonColor = false
hayirBtn.ZIndex = 201
hayirBtn.Parent = onayFrame
corner(hayirBtn, 8)
addStroke(hayirBtn, 0.7, 1, Color3.new(1, 1, 1))

local KUCUK_W, KUCUK_H = 320, 64
local KUCUK_BTN = isMobile() and 34 or 26

local kucukFrame = Instance.new("Frame")
kucukFrame.Size = UDim2.fromOffset(KUCUK_W, KUCUK_H)
kucukFrame.AnchorPoint = Vector2.new(0.5, 0.5)
kucukFrame.Position = UDim2.fromOffset(0, 0)
kucukFrame.BackgroundColor3 = GLASS_COLOR
kucukFrame.BackgroundTransparency = 0.2
kucukFrame.BorderSizePixel = 0
kucukFrame.Visible = false
kucukFrame.Active = true
kucukFrame.ZIndex = 150
kucukFrame.Parent = gui
corner(kucukFrame, 16)
addStroke(kucukFrame, 0.5, 1, Color3.new(1, 1, 1))

local kucukKapak = Instance.new("ImageLabel")
kucukKapak.Size = UDim2.new(0, 44, 0, 44)
kucukKapak.Position = UDim2.new(0, 10, 0, 10)
kucukKapak.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
kucukKapak.BorderSizePixel = 0
kucukKapak.Image = ""
kucukKapak.ScaleType = Enum.ScaleType.Crop
kucukKapak.ZIndex = 151
kucukKapak.Parent = kucukFrame
corner(kucukKapak, 10)

local kucukAd = Instance.new("TextLabel")
kucukAd.Size = UDim2.new(1, -220, 0, 18)
kucukAd.Position = UDim2.new(0, 62, 0, 12)
kucukAd.BackgroundTransparency = 1
kucukAd.Text = "Sarki sec"
kucukAd.TextColor3 = Color3.new(1, 1, 1)
kucukAd.TextSize = 12
kucukAd.Font = Enum.Font.GothamBold
kucukAd.TextXAlignment = Enum.TextXAlignment.Left
kucukAd.TextTruncate = Enum.TextTruncate.AtEnd
kucukAd.ZIndex = 152
kucukAd.Parent = kucukFrame

local kucukSure = Instance.new("TextLabel")
kucukSure.Size = UDim2.new(0, 110, 0, 14)
kucukSure.Position = UDim2.new(0, 62, 0, 32)
kucukSure.BackgroundTransparency = 1
kucukSure.Text = "0:00 / 0:00"
kucukSure.TextColor3 = Color3.new(1, 1, 1)
kucukSure.TextTransparency = 0.4
kucukSure.TextSize = 10
kucukSure.Font = Enum.Font.Gotham
kucukSure.TextXAlignment = Enum.TextXAlignment.Left
kucukSure.ZIndex = 152
kucukSure.Parent = kucukFrame

local kucukGeri = Instance.new("TextButton")
kucukGeri.Size = UDim2.new(0, KUCUK_BTN, 0, KUCUK_BTN)
kucukGeri.Position = UDim2.new(1, -124, 0.5, -KUCUK_BTN/2)
kucukGeri.AnchorPoint = Vector2.new(0, 0)
kucukGeri.BackgroundColor3 = Color3.new(1, 1, 1)
kucukGeri.BackgroundTransparency = 0.85
kucukGeri.Text = ""
kucukGeri.AutoButtonColor = false
kucukGeri.ZIndex = 152
kucukGeri.Parent = kucukFrame
corner(kucukGeri, KUCUK_BTN/2)
addStroke(kucukGeri, 0.7, 1, Color3.new(1, 1, 1))

local kucukGeriImg = Instance.new("ImageLabel")
kucukGeriImg.Size = UDim2.fromScale(0.5, 0.5)
kucukGeriImg.Position = UDim2.fromScale(0.25, 0.25)
kucukGeriImg.BackgroundTransparency = 1
kucukGeriImg.Image = ""
kucukGeriImg.ScaleType = Enum.ScaleType.Fit
kucukGeriImg.ZIndex = 153
kucukGeriImg.Parent = kucukGeri

local kucukOynat = Instance.new("TextButton")
kucukOynat.Size = UDim2.new(0, KUCUK_BTN + 6, 0, KUCUK_BTN + 6)
kucukOynat.Position = UDim2.new(1, -91, 0.5, -(KUCUK_BTN+6)/2)
kucukOynat.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
kucukOynat.BackgroundTransparency = 0.15
kucukOynat.Text = ""
kucukOynat.AutoButtonColor = false
kucukOynat.ZIndex = 152
kucukOynat.Parent = kucukFrame
corner(kucukOynat, (KUCUK_BTN+6)/2)

local kucukOynatImg = Instance.new("ImageLabel")
kucukOynatImg.Size = UDim2.fromScale(0.6, 0.6)
kucukOynatImg.Position = UDim2.fromScale(0.2, 0.2)
kucukOynatImg.BackgroundTransparency = 1
kucukOynatImg.Image = ""
kucukOynatImg.ScaleType = Enum.ScaleType.Fit
kucukOynatImg.ZIndex = 153
kucukOynatImg.Parent = kucukOynat

local kucukIleri = Instance.new("TextButton")
kucukIleri.Size = UDim2.new(0, KUCUK_BTN, 0, KUCUK_BTN)
kucukIleri.Position = UDim2.new(1, -52, 0.5, -KUCUK_BTN/2)
kucukIleri.BackgroundColor3 = Color3.new(1, 1, 1)
kucukIleri.BackgroundTransparency = 0.85
kucukIleri.Text = ""
kucukIleri.AutoButtonColor = false
kucukIleri.ZIndex = 152
kucukIleri.Parent = kucukFrame
corner(kucukIleri, KUCUK_BTN/2)
addStroke(kucukIleri, 0.7, 1, Color3.new(1, 1, 1))

local kucukIleriImg = Instance.new("ImageLabel")
kucukIleriImg.Size = UDim2.fromScale(0.5, 0.5)
kucukIleriImg.Position = UDim2.fromScale(0.25, 0.25)
kucukIleriImg.BackgroundTransparency = 1
kucukIleriImg.Image = ""
kucukIleriImg.ScaleType = Enum.ScaleType.Fit
kucukIleriImg.ZIndex = 153
kucukIleriImg.Parent = kucukIleri

local kucukBuyut = Instance.new("TextButton")
kucukBuyut.Size = UDim2.new(0, 30, 0, 30)
kucukBuyut.Position = UDim2.new(1, -22, 0, -8)
kucukBuyut.BackgroundColor3 = Color3.new(1, 1, 1)
kucukBuyut.BackgroundTransparency = 0.85
kucukBuyut.Text = ""
kucukBuyut.AutoButtonColor = false
kucukBuyut.ZIndex = 160
kucukBuyut.Parent = kucukFrame
corner(kucukBuyut, 10)
addStroke(kucukBuyut, 0.7, 1, Color3.new(1, 1, 1))

local kucukBuyutImg = Instance.new("ImageLabel")
kucukBuyutImg.Size = UDim2.fromScale(0.6, 0.6)
kucukBuyutImg.Position = UDim2.fromScale(0.2, 0.2)
kucukBuyutImg.BackgroundTransparency = 1
kucukBuyutImg.Image = ""
kucukBuyutImg.ScaleType = Enum.ScaleType.Fit
kucukBuyutImg.ZIndex = 161
kucukBuyutImg.Parent = kucukBuyut

local kucukProg = Instance.new("Frame")
kucukProg.Size = UDim2.new(1, -20, 0, 3)
kucukProg.Position = UDim2.new(0, 10, 1, -5)
kucukProg.BackgroundColor3 = Color3.new(1, 1, 1)
kucukProg.BackgroundTransparency = 0.8
kucukProg.BorderSizePixel = 0
kucukProg.ZIndex = 151
kucukProg.Parent = kucukFrame
corner(kucukProg, 2)

local kucukProgDolu = Instance.new("Frame")
kucukProgDolu.Size = UDim2.new(0, 0, 1, 0)
kucukProgDolu.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
kucukProgDolu.BorderSizePixel = 0
kucukProgDolu.ZIndex = 152
kucukProgDolu.Parent = kucukProg
corner(kucukProgDolu, 2)

local function oynatDurumGuncelle()
	if not oynatBtn or not sarkiDurum then return end
	if caliyor then
		sarkiDurum.Text = "Caliyor"
		local oynatImg = oynatBtn:FindFirstChild("Img") :: ImageLabel?
		local pauseAsset = oynatBtn:GetAttribute("PauseAsset")
		if oynatImg and type(pauseAsset) == "string" and pauseAsset ~= "" then
			oynatImg.Image = pauseAsset
		end
		if kucultulmus and kucukOynatImg then
			if type(pauseAsset) == "string" and pauseAsset ~= "" then
				kucukOynatImg.Image = pauseAsset
			end
		end
	else
		sarkiDurum.Text = "Duraklatildi"
		local oynatImg = oynatBtn:FindFirstChild("Img") :: ImageLabel?
		local playAsset = logoAssets["play"]
		if oynatImg and playAsset then oynatImg.Image = playAsset end
		if kucultulmus and kucukOynatImg then
			kucukOynatImg.Image = logoAssets["play"] or ""
		end
	end
end

local function sarkiDegistir(yeni: number)
	if not sarkiIndir(yeni) then
		if sarkiDurum then sarkiDurum.Text = "Indirme basarisiz" end
		return
	end
	local asset = sarkiAsset(yeni)
	if not asset then
		if sarkiDurum then sarkiDurum.Text = "Ses formati desteklenmiyor" end
		return
	end

	if not sound then
		sound = Instance.new("Sound")
		sound.Name = "EnesPanelMuzik"
		sound.Volume = sesSeviyesi
		sound.Looped = false
		sound.Parent = SoundService
	end

	sound:Stop()
	sound.SoundId = asset
	local ok = pcall(function() sound:Play() end)
	if ok then
		caliyor = true
		aktifIndex = yeni
		sarkiBitti = false

		if sarkiAd then sarkiAd.Text = SARKILAR[yeni].ad end
		if sarkiDurum then sarkiDurum.Text = "Caliyor" end

		local imgAsset = gorselIndir(SARKILAR[yeni].gorsel, SARKILAR[yeni].gorselAd)
		if imgAsset then
			if kapakImg then kapakImg.Image = imgAsset end
			if kucukKapak then kucukKapak.Image = imgAsset end
			if kapakPlaceholder then kapakPlaceholder.Visible = false end
		end

		if kucukAd then kucukAd.Text = SARKILAR[yeni].ad end
		satirSec(yeni)
		oynatDurumGuncelle()
	end
end

for i, sarki in ipairs(SARKILAR) do
	local satir = Instance.new("TextButton")
	satir.Name = "Sarki" .. i
	satir.Size = UDim2.new(1, -6, 0, 52)
	satir.BackgroundColor3 = Color3.new(1, 1, 1)
	satir.BackgroundTransparency = 0.85
	satir.Text = ""
	satir.AutoButtonColor = false
	satir.ZIndex = 12
	satir.Parent = scroll
	corner(satir, 10)
	addStroke(satir, 0.8, 1, Color3.new(1, 1, 1))

	local gorsel = Instance.new("ImageLabel")
	gorsel.Size = UDim2.new(0, 40, 0, 40)
	gorsel.Position = UDim2.new(0, 6, 0, 6)
	gorsel.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	gorsel.BorderSizePixel = 0
	gorsel.Image = ""
	gorsel.ScaleType = Enum.ScaleType.Crop
	gorsel.ZIndex = 13
	gorsel.Parent = satir
	corner(gorsel, 8)

	task.spawn(function()
		local imgAsset = gorselIndir(sarki.gorsel, sarki.gorselAd)
		if imgAsset then gorsel.Image = imgAsset end
	end)

	local adLabel = Instance.new("TextLabel")
	adLabel.Size = UDim2.new(1, -90, 0, 28)
	adLabel.Position = UDim2.new(0, 54, 0, 6)
	adLabel.BackgroundTransparency = 1
	adLabel.Text = sarki.ad
	adLabel.TextColor3 = Color3.new(1, 1, 1)
	adLabel.TextSize = 13
	adLabel.Font = Enum.Font.GothamSemibold
	adLabel.TextXAlignment = Enum.TextXAlignment.Left
	adLabel.TextTruncate = Enum.TextTruncate.AtEnd
	adLabel.ZIndex = 13
	adLabel.Parent = satir

	local altLabel = Instance.new("TextLabel")
	altLabel.Size = UDim2.new(1, -90, 0, 14)
	altLabel.Position = UDim2.new(0, 54, 0, 30)
	altLabel.BackgroundTransparency = 1
	altLabel.Text = "Neck Hurt Mix"
	altLabel.TextColor3 = Color3.new(1, 1, 1)
	altLabel.TextTransparency = 0.5
	altLabel.TextSize = 10
	altLabel.Font = Enum.Font.Gotham
	altLabel.TextXAlignment = Enum.TextXAlignment.Left
	altLabel.ZIndex = 13
	altLabel.Parent = satir

	local calIkon = Instance.new("ImageLabel")
	calIkon.Size = UDim2.new(0, 18, 0, 18)
	calIkon.Position = UDim2.new(1, -28, 0, 17)
	calIkon.BackgroundTransparency = 1
	calIkon.Image = logoAssets["chevron"] or ""
	calIkon.ImageColor3 = Color3.new(1, 1, 1)
	calIkon.ImageTransparency = 0.3
	calIkon.ZIndex = 13
	calIkon.Parent = satir

	satirlar[i] = {satir = satir, adLabel = adLabel, calIkon = calIkon}

	satir.MouseButton1Click:Connect(function()
		if justDragged or onayAcik then return end
		sarkiDurum.Text = "Yukleniyor..."
		task.spawn(function()
			if not sarkiIndir(i) then
				sarkiDurum.Text = "Indirme basarisiz"
				return
			end
			local asset = sarkiAsset(i)
			if not asset then
				sarkiDurum.Text = "Ses formati desteklenmiyor"
				return
			end
			if not sound then
				sound = Instance.new("Sound")
				sound.Name = "EnesPanelMuzik"
				sound.Volume = sesSeviyesi
				sound.Looped = false
				sound.Parent = SoundService
			end
			sound:Stop()
			sound.SoundId = asset
			local ok = pcall(function() sound:Play() end)
			if ok then
				caliyor = true
				aktifIndex = i
				sarkiBitti = false
				sarkiAd.Text = sarki.ad
				sarkiDurum.Text = "Caliyor"

				local imgAsset = gorselIndir(sarki.gorsel, sarki.gorselAd)
				if imgAsset then
					kapakImg.Image = imgAsset
					kucukKapak.Image = imgAsset
					kapakPlaceholder.Visible = false
				end
				kucukAd.Text = sarki.ad

				satirSec(i)
				oynatDurumGuncelle()
			else
				sarkiDurum.Text = "Play hatasi"
			end
		end)
	end)
end

listeLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0, 0, 0, listeLayout.AbsoluteContentSize.Y + 20)
end)

local btnScales: {[GuiObject]: {cur: number, vel: number}} = {}

local function btnJellyBasla(btn: GuiObject)
	if btnScales[btn] then return end
	btnScales[btn] = {cur = 1.0, vel = 0}

	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local s = btnScales[btn]
			if s then s.vel = s.vel + 6 end
		end
	end)
end

for _, b in ipairs({kucultBtn, kapatBtn, geriBtn, oynatBtn, ileriBtn, kucukBuyut, kucukOynat, kucukGeri, kucukIleri}) do
	btnJellyBasla(b)
end

local function openPanel()
	if isAnimating or isOpen then return end
	isAnimating = true

	local tx, ty
	if savedCx then
		tx, ty = clampPanelPos(savedCx, savedCy :: number)
	else
		tx, ty = getCenterPos()
		tx, ty = clampPanelPos(tx, ty)
	end
	local bx, by = getButtonPos()

	panelCx, panelCy = bx, by
	applyPanelPos()
	wrapper.Size = UDim2.fromOffset(0, 0)
	wrapper.Visible = true
	content.GroupTransparency = 1

	barCx, barCy = bx, by
	homeBar.Size = UDim2.fromOffset(0, 0)
	homeBar.BackgroundTransparency = 1
	homeBar.Visible = true
	applyBarPos()

	mode = "panel"
	dragging = nil

	local panelTween = TweenService:Create(
		wrapper,
		TweenInfo.new(OPEN_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Size = PANEL_SIZE, Position = UDim2.fromOffset(tx, ty) }
	)
	panelTween:Play()

	local barTargetCx = tx
	local barTargetCy = ty + BAR_DY
	TweenService:Create(
		homeBar,
		TweenInfo.new(OPEN_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{
			Size = UDim2.fromOffset(HOME_BAR_W, HOME_BAR_H),
			Position = UDim2.fromOffset(barTargetCx, barTargetCy),
			BackgroundTransparency = HOME_BAR_TRANSP,
		}
	):Play()

	task.delay(0.15, function()
		TweenService:Create(content,
			TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ GroupTransparency = 0 }):Play()
	end)

	TweenService:Create(icon, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Rotation = 45 }):Play()

	panelTween.Completed:Wait()

	panelCx, panelCy = tx, ty
	barCx,   barCy   = barTargetCx, barTargetCy
	applyPanelPos()
	applyBarPos()

	isAnimating = false
	isOpen = true
end

local function closePanel()
	if isAnimating or not isOpen then return end
	isAnimating = true
	dragging = nil

	TweenService:Create(content,
		TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ GroupTransparency = 1 }):Play()

	TweenService:Create(icon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Rotation = 0 }):Play()

	local bx, by = getButtonPos()

	local panelTween = TweenService:Create(
		wrapper,
		TweenInfo.new(CLOSE_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{ Size = UDim2.fromOffset(0, 0), Position = UDim2.fromOffset(bx, by) }
	)
	panelTween:Play()

	TweenService:Create(
		homeBar,
		TweenInfo.new(CLOSE_TIME, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{
			Size = UDim2.fromOffset(0, 0),
			Position = UDim2.fromOffset(bx, by),
			BackgroundTransparency = 1,
		}
	):Play()

	panelTween.Completed:Wait()

	wrapper.Visible = false
	homeBar.Visible = false
	isAnimating = false
	isOpen = false
end

toggle.MouseButton1Click:Connect(function()
	if isOpen then closePanel() else openPanel() end
end)

kapatBtn.MouseButton1Click:Connect(function()
	if not isOpen then return end
	onayAcik = true
	onayFrame.Visible = true
end)

evetBtn.MouseButton1Click:Connect(function()
	onayAcik = false
	onayFrame.Visible = false

	if sound then
		pcall(function() sound:Stop() end)
		pcall(function() sound:Destroy() end)
		sound = nil
	end
	caliyor = false

	if wrapper then wrapper:Destroy() end
	if homeBar then homeBar:Destroy() end
	if kucukFrame then kucukFrame:Destroy() end
	if toggle then toggle:Destroy() end
	if onayFrame then onayFrame:Destroy() end
	if gui then gui:Destroy() end
end)

hayirBtn.MouseButton1Click:Connect(function()
	onayAcik = false
	onayFrame.Visible = false
end)

kucultBtn.MouseButton1Click:Connect(function()
	if not isOpen or isAnimating then return end
	kucultulmus = true

	TweenService:Create(wrapper, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Size = UDim2.fromOffset(0, 0)
	}):Play()

	TweenService:Create(homeBar, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Size = UDim2.fromOffset(0, 0),
		BackgroundTransparency = 1
	}):Play()

	task.delay(0.4, function()
		wrapper.Visible = false
		homeBar.Visible = false

		kucukFrame.Visible = true
		local sx, sy = clampSmallPos(panelCx, panelCy)
		kucukFrame.Position = UDim2.fromOffset(sx, sy)

		kucukAd.Text = (aktifIndex and SARKILAR[aktifIndex].ad) or "Sarki sec"
		if aktifIndex then
			local imgAsset = gorselIndir(SARKILAR[aktifIndex].gorsel, SARKILAR[aktifIndex].gorselAd)
			if imgAsset then kucukKapak.Image = imgAsset end
		end
		if caliyor then
			local pauseAsset = oynatBtn:GetAttribute("PauseAsset")
			if type(pauseAsset) == "string" and pauseAsset ~= "" then kucukOynatImg.Image = pauseAsset end
		else
			kucukOynatImg.Image = logoAssets["play"] or ""
		end
		kucukGeriImg.Image = logoAssets["previous"] or ""
		kucukIleriImg.Image = logoAssets["next"] or ""
		kucukBuyutImg.Image = logoAssets["expand"] or ""

		kucukFrame.Size = UDim2.fromOffset(0, 0)
		TweenService:Create(kucukFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(KUCUK_W, KUCUK_H)
		}):Play()
	end)
end)

kucukBuyut.MouseButton1Click:Connect(function()
	if not kucultulmus then return end
	kucultulmus = false

	TweenService:Create(kucukFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Size = UDim2.fromOffset(0, 0)
	}):Play()

	task.delay(0.3, function()
		kucukFrame.Visible = false
		wrapper.Visible = true
		homeBar.Visible = true

		local cx, cy = clampPanelPos(kucukFrame.Position.X.Offset, kucukFrame.Position.Y.Offset)
		panelCx, panelCy = cx, cy
		applyPanelPos()

		barCx = panelCx
		barCy = panelCy + BAR_DY
		applyBarPos()

		wrapper.Size = UDim2.fromOffset(0, 0)
		TweenService:Create(wrapper, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = PANEL_SIZE
		}):Play()

		homeBar.Size = UDim2.fromOffset(0, 0)
		TweenService:Create(homeBar, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(HOME_BAR_W, HOME_BAR_H),
			BackgroundTransparency = HOME_BAR_TRANSP
		}):Play()
	end)
end)

kucukOynat.MouseButton1Click:Connect(function()
	if not sound or not aktifIndex then return end
	if caliyor then
		pcall(function() sound:Pause() end)
		caliyor = false
	else
		local ok = pcall(function() sound:Resume() end)
		if ok then caliyor = true end
	end
	oynatDurumGuncelle()
end)

kucukGeri.MouseButton1Click:Connect(function()
	if not aktifIndex then return end
	local yeni = aktifIndex - 1
	if yeni < 1 then yeni = #SARKILAR end
	task.spawn(function() sarkiDegistir(yeni) end)
end)

kucukIleri.MouseButton1Click:Connect(function()
	if not aktifIndex then return end
	local yeni = aktifIndex + 1
	if yeni > #SARKILAR then yeni = 1 end
	task.spawn(function() sarkiDegistir(yeni) end)
end)

oynatBtn.MouseButton1Click:Connect(function()
	if not sound or not aktifIndex then return end
	if caliyor then
		pcall(function() sound:Pause() end)
		caliyor = false
	else
		local ok = pcall(function() sound:Resume() end)
		if ok then caliyor = true end
	end
	oynatDurumGuncelle()
end)

geriBtn.MouseButton1Click:Connect(function()
	if not aktifIndex then return end
	local yeni = aktifIndex - 1
	if yeni < 1 then yeni = #SARKILAR end
	task.spawn(function() sarkiDegistir(yeni) end)
end)

ileriBtn.MouseButton1Click:Connect(function()
	if not aktifIndex then return end
	local yeni = aktifIndex + 1
	if yeni > #SARKILAR then yeni = 1 end
	task.spawn(function() sarkiDegistir(yeni) end)
end)

local function pointInFrame(pos: Vector2, frame: GuiObject): boolean
	local p = frame.AbsolutePosition
	local s = frame.AbsoluteSize
	return pos.X >= p.X and pos.X <= p.X + s.X
		and pos.Y >= p.Y and pos.Y <= p.Y + s.Y
end

local function pointNearHomeBar(pos: Vector2): boolean
	if not homeBar.Visible then return false end
	local p = homeBar.AbsolutePosition
	local s = homeBar.AbsoluteSize
	local padX, padY = 20, 14
	return pos.X >= p.X - padX and pos.X <= p.X + s.X + padX
		and pos.Y >= p.Y - padY and pos.Y <= p.Y + s.Y + padY
end

local function isOnInteractiveElement(pos: Vector2): boolean
	if pointInFrame(pos, oynatBtn) or pointInFrame(pos, geriBtn) or pointInFrame(pos, ileriBtn) then return true end
	if pointInFrame(pos, kucultBtn) or pointInFrame(pos, kapatBtn) then return true end
	if pointInFrame(pos, sesTutucu) then return true end
	if pointInFrame(pos, scroll) then return true end
	return false
end

local dragStartInput: Vector2? = nil
local dragStartPanel: {cx: number, cy: number}? = nil
local dragStartBar: {cx: number, cy: number}? = nil
local dragPending     = false
local pendingTarget: string? = nil

local kucukDragStart: Vector2? = nil
local kucukDragPos: {cx: number, cy: number}? = nil

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then return end
	if onayAcik then return end

	if kucultulmus and pointInFrame(input.Position, kucukFrame) then
		if pointInFrame(input.Position, kucukOynat) or
		   pointInFrame(input.Position, kucukGeri) or
		   pointInFrame(input.Position, kucukIleri) or
		   pointInFrame(input.Position, kucukBuyut) then
			return
		end

		kucukDragStart = input.Position
		kucukDragPos = {cx = kucukFrame.Position.X.Offset, cy = kucukFrame.Position.Y.Offset}
		return
	end

	if not isOpen or isAnimating then return end

	if pointNearHomeBar(input.Position) then
		dragPending    = true
		pendingTarget  = "bar"
		dragStartInput = input.Position
		dragStartBar   = { cx = barCx, cy = barCy }
		return
	end

	if pointInFrame(input.Position, wrapper) then
		if isOnInteractiveElement(input.Position) then return end

		panelCx = math.floor(panelCx + 0.5)
		panelCy = math.floor(panelCy + 0.5)
		dragPending    = true
		pendingTarget  = "panel"
		dragStartInput = input.Position
		dragStartPanel = { cx = panelCx, cy = panelCy }
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseMovement
		and input.UserInputType ~= Enum.UserInputType.Touch then return end

	if kucukDragStart and kucukDragPos then
		local d = input.Position - kucukDragStart
		local ncx, ncy = clampSmallPos(kucukDragPos.cx + d.X, kucukDragPos.cy + d.Y)
		kucukFrame.Position = UDim2.fromOffset(ncx, ncy)
		return
	end

	if not isOpen or isAnimating or onayAcik then return end

	if dragPending and dragging == nil and dragStartInput then
		local d = input.Position - dragStartInput
		if math.abs(d.X) + math.abs(d.Y) >= DRAG_THRESHOLD then
			dragging = pendingTarget
			mode = pendingTarget :: string
		end
	end

	if dragging == "panel" and dragStartInput and dragStartPanel then
		local d = input.Position - dragStartInput
		local ncx, ncy = clampPanelPos(dragStartPanel.cx + d.X, dragStartPanel.cy + d.Y)
		panelCx, panelCy = ncx, ncy
		applyPanelPos()
	elseif dragging == "bar" and dragStartInput and dragStartBar then
		local d = input.Position - dragStartInput
		local ncx, ncy = clampBarPos(dragStartBar.cx + d.X, dragStartBar.cy + d.Y)
		barCx, barCy = ncx, ncy
		applyBarPos()
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then return end

	if kucukDragStart then
		kucukDragStart = nil
		kucukDragPos = nil
		return
	end

	if dragging then
		justDragged = true
		task.delay(0.08, function() justDragged = false end)
		savedCx, savedCy = panelCx, panelCy
	end

	dragging       = nil
	dragPending    = false
	pendingTarget  = nil
	dragStartInput = nil
	dragStartPanel = nil
	dragStartBar   = nil
end)

local sesSurukleniyor = false

local function sesGuncelle(gx: number)
	local rel = math.clamp((gx - sesArka.AbsolutePosition.X) / math.max(1, sesArka.AbsoluteSize.X), 0, 1)
	sesDolu.Size = UDim2.new(rel, 0, 1, 0)
	sesSeviyesi = rel
	if sound then sound.Volume = rel end
	sesYazi.Text = math.floor(rel * 100) .. "%"
end

sesTutucu.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sesSurukleniyor = true
		sesGuncelle(input.Position.X)
	end
end)

sesArka.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sesSurukleniyor = true
		sesGuncelle(input.Position.X)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not sesSurukleniyor then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		sesGuncelle(input.Position.X)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		sesSurukleniyor = false
	end
end)

RunService.RenderStepped:Connect(function(dt)
	local dtC = math.min(dt, 1/30)

	for btn, s in pairs(btnScales) do
		if math.abs(s.cur - 1.0) < 0.001 and math.abs(s.vel) < 0.01 then
			continue
		end
		s.cur, s.vel = spring(s.cur, s.vel, 1.0, SCALE_STIFF, SCALE_DAMP, dtC, 0.004, 0.10)
		local yeni = math.max(0.4, s.cur)
		local temelBoyut = btn:GetAttribute("TemelBoyut")
		if not temelBoyut then
			temelBoyut = btn.Size.X.Offset
			btn:SetAttribute("TemelBoyut", temelBoyut)
		end
		btn.Size = UDim2.fromOffset(temelBoyut * yeni, temelBoyut * yeni)
	end

	if sound then
		local gecen, toplam = 0, 0
		pcall(function()
			gecen = sound.TimePosition or 0
			toplam = sound.TimeLength or 0
		end)
		if toplam > 0 then
			local oran = math.clamp(gecen / toplam, 0, 1)
			if progDolu then progDolu.Size = UDim2.new(oran, 0, 1, 0) end
			if kucukProgDolu then kucukProgDolu.Size = UDim2.new(oran, 0, 1, 0) end
			if gecenSure then gecenSure.Text = formatSure(gecen) end
			if toplamSure then toplamSure.Text = formatSure(toplam) end
			if kucukSure then kucukSure.Text = formatSure(gecen) .. " / " .. formatSure(toplam) end
		end

		if caliyor and toplam > 0 and gecen >= (toplam - 1) and not sarkiBitti then
			sarkiBitti = true
			if aktifIndex and aktifIndex < #SARKILAR then
				local yeni = aktifIndex + 1
				task.spawn(function() sarkiDegistir(yeni) end)
			else
				pcall(function() sound:Stop() end)
				caliyor = false
				oynatDurumGuncelle()
			end
		end
	end

	if not isOpen or isAnimating then return end
	if not homeBar.Visible then return end

	if mode == "panel" then
		local tgtX = panelCx
		local tgtY = panelCy + BAR_DY
		local a = math.min(1, dt * HOME_LERP)
		barCx = barCx + (tgtX - barCx) * a
		barCy = barCy + (tgtY - barCy) * a
		applyBarPos()
	else
		local tgtX = barCx
		local tgtY = barCy - BAR_DY
		local a = math.min(1, dt * PANEL_LERP)
		local newCx = panelCx + (tgtX - panelCx) * a
		local newCy = panelCy + (tgtY - panelCy) * a
		panelCx, panelCy = clampPanelPos(newCx, newCy)
		applyPanelPos()
	end
end)

task.spawn(function()
	local kalan = #SARKILAR
	for i = 1, #SARKILAR do
		task.spawn(function()
			sarkiIndir(i)
			kalan = kalan - 1
			if kalan <= 0 then
				sarkiDurum.Text = #SARKILAR .. "/" .. #SARKILAR .. " sarki hazir"
			end
		end)
	end
end)
