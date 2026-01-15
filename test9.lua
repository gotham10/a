local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil
    local function Update(input)
        local Delta = input.Position - DragStart
        object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
    end
    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

function Library.new(Title, Size)
    local Window = {}
    local ExodusGUI = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Sidebar = Instance.new("Frame")
    local SidebarLayout = Instance.new("UIListLayout")
    local SidebarPadding = Instance.new("UIPadding")
    local TitleLabel = Instance.new("TextLabel")
    local ContentFrame = Instance.new("Frame")
    local UICorner_Main = Instance.new("UICorner")
    local UIStroke_Main = Instance.new("UIStroke")
    
    if getgenv().ExodusUI then
        getgenv().ExodusUI:Destroy()
    end
    getgenv().ExodusUI = ExodusGUI

    ExodusGUI.Name = "SystemExodusUI"
    ExodusGUI.Parent = CoreGui
    ExodusGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ExodusGUI
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -340, 0.5, -200)
    MainFrame.Size = Size or UDim2.new(0, 680, 0, 400)
    MainFrame.ClipsDescendants = true
    MakeDraggable(MainFrame, MainFrame)

    UICorner_Main.CornerRadius = UDim.new(0, 6)
    UICorner_Main.Parent = MainFrame

    UIStroke_Main.Parent = MainFrame
    UIStroke_Main.Color = Color3.fromRGB(45, 45, 45)
    UIStroke_Main.Thickness = 1

    TitleLabel.Parent = MainFrame
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1.000
    TitleLabel.Position = UDim2.new(0, 15, 0, 10)
    TitleLabel.Size = UDim2.new(0, 200, 0, 25)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14.000
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Sidebar.BorderSizePixel = 0
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.Size = UDim2.new(0, 160, 1, -45)

    SidebarLayout.Name = "SidebarLayout"
    SidebarLayout.Parent = Sidebar
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 4)

    SidebarPadding.Parent = Sidebar
    SidebarPadding.PaddingLeft = UDim.new(0, 10)
    SidebarPadding.PaddingTop = UDim.new(0, 10)

    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentFrame.BackgroundTransparency = 1.000
    ContentFrame.Position = UDim2.new(0, 170, 0, 45)
    ContentFrame.Size = UDim2.new(1, -180, 1, -55)

    local FirstCategory = true
    local Tabs = {}

    function Window:Category(Name)
        local Category = {}
        local TabButton = Instance.new("TextButton")
        local TabCorner = Instance.new("UICorner")
        local TabTitle = Instance.new("TextLabel")
        local SectorPage = Instance.new("ScrollingFrame")
        local SectorLayout = Instance.new("UIGridLayout")
        local SectorPadding = Instance.new("UIPadding")

        TabButton.Name = Name
        TabButton.Parent = Sidebar
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Size = UDim2.new(0, 140, 0, 30)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Text = ""
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14.000

        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = TabButton

        TabTitle.Name = "Title"
        TabTitle.Parent = TabButton
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Position = UDim2.new(0, 10, 0, 0)
        TabTitle.Size = UDim2.new(1, -10, 1, 0)
        TabTitle.Font = Enum.Font.GothamBold
        TabTitle.Text = Name
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 13.000
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left
        TabTitle.RichText = true

        SectorPage.Name = Name .. "_Page"
        SectorPage.Parent = ContentFrame
        SectorPage.Active = true
        SectorPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectorPage.BackgroundTransparency = 1.000
        SectorPage.BorderSizePixel = 0
        SectorPage.Size = UDim2.new(1, 0, 1, 0)
        SectorPage.ScrollBarThickness = 2
        SectorPage.ScrollBarImageColor3 = Color3.fromRGB(98, 37, 209)
        SectorPage.Visible = false

        SectorLayout.Parent = SectorPage
        SectorLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectorLayout.CellSize = UDim2.new(0.485, 0, 0, 0)
        SectorLayout.CellPadding = UDim2.new(0, 10, 0, 10)
        SectorLayout.FillDirectionMaxCells = 2

        SectorPadding.Parent = SectorPage
        SectorPadding.PaddingBottom = UDim.new(0, 10)
        SectorPadding.PaddingLeft = UDim.new(0, 2)
        SectorPadding.PaddingRight = UDim.new(0, 2)
        SectorPadding.PaddingTop = UDim.new(0, 2)

        if FirstCategory then
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectorPage.Visible = true
            FirstCategory = false
        end

        local function UpdateTabState()
            for _, Tab in ipairs(Tabs) do
                if Tab.Button == TabButton then
                    Tab.Button.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Tab.Page.Visible = true
                else
                    Tab.Button.Title.TextColor3 = Color3.fromRGB(150, 150, 150)
                    Tab.Page.Visible = false
                end
            end
        end

        TabButton.MouseButton1Click:Connect(UpdateTabState)
        table.insert(Tabs, {Button = TabButton, Page = SectorPage})

        function Category:Sector(SectorName)
            local Sector = {}
            local SectorFrame = Instance.new("Frame")
            local SectorCorner = Instance.new("UICorner")
            local SectorStroke = Instance.new("UIStroke")
            local SectorTitle = Instance.new("TextLabel")
            local SectorContainer = Instance.new("Frame")
            local SectorList = Instance.new("UIListLayout")
            local SectorInnerPadding = Instance.new("UIPadding")

            SectorFrame.Name = SectorName
            SectorFrame.Parent = SectorPage
            SectorFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            SectorFrame.Size = UDim2.new(1, 0, 0, 200) 
            SectorFrame.AutomaticSize = Enum.AutomaticSize.Y

            SectorCorner.CornerRadius = UDim.new(0, 5)
            SectorCorner.Parent = SectorFrame

            SectorStroke.Parent = SectorFrame
            SectorStroke.Color = Color3.fromRGB(40, 40, 40)
            SectorStroke.Thickness = 1
            SectorStroke.Transparency = 0.5

            SectorTitle.Name = "Title"
            SectorTitle.Parent = SectorFrame
            SectorTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectorTitle.BackgroundTransparency = 1.000
            SectorTitle.Position = UDim2.new(0, 10, 0, 5)
            SectorTitle.Size = UDim2.new(1, -20, 0, 20)
            SectorTitle.Font = Enum.Font.GothamBold
            SectorTitle.Text = SectorName
            SectorTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectorTitle.TextSize = 12.000
            SectorTitle.TextXAlignment = Enum.TextXAlignment.Left

            SectorContainer.Name = "Container"
            SectorContainer.Parent = SectorFrame
            SectorContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SectorContainer.BackgroundTransparency = 1.000
            SectorContainer.Position = UDim2.new(0, 0, 0, 30)
            SectorContainer.Size = UDim2.new(1, 0, 1, -30)
            SectorContainer.AutomaticSize = Enum.AutomaticSize.Y

            SectorList.Parent = SectorContainer
            SectorList.SortOrder = Enum.SortOrder.LayoutOrder
            SectorList.Padding = UDim.new(0, 6)

            SectorInnerPadding.Parent = SectorContainer
            SectorInnerPadding.PaddingBottom = UDim.new(0, 10)
            SectorInnerPadding.PaddingLeft = UDim.new(0, 10)
            SectorInnerPadding.PaddingRight = UDim.new(0, 10)

            function Sector:Cheat(Type, Label, Callback, Options)
                Options = Options or {}
                local Cheat = {}

                if Type == "Label" then
                    local LabelFrame = Instance.new("Frame")
                    local LabelText = Instance.new("TextLabel")

                    LabelFrame.Name = "Label"
                    LabelFrame.Parent = SectorContainer
                    LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    LabelFrame.BackgroundTransparency = 1.000
                    LabelFrame.Size = UDim2.new(1, 0, 0, 20)
                    LabelFrame.AutomaticSize = Enum.AutomaticSize.Y

                    LabelText.Parent = LabelFrame
                    LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    LabelText.BackgroundTransparency = 1.000
                    LabelText.Size = UDim2.new(1, 0, 0, 20)
                    LabelText.Font = Enum.Font.Gotham
                    LabelText.Text = Label
                    LabelText.TextColor3 = Color3.fromRGB(200, 200, 200)
                    LabelText.TextSize = 11.000
                    LabelText.TextXAlignment = Enum.TextXAlignment.Left
                    LabelText.TextWrapped = true
                    LabelText.RichText = true
                    LabelText.AutomaticSize = Enum.AutomaticSize.Y

                    function Cheat:Set(NewText)
                        LabelText.Text = NewText
                    end

                elseif Type == "Checkbox" then
                    local CheckFrame = Instance.new("Frame")
                    local CheckButton = Instance.new("TextButton")
                    local CheckTitle = Instance.new("TextLabel")
                    local CheckBox = Instance.new("Frame")
                    local CheckBoxCorner = Instance.new("UICorner")
                    local CheckBoxStroke = Instance.new("UIStroke")
                    local CheckIndicator = Instance.new("Frame")
                    local CheckIndicatorCorner = Instance.new("UICorner")

                    local Enabled = Options.enabled or false

                    CheckFrame.Name = "Checkbox"
                    CheckFrame.Parent = SectorContainer
                    CheckFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    CheckFrame.BackgroundTransparency = 1.000
                    CheckFrame.Size = UDim2.new(1, 0, 0, 26)

                    CheckButton.Parent = CheckFrame
                    CheckButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    CheckButton.BackgroundTransparency = 1.000
                    CheckButton.Size = UDim2.new(1, 0, 1, 0)
                    CheckButton.Font = Enum.Font.SourceSans
                    CheckButton.Text = ""
                    CheckButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    CheckButton.TextSize = 14.000

                    CheckTitle.Parent = CheckFrame
                    CheckTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    CheckTitle.BackgroundTransparency = 1.000
                    CheckTitle.Size = UDim2.new(1, -30, 1, 0)
                    CheckTitle.Font = Enum.Font.GothamMedium
                    CheckTitle.Text = Label
                    CheckTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                    CheckTitle.TextSize = 11.000
                    CheckTitle.TextXAlignment = Enum.TextXAlignment.Left
                    CheckTitle.RichText = true

                    CheckBox.Name = "Box"
                    CheckBox.Parent = CheckFrame
                    CheckBox.AnchorPoint = Vector2.new(1, 0.5)
                    CheckBox.BackgroundColor3 = Enabled and Color3.fromRGB(98, 37, 209) or Color3.fromRGB(35, 35, 35)
                    CheckBox.Position = UDim2.new(1, 0, 0.5, 0)
                    CheckBox.Size = UDim2.new(0, 18, 0, 18)

                    CheckBoxCorner.CornerRadius = UDim.new(0, 4)
                    CheckBoxCorner.Parent = CheckBox

                    CheckBoxStroke.Parent = CheckBox
                    CheckBoxStroke.Color = Color3.fromRGB(60, 60, 60)
                    CheckBoxStroke.Thickness = 1

                    CheckIndicator.Name = "Indicator"
                    CheckIndicator.Parent = CheckBox
                    CheckIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
                    CheckIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    CheckIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
                    CheckIndicator.Size = UDim2.new(0, 10, 0, 10)
                    CheckIndicator.BackgroundTransparency = Enabled and 0 or 1

                    CheckIndicatorCorner.CornerRadius = UDim.new(0, 2)
                    CheckIndicatorCorner.Parent = CheckIndicator

                    local function UpdateState()
                        Enabled = not Enabled
                        local TweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        if Enabled then
                            TweenService:Create(CheckBox, TweenInfo, {BackgroundColor3 = Color3.fromRGB(98, 37, 209)}):Play()
                            TweenService:Create(CheckIndicator, TweenInfo, {BackgroundTransparency = 0}):Play()
                            CheckTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                            TweenService:Create(CheckBox, TweenInfo, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                            TweenService:Create(CheckIndicator, TweenInfo, {BackgroundTransparency = 1}):Play()
                            CheckTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                        end
                        Callback(Enabled)
                    end

                    CheckButton.MouseButton1Click:Connect(UpdateState)

                    function Cheat:toggleState(State)
                        if State ~= Enabled then
                            UpdateState()
                        end
                    end

                elseif Type == "Button" then
                    local ButtonFrame = Instance.new("Frame")
                    local ButtonBtn = Instance.new("TextButton")
                    local ButtonCorner = Instance.new("UICorner")
                    local ButtonStroke = Instance.new("UIStroke")

                    ButtonFrame.Name = "Button"
                    ButtonFrame.Parent = SectorContainer
                    ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ButtonFrame.BackgroundTransparency = 1.000
                    ButtonFrame.Size = UDim2.new(1, 0, 0, 28)

                    ButtonBtn.Parent = ButtonFrame
                    ButtonBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    ButtonBtn.Size = UDim2.new(1, 0, 1, 0)
                    ButtonBtn.AutoButtonColor = false
                    ButtonBtn.Font = Enum.Font.GothamMedium
                    ButtonBtn.Text = (Options.text and Options.text ~= "") and Options.text or Label
                    ButtonBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                    ButtonBtn.TextSize = 11.000
                    ButtonBtn.RichText = true

                    ButtonCorner.CornerRadius = UDim.new(0, 4)
                    ButtonCorner.Parent = ButtonBtn

                    ButtonStroke.Parent = ButtonBtn
                    ButtonStroke.Color = Color3.fromRGB(60, 60, 60)
                    ButtonStroke.Thickness = 1

                    ButtonBtn.MouseEnter:Connect(function()
                        TweenService:Create(ButtonBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
                    end)
                    ButtonBtn.MouseLeave:Connect(function()
                        TweenService:Create(ButtonBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                    end)
                    ButtonBtn.MouseButton1Click:Connect(function()
                        TweenService:Create(ButtonBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(98, 37, 209)}):Play()
                        task.wait(0.1)
                        TweenService:Create(ButtonBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                        Callback()
                    end)

                elseif Type == "Dropdown" then
                    local DropdownFrame = Instance.new("Frame")
                    local DropdownBtn = Instance.new("TextButton")
                    local DropdownCorner = Instance.new("UICorner")
                    local DropdownStroke = Instance.new("UIStroke")
                    local DropdownLabel = Instance.new("TextLabel")
                    local DropdownArrow = Instance.new("ImageLabel")
                    local DropdownListFrame = Instance.new("Frame")
                    local DropdownListLayout = Instance.new("UIListLayout")
                    local DropdownScroll = Instance.new("ScrollingFrame")
                    local DropdownListCorner = Instance.new("UICorner")
                    local DropdownListStroke = Instance.new("UIStroke")

                    local OptionsList = Options.options or {}
                    local Default = Options.default or "(Select/None)"
                    local Open = false

                    DropdownFrame.Name = "Dropdown"
                    DropdownFrame.Parent = SectorContainer
                    DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownFrame.BackgroundTransparency = 1.000
                    DropdownFrame.Size = UDim2.new(1, 0, 0, 42)
                    DropdownFrame.ZIndex = 2

                    local DropTitle = Instance.new("TextLabel")
                    DropTitle.Parent = DropdownFrame
                    DropTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropTitle.BackgroundTransparency = 1.000
                    DropTitle.Size = UDim2.new(1, 0, 0, 14)
                    DropTitle.Font = Enum.Font.GothamMedium
                    DropTitle.Text = Label
                    DropTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
                    DropTitle.TextSize = 11.000
                    DropTitle.TextXAlignment = Enum.TextXAlignment.Left
                    DropTitle.RichText = true

                    DropdownBtn.Parent = DropdownFrame
                    DropdownBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    DropdownBtn.Position = UDim2.new(0, 0, 0, 16)
                    DropdownBtn.Size = UDim2.new(1, 0, 0, 26)
                    DropdownBtn.AutoButtonColor = false
                    DropdownBtn.Font = Enum.Font.SourceSans
                    DropdownBtn.Text = ""
                    DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                    DropdownBtn.TextSize = 14.000

                    DropdownCorner.CornerRadius = UDim.new(0, 4)
                    DropdownCorner.Parent = DropdownBtn

                    DropdownStroke.Parent = DropdownBtn
                    DropdownStroke.Color = Color3.fromRGB(60, 60, 60)
                    DropdownStroke.Thickness = 1

                    DropdownLabel.Parent = DropdownBtn
                    DropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownLabel.BackgroundTransparency = 1.000
                    DropdownLabel.Position = UDim2.new(0, 8, 0, 0)
                    DropdownLabel.Size = UDim2.new(1, -30, 1, 0)
                    DropdownLabel.Font = Enum.Font.Gotham
                    DropdownLabel.Text = Default
                    DropdownLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                    DropdownLabel.TextSize = 11.000
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownLabel.TextTruncate = Enum.TextTruncate.AtEnd

                    DropdownArrow.Parent = DropdownBtn
                    DropdownArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownArrow.BackgroundTransparency = 1.000
                    DropdownArrow.Position = UDim2.new(1, -22, 0, 5)
                    DropdownArrow.Size = UDim2.new(0, 16, 0, 16)
                    DropdownArrow.Image = "rbxassetid://6031090990"
                    DropdownArrow.ImageColor3 = Color3.fromRGB(150, 150, 150)

                    DropdownListFrame.Name = "List"
                    DropdownListFrame.Parent = MainFrame
                    DropdownListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    DropdownListFrame.Visible = false
                    DropdownListFrame.ZIndex = 100
                    
                    DropdownListCorner.CornerRadius = UDim.new(0, 4)
                    DropdownListCorner.Parent = DropdownListFrame
                    
                    DropdownListStroke.Parent = DropdownListFrame
                    DropdownListStroke.Color = Color3.fromRGB(60, 60, 60)
                    DropdownListStroke.Thickness = 1

                    DropdownScroll.Parent = DropdownListFrame
                    DropdownScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownScroll.BackgroundTransparency = 1.000
                    DropdownScroll.BorderSizePixel = 0
                    DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
                    DropdownScroll.ScrollBarThickness = 2
                    DropdownScroll.ScrollBarImageColor3 = Color3.fromRGB(98, 37, 209)

                    DropdownListLayout.Parent = DropdownScroll
                    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    
                    local function RefreshList()
                        for _, v in pairs(DropdownScroll:GetChildren()) do
                            if v:IsA("TextButton") then v:Destroy() end
                        end
                        for _, v in pairs(OptionsList) do
                            local OptionBtn = Instance.new("TextButton")
                            OptionBtn.Parent = DropdownScroll
                            OptionBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                            OptionBtn.BorderSizePixel = 0
                            OptionBtn.Size = UDim2.new(1, 0, 0, 24)
                            OptionBtn.Font = Enum.Font.Gotham
                            OptionBtn.Text = v
                            OptionBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                            OptionBtn.TextSize = 11.000
                            OptionBtn.ZIndex = 101
                            OptionBtn.MouseButton1Click:Connect(function()
                                DropdownLabel.Text = v
                                Callback(v)
                                Open = false
                                DropdownListFrame.Visible = false
                            end)
                        end
                        DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, DropdownListLayout.AbsoluteContentSize.Y)
                    end
                    RefreshList()

                    DropdownBtn.MouseButton1Click:Connect(function()
                        Open = not Open
                        if Open then
                            RefreshList()
                            DropdownListFrame.Size = UDim2.new(0, DropdownBtn.AbsoluteSize.X, 0, math.min(#OptionsList * 24, 150))
                            DropdownListFrame.Position = UDim2.new(0, DropdownBtn.AbsolutePosition.X, 0, DropdownBtn.AbsolutePosition.Y + DropdownBtn.AbsoluteSize.Y + 5)
                            DropdownListFrame.Visible = true
                        else
                            DropdownListFrame.Visible = false
                        end
                    end)
                    
                    UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if Open and not DropdownListFrame.Visible then Open = false end 
                            if Open then
                                local MousePos = UserInputService:GetMouseLocation()
                                local FramePos = DropdownListFrame.AbsolutePosition
                                local FrameSize = DropdownListFrame.AbsoluteSize
                                if MousePos.X < FramePos.X or MousePos.X > FramePos.X + FrameSize.X or MousePos.Y < FramePos.Y + 36 or MousePos.Y > FramePos.Y + FrameSize.Y + 36 then
                                     -- Offset for gui inset
                                     if not (MousePos.X >= DropdownBtn.AbsolutePosition.X and MousePos.X <= DropdownBtn.AbsolutePosition.X + DropdownBtn.AbsoluteSize.X and MousePos.Y >= DropdownBtn.AbsolutePosition.Y + 36 and MousePos.Y <= DropdownBtn.AbsolutePosition.Y + DropdownBtn.AbsoluteSize.Y + 36) then
                                        Open = false
                                        DropdownListFrame.Visible = false
                                     end
                                end
                            end
                        end
                    end)

                elseif Type == "Textbox" then
                    local TextboxFrame = Instance.new("Frame")
                    local TextBoxCorner = Instance.new("UICorner")
                    local TextBoxStroke = Instance.new("UIStroke")
                    local Input = Instance.new("TextBox")
                    
                    TextboxFrame.Name = "Textbox"
                    TextboxFrame.Parent = SectorContainer
                    TextboxFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    TextboxFrame.Size = UDim2.new(1, 0, 0, 26)

                    TextBoxCorner.CornerRadius = UDim.new(0, 4)
                    TextBoxCorner.Parent = TextboxFrame

                    TextBoxStroke.Parent = TextboxFrame
                    TextBoxStroke.Color = Color3.fromRGB(60, 60, 60)
                    TextBoxStroke.Thickness = 1
                    
                    Input.Parent = TextboxFrame
                    Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Input.BackgroundTransparency = 1.000
                    Input.Position = UDim2.new(0, 8, 0, 0)
                    Input.Size = UDim2.new(1, -16, 1, 0)
                    Input.Font = Enum.Font.Gotham
                    Input.PlaceholderText = Options.placeholder or Label
                    Input.Text = ""
                    Input.TextColor3 = Color3.fromRGB(220, 220, 220)
                    Input.TextSize = 11.000
                    Input.TextXAlignment = Enum.TextXAlignment.Left
                    Input.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)

                    Input.FocusLost:Connect(function(enterPressed)
                        Callback(Input.Text)
                    end)

                elseif Type == "Keybind" then
                    local KeybindFrame = Instance.new("Frame")
                    local KeybindBtn = Instance.new("TextButton")
                    local KeybindCorner = Instance.new("UICorner")
                    local KeybindStroke = Instance.new("UIStroke")

                    KeybindFrame.Name = "Keybind"
                    KeybindFrame.Parent = SectorContainer
                    KeybindFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    KeybindFrame.BackgroundTransparency = 1.000
                    KeybindFrame.Size = UDim2.new(1, 0, 0, 26)

                    KeybindBtn.Parent = KeybindFrame
                    KeybindBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    KeybindBtn.Size = UDim2.new(1, 0, 1, 0)
                    KeybindBtn.AutoButtonColor = false
                    KeybindBtn.Font = Enum.Font.Gotham
                    KeybindBtn.Text = Label .. ": " .. (Options.default or "None")
                    KeybindBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                    KeybindBtn.TextSize = 11.000

                    KeybindCorner.CornerRadius = UDim.new(0, 4)
                    KeybindCorner.Parent = KeybindBtn

                    KeybindStroke.Parent = KeybindBtn
                    KeybindStroke.Color = Color3.fromRGB(60, 60, 60)
                    KeybindStroke.Thickness = 1

                    local Listening = false

                    KeybindBtn.MouseButton1Click:Connect(function()
                        Listening = true
                        KeybindBtn.Text = "Press any key..."
                        KeybindBtn.TextColor3 = Color3.fromRGB(98, 37, 209)
                    end)

                    UserInputService.InputBegan:Connect(function(input)
                        if Listening and input.UserInputType == Enum.UserInputType.Keyboard then
                            Listening = false
                            KeybindBtn.Text = Label .. ": " .. input.KeyCode.Name
                            KeybindBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
                            Callback(input.KeyCode)
                        end
                    end)
                end

                return Cheat
            end

            return Sector
        end

        return Category
    end

    function Window.ChangeToggleKey(NewKey)
        UserInputService.InputBegan:Connect(function(input, gpe)
            if not gpe and input.KeyCode == NewKey then
                ExodusGUI.Enabled = not ExodusGUI.Enabled
            end
        end)
    end

    return Window
end

local Notification = {}
function Notification:Notify(Data, Settings, Icon)
    local NotifyFrame = Instance.new("Frame")
    local NotifyCorner = Instance.new("UICorner")
    local NotifyStroke = Instance.new("UIStroke")
    local NotifyTitle = Instance.new("TextLabel")
    local NotifyDesc = Instance.new("TextLabel")

    local NotifyGui = getgenv().ExodusUI or Instance.new("ScreenGui", CoreGui)

    NotifyFrame.Parent = NotifyGui
    NotifyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    NotifyFrame.Position = UDim2.new(1, 10, 1, -100)
    NotifyFrame.Size = UDim2.new(0, 250, 0, 60)

    NotifyCorner.CornerRadius = UDim.new(0, 6)
    NotifyCorner.Parent = NotifyFrame

    NotifyStroke.Parent = NotifyFrame
    NotifyStroke.Color = Color3.fromRGB(98, 37, 209)
    NotifyStroke.Thickness = 1

    NotifyTitle.Parent = NotifyFrame
    NotifyTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotifyTitle.BackgroundTransparency = 1.000
    NotifyTitle.Position = UDim2.new(0, 10, 0, 5)
    NotifyTitle.Size = UDim2.new(1, -20, 0, 20)
    NotifyTitle.Font = Enum.Font.GothamBold
    NotifyTitle.Text = Data.Title or "Notification"
    NotifyTitle.TextColor3 = Color3.fromRGB(98, 37, 209)
    NotifyTitle.TextSize = 12.000
    NotifyTitle.TextXAlignment = Enum.TextXAlignment.Left

    NotifyDesc.Parent = NotifyFrame
    NotifyDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotifyDesc.BackgroundTransparency = 1.000
    NotifyDesc.Position = UDim2.new(0, 10, 0, 25)
    NotifyDesc.Size = UDim2.new(1, -20, 1, -30)
    NotifyDesc.Font = Enum.Font.Gotham
    NotifyDesc.Text = Data.Description or ""
    NotifyDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifyDesc.TextSize = 11.000
    NotifyDesc.TextXAlignment = Enum.TextXAlignment.Left
    NotifyDesc.TextWrapped = true

    TweenService:Create(NotifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -260, 1, -100)}):Play()

    task.wait(Settings.Time or 3)
    local Close = TweenService:Create(NotifyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 1, -100)})
    Close:Play()
    Close.Completed:Wait()
    NotifyFrame:Destroy()
end

local Version = {
    Version = "1.0",
    Date = "05/22/2024",
    Changelog = {},
    Emojis = {}
}
function Version:Get(x) return Version end

return Library, Notification, Version
