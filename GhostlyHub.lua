-- Ghostly Hub - dark, draggable UI with animated startup
-- For use in your own Roblox experience / Studio testing.
-- This file builds the UI locally and does not download or execute exploit scripts.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not player then
    warn("[Ghostly Hub] LocalPlayer unavailable.")
    return
end

local playerGui = player:WaitForChild("PlayerGui")
local old = playerGui:FindFirstChild("GhostlyHub")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(14, 14, 15),
    panel = Color3.fromRGB(20, 20, 21),
    panel2 = Color3.fromRGB(27, 27, 29),
    hover = Color3.fromRGB(36, 36, 39),
    line = Color3.fromRGB(48, 48, 51),
    text = Color3.fromRGB(235, 235, 238),
    muted = Color3.fromRGB(145, 145, 151),
    purple = Color3.fromRGB(139, 92, 246),
    purpleDark = Color3.fromRGB(84, 49, 153),
}

local function new(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function corner(parent, radius)
    new("UICorner", {CornerRadius = UDim.new(0, radius or 7)}, parent)
end

local function stroke(parent, color, thickness, transparency)
    return new("UIStroke", {
        Color = color or C.line,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, parent)
end

local gui = new("ScreenGui", {
    Name = "GhostlyHub",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

-- Animated startup overlay
local intro = new("Frame", {
    Name = "Intro",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = C.bg,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    ZIndex = 50,
}, gui)

local introTitle = new("TextLabel", {
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.44),
    Size = UDim2.fromOffset(360, 58),
    Font = Enum.Font.GothamBold,
    Text = "GHOSTLY",
    TextColor3 = C.text,
    TextSize = 32,
    TextTransparency = 1,
    ZIndex = 51,
}, intro)

local introSub = new("TextLabel", {
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.51),
    Size = UDim2.fromOffset(360, 25),
    Font = Enum.Font.Gotham,
    Text = "INITIALIZING HUB",
    TextColor3 = C.purple,
    TextSize = 11,
    TextTransparency = 1,
    ZIndex = 51,
}, intro)

local barBack = new("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.57),
    Size = UDim2.fromOffset(220, 3),
    BackgroundColor3 = C.line,
    BorderSizePixel = 0,
    ZIndex = 51,
}, intro)
corner(barBack, 3)

local bar = new("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = C.purple,
    BorderSizePixel = 0,
    ZIndex = 52,
}, barBack)
corner(bar, 3)

-- Main window
local main = new("Frame", {
    Name = "Window",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.53),
    Size = UDim2.fromOffset(650, 405),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
    Visible = false,
    ClipsDescendants = true,
}, gui)
corner(main, 10)
stroke(main, Color3.fromRGB(57, 57, 61), 1, 0.15)

