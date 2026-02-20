-- Amın oglu Aimbot

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
local LocalPlayer = Players.LocalPlayer

StarterGui:SetCore("SendNotification", {
    Title = "Aimbot Aktif";
    Text = "Fare2 ile basılı tutup kontrol et";
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
local loop = nil

local function getClosest(cframe)
    local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
    local target = nil
    local mag = math.huge
    local screenCenter = workspace.CurrentCamera.ViewportSize / 2

    for i, v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild(lockPart) and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and (v.Team ~= LocalPlayer.Team or (not teamCheck)) then
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
    -- Kamera boyutu değişirse güncelle
    if workspace.CurrentCamera then
        FOVring.Position = workspace.CurrentCamera.ViewportSize / 2
    end
end

local function highlightTarget(target)
    if highlightEnabled and target and target.Character then
        if not target.Character:FindFirstChildOfClass("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = target.Character
            highlight.FillColor = Color3.fromRGB(100, 200, 255)
            highlight.OutlineColor = Color3.fromRGB(150, 220, 255)
            highlight.Parent = target.Character
        end
    end
end

local function removeHighlight(target)
    if highlightEnabled and target and target.Character then
        local h = target.Character:FindFirstChildOfClass("Highlight")
        if h then h:Destroy() end
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

-- Ana loop
loop = RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        updateFOVRing()

        local localChar = LocalPlayer.Character
        local cam = workspace.CurrentCamera
        if not cam then return end
        local screenCenter = cam.ViewportSize / 2

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


local function cleanup()
    if loop then
        loop:Disconnect()
    end
    if FOVring and FOVring.Remove then
        pcall(function() FOVring:Remove() end)
    end
end

game:BindToClose(cleanup)

