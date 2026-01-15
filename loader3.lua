local Finity = {}
local Notification = {}
local Version = {
    Version = "2.1.0",
    Date = "05/22/2024",
    PlaceVersion = game.PlaceVersion,
    Changelog = {
        "Fixed UI Overlaps",
        "Improved Sector Layout",
        "Optimized Cheat Callbacks",
        "Modern Aesthetic Update"
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

function Version:Get()
    return self
end

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

function Notification:Notify(info, style, icon)
    local sg = Instance.new("ScreenGui", CoreGui)
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 90)
    frame.Position = UDim2.new(1, 10, 1, -110)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local accent = Instance.new("Frame", frame)
    accent.Size = UDim2.new(0, 4, 1, 0)
    accent.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
    accent.BorderSizePixel = 0
    Instance.new("UICorner", accent)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -50, 0, 30)
    title.Position = UDim2.new(0, 15, 0, 10)
    title.Text = info.Title or "System Exodus"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    
    local desc = Instance.new("TextLabel", frame)
    desc.Size = UDim2.new(1, -30, 1, -45)
    desc.Position = UDim2.new(0, 15, 0, 35)
    desc.Text = info.Description or ""
    desc.TextColor3 = Color3.fromRGB(180, 180, 180)
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 12

    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -310, 1, -110)}):Play()
    
    task.delay(style and style.Time or 3, function()
        local t = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 1, -110)})
        t:Play()
        t.Completed:Wait()
        sg:Destroy()
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
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    header.BorderSizePixel = 0
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)
    
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    header.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)

    local titleLabel = Instance.new("TextLabel", header)
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.RichText = true

    UI.container = {Categories = {}}
    
    local sidebar = Instance.new("ScrollingFrame", main)
    sidebar.Position = UDim2.new(0, 0, 0, 45)
    sidebar.Size = UDim2.new(0, 170, 1, -45)
    sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    sidebar.BorderSizePixel = 0
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sidebar.ScrollBarThickness = 2

    local sideLayout = Instance.new("UIListLayout", sidebar)
    sideLayout.Padding = UDim.new(0, 2)
    
    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0, 170, 0, 45)
    content.Size = UDim2.new(1, -170, 1, -45)
    content.BackgroundTransparency = 1

    function UI:Destroy() sg:Destroy() end
    function UI.ChangeToggleKey(key) toggleKey = key end
    
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == toggleKey then
            main.Visible = not main.Visible
        end
    end)

    function UI:Category(name)
        local cat = {R = {}}
        UI.container.Categories[name] = cat
        
        local btn = Instance.new("TextButton", sidebar)
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.Text = "  " .. name
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.RichText = true
        
        local catFrame = Instance.new("ScrollingFrame", content)
        catFrame.Size = UDim2.new(1, 0, 1, 0)
        catFrame.Visible = false
        catFrame.BackgroundTransparency = 1
        catFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        catFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        catFrame.ScrollBarThickness = 3
        catFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
        
        local layout = Instance.new("UIGridLayout", catFrame)
        layout.CellPadding = UDim2.new(0, 10, 0, 10)
        layout.CellSize = UDim2.new(0.47, 0, 0, 10)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local function updateCellSize()
            for _, child in pairs(catFrame:GetChildren()) do
                if child:IsA("Frame") then
                    child.AutomaticSize = Enum.AutomaticSize.Y
                end
            end
        end
        catFrame.ChildAdded:Connect(updateCellSize)

        Instance.new("UIPadding", catFrame).PaddingTop = UDim.new(0, 10)
        Instance.new("UIPadding", catFrame).PaddingLeft = UDim.new(0, 10)

        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(content:GetChildren()) do v.Visible = false end
            for _, b in pairs(sidebar:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(200, 200, 200) b.BackgroundColor3 = Color3.fromRGB(30,30,30) end end
            catFrame.Visible = true
            btn.TextColor3 = Color3.fromRGB(150, 100, 255)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)

        if #sidebar:GetChildren() == 2 then 
            catFrame.Visible = true 
            btn.TextColor3 = Color3.fromRGB(150, 100, 255)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end

        function cat:Sector(secName)
            local sector = {}
            local secFrame = Instance.new("Frame", catFrame)
            secFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
            secFrame.BorderSizePixel = 0
            secFrame.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UICorner", secFrame)
            
            cat.R[secName] = {Container = secFrame}
            
            local secLayout = Instance.new("UIListLayout", secFrame)
            secLayout.Padding = UDim.new(0, 6)
            secLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            
            local secTitle = Instance.new("TextLabel", secFrame)
            secTitle.Size = UDim2.new(1, 0, 0, 28)
            secTitle.Text = secName
            secTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            secTitle.TextColor3 = Color3.new(1, 1, 1)
            secTitle.Font = Enum.Font.GothamBold
            secTitle.TextSize = 13
            Instance.new("UICorner", secTitle)
            Instance.new("UIPadding", secFrame).PaddingBottom = UDim.new(0, 10)

            function sector:Cheat(type, label, callback, options)
                local cheat = {}
                if type == "Label" then
                    local l = Instance.new("TextLabel", secFrame)
                    l.Size = UDim2.new(0.9, 0, 0, 0)
                    l.AutomaticSize = Enum.AutomaticSize.Y
                    l.Text = label
                    l.TextColor3 = Color3.fromRGB(220, 220, 220)
                    l.BackgroundTransparency = 1
                    l.RichText = true
                    l.TextSize = 11
                    l.TextWrapped = true
                    l.TextXAlignment = Enum.TextXAlignment.Left
                    l.Font = Enum.Font.Gotham
                elseif type == "Button" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 32)
                    b.Text = (options and options.text ~= "") and options.text or label
                    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    b.TextColor3 = Color3.new(1, 1, 1)
                    b.Font = Enum.Font.Gotham
                    b.TextSize = 12
                    Instance.new("UICorner", b)
                    b.MouseButton1Click:Connect(callback)
                    UI.Features["- " .. label .. ":"] = {button = b}
                elseif type == "Checkbox" then
                    local val = options and options.enabled or false
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 32)
                    b.Text = "  " .. label
                    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    b.TextColor3 = val and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(180, 180, 180)
                    b.Font = Enum.Font.Gotham
                    b.TextSize = 12
                    b.TextXAlignment = Enum.TextXAlignment.Left
                    Instance.new("UICorner", b)
                    
                    local indicator = Instance.new("Frame", b)
                    indicator.Size = UDim2.new(0, 18, 0, 18)
                    indicator.Position = UDim2.new(1, -25, 0.5, -9)
                    indicator.BackgroundColor3 = val and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(60, 60, 60)
                    Instance.new("UICorner", indicator)

                    function cheat:toggleState(s)
                        val = s
                        b.TextColor3 = val and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(180, 180, 180)
                        indicator.BackgroundColor3 = val and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(60, 60, 60)
                    end

                    b.MouseButton1Click:Connect(function()
                        val = not val
                        cheat:toggleState(val)
                        callback(val)
                    end)
                elseif type == "Dropdown" then
                    local d = Instance.new("TextBox", secFrame)
                    d.Size = UDim2.new(0.92, 0, 0, 32)
                    d.PlaceholderText = label
                    d.Text = (options and options.default) or ""
                    d.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    d.TextColor3 = Color3.new(1, 1, 1)
                    d.Font = Enum.Font.Gotham
                    d.TextSize = 12
                    Instance.new("UICorner", d)
                    d.FocusLost:Connect(function() callback(d.Text) end)
                elseif type == "Textbox" then
                    local t = Instance.new("TextBox", secFrame)
                    t.Size = UDim2.new(0.92, 0, 0, 32)
                    t.PlaceholderText = (options and options.placeholder) or label
                    t.Text = ""
                    t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    t.TextColor3 = Color3.new(1, 1, 1)
                    t.Font = Enum.Font.Gotham
                    t.TextSize = 12
                    Instance.new("UICorner", t)
                    t.FocusLost:Connect(function() callback(t.Text) end)
                elseif type == "Keybind" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 32)
                    b.Text = label .. ": " .. (options and options.default or "None")
                    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    b.TextColor3 = Color3.new(1, 1, 1)
                    b.Font = Enum.Font.Gotham
                    b.TextSize = 12
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
