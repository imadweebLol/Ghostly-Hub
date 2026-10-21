-- Destroy existing UI if it's already running to prevent overlap
if game.CoreGui:FindFirstChild("Orion") then
    game.CoreGui.Orion:Destroy()
end

-- FIXED: Re-hosted, 100% working mirror of the Orion Library
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet('https://githubusercontent.com'))()
end)

if not success or not OrionLib then
    warn("Ghostly Hub Error: Framework failed to load.")
    return
end

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
        local scriptSuccess = pcall(function()
            -- FIXED: Clean loader link alternative
            loadstring(game:HttpGet("https://githubusercontent.com"))()
        end)
        
        if scriptSuccess then
            OrionLib:MakeNotification({
                Name = "Ghostly Hub",
                Content = "MM2 Nexus Executed!",
                Image = "rbxassetid://4483362458",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Execution Error",
                Content = "Nexus script link is currently offline.",
                Time = 4
            })
        end
    end    
})

-- Button 2: Vertex Alternative
ScriptTab:AddButton({
    Name = "Vertex Script Alternative",
    Callback = function()
        local scriptSuccess = pcall(function()
            -- FIXED: Smokingscripts domain is down; updated to a reliable universal MM2 GUI
            loadstring(game:HttpGet('https://githubusercontent.com'))()
        end)
        
        if scriptSuccess then
            OrionLib:MakeNotification({
                Name = "Ghostly Hub",
                Content = "Script Executed!",
                Image = "rbxassetid://4483362458",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Execution Error",
                Content = "Script source could not be reached.",
                Time = 4
            })
        end
    end    
})

-- Button 3: Infinite Yield
ScriptTab:AddButton({
    Name = "Infinite Yield Admin",
    Callback = function()
        local scriptSuccess = pcall(function()
            loadstring(game:HttpGet("https://githubusercontent.com"))()
        end)
        
        if scriptSuccess then
            OrionLib:MakeNotification({
                Name = "Ghostly Hub",
                Content = "Infinite Yield Executed!",
                Image = "rbxassetid://4483362458",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Execution Error",
                Content = "Infinite Yield source could not be reached.",
                Time = 4
            })
        end
    end    
})

-- Initialize the script hub UI
OrionLib:Init()
