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
        ["Noclip"] = "👻", ["Warning"] = "⚠️", ["Herb"] = "🌿", ["Craft"] = "🔨"
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
    sg.Name = "ExodusNotify"
    
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(1, 10, 1, -110)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(40, 40, 40)
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local accent = Instance.new("Frame", frame)
    accent.Size = UDim2.new(0, 3, 1, 0)
    accent.BackgroundColor3 = style and style.OutlineColor or Color3.fromRGB(150, 100, 255)
    accent.BorderSizePixel = 0
    Instance.new("UICorner", accent)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -60, 0, 25)
    title.Position = UDim2.new(0, 15, 0, 10)
    title.Text = info.Title or "System Exodus"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.RichText = true
    
    local desc = Instance.new("TextLabel", frame)
    desc.Size = UDim2.new(1, -30, 1, -40)
    desc.Position = UDim2.new(0, 15, 0, 32)
    desc.Text = info.Description or ""
    desc.TextColor3 = Color3.fromRGB(160, 160, 160)
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 11
    desc.RichText = true

    if icon and icon.Type == "image" then
        local img = Instance.new("ImageLabel", frame)
        img.Size = UDim2.new(0, 20, 0, 20)
        img.Position = UDim2.new(1, -35, 0, 12)
        img.Image = icon.Image
        img.ImageColor3 = icon.ImageColor or Color3.new(1,1,1)
        img.BackgroundTransparency = 1
    end

    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, -310, 1, -110)}):Play()
    
    task.delay(style and style.Time or 3, function()
        local t = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 1, -110)})
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
    sg.ResetOnSpawn = false
    
    local main = Instance.new("Frame", sg)
    main.Size = size
    main.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
    
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(45, 45, 45)
    mainStroke.Thickness = 1
    
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    header.BorderSizePixel = 0
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 8)
    
    local headerLine = Instance.new("Frame", header)
    headerLine.Size = UDim2.new(1, 0, 0, 1)
    headerLine.Position = UDim2.new(0, 0, 1, -1)
    headerLine.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    headerLine.BorderSizePixel = 0

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
    titleLabel.TextSize = 14
    titleLabel.RichText = true

    UI.container = {Categories = {}}
    
    local sidebar = Instance.new("ScrollingFrame", main)
    sidebar.Position = UDim2.new(0, 0, 0, 40)
    sidebar.Size = UDim2.new(0, 160, 1, -40)
    sidebar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    sidebar.BorderSizePixel = 0
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sidebar.ScrollBarThickness = 0
    
    local sideLine = Instance.new("Frame", main)
    sideLine.Size = UDim2.new(0, 1, 1, -40)
    sideLine.Position = UDim2.new(0, 160, 0, 40)
    sideLine.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    sideLine.BorderSizePixel = 0

    local sideLayout = Instance.new("UIListLayout", sidebar)
    sideLayout.Padding = UDim.new(0, 4)
    Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0, 10)
    Instance.new("UIPadding", sidebar).PaddingLeft = UDim.new(0, 8)
    Instance.new("UIPadding", sidebar).PaddingRight = UDim.new(0, 8)
    
    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0, 161, 0, 40)
    content.Size = UDim2.new(1, -161, 1, -40)
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
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.BackgroundTransparency = 1
        btn.TextColor3 = Color3.fromRGB(160, 160, 160)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.RichText = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        Instance.new("UIPadding", btn).PaddingLeft = UDim.new(0, 10)
        
        local catFrame = Instance.new("ScrollingFrame", content)
        catFrame.Size = UDim2.new(1, 0, 1, 0)
        catFrame.Visible = false
        catFrame.BackgroundTransparency = 1
        catFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        catFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        catFrame.ScrollBarThickness = 2
        catFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 100, 255)
        
        local layout = Instance.new("UIListLayout", catFrame)
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        Instance.new("UIPadding", catFrame).PaddingTop = UDim.new(0, 15)
        Instance.new("UIPadding", catFrame).PaddingBottom = UDim.new(0, 15)

        btn.MouseEnter:Connect(function()
            if not catFrame.Visible then
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.9, TextColor3 = Color3.fromRGB(220, 220, 220)}):Play()
            end
        end)
        btn.MouseLeave:Connect(function()
            if not catFrame.Visible then
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(160, 160, 160)}):Play()
            end
        end)

        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(content:GetChildren()) do v.Visible = false end
            for _, b in pairs(sidebar:GetChildren()) do 
                if b:IsA("TextButton") then 
                    TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(160, 160, 160)}):Play()
                end 
            end
            catFrame.Visible = true
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, TextColor3 = Color3.fromRGB(150, 100, 255)}):Play()
        end)

        if #sidebar:GetChildren() == 2 then 
            catFrame.Visible = true 
            btn.BackgroundTransparency = 0.8
            btn.TextColor3 = Color3.fromRGB(150, 100, 255)
        end

        function cat:Sector(secName)
            local sector = {}
            if secName == "" then return sector end

            local secFrame = Instance.new("Frame", catFrame)
            secFrame.Size = UDim2.new(0.92, 0, 0, 0)
            secFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            secFrame.BorderSizePixel = 0
            secFrame.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UICorner", secFrame).CornerRadius = UDim.new(0, 6)
            
            local secStroke = Instance.new("UIStroke", secFrame)
            secStroke.Color = Color3.fromRGB(45, 45, 45)
            secStroke.Thickness = 1

            cat.R[secName] = {Container = secFrame}
            
            local secLayout = Instance.new("UIListLayout", secFrame)
            secLayout.Padding = UDim.new(0, 6)
            secLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            
            local secTitle = Instance.new("TextLabel", secFrame)
            secTitle.Size = UDim2.new(1, 0, 0, 26)
            secTitle.Text = secName:upper()
            secTitle.BackgroundTransparency = 1
            secTitle.TextColor3 = Color3.fromRGB(150, 100, 255)
            secTitle.Font = Enum.Font.GothamBold
            secTitle.TextSize = 10
            secTitle.ZIndex = 2
            
            local secTitlePad = Instance.new("UIPadding", secTitle)
            secTitlePad.PaddingLeft = UDim.new(0, 12)
            secTitle.TextXAlignment = Enum.TextXAlignment.Left

            Instance.new("UIPadding", secFrame).PaddingBottom = UDim.new(0, 10)

            function sector:Cheat(type, label, callback, options)
                local cheat = {}
                if type == "Label" then
                    local l = Instance.new("TextLabel", secFrame)
                    l.Size = UDim2.new(0.92, 0, 0, 0)
                    l.AutomaticSize = Enum.AutomaticSize.Y
                    l.Text = label
                    l.TextColor3 = Color3.fromRGB(180, 180, 180)
                    l.BackgroundTransparency = 1
                    l.RichText = true
                    l.TextSize = 11
                    l.TextWrapped = true
                    l.TextXAlignment = Enum.TextXAlignment.Left
                    l.Font = Enum.Font.Gotham
                elseif type == "Button" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 28)
                    b.Text = (options and options.text ~= "") and options.text or label
                    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    b.TextColor3 = Color3.fromRGB(220, 220, 220)
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 11
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
                    local bs = Instance.new("UIStroke", b)
                    bs.Color = Color3.fromRGB(50, 50, 50)
                    bs.Thickness = 1
                    
                    b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play() end)
                    b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play() end)
                    b.MouseButton1Click:Connect(function()
                        local t = TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(150, 100, 255)})
                        t:Play() t.Completed:Wait()
                        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                        callback()
                    end)
                    UI.Features["- " .. label .. ":"] = {button = b}
                elseif type == "Checkbox" then
                    local val = options and options.enabled or false
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 28)
                    b.Text = label
                    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    b.BackgroundTransparency = 1
                    b.TextColor3 = val and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 11
                    b.TextXAlignment = Enum.TextXAlignment.Left
                    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 4)
                    
                    local togBack = Instance.new("Frame", b)
                    togBack.Size = UDim2.new(0, 32, 0, 16)
                    togBack.Position = UDim2.new(1, -36, 0.5, -8)
                    togBack.BackgroundColor3 = val and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(45, 45, 45)
                    Instance.new("UICorner", togBack).CornerRadius = UDim.new(1, 0)
                    
                    local togCircle = Instance.new("Frame", togBack)
                    togCircle.Size = UDim2.new(0, 12, 0, 12)
                    togCircle.Position = val and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
                    togCircle.BackgroundColor3 = Color3.new(1, 1, 1)
                    Instance.new("UICorner", togCircle).CornerRadius = UDim.new(1, 0)

                    function cheat:toggleState(s)
                        val = s
                        TweenService:Create(b, TweenInfo.new(0.2), {TextColor3 = val and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160)}):Play()
                        TweenService:Create(togBack, TweenInfo.new(0.2), {BackgroundColor3 = val and Color3.fromRGB(150, 100, 255) or Color3.fromRGB(45, 45, 45)}):Play()
                        TweenService:Create(togCircle, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Position = val and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)}):Play()
                    end

                    b.MouseButton1Click:Connect(function()
                        val = not val
                        cheat:toggleState(val)
                        callback(val)
                    end)
                elseif type == "Dropdown" then
                    local d = Instance.new("TextBox", secFrame)
                    d.Size = UDim2.new(0.92, 0, 0, 28)
                    d.PlaceholderText = label
                    d.Text = (options and options.default) or ""
                    d.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
                    d.TextColor3 = Color3.new(1, 1, 1)
                    d.Font = Enum.Font.Gotham
                    d.TextSize = 11
                    Instance.new("UICorner", d).CornerRadius = UDim.new(0, 4)
                    local ds = Instance.new("UIStroke", d)
                    ds.Color = Color3.fromRGB(50, 50, 50)
                    d.FocusLost:Connect(function() callback(d.Text) end)
                elseif type == "Textbox" then
                    local t = Instance.new("TextBox", secFrame)
                    t.Size = UDim2.new(0.92, 0, 0, 28)
                    t.PlaceholderText = (options and options.placeholder) or label
                    t.Text = ""
                    t.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
                    t.TextColor3 = Color3.new(1, 1, 1)
                    t.Font = Enum.Font.Gotham
                    t.TextSize = 11
                    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 4)
                    local ts = Instance.new("UIStroke", t)
                    ts.Color = Color3.fromRGB(50, 50, 50)
                    t.FocusLost:Connect(function() callback(t.Text) end)
                elseif type == "Keybind" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 28)
                    b.Text = label .. " [" .. (options and options.default or "None") .. "]"
                    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    b.TextColor3 = Color3.fromRGB(200, 200, 200)
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 11
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
                    local ks = Instance.new("UIStroke", b)
                    ks.Color = Color3.fromRGB(50, 50, 50)
                    
                    b.MouseButton1Click:Connect(function()
                        b.Text = "Listening..."
                        b.TextColor3 = Color3.fromRGB(150, 100, 255)
                        local conn; conn = UserInputService.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                conn:Disconnect()
                                b.Text = label .. " [" .. input.KeyCode.Name .. "]"
                                b.TextColor3 = Color3.fromRGB(200, 200, 200)
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
