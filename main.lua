
-- ==================== SCRIPTS TAB ====================
local ScriptTab = Window:MakeTab({
    Name = "My Scripts",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- Vertex
ScriptTab:AddButton({
    Name = "Vertex",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(
                "https://scriptblox.com/raw/Murder-Mystery-2-nexus-updated-15270"
            ))()
        end)

        OrionLib:MakeNotification({
            Name = success and "Ghostly Hub" or "Execution Error",
            Content = success
                and "Vertex script launched."
                or tostring(err),
            Image = "rbxassetid://4483362458",
            Time = 4
        })
    end
})

-- Infinite Yield
ScriptTab:AddButton({
    Name = "Infinite Yield Admin",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(
                "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
            ))()
        end)

        OrionLib:MakeNotification({
            Name = success and "Ghostly Hub" or "Execution Error",
            Content = success
                and "Infinite Yield launched."
                or tostring(err),
            Image = "rbxassetid://4483362458",
            Time = 4
        })
    end
})

