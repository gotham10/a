local Finity = {}
local Notification = {}
local Version = {
    Version = "2.1.0",
    Date = "05/22/2024",
    PlaceVersion = game.PlaceVersion,
    Changelog = {
        "Reconstructed UI Loader",
        "Fixed Emoji Mappings",
        "Restored Notification System"
    },
    Emojis = {
        ["Island"] = "🏝️", ["Clipboard"] = "📋", ["Tractor"] = "🚜", ["Sword"] = "⚔️",
        ["Machine"] = "⚙️", ["Glass"] = "🔍", ["Barrier"] = "🚧", ["Gear"] = "⚙️",
        ["Scroll"] = "📜", ["PurpleHeart"] = "💜", ["Sparkle"] = "✨", ["Link"] = "🔗",
        ["Keyboard"] = "⌨️", ["Keyboard"] = "⌨️", ["Crop"] = "🌾", ["Berry"] = "🍓",
        ["Pickaxe"] = "⛏️", ["Axe"] = "🪓", ["Box"] = "📦", ["Droplet"] = "💧",
        ["Flower"] = "🌸", ["SkullCross"] = "☠️", ["Fish"] = "🐟", ["Firefly"] = "🪲",
        ["Bee"] = "🐝", ["Rabbit"] = "🐇", ["Frog"] = "🐸", ["Ghost"] = "👻",
        ["Fire"] = "🔥", ["Shine"] = "✨", ["Watch"] = "⌚", ["Food"] = "🍎",
        ["Pin"] = "📍", ["Eyes"] = "👀", ["Amount"] = "🔢", ["Purple"] = "🟣",
        ["Map"] = "🗺️", ["Print"] = "🖨️", ["Hammer"] = "🔨", ["Abort"] = "🛑",
        ["Rotate"] = "🔄", ["Add"] = "➕", ["File"] = "📄", ["Rocket"] = "🚀",
        ["Paper"] = "📝", ["Save"] = "💾", ["Scale"] = "⚖️", ["Fly"] = "🕊️",
        ["Noclip"] = "👻", ["Watch"] = "⌚", ["Warning"] = "⚠️"
    }
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

function Notification:Notify(info, style, icon)
    local sg = Instance.new("ScreenGui", CoreGui)
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 250, 0, 80)
    frame.Position = UDim2.new(1, -260, 1, -90)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner", frame)
    local title = Instance.new("TextLabel", frame)
    title.Text = info.Title or "Notification"
    title.Size = UDim2.new(1, -10, 0, 30)
    title.Position = UDim2.new(0, 5, 0, 5)
    title.TextColor3 = Color3.new(1, 1, 1)
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Font = Enum.Font.GothamBold
    
    local desc = Instance.new("TextLabel", frame)
    desc.Text = info.Description or ""
    desc.Size = UDim2.new(1, -10, 1, -40)
    desc.Position = UDim2.new(0, 5, 0, 35)
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true
    desc.Font = Enum.Font.Gotham
    
    task.delay(style.Time or 3, function()
        frame:Destroy()
        sg:Destroy()
    end)
end

function Finity.new(title, size, ?, callback)
    local UI = {Features = {}}
    local toggleKey = Enum.KeyCode.RightShift
    
    local sg = Instance.new("ScreenGui", CoreGui)
    sg.Name = "FinityUI"
    local main = Instance.new("Frame", sg)
    main.Size = size
    main.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    local titleLabel = Instance.new("TextLabel", header)
    titleLabel.Size = UDim2.new(1, -10, 1, 0)
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
    catContainer.Size = UDim2.new(0, 150, 1, -40)
    catContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    local content = Instance.new("Frame", main)
    content.Position = UDim2.new(0, 150, 0, 40)
    content.Size = UDim2.new(1, -150, 1, -40)
    content.BackgroundTransparency = 1

    function UI.ChangeToggleKey(key) toggleKey = key end
    
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == toggleKey then
            main.Visible = not main.Visible
        end
    end)

    function UI:Category(name)
        local cat = {R = {}}
        UI.container.Categories[name] = cat
        
        local btn = Instance.new("TextButton", catContainer)
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.Gotham
        btn.RichText = true
        
        local catFrame = Instance.new("ScrollingFrame", content)
        catFrame.Size = UDim2.new(1, 0, 1, 0)
        catFrame.Visible = false
        catFrame.BackgroundTransparency = 1
        catFrame.CanvasSize = UDim2.new(0,0,2,0)
        
        local layout = Instance.new("UIGridLayout", catFrame)
        layout.CellPadding = UDim2.new(0, 5, 0, 5)
        layout.CellSize = UDim2.new(0.48, 0, 0, 200)

        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(content:GetChildren()) do v.Visible = false end
            catFrame.Visible = true
        end)

        function cat:Sector(secName)
            local sector = {}
            local secFrame = Instance.new("Frame", catFrame)
            secFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            cat.R[secName] = {Container = secFrame}
            
            local secLayout = Instance.new("UIListLayout", secFrame)
            secLayout.Padding = UDim.new(0, 5)
            
            local secTitle = Instance.new("TextLabel", secFrame)
            secTitle.Size = UDim2.new(1, 0, 0, 20)
            secTitle.Text = secName
            secTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            secTitle.TextColor3 = Color3.new(1, 1, 1)
            secTitle.Font = Enum.Font.GothamBold

            function sector:Cheat(type, label, callback, options)
                local cheat = {}
                if type == "Label" then
                    local l = Instance.new("TextLabel", secFrame)
                    l.Size = UDim2.new(1, 0, 0, 20)
                    l.Text = label
                    l.TextColor3 = Color3.new(1, 1, 1)
                    l.BackgroundTransparency = 1
                    l.RichText = true
                    l.TextWrapped = true
                elseif type == "Button" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(1, 0, 0, 25)
                    b.Text = label
                    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    b.TextColor3 = Color3.new(1, 1, 1)
                    b.MouseButton1Click:Connect(callback)
                    UI.Features["- " .. label .. ":"] = {button = b}
                elseif type == "Checkbox" then
                    local val = options.enabled or false
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(1, 0, 0, 25)
                    b.Text = label .. ": " .. (val and "ON" or "OFF")
                    b.BackgroundColor3 = val and Color3.fromRGB(50, 100, 50) or Color3.fromRGB(100, 50, 50)
                    
                    function cheat:toggleState(s)
                        val = s
                        b.Text = label .. ": " .. (val and "ON" or "OFF")
                        b.BackgroundColor3 = val and Color3.fromRGB(50, 100, 50) or Color3.fromRGB(100, 50, 50)
                    end

                    b.MouseButton1Click:Connect(function()
                        val = not val
                        cheat:toggleState(val)
                        callback(val)
                    end)
                elseif type == "Dropdown" then
                    local d = Instance.new("TextBox", secFrame)
                    d.Size = UDim2.new(1, 0, 0, 25)
                    d.PlaceholderText = label
                    d.Text = options.default or ""
                    d.FocusLost:Connect(function() callback(d.Text) end)
                elseif type == "Textbox" then
                    local t = Instance.new("TextBox", secFrame)
                    t.Size = UDim2.new(1, 0, 0, 25)
                    t.PlaceholderText = options.placeholder or label
                    t.FocusLost:Connect(function() callback(t.Text) end)
                elseif type == "Keybind" then
                    local b = Instance.new("TextButton", secFrame)
                    b.Size = UDim2.new(1, 0, 0, 25)
                    b.Text = label
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