local top = new("Frame", {
    Name = "Topbar",
    Size = UDim2.new(1, 0, 0, 43),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, main)
new("Frame", {
    Position = UDim2.new(0, 0, 1, -1),
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = C.line,
    BorderSizePixel = 0,
}, top)

for i, color in ipairs({
    Color3.fromRGB(239, 91, 91),
    Color3.fromRGB(238, 187, 82),
    Color3.fromRGB(100, 205, 132),
}) do
    local dot = new("Frame", {
        Position = UDim2.fromOffset(13 + (i - 1) * 13, 16),
        Size = UDim2.fromOffset(7, 7),
        BackgroundColor3 = color,
        BorderSizePixel = 0,
    }, top)
    corner(dot, 10)
end

new("TextLabel", {
    Position = UDim2.fromOffset(62, 0),
    Size = UDim2.fromOffset(200, 43),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "ghostly",
    TextColor3 = C.text,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
}, top)

new("TextLabel", {
    Position = UDim2.new(1, -145, 0, 0),
    Size = UDim2.fromOffset(105, 43),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "v1.0.0  •  BETA",
    TextColor3 = C.muted,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Right,
}, top)

local minimize = new("TextButton", {
    Position = UDim2.new(1, -35, 0, 8),
    Size = UDim2.fromOffset(24, 26),
    BackgroundColor3 = C.panel2,
    BorderSizePixel = 0,
    Font = Enum.Font.GothamBold,
    Text = "—",
    TextColor3 = C.text,
    TextSize = 13,
    AutoButtonColor = true,
}, top)
corner(minimize, 5)

local sidebar = new("Frame", {
    Position = UDim2.fromOffset(0, 43),
    Size = UDim2.new(0, 158, 1, -43),
    BackgroundColor3 = C.panel,
    BorderSizePixel = 0,
}, main)
new("Frame", {
    Position = UDim2.new(1, -1, 0, 0),
    Size = UDim2.new(0, 1, 1, 0),
    BackgroundColor3 = C.line,
    BorderSizePixel = 0,
}, sidebar)

new("TextLabel", {
    Position = UDim2.fromOffset(17, 15),
    Size = UDim2.new(1, -28, 0, 18),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    Text = "GHOSTLY HUB",
    TextColor3 = C.muted,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, sidebar)

local nav = new("Frame", {
    Position = UDim2.fromOffset(9, 45),
    Size = UDim2.new(1, -18, 1, -55),
    BackgroundTransparency = 1,
}, sidebar)
new("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, nav)

local content = new("Frame", {
    Position = UDim2.fromOffset(159, 43),
    Size = UDim2.new(1, -159, 1, -43),
    BackgroundColor3 = C.bg,
    BorderSizePixel = 0,
}, main)

local pageHeader = new("TextLabel", {
    Position = UDim2.fromOffset(24, 16),
    Size = UDim2.new(1, -48, 0, 24),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamSemibold,
    Text = "Main",
    TextColor3 = C.text,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local pageSub = new("TextLabel", {
    Position = UDim2.fromOffset(24, 41),
    Size = UDim2.new(1, -48, 0, 20),
    BackgroundTransparency = 1,
    Font = Enum.Font.Gotham,
    Text = "Welcome back. Select a section from the sidebar.",
    TextColor3 = C.muted,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
}, content)

local body = new("ScrollingFrame", {
    Position = UDim2.fromOffset(18, 72),
    Size = UDim2.new(1, -36, 1, -88),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.purple,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, content)
new("UIListLayout", {
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, body)

local function clearBody()
    for _, child in ipairs(body:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end
end

local function addInfo(title, description)
    local card = new("Frame", {
        Size = UDim2.new(1, -3, 0, 64),
        BackgroundColor3 = C.panel,
        BorderSizePixel = 0,
    }, body)
    corner(card, 7)
    stroke(card, C.line, 1, 0.35)
    new("TextLabel", {
        Position = UDim2.fromOffset(14, 10),
        Size = UDim2.new(1, -28, 0, 18),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold,
        Text = title,
        TextColor3 = C.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
    new("TextLabel", {
        Position = UDim2.fromOffset(14, 31),
        Size = UDim2.new(1, -28, 0, 23),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = description,
        TextColor3 = C.muted,
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
end

local function addAction(title, description, buttonText, callback)
    local card = new("Frame", {
        Size = UDim2.new(1, -3, 0, 70),
        BackgroundColor3 = C.panel,
        BorderSizePixel = 0,
    }, body)
    corner(card, 7)
    stroke(card, C.line, 1, 0.35)
    new("TextLabel", {
        Position = UDim2.fromOffset(14, 10),
        Size = UDim2.new(1, -132, 0, 18),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold,
        Text = title,
        TextColor3 = C.text,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
    new("TextLabel", {
        Position = UDim2.fromOffset(14, 31),
        Size = UDim2.new(1, -132, 0, 25),
        BackgroundTransparency = 1,
        Font = Enum.Font.Gotham,
        Text = description,
        TextColor3 = C.muted,
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, card)
    local button = new("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -12, 0.5, 0),
        Size = UDim2.fromOffset(94, 30),
        BackgroundColor3 = C.purpleDark,
        BorderSizePixel = 0,
        Font = Enum.Font.GothamSemibold,
        Text = buttonText,
        TextColor3 = C.text,
        TextSize = 10,
    }, card)
    corner(button, 6)
    button.Activated:Connect(callback)
end

local pages = {"Main", "Target", "Misc", "Roles", "Webhook", "Player", "Settings"}
local symbols = {Main = "⌂", Target = "◎", Misc = "✣", Roles = "♙", Webhook = "⌁", Player = "♟", Settings = "⚙"}
local selectedNav

local function showPage(page)
    pageHeader.Text = page
    clearBody()

    if page == "Main" then
        pageSub.Text = "Welcome to Ghostly Hub."
        addInfo("Welcome", "A clean, draggable hub interface with an animated startup.")
        addInfo("Anti-cheat testing", "Use the Player and Settings sections to run local UI checks.")
        addAction("Check character", "Inspect your current character and Humanoid.", "Run check", function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                addInfo("Character status", ("Humanoid found • Health %d • WalkSpeed %d"):format(
                    math.floor(humanoid.Health), math.floor(humanoid.WalkSpeed)))
            else
                addInfo("Character status", "Character or Humanoid was not found.")
            end
        end)
    elseif page == "Target" then
        pageSub.Text = "Targeting tools for your own game."
        addInfo("Target tools", "Add your own game-specific, server-authorized testing tools here.")
        addInfo("Safe testing", "This template intentionally does not include exploit or combat automation.")
    elseif page == "Misc" then
        pageSub.Text = "Utilities and quick actions."
        addAction("Respawn character", "Request a character respawn in your own experience.", "Respawn", function()
            local ok, err = pcall(function() player:LoadCharacter() end)
            addInfo("Respawn result", ok and "Respawn requested." or tostring(err))
        end)
        addInfo("Script launcher slots", "Add trusted scripts you own or have permission to use.")
    elseif page == "Roles" then
        pageSub.Text = "Role and permission diagnostics."
        addInfo("Client permissions", "Client UI is not a security boundary. Validate roles on the server.")
    elseif page == "Webhook" then
        pageSub.Text = "Webhook configuration."
        addInfo("Not configured", "Add a server-side webhook handler; never put private webhook tokens in a LocalScript.")
    elseif page == "Player" then
        pageSub.Text = "Local player diagnostics."
        addAction("Check character / Humanoid", "Show current local character stats.", "Inspect", function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                addInfo("Character stats", ("Health: %d • WalkSpeed: %d • JumpPower: %d"):format(
                    math.floor(humanoid.Health), math.floor(humanoid.WalkSpeed), math.floor(humanoid.JumpPower)))
            else
                addInfo("Character stats", "No active Humanoid found.")
            end
        end)
        addAction("Reset local WalkSpeed", "Set local WalkSpeed to the default 16 for testing.", "Reset", function()
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
                addInfo("WalkSpeed", "Local WalkSpeed set to 16. Enforce movement rules on the server too.")
            else
                addInfo("WalkSpeed", "No active Humanoid found.")
            end
        end)
    else
        pageSub.Text = "Customize the hub."
        addInfo("Appearance", "Dark theme with purple accents is enabled.")
        addAction("Close hub", "Remove the Ghostly Hub interface.", "Close", function()
            gui:Destroy()
        end)
    end
end

for i, page in ipairs(pages) do
    local btn = new("TextButton", {
        Name = page .. "Button",
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundColor3 = page == "Main" and C.hover or C.panel,
        BorderSizePixel = 0,
        Font = Enum.Font.Gotham,
        Text = "   " .. (symbols[page] or "•") .. "     " .. page,
        TextColor3 = page == "Main" and C.text or C.muted,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = i,
    }, nav)
    corner(btn, 6)
    btn.Activated:Connect(function()
        for _, other in ipairs(nav:GetChildren()) do
            if other:IsA("TextButton") then
                other.BackgroundColor3 = C.panel
                other.TextColor3 = C.muted
            end
        end
        btn.BackgroundColor3 = C.hover
        btn.TextColor3 = C.text
        showPage(page)
    end)
end

-- Drag window from topbar
local dragging = false
local dragStart
local startPosition

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local minimized = false
minimize.Activated:Connect(function()
    minimized = not minimized
    sidebar.Visible = not minimized
    content.Visible = not minimized
    main.Size = minimized and UDim2.fromOffset(650, 43) or UDim2.fromOffset(650, 405)
    minimize.Text = minimized and "+" or "—"
end)

showPage("Main")

-- Startup animation then reveal window
TweenService:Create(introTitle, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    TextTransparency = 0,
}):Play()
TweenService:Create(introSub, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.12), {
    TextTransparency = 0,
}):Play()
TweenService:Create(bar, TweenInfo.new(1.05, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    Size = UDim2.fromScale(1, 1),
}):Play()

task.wait(1.25)
main.Visible = true
main.Size = UDim2.fromOffset(610, 380)
main.BackgroundTransparency = 1
TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(650, 405),
    BackgroundTransparency = 0,
    Position = UDim2.fromScale(0.5, 0.5),
}):Play()
TweenService:Create(intro, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 1,
}):Play()
task.wait(0.32)
intro:Destroy()

print("[Ghostly Hub] UI loaded.")
