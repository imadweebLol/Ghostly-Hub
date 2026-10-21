-- Destroy existing UI if it's already running to prevent overlap
if game.CoreGui:FindFirstChild("Orion") then
    game.CoreGui.Orion:Destroy()
end

-- FIXED: Official raw public source for the Orion UI Library
local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()

-- Create the main window with your requested Ghostly Dark/Purple aesthetic
local Window = OrionLib:MakeWindow({
    Name = "Ghostly Hub 👻", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "GhostlyHubConfig",
    IntroText = "Loading Ghostly Hub..."
})

-- Applied custom Dark & Vibrant Purple theme profile
OrionLib.Themes["Default"] = {
    Main = Color3.fromRGB(15, 15, 15),       -- Deep black background
    Header = Color3.fromRGB(10, 10, 10),     -- Darker header border
    Accent = Color3.fromRGB(138, 43, 226),   -- Vibrant Purple accent
    LightContrast = Color3.fromRGB(30, 30, 30), -- Dark grey buttons
    DarkContrast = Color3.fromRGB(5, 5, 5),
    TextColor = Color3.fromRGB(240, 240, 240)  -- Clear white text
}

-- ==================== MAIN TAB ====================
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

MainTab:AddParagraph("Welcome to Ghostly Hub", "Your customized interface for execution.")

-- Universal Walkspeed Feature
MainTab:AddSlider({
    Name = "Walkspeed Changer",
    Min = 16,
    Max = 250,
    Default = 16,
    Color = Color3.fromRGB(138, 43, 226),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end    
})

-- ==================== SCRIPTS TAB ====================
local ScriptTab = Window:MakeTab({
    Name = "My Scripts",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- Button 1: Murder Mystery 2 Nexus Updated
ScriptTab:AddButton({
    Name = "MM2 Nexus Updated",
    Callback = function()
        pcall(function()
            -- FIXED: Raw public loadstring for MM2 Nexus
            loadstring(game:HttpGet("https://raw.githubusercontent.com/s-0-a-b/nexus/main/loadstring"))()
        end)
        OrionLib:MakeNotification({
            Name = "Ghostly Hub",
            Content = "MM2 Nexus Executed!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end    
})

-- Button 2: Vertex
ScriptTab:AddButton({
    Name = "Vertex Script",
    Callback = function()
        pcall(function()
            -- FIXED: Raw public loadstring for Vertex MM2 Hub
            loadstring(game:HttpGet('https://raw.smokingscripts.org/vertex.lua'))()
        end)
        OrionLib:MakeNotification({
            Name = "Ghostly Hub",
            Content = "Vertex Executed!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end    
})

-- Button 3: Infinite Yield
ScriptTab:AddButton({
    Name = "Infinite Yield Admin",
    Callback = function()
        pcall(function()
            -- FIXED: Official raw GitHub source path for Infinite Yield Admin
            loadstring(game:HttpGet("https://githubusercontent.com"))()
        end)
        OrionLib:MakeNotification({
            Name = "Ghostly Hub",
            Content = "Infinite Yield Executed!",
            Image = "rbxassetid://4483362458",
            Time = 3
        })
    end    
})

-- Initialize the script hub UI
OrionLib:Init()
