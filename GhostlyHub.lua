-- Ghostly Hub - Anti-Cheat UI Test
-- For testing in your own Roblox experience.
-- This is a standalone UI; it does not download or execute third-party scripts.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then
    warn("[Ghostly Hub] LocalPlayer unavailable.")
    return
end

local playerGui = player:WaitForChild("PlayerGui")

local existing = playerGui:FindFirstChild("GhostlyHubTest")
if existing then
    existing:Destroy()
end

local purple = Color3.fromRGB(138, 43, 226)
local dark = Color3.fromRGB(15, 15, 18)
local panel = Color3.fromRGB(27, 27, 33)
local white = Color3.fromRGB(240, 240, 245)

local gui = Instance.new("ScreenGui")
gui.Name = "GhostlyHubTest"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Name = "Main"
frame.Size = UDim2.fromOffset(360, 300)
frame.Position = UDim2.new(0.5, -180, 0.5, -150)
frame.BackgroundColor3 = dark
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = purple
stroke.Thickness = 1.5
stroke.Parent = frame

local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -24, 0, 42)
header.Position = UDim2.fromOffset(12, 5)
header.BackgroundTransparency = 1
header.Font = Enum.Font.GothamBold
header.Text = "Ghostly Hub  |  Anti-Cheat Test"
header.TextColor3 = white
header.TextSize = 16
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -24, 0, 38)
status.Position = UDim2.fromOffset(12, 48)
status.BackgroundColor3 = panel
status.BorderSizePixel = 0
status.Font = Enum.Font.Gotham
status.Text = "Ready — choose a test below."
status.TextColor3 = white
status.TextSize = 12
status.TextWrapped = true
status.Parent = frame
Instance.new("UICorner", status).CornerRadius = UDim.new(0, 6)

local function makeButton(text, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -24, 0, 38)
    button.Position = UDim2.fromOffset(12, y)
    button.BackgroundColor3 = panel
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextColor3 = white
    button.TextSize = 13
    button.AutoButtonColor = true
    button.Parent = frame
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

    local line = Instance.new("UIStroke")
    line.Color = purple
    line.Thickness = 1
    line.Transparency = 0.35
    line.Parent = button

    button.Activated:Connect(callback)
    return button
end

makeButton("Check character / Humanoid", 96, function()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        status.Text = ("Character found | WalkSpeed: %s | Health: %s"):format(
            tostring(humanoid.WalkSpeed),
            tostring(math.floor(humanoid.Health))
        )
    else
        status.Text = "No character or Humanoid found."
    end
end)

makeButton("Respawn character", 142, function()
    status.Text = "Requesting character respawn..."
    local ok, err = pcall(function()
        player:LoadCharacter()
    end)
    status.Text = ok and "Respawn requested." or ("Respawn failed: " .. tostring(err))
end)

makeButton("Restore local WalkSpeed to 16", 188, function()
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        status.Text = "Local WalkSpeed set to 16. Verify server-side enforcement."
    else
        status.Text = "No Humanoid found."
    end
end)

local close = makeButton("Close", 234, function()
    gui:Destroy()
end)
close.BackgroundColor3 = Color3.fromRGB(55, 25, 65)

print("[Ghostly Hub] Anti-cheat test UI loaded.")
