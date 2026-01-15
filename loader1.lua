local Finity = {}
local Notification = {}
local Version = {
    Version = "2.1.0",
    Date = "05/22/2024",
    PlaceVersion = game.PlaceVersion,
    Changelog = {
        "Fixed Loader logic",
        "Optimized UI Library",
        "Resolved Nil Call Errors"
    },
    Emojis = {
        ["Island"] = "🏝️", ["Clipboard"] = "📋", ["Tractor"] = "🚜", ["Sword"] = "⚔️",
        ["Machine"] = "⚙️", ["Glass"] = "🔍", ["Barrier"] = "🚧", ["Gear"] = "⚙️",
        ["Scroll"] = "📜", ["PurpleHeart"] = "💜", ["Sparkle"] = "✨", ["Link"] = "🔗",
        ["Keyboard"] = "⌨️", ["Crop"] = "🌾", ["Berry"] = "🍓",
        ["Pickaxe"] = "⛏️", ["Axe"] = "🪓", ["Box"] = "📦", ["Droplet"] = "💧",
        ["Flower"] = "🌸", ["SkullCross"] = "☠️", ["Fish"] = "🐟", ["Firefly"] = "🪲",
        ["Bee"] = "🐝", ["Rabbit"] = "🐇", ["Frog"] = "🐸", ["Ghost"] = "👻",
        ["Fire"] = "🔥", ["Shine"] = "✨", ["Watch"] = "⌚", ["Food"] = "🍎",
        ["Pin"] = "📍", ["Eyes"] = "👀", ["Amount"] = "🔢", ["Purple"] = "🟣",
        ["Map"] = "🗺️", ["Print"] = "🖨️", ["Hammer"] = "🔨", ["Abort"] = "🛑",
        ["Rotate"] = "🔄", ["Add"] = "➕", ["File"] = "📄", ["Rocket"] = "🚀",
        ["Paper"] = "📝", ["Save"] = "💾", ["Scale"] = "⚖️", ["Fly"] = "🕊️",
        ["Noclip"] = "👻", ["Warning"] = "⚠️"
    }
}

function Version:Get(name)
    return self
end

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

function Notification:Notify(info, style, icon)
    local sg = Instance.new("ScreenGui", CoreGui)
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 280, 0, 85)
    frame.Position = UDim2.new(1, -300, 1, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = table.unpack({UDim.new(0, 8)})
    
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -20, 0, 30)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.Text = info.Title or "Notification"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    
    local desc = Instance.new("TextLabel", frame)
    desc.Size = UDim2.new(1, -20, 1, -40)
    desc.Position = UDim2.new(0, 10, 0, 35)
    desc.Text = info.Description or ""
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12
    
    task.delay(style and style.Time or 3, function()
        pcall(function() sg:Destroy() end)
    end)
end

