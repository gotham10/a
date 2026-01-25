local Finity = {}
local Notification = {}
local Version = {
    Version = "2.0.0",
    Date = "01/24/2026",
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
    frame.Size = UDim2.new(0, 280, 0, 70)
    frame.Position = UDim2.new(1, 10, 1, -85)
    frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
    
    local str = Instance.new("UIStroke", frame)
    str.Color = Color3.fromRGB(35, 35, 35)
    str.Thickness = 1

    local accent = Instance.new("Frame", frame)
    accent.Size = UDim2.new(0, 2, 1, 0)
    accent.BackgroundColor3 = style and style.OutlineColor or Color3.fromRGB(160, 110, 255)
    accent.BorderSizePixel = 0
    Instance.new("UICorner", accent)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -50, 0, 25)
    title.Position = UDim2.new(0, 12, 0, 8)
    title.Text = info.Title or "System Exodus"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.RichText = true
    
    local desc = Instance.new("TextLabel", frame)
    desc.Size = UDim2.new(1, -25, 1, -35)
    desc.Position = UDim2.new(0, 12, 0, 28)
    desc.Text = info.Description or ""
    desc.TextColor3 = Color3.fromRGB(150, 150, 150)
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 10
    desc.RichText = true

    if icon and icon.Type == "image" then
        local img = Instance.new("ImageLabel", frame)
        img.Size = UDim2.new(0, 18, 0, 18)
        img.Position = UDim2.new(1, -28, 0, 10)
        img.Image = icon.Image
        img.ImageColor3 = icon.ImageColor or Color3.new(1,1,1)
        img.BackgroundTransparency = 1
    end

    TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, -295, 1, -85)}):Play()
    
    task.delay(style and style.Time or 3, function()
        local t = TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 1, -85)})
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
    sg.DisplayOrder = 10
    sg.ResetOnSpawn = false
    
    local main = Instance.new("Frame", sg)
    main.Size = size
    main.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2 + 60)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.BackgroundTransparency = 1
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 4)
    
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(35, 35, 35)
    stroke.Thickness = 1
    stroke.Transparency = 1
    
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 32)
    header.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    header.BorderSizePixel = 0
    Instance.new("UICorner", header).CornerRadius = UDim.new(0, 4)
    
    local line = Instance.new("Frame", main)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0, 32)
    line.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    line.BorderSizePixel = 0
    line.ZIndex = 5

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
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 11
    titleLabel.RichText = true

    UI.container = {Categories = {}}
    
    local sidebar = Instance.new("ScrollingFrame", main)
    sidebar.Position = UDim2.new(0, 0, 0, 33)
    sidebar.Size = UDim2.new(0, 140, 1, -33)
    sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    sidebar.BorderSizePixel = 0
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sidebar.ScrollBarThickness = 0
    
    local sideLayout = Instance.new("UIListLayout", sidebar)
    sideLayout.Padding = UDim.new(0, 0)
    Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0, 5)
    
    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0, 141, 0, 33)
    content.Size = UDim2.new(1, -141, 1, -33)
    content.BackgroundTransparency = 1

    local sep = Instance.new("Frame", main)
    sep.Size = UDim2.new(0, 1, 1, -33)
    sep.Position = UDim2.new(0, 140, 0, 33)
    sep.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    sep.BorderSizePixel = 0
    sep.ZIndex = 2

    TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2), BackgroundTransparency = 0}):Play()
    TweenService:Create(stroke, TweenInfo.new(0.6), {Transparency = 0}):Play()

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
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.Text = name
        btn.BackgroundTransparency = 1
        btn.TextColor3 = Color3.fromRGB(120, 120, 120)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 10
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        btn.RichText = true
        Instance.new("UIPadding", btn).PaddingLeft = UDim.new(0, 15)
        
        local catFrame = Instance.new("ScrollingFrame", content)
        catFrame.Size = UDim2.new(1, 0, 1, 0)
        catFrame.Visible = false
        catFrame.BackgroundTransparency = 1
        catFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        catFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        catFrame.ScrollBarThickness = 2
        catFrame.ScrollBarImageColor3 = Color3.fromRGB(160, 110, 255)
        
        local leftSide = Instance.new("Frame", catFrame)
        leftSide.Size = UDim2.new(0.5, -12, 1, 0)
        leftSide.Position = UDim2.new(0, 8, 0, 12)
        leftSide.BackgroundTransparency = 1
        
        local rightSide = Instance.new("Frame", catFrame)
        rightSide.Size = UDim2.new(0.5, -12, 1, 0)
        rightSide.Position = UDim2.new(0.5, 4, 0, 12)
        rightSide.BackgroundTransparency = 1

        Instance.new("UIListLayout", leftSide).Padding = UDim.new(0, 10)
        Instance.new("UIListLayout", rightSide).Padding = UDim.new(0, 10)

        local selInd = Instance.new("Frame", btn)
        selInd.Size = UDim2.new(0, 2, 0, 14)
        selInd.Position = UDim2.new(0, 0, 0.5, -7)
        selInd.BackgroundColor3 = Color3.fromRGB(160, 110, 255)
        selInd.BorderSizePixel = 0
        selInd.Transparency = 1

        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(content:GetChildren()) do v.Visible = false end
            for _, b in pairs(sidebar:GetChildren()) do 
                if b:IsA("TextButton") then 
                    TweenService:Create(b, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(120, 120, 120), BackgroundTransparency = 1}):Play()
                    TweenService:Create(b:FindFirstChild("Frame"), TweenInfo.new(0.3), {Transparency = 1}):Play()
                end 
            end
            catFrame.Visible = true
            TweenService:Create(btn, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(160, 110, 255), BackgroundTransparency = 0.96}):Play()
            TweenService:Create(selInd, TweenInfo.new(0.3), {Transparency = 0}):Play()
            
            catFrame.CanvasPosition = Vector2.new(0,0)
            local stagger = 0
            local allSectors = {}
            for _, side in pairs({leftSide, rightSide}) do
                for _, container in pairs(side:GetChildren()) do
                    if container:IsA("Frame") and container.Name == "SectorContainer" then
                        table.insert(allSectors, container:FindFirstChild("SectorCard"))
                    end
                end
            end
            
            for _, card in pairs(allSectors) do
                if card then
                    card.Position = UDim2.new(0, 0, 0, 25)
                    card.BackgroundTransparency = 1
                    local str = card:FindFirstChild("UIStroke")
                    if str then str.Transparency = 1 end
                    
                    task.delay(stagger, function()
                        TweenService:Create(card, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 0}):Play()
                        if str then TweenService:Create(str, TweenInfo.new(0.6), {Transparency = 0}):Play() end
                    end)
                    stagger = stagger + 0.04
                end
            end
        end)

        if #sidebar:GetChildren() == 2 then 
            catFrame.Visible = true 
            btn.TextColor3 = Color3.fromRGB(160, 110, 255)
            btn.BackgroundTransparency = 0.96
            selInd.Transparency = 0
        end

        function cat:Sector(secName)
            local sector = {}
            if secName == "" then return sector end
            
            local target = #leftSide:GetChildren() <= #rightSide:GetChildren() and leftSide or rightSide
            
            local container = Instance.new("Frame", target)
            container.Name = "SectorContainer"
            container.BackgroundTransparency = 1
            container.Size = UDim2.new(1, 0, 0, 0)
            container.AutomaticSize = Enum.AutomaticSize.Y
            container.ClipsDescendants = true

            local secFrame = Instance.new("Frame", container)
            secFrame.Name = "SectorCard"
            secFrame.Size = UDim2.new(1, 0, 0, 0)
            secFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            secFrame.BorderSizePixel = 0
            secFrame.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UICorner", secFrame).CornerRadius = UDim.new(0, 4)
            
            local st = Instance.new("UIStroke", secFrame)
            st.Color = Color3.fromRGB(30, 30, 30)
            st.Thickness = 1

            local secLayout = Instance.new("UIListLayout", secFrame)
            secLayout.Padding = UDim.new(0, 5)
            secLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            
            local secTitle = Instance.new("TextLabel", secFrame)
            secTitle.Size = UDim2.new(1, 0, 0, 24)
            secTitle.Text = secName:upper()
            secTitle.BackgroundTransparency = 1
            secTitle.TextColor3 = Color3.fromRGB(160, 110, 255)
            secTitle.Font = Enum.Font.GothamBold
            secTitle.TextSize = 9
            secTitle.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UIPadding", secTitle).PaddingLeft = UDim.new(0, 12)

            Instance.new("UIPadding", secFrame).PaddingBottom = UDim.new(0, 10)

            function sector:Cheat(type, label, callback, options)
                local cheat = {}
                if type == "Label" then
                    local l = Instance.new("TextLabel", secFrame)
                    l.Size = UDim2.new(0.92, 0, 0, 0)
                    l.AutomaticSize = Enum.AutomaticSize.Y
                    l.Text = label
                    l.TextColor3 = Color3.fromRGB(150, 150, 150)
                    l.BackgroundTransparency = 1
                    l.RichText = true
                    l.TextSize = 10
                    l.TextWrapped = true
                    l.TextXAlignment = Enum.TextXAlignment.Left
                    l.Font = Enum.Font.Gotham
                elseif type == "Button" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 26)
                    b.Text = (options and options.text ~= "") and options.text or label
                    b.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    b.TextColor3 = Color3.fromRGB(200, 200, 200)
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 10
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
                    local bs = Instance.new("UIStroke", b)
                    bs.Color = Color3.fromRGB(40, 40, 40)
                    
                    b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play() end)
                    b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}):Play() end)
                    b.MouseButton1Click:Connect(function()
                        local t = TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(160, 110, 255)})
                        t:Play() t.Completed:Wait()
                        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}):Play()
                        callback()
                    end)
                    UI.Features["- " .. label .. ":"] = {button = b}
                elseif type == "Checkbox" then
                    local val = options and options.enabled or false
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 26)
                    b.Text = label
                    b.BackgroundTransparency = 1
                    b.TextColor3 = val and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 10
                    b.TextXAlignment = Enum.TextXAlignment.Left
                    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0, 4)
                    
                    local back = Instance.new("Frame", b)
                    back.Size = UDim2.new(0, 28, 0, 14)
                    back.Position = UDim2.new(1, -32, 0.5, -7)
                    back.BackgroundColor3 = val and Color3.fromRGB(160, 110, 255) or Color3.fromRGB(35, 35, 35)
                    Instance.new("UICorner", back).CornerRadius = UDim.new(1, 0)
                    
                    local dot = Instance.new("Frame", back)
                    dot.Size = UDim2.new(0, 10, 0, 10)
                    dot.Position = val and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
                    dot.BackgroundColor3 = Color3.new(1, 1, 1)
                    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

                    function cheat:toggleState(s)
                        val = s
                        TweenService:Create(b, TweenInfo.new(0.25), {TextColor3 = val and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)}):Play()
                        TweenService:Create(back, TweenInfo.new(0.25), {BackgroundColor3 = val and Color3.fromRGB(160, 110, 255) or Color3.fromRGB(35, 35, 35)}):Play()
                        TweenService:Create(dot, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = val and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)}):Play()
                    end

                    b.MouseButton1Click:Connect(function()
                        val = not val
                        cheat:toggleState(val)
                        callback(val)
                    end)
                elseif type == "Dropdown" then
                    local d = Instance.new("TextBox", secFrame)
                    d.Size = UDim2.new(0.92, 0, 0, 26)
                    d.PlaceholderText = label
                    d.Text = (options and options.default) or ""
                    d.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                    d.TextColor3 = Color3.new(1, 1, 1)
                    d.Font = Enum.Font.Gotham
                    d.TextSize = 10
                    Instance.new("UICorner", d).CornerRadius = UDim.new(0, 3)
                    Instance.new("UIStroke", d).Color = Color3.fromRGB(40, 40, 40)
                    d.FocusLost:Connect(function() callback(d.Text) end)
                elseif type == "Textbox" then
                    local t = Instance.new("TextBox", secFrame)
                    t.Size = UDim2.new(0.92, 0, 0, 26)
                    t.PlaceholderText = (options and options.placeholder) or label
                    t.Text = ""
                    t.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
                    t.TextColor3 = Color3.new(1, 1, 1)
                    t.Font = Enum.Font.Gotham
                    t.TextSize = 10
                    Instance.new("UICorner", t).CornerRadius = UDim.new(0, 3)
                    Instance.new("UIStroke", t).Color = Color3.fromRGB(40, 40, 40)
                    t.FocusLost:Connect(function() callback(t.Text) end)
                elseif type == "Keybind" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(0.92, 0, 0, 26)
                    b.Text = label .. " [" .. (options and options.default or "None") .. "]"
                    b.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                    b.TextColor3 = Color3.fromRGB(180, 180, 180)
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 10
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
                    Instance.new("UIStroke", b).Color = Color3.fromRGB(40, 40, 40)
                    
                    b.MouseButton1Click:Connect(function()
                        b.Text = "Listening..."
                        b.TextColor3 = Color3.fromRGB(160, 110, 255)
                        local conn; conn = UserInputService.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.Keyboard then
                                conn:Disconnect()
                                b.Text = label .. " [" .. input.KeyCode.Name .. "]"
                                b.TextColor3 = Color3.fromRGB(180, 180, 180)
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
