

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local espEnabled = false
local highlights = {}

local function addESP(character, targetPlayer)
	if highlights[character] then return end
	
	local highlight = Instance.new("Highlight")
	highlight.Name = "TeamColorESP"
	highlight.OutlineColor = Color3.new(1,1,1)
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = character
	
	highlights[character] = highlight
end

local function removeESP(character)
	if highlights[character] then
		highlights[character]:Destroy()
		highlights[character] = nil
	end
end

local function updateESP()
	for _, targetPlayer in pairs(Players:GetPlayers()) do
		if targetPlayer ~= player and targetPlayer.Character then
			
			if espEnabled then
				
				addESP(targetPlayer.Character, targetPlayer)
				
				local highlight = highlights[targetPlayer.Character]
				
				if highlight then
					if targetPlayer.Team then
						highlight.FillColor = targetPlayer.Team.TeamColor.Color
					else
						highlight.FillColor = Color3.fromRGB(255,255,255)
					end
				end
				
			else
				removeESP(targetPlayer.Character)
			end
			
		end
	end
end

-- Z
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	
	if input.KeyCode == Enum.KeyCode.Z then
		espEnabled = not espEnabled
		updateESP()
	end
end)


RunService.RenderStepped:Connect(function()
	if espEnabled then
		updateESP()
	end
end)