function Finity.new(title, size, extra, callback)
    local UI = {Features = {}}
    local toggleKey = Enum.KeyCode.RightShift
    
    local sg = Instance.new("ScreenGui", CoreGui)
    sg.Name = "FinityUI"
    local main = Instance.new("Frame", sg)
    main.Size = size
    main.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main)
    
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    header.BorderSizePixel = 0
    Instance.new("UICorner", header)
    
    local titleLabel = Instance.new("TextLabel", header)
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.RichText = true

    UI.container = {Categories = {}}
    local catContainer = Instance.new("Frame", main)
    catContainer.Position = UDim2.new(0, 0, 0, 40)
    catContainer.Size = UDim2.new(0, 160, 1, -40)
    catContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    catContainer.BorderSizePixel = 0

    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0, 160, 0, 40)
    content.Size = UDim2.new(1, -160, 1, -40)
    content.BackgroundTransparency = 1

    function UI:Destroy()
        sg:Destroy()
    end

    function UI.ChangeToggleKey(key) 
        toggleKey = key 
    end
    
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == toggleKey then
            main.Visible = not main.Visible
        end
    end)

    function UI:Category(name)
        local cat = {R = {}}
        UI.container.Categories[name] = cat
        
        local btn = Instance.new("TextButton", catContainer)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, (#catContainer:GetChildren() * 35))
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.Gotham
        btn.RichText = true
        Instance.new("UICorner", btn)
        
        local catFrame = Instance.new("ScrollingFrame", content)
        catFrame.Size = UDim2.new(1, -10, 1, -10)
        catFrame.Position = UDim2.new(0, 5, 0, 5)
        catFrame.Visible = false
        catFrame.BackgroundTransparency = 1
        catFrame.ScrollBarThickness = 2
        catFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local layout = Instance.new("UIGridLayout", catFrame)
        layout.CellPadding = UDim2.new(0, 10, 0, 10)
        layout.CellSize = UDim2.new(0.48, 0, 0, 250)

        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(content:GetChildren()) do v.Visible = false end
            catFrame.Visible = true
        end)

        function cat:Sector(secName)
            local sector = {}
            local secFrame = Instance.new("Frame", catFrame)
            secFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            secFrame.BorderSizePixel = 0
            Instance.new("UICorner", secFrame)
            cat.R[secName] = {Container = secFrame}
            
            local secLayout = Instance.new("UIListLayout", secFrame)
            secLayout.Padding = UDim.new(0, 5)
            secLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            
            local secTitle = Instance.new("TextLabel", secFrame)
            secTitle.Size = UDim2.new(1, 0, 0, 25)
            secTitle.Text = secName
            secTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            secTitle.TextColor3 = Color3.new(1, 1, 1)
            secTitle.Font = Enum.Font.GothamBold
            Instance.new("UICorner", secTitle)

            function sector:Cheat(type, label, callback, options)
                local cheat = {}
                if type == "Label" then
                    local l = Instance.new("TextLabel", secFrame)
                    l.Size = UDim2.new(0.9, 0, 0, 20)
                    l.Text = label
                    l.TextColor3 = Color3.new(1, 1, 1)
                    l.BackgroundTransparency = 1
                    l.RichText = true
                    l.TextSize = 12
                    l.TextWrapped = true
                elseif type == "Button" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.9, 0, 0, 30)
                    b.Text = (options and options.text ~= "") and options.text or label
                    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    b.TextColor3 = Color3.new(1, 1, 1)
                    Instance.new("UICorner", b)
                    b.MouseButton1Click:Connect(callback)
                    UI.Features["- " .. label .. ":"] = {button = b}
                elseif type == "Checkbox" then
                    local val = options and options.enabled or false
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.9, 0, 0, 30)
                    b.Text = label .. ": " .. (val and "ON" or "OFF")
                    b.BackgroundColor3 = val and Color3.fromRGB(60, 120, 60) or Color3.fromRGB(120, 60, 60)
                    Instance.new("UICorner", b)
                    
                    function cheat:toggleState(s)
                        val = s
                        b.Text = label .. ": " .. (val and "ON" or "OFF")
                        b.BackgroundColor3 = val and Color3.fromRGB(60, 120, 60) or Color3.fromRGB(120, 60, 60)
                    end

                    b.MouseButton1Click:Connect(function()
                        val = not val
                        cheat:toggleState(val)
                        callback(val)
                    end)
                elseif type == "Dropdown" then
                    local d = Instance.new("TextBox", secFrame)
                    d.Size = UDim2.new(0.9, 0, 0, 30)
                    d.PlaceholderText = label
                    d.Text = (options and options.default) or ""
                    d.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    d.TextColor3 = Color3.new(1, 1, 1)
                    Instance.new("UICorner", d)
                    d.FocusLost:Connect(function() callback(d.Text) end)
                elseif type == "Textbox" then
                    local t = Instance.new("TextBox", secFrame)
                    t.Size = UDim2.new(0.9, 0, 0, 30)
                    t.PlaceholderText = (options and options.placeholder) or label
                    t.Text = ""
                    t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    t.TextColor3 = Color3.new(1, 1, 1)
                    Instance.new("UICorner", t)
                    t.FocusLost:Connect(function() callback(t.Text) end)
                elseif type == "Keybind" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.9, 0, 0, 30)
                    b.Text = label
                    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    b.TextColor3 = Color3.new(1, 1, 1)
                    Instance.new("UICorner", b)
                    b.MouseButton1Click:Connect(function()
                        b.Text = "..."
                        local conn; conn = UserInputService.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                conn:Disconnect()
                                b.Text = label .. ": " .. input.KeyCode.Name
                                callback(input.KeyCode)
                            end
                        end)
                    end)
                end
                return cheat
            end
            return sector
        end
        return cat
    end

    if callback then callback({tip = titleLabel}) end
    return UI
end

return Finity, Notification, Version
