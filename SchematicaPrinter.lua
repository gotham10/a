local Keys = getgenv().Keys or {
    PlaceBlockArgName = "mugxoJixuszjvCbkdfloi",
    PlaceBlockArgCode = "\a\240\159\164\163\240\159\164\161\a\n\a\n\a\nswxTUgrkwbsbjf",
    DestroyBlockArgName = "vzzysogImQgcZtgeF",
    DestroyBlockArgCode = "\a\240\159\164\163\240\159\164\161\a\n\a\n\a\nyzwicssuxmkzmqvbgqgQMuyc"
}

local Printer = {}
Printer.__index = Printer

local Remotes = game.ReplicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged

function Printer.new(Data)
    local self = setmetatable({}, Printer)
    self.Data = Data
    self.Blocks = Data.Blocks or {}
    self.Model = Instance.new("Model")
    self.Model.Name = "SchematicPreview"
    self.PrimaryPart = nil
    self.CFrame = CFrame.new()
    self.Abort = false
    self.Transparency = 0.5
    return self
end

function Printer:Init()
    for blockName, positions in pairs(self.Blocks) do
        for _, data in ipairs(positions) do
            local cf = CFrame.new(unpack(data.C))
            local p = Instance.new("Part")
            p.Name = blockName
            p.Size = Vector3.new(3, 3, 3)
            p.Transparency = self.Transparency
            p.CanCollide = false
            p.Anchored = true
            p.Material = Enum.Material.SmoothPlastic
            p.CFrame = cf
            p.Parent = self.Model
            if not self.PrimaryPart then
                self.PrimaryPart = p
                self.Model.PrimaryPart = p
            end
        end
    end
end

function Printer:SetCFrame(cf)
    self.CFrame = cf
    if self.Model.PrimaryPart then
        self.Model:SetPrimaryPartCFrame(cf)
    end
end

function Printer:SetVisibility(val)
    self.Transparency = val
    for _, v in ipairs(self.Model:GetChildren()) do
        if v:IsA("BasePart") then
            v.Transparency = val
        end
    end
end

function Printer:Render(state)
    if state then
        self.Model.Parent = workspace
    else
        self.Model.Parent = nil
    end
end

function Printer:Destroy()
    self.Model:Destroy()
end

function Printer:IsTaken(pos)
    local region = Region3.new(pos - Vector3.new(0.1, 0.1, 0.1), pos + Vector3.new(0.1, 0.1, 0.1))
    local parts = workspace:FindPartsInRegion3(region, nil, math.huge)
    for _, v in ipairs(parts) do
        if v.Parent and v.Parent.Name == "Blocks" then
            return true
        end
    end
    return false
end

function Printer:Build(Callback)
    self.Abort = false
    local Counter = 0
    Callback.Start()

    for blockName, positions in pairs(self.Blocks) do
        if self.Abort then break end
        for _, data in ipairs(positions) do
            if self.Abort then break end
            
            local relativeCF = CFrame.new(unpack(data.C))
            local targetPos = (self.CFrame * relativeCF).Position
            local targetCF = CFrame.new(targetPos)

            if not self:IsTaken(targetPos) then
                task.spawn(function()
                    Counter = Counter + 1
                    repeat 
                        task.wait()
                        Callback.Build(targetCF)
                        Remotes["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
                            ["cframe"] = targetCF,
                            ["blockType"] = blockName,
                            [getgenv().Keys.PlaceBlockArgName] = getgenv().Keys.PlaceBlockArgCode
                        })
                    until self:IsTaken(targetPos) or self.Abort or Counter == 0
                    Counter = Counter - 1
                end)

                if Counter >= 50 then
                    repeat task.wait() until Counter == 0 or self.Abort
                end
                task.wait(getgenv().WAmount or 0.1)
            end
        end
    end

    repeat task.wait() until Counter == 0 or self.Abort
    Callback.End()
end

return Printer
