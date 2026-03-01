-- Amınoglu Aimbot

local teamCheck = false
local fov = 90
local smoothing = 1
local predictionFactor = 0.08
local highlightEnabled = false
local lockPart = "Head"

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer


local AimbotToggleKey = Enum.KeyCode.X
local aimbotEnabled = false

StarterGui:SetCore("SendNotification", {
    Title = "En3s_xs";
    Text = "X ile Aimbot Aç/Kapa";
    Duration = 4;
})


local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 1
FOVring.Radius = fov
FOVring.Transparency = 0.8
FOVring.Color = Color3.fromRGB(100, 200, 255)
FOVring.Position = workspace.CurrentCamera.ViewportSize / 2

local currentTarget = nil
local debounce = false



UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == AimbotToggleKey then
        aimbotEnabled = not aimbotEnabled
        
        FOVring.Visible = aimbotEnabled
        currentTarget = nil
        
        StarterGui:SetCore("SendNotification", {
            Title = "En3s_xs",
            Text = aimbotEnabled and "Aimbot Açıldı (X)" or "Aimbot Kapatıldı (X)",
            Duration = 2;
        })
    end
end)



local function getClosest(cframe)
    local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
    local target = nil
    local mag = math.huge
    local screenCenter = workspace.CurrentCamera.ViewportSize / 2

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer
        and v.Character
        and v.Character:FindFirstChild(lockPart)
        and v.Character:FindFirstChild("HumanoidRootPart")
        and (v.Team ~= LocalPlayer.Team or not teamCheck) then

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



local function predictPosition(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local velocity = target.Character.HumanoidRootPart.Velocity
        local position = target.Character[lockPart].Position
        return position + (velocity * predictionFactor)
    end
    return nil
end



RunService.RenderStepped:Connect(function()
    if not aimbotEnabled then return end
    
    local cam = workspace.CurrentCamera
    if not cam then return end
    
    FOVring.Position = cam.ViewportSize / 2
    
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        
        if not currentTarget then
            currentTarget = getClosest(cam.CFrame)
        end
        
        if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild(lockPart) then
            local predictedPosition = predictPosition(currentTarget)
            
            if predictedPosition then
                cam.CFrame = cam.CFrame:Lerp(
                    CFrame.new(cam.CFrame.Position, predictedPosition),
                    smoothing
                )
            end
            
            FOVring.Color = Color3.fromRGB(0, 255, 100)
        end
        
    else
        currentTarget = nil
        FOVring.Color = Color3.fromRGB(100, 200, 255)
    end
end)
