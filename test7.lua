local Finity = {}
local Notification = {}
local Version = {
    Version = "2.1.0",
    Date = "September 4th",
    PlaceVersion = game.PlaceVersion,
    Changelog = {
        "[+] Beta Testing 🧪"
    },
    Emojis = {
        ["Home"] = "📋", ["Farming"] = "🚜", ["Creatures"] = "⚔️",
        ["Machinery"] = "🏗️", ["Miscellaneous"] = "🔍", ["World Edit"] = "🛠️",
        ["Settings"] = "⚙️", ["Islands"] = "🏝️", ["Scroll"] = "📜",
        ["PurpleHeart"] = "💜", ["Sparkle"] = "✨", ["Link"] = "🔗"
    }
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

function Notification:Notify(info, style, icon)
    local sg = Instance.new("ScreenGui", CoreGui)
    local frame = Instance.new("Frame", sg)
    frame.Size = UDim2.new(0, 280, 0, 70)
    frame.Position = UDim2.new(1, 10, 1, -85)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 4)
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
    desc.TextColor3 = Color3.fromRGB(180, 180, 180)
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.TextWrapped = true
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 10
    desc.RichText = true
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -295, 1, -85)}):Play()
    task.delay(style and style.Time or 3, function()
        local t = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 10, 1, -85)})
        t:Play()
        t.Completed:Wait()
        sg:Destroy()
    end)
end

function Finity.new(title, size)
    local UI = {Features = {}}
    local toggleKey = Enum.KeyCode.RightShift
    local sg = Instance.new("ScreenGui", CoreGui)
    local main = Instance.new("Frame", sg)
    main.Size = size
    main.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BorderSizePixel = 0
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 4)
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0, 160, 1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    sidebar.BorderSizePixel = 0
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 4)
    local sidebarLine = Instance.new("Frame", sidebar)
    sidebarLine.Size = UDim2.new(0, 1, 1, 0)
    sidebarLine.Position = UDim2.new(1, 0, 0, 0)
    sidebarLine.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    sidebarLine.BorderSizePixel = 0
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 35)
    header.BackgroundTransparency = 1
    local titleLabel = Instance.new("TextLabel", header)
    titleLabel.Size = UDim2.new(1, -20, 1, 0)
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 13
    local container = Instance.new("Frame", main)
    container.Size = UDim2.new(1, -165, 1, -45)
    container.Position = UDim2.new(0, 165, 0, 45)
    container.BackgroundTransparency = 1
    local sideList = Instance.new("UIListLayout", sidebar)
    sideList.Padding = UDim.new(0, 2)
    Instance.new("UIPadding", sidebar).PaddingTop = UDim.new(0, 40)
    local dragging, dragInput, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == toggleKey then main.Visible = not main.Visible end
    end)
    function UI:Category(name, icon)
        local cat = {Sectors = {}}
        local btn = Instance.new("TextButton", sidebar)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.BackgroundTransparency = 1
        btn.Text = icon .. "  " .. name
        btn.TextColor3 = Color3.fromRGB(180, 180, 180)
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 11
        btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UIPadding", btn).PaddingLeft = UDim.new(0, 15)
        local page = Instance.new("ScrollingFrame", container)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.ScrollBarThickness = 0
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local pageLayout = Instance.new("UIListLayout", page)
        pageLayout.Padding = UDim.new(0, 15)
        btn.MouseButton1Click:Connect(function()
            for _, v in pairs(container:GetChildren()) do v.Visible = false end
            for _, v in pairs(sidebar:GetChildren()) do
                if v:IsA("TextButton") then TweenService:Create(v, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play() end
            end
            page.Visible = true
            TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = Color3.new(1, 1, 1)}):Play()
            page.GroupTransparency = 1
            TweenService:Create(page, TweenInfo.new(0.4), {GroupTransparency = 0}):Play()
        end)
        function cat:Sector(secName)
            local sec = {}
            local secFrame = Instance.new("Frame", page)
            secFrame.Size = UDim2.new(1, -10, 0, 0)
            secFrame.AutomaticSize = Enum.AutomaticSize.Y
            secFrame.BackgroundTransparency = 1
            local secTitle = Instance.new("TextLabel", secFrame)
            secTitle.Size = UDim2.new(1, 0, 0, 20)
            secTitle.Text = secName
            secTitle.TextColor3 = Color3.new(1, 1, 1)
            secTitle.Font = Enum.Font.GothamBold
            secTitle.TextSize = 12
            secTitle.TextXAlignment = Enum.TextXAlignment.Left
            secTitle.BackgroundTransparency = 1
            local items = Instance.new("Frame", secFrame)
            items.Size = UDim2.new(1, 0, 0, 0)
            items.Position = UDim2.new(0, 0, 0, 25)
            items.AutomaticSize = Enum.AutomaticSize.Y
            items.BackgroundTransparency = 1
            local itemLayout = Instance.new("UIListLayout", items)
            itemLayout.Padding = UDim.new(0, 5)
            function sec:Cheat(type, label, callback, options)
                if type == "Label" then
                    local l = Instance.new("TextLabel", items)
                    l.Size = UDim2.new(1, 0, 0, 18)
                    l.Text = "- " .. label
                    l.TextColor3 = Color3.fromRGB(180, 180, 180)
                    l.Font = Enum.Font.Gotham
                    l.TextSize = 11
                    l.TextXAlignment = Enum.TextXAlignment.Left
                    l.BackgroundTransparency = 1
                elseif type == "Button" then
                    local b = Instance.new("TextButton", items)
                    b.Size = UDim2.new(0, 120, 0, 24)
                    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    b.Text = options and options.text or label
                    b.TextColor3 = Color3.new(1, 1, 1)
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 11
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
                    b.MouseButton1Click:Connect(callback)
                    UI.Features["- " .. label .. ":"] = {button = b}
                end
            end
            return sec
        end
        return cat
    end
    function UI:SelectHome()
        local first = sidebar:FindFirstChildWhichIsA("TextButton")
        if first then
            for _, v in pairs(container:GetChildren()) do v.Visible = false end
            container:FindFirstChildWhichIsA("ScrollingFrame").Visible = true
            first.TextColor3 = Color3.new(1, 1, 1)
        end
    end
    return UI
end

local UI = Finity.new("Islands | System Exodus (Premium Version)", UDim2.new(0, 680, 0, 370))
local Home = UI:Category("Home", Version.Emojis.Home)
local Farming = UI:Category("Farming", Version.Emojis.Farming)
local Creatures = UI:Category("Creatures", Version.Emojis.Creatures)
local Machinery = UI:Category("Machinery", Version.Emojis.Machinery)
local Miscellaneous = UI:Category("Miscellaneous", Version.Emojis.Miscellaneous)
local WorldEdit = UI:Category("World Edit", Version.Emojis.WorldEdit)
local Settings = UI:Category("Settings", Version.Emojis.Settings)

local IslandsSec = Home:Sector("Islands")
IslandsSec:Cheat("Label", "Scripted by: wYn#0001 & Jxnt#9946")
IslandsSec:Cheat("Label", "UI by: deto#1153 & xxxYoloxxx999#2166")
IslandsSec:Cheat("Label", "To minimize the script, press RightShift")
IslandsSec:Cheat("Button", "Discord Invite", function() setclipboard("https://discord.gg/SystemExodus") end, {text = "Copy / Join"})

local UpdateSec = Home:Sector("UI Update (September 4th)")
UpdateSec:Cheat("Label", "[+] Beta Testing 🧪")

UI:SelectHome()
return UI
