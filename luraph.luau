local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WindUI = loadstring(game:HttpGet(
"https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local player = game.Players.LocalPlayer




local avatar = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="
..player.UserId.."&size=420x420&format=Png"

local Window = WindUI:CreateWindow({
    Title = "Dipper HUB | Premium [ BLOCK SPIN] ",
    Icon = "rbxassetid://124339558110081",
    Author = "D!PPER-TEAM",
    Folder = "N HUB",
    Size = UDim2.fromOffset(700, 540),
    Theme = "Light",
    Transparent = true,
    Resizable = true,

    User = {
        Enabled = false,
        Custom = {
            Name = "Anonymous",
            Bio = "RickHUB USER",
            Image = avatar
        }
    }
})
Window:Tag({
    Title = "v0.0.1",
    Icon = "github",
    Color = Color3.fromHex("#00bfff"),
    Radius = 5,
})

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

Window:EditOpenButton({ Enabled = false })

local ScreenGui = Instance.new("ScreenGui")
local ToggleBtn = Instance.new("ImageButton")

ScreenGui.Name = "WindUI_Toggle"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Image = "rbxassetid://124339558110081"
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui


local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = ToggleBtn

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(255,255,255)
UIStroke.Parent = ToggleBtn

local opened = true

local function toggle()
    opened = not opened
    if Window.UI then
        Window.UI.Enabled = opened
    else
        Window:Toggle()
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    ToggleBtn:TweenSize(
        UDim2.new(0, 56, 0, 56),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.12,
        true,
        function()
            ToggleBtn:TweenSize(
                UDim2.new(0, 50, 0, 50),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.12,
                true
            )
        end
    )
    toggle()
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.T then
        toggle()
    end
end)

local MainTab = Window:Tab({
    Title = "Main",
    Icon = "list"
})

local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "swords"
})

local VisualTab = Window:Tab({
    Title = "Visual",
    Icon = "eye"
})

local CarTab = Window:Tab({
    Title = "Car",
    Icon = "car"
})

local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "layers"
})

local ServerTab = Window:Tab({
    Title = "Server",
    Icon = "server"
})

MainTab:Section(
    {
        Title = "Player Modifier:"
    }
)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local defaultJumpPower = 20
local maxJumpPower = 100
local highJumpPower = 60
local walkSpeedMultiplier = 0.10
local highJumpActive = false
local speedActive = false

local function setJumpPower(power)
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = math.clamp(power, 0, maxJumpPower)
    end
end

local function setupCharacter(char)
    local hum = char:WaitForChild("Humanoid")
    hum.AutoJumpEnabled = false  

    if highJumpActive then
        hum.UseJumpPower = true
        hum.JumpPower = highJumpPower
    else
        hum.JumpPower = defaultJumpPower
    end
end

player.CharacterAdded:Connect(setupCharacter)

if player.Character then
    setupCharacter(player.Character)
end


MainTab:Toggle({
    Title = "High Jump",
    Default = false,
    Callback = function(state)
        highJumpActive = state
        if state then
            setJumpPower(highJumpPower)
        else
            setJumpPower(defaultJumpPower)
        end
    end
})

-- ปรับดโดสุง
MainTab:Slider({
    Title = "High Jump Power",
    Value = {Min = 20, Max = maxJumpPower, Default = highJumpPower},
    Step = 1,
    Callback = function(value)
        highJumpPower = tonumber(value)
        if highJumpActive then
            setJumpPower(highJumpPower)
        end
    end
})

-- ปุ่มวิ่งไว
MainTab:Toggle({
    Title = "Walk Speed",
    Default = false,
    Callback = function(state)
        speedActive = state
    end
})

-- ปรับวิ่งวไ
MainTab:Slider({
    Title = "Speed Multiplier",
    Value = {Min = 1, Max = 5, Default = walkSpeedMultiplier},
    Step = 1,
    Callback = function(value)
        walkSpeedMultiplier = tonumber(value)
    end
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local character, humanoid, rootPart
local originalPos = nil
local isEvading = false

local function setupCharacter(char)
    character = char
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    isEvading = false
    originalPos = nil
end

if player.Character then
    setupCharacter(player.Character)
end

player.CharacterAdded:Connect(setupCharacter)

getgenv().AntiAimAssiant = false
getgenv().AutoAntiKill = false

local AntiAimConnection
local Char = require(game.ReplicatedStorage.Modules.Core.Char)

local function startAntiAim()
    if AntiAimConnection then return end
    AntiAimConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().AntiAimAssiant then return end
        local hum = Char.get_hum()
        if hum and not hum:GetAttribute("HasBeenDowned") then
            local root = Char.get_hrp()
            if not root then return end
            local A = root.Velocity
            local B = root.AssemblyLinearVelocity
            local C = root.AssemblyAngularVelocity
            root.Velocity = Vector3.new(math.random(-100000,999999),math.random(-100000,999999),math.random(-100000,999999))
            root.AssemblyLinearVelocity = Vector3.new(math.random(-100000,999999),math.random(-100000,999999),math.random(-100000,999999))
            root.AssemblyAngularVelocity = Vector3.new(math.random(-100000,999999),math.random(-100000,999999),math.random(-100000,999999))
            RunService.RenderStepped:Wait()
            root.Velocity = A
            root.AssemblyLinearVelocity = B
            root.AssemblyAngularVelocity = C
        end
    end)
end

local function stopAntiAim()
    if AntiAimConnection then
        AntiAimConnection:Disconnect()
        AntiAimConnection = nil
    end
end

local function setNoclip(state)
    if not character then return end
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not state
        end
    end
end

RunService.Heartbeat:Connect(function()
    if not humanoid or not rootPart then return end
    if not getgenv().AutoAntiKill then return end

    if humanoid.Health > 0 and humanoid.Health < 17 and not isEvading then
        isEvading = true
        originalPos = rootPart.CFrame
        stopAntiAim()
        setNoclip(true)
        task.spawn(function()
            while isEvading and humanoid and humanoid.Health > 0 do
                local randomOffset = Vector3.new(
                    math.random(-500, 500), 
                    math.random(-200, 500),
                    math.random(-500, 500)
                )
                rootPart.CFrame = rootPart.CFrame * CFrame.new(randomOffset)
                task.wait(0.05)
            end
        end)
    elseif humanoid.Health >= 30 and isEvading then
        isEvading = false
        setNoclip(false)
        if originalPos and rootPart then
            rootPart.CFrame = originalPos
        end
        if getgenv().AntiAimAssiant then
            startAntiAim()
        end
    end
end)

MainTab:Toggle({
    Title = "Anti Aim",
    Flag = "antiaim",
    Value = false,
    Callback = function(Value)
        getgenv().AntiAimAssiant = Value
        if Value then
            startAntiAim()
        else
            stopAntiAim()
        end
    end
})

MainTab:Toggle({
    Title = "Anti Kill",
    Flag = "autoantikill",
    Value = false,
    Callback = function(Value)
        getgenv().AutoAntiKill = Value
    end
})

-- อันติแรคดอล
local function AntiRagdollLoop()
    while _G.AntiRagdoll do
        task.wait(0.1)

        pcall(function()
            local isRagdolled = RagdollModule.is_ragdolling.get()
            if isRagdolled then
                RagdollModule.is_ragdolling.set(false)
                
                
                pcall(function() Net.send("end_ragdoll_early") end)
                pcall(function() Net.send("clear_ragdoll") end)
                pcall(function() Net.get("end_ragdoll_early") end)
                pcall(function() Net.get("clear_ragdoll") end)
            end
        end)
    end
end


MainTab:Toggle({
    Title = "Anti Ragdoll",
    Desc = "No ragdoll",
    Flag = "AntiRagdoll",
    Type = "Checkbox",
    Value = false,
    Callback = function(Value)
        _G.AntiRagdoll = Value

        if Value then
            task.spawn(AntiRagdollLoop)
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local DroppedItems = workspace:WaitForChild("DroppedItems")

local Character
local HRP

local PICKUP_DISTANCE = 350
local TOUCH_REPEAT = 25
local pickupEnabled = false


local function bindCharacter(char)
    Character = char
    HRP = char:WaitForChild("HumanoidRootPart", 5)
end

if LocalPlayer.Character then
    bindCharacter(LocalPlayer.Character)
end
LocalPlayer.CharacterAdded:Connect(bindCharacter)


local function firetouch(partA, partB)
    if not firetouchinterest or not partA or not partB then return end
    for i = 1, TOUCH_REPEAT do
        firetouchinterest(partA, partB, 0)
        firetouchinterest(partA, partB, 1)
    end
end


RunService.RenderStepped:Connect(function()
    if not pickupEnabled then return end
    if not HRP or not HRP.Parent then return end

    for _, item in ipairs(DroppedItems:GetChildren()) do
        local zone = item:FindFirstChild("PickUpZone")
        if zone and zone:IsA("BasePart") then
            local dist = (HRP.Position - zone.Position).Magnitude
            if dist <= PICKUP_DISTANCE then
                firetouch(zone, HRP)
            end
        end
    end
end)


MainTab:Toggle({
    Title = "Pickup Item",
    Default = false,
    Callback = function(state)
        pickupEnabled = state
    end
})

MainTab:Toggle({
    Title = "infinity stamina",
    Default = false,
    Callback = function(state)
        if state then
            if not getgenv().Bypassed then
                local NetModule = require(ReplicatedStorage.Modules.Core.Net)
                local func = debug.getupvalue(NetModule.get, 2)
                debug.setconstant(func, 3, '__Bypass')
                debug.setconstant(func, 4, '__Bypass')
                getgenv().Bypassed = true
            end

            repeat task.wait() until getgenv().Bypassed

            local NetModule = require(ReplicatedStorage.Modules.Core.Net)
            local SprintModule = require(ReplicatedStorage.Modules.Game.Sprint)

            
            if staminaConnection then staminaConnection:Disconnect() end

            staminaConnection = RunService.Heartbeat:Connect(function()
                NetModule.send("set_sprinting_1", true)
            end)

            local consume_stamina = SprintModule.consume_stamina
            local SprintBar = debug.getupvalue(consume_stamina, 2).sprint_bar
            local oldUpdate = SprintBar.update

            SprintBar.update = function(...)
                if getgenv().InfiniteStamina then
                    return 1 
                end
                return oldUpdate(...)
            end

            getgenv().InfiniteStamina = true
        else
            getgenv().InfiniteStamina = false
            if staminaConnection then
                staminaConnection:Disconnect()
                staminaConnection = nil
            end
        end
    end
})

MainTab:Section(
    {
        Title = "Snap:"
    }
)

local EnabledSnapRunning = false
local SnapThread = nil
local YoffsetValue = 70
local func = {}

func["EnabledSnap"] = function()
    local basePosition = RootPart.Position
    while EnabledSnapRunning do
        task.wait()
        if not EnabledSnapRunning then break end
        local currentY = RootPart.Position.Y
        local targetY = basePosition.Y - YoffsetValue
        local deltaY = targetY - currentY
        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, deltaY, 0)
    end
end


local function SetSnapState(value)
    if EnabledSnapRunning == value then return end
    EnabledSnapRunning = value
    if value then
        if not SnapThread then
            SnapThread = task.spawn(func["EnabledSnap"])
        end
    else
        SnapThread = nil
    end

    if MainTab:Get("UndergroundToggle") then
        MainTab:Get("UndergroundToggle"):SetValue(value)
    end
end


MainTab:Toggle({
    Title = "Snap",
    Value = false,
    Flag = "UndergroundToggle",
    Callback = function(value)
        SetSnapState(value)
    end
})


MainTab:Keybind({
    Title = "Snap Keybind",
    Flag = "snap_keybind",
    Value = "G",
    Callback = function()
        SetSnapState(not EnabledSnapRunning)
    end
})


MainTab:Slider({
    Title = "Snap High",
    Flag = "snap_height",
    Step = 1,
    Value = { Min = 1, Max = 70, Default = YoffsetValue },
    Callback = function(value)
        YoffsetValue = value
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Network = require(game.ReplicatedStorage.Modules.Core.Net)

local TargetHistory = {}

local FOV = 200
local HIGH_VEL_THRESHOLD = 250
local TargetPartName = "Head"

local function GetPlayerNames()
    local t = {}
    for _,v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(t, v.Name)
        end
    end
    return t
end

local fovCircle = Drawing.new("Circle")
fovCircle.Radius = FOV
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Color = Color3.fromRGB(255,255,255)
fovCircle.Visible = true

local tracer = Drawing.new("Line")
tracer.Thickness = 2
tracer.Color = Color3.fromRGB(255,0,0)
tracer.Visible = false

local shotToggle = false

local function CreateTracer(fromPos, toPos)
    shotToggle = not shotToggle
    local distance = (toPos - fromPos).Magnitude

    local part = Instance.new("Part")
    part.Size = Vector3.new(0.25, 0.25, distance)
    part.CFrame = CFrame.new(fromPos, toPos) * CFrame.new(0, 0, -distance/2)
    part.Anchored = true
    part.CanCollide = false
    part.Material = Enum.Material.Neon
    part.Color = shotToggle and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
    part.Parent = workspace

    Debris:AddItem(part, 3)
end

local function GetDistanceStart(a, b)
    return (a - b).Magnitude
end

local function WorldToViewPoint(pos)
    local vp, onScreen = Camera:WorldToViewportPoint(pos)
    return vp, onScreen
end

local function IsAlive(model)
    local hum = model:FindFirstChildOfClass("Humanoid")
    local root = model:FindFirstChild("HumanoidRootPart")
    return hum and root and hum.Health > 0
end

local function IsBehindWall(startPos, endPos, ignore)
    local ray = Ray.new(startPos, endPos - startPos)
    local hit = workspace:FindPartOnRayWithIgnoreList(ray, ignore or {})
    return hit ~= nil
end

local function GetClosestTarget()
    local closest = nil
    local dist = math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and IsAlive(v.Character) then
            if not v:GetAttribute("SilentAimIgnore") then
                local root = v.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local pos, onScreen = WorldToViewPoint(root.Position)
                    if onScreen then
                        local d = GetDistanceStart(
                            Vector2.new(pos.X, pos.Y),
                            Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                        )
                        if d < FOV and d < dist then
                            closest = v.Character
                            dist = d
                        end
                    end
                end
            end
        end
    end

    return closest
end

RunService.RenderStepped:Connect(function()
    fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    local target = GetClosestTarget()

    if target and target:FindFirstChild(TargetPartName) then
        local pos, onScreen = WorldToViewPoint(target[TargetPartName].Position)

        if onScreen then
            tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            tracer.To = Vector2.new(pos.X, pos.Y)
            tracer.Visible = true
        else
            tracer.Visible = false
        end
    else
        tracer.Visible = false
    end
end)

local function solveQuadratic(A, B, C)
    local D = B^2 - 4*A*C
    if D < 0 then return nil, nil end
    local s = math.sqrt(D)
    return (-B - s)/(2*A), (-B + s)/(2*A)
end

local function getBallisticFlightTime(direction, gravity, speed)
    local r1, r2 = solveQuadratic(
        gravity:Dot(gravity)/3.8,
        gravity:Dot(direction) - speed^2,
        direction:Dot(direction)
    )

    if r1 and r2 then
        if r1 > 0 then return math.sqrt(r1) end
        if r2 > 0 then return math.sqrt(r2) end
    end

    return 0
end

local function PredictPosition(pos, vel, t, gravity)
    return pos + vel * t + (0.001 * gravity * (t^2))
end

local function GetVelocity(target, pos)
    local t = tick()

    TargetHistory[target] = TargetHistory[target] or {}
    local hist = TargetHistory[target]

    if #hist >= 3 then table.remove(hist, 1) end
    table.insert(hist, {pos = pos, time = t})

    if #hist < 2 then return Vector3.zero end

    local p1 = hist[#hist - 1]
    local p2 = hist[#hist]

    local dt = math.max(p2.time - p1.time, 1e-6)
    return (p2.pos - p1.pos) / dt
end

local OldSend
OldSend = hookfunction(Network.send, function(...)
    local args = {...}

    if args[1] == "shoot_gun" then
        local target = GetClosestTarget()

        if target then
            local plr = Players:GetPlayerFromCharacter(target)
            if plr and plr:GetAttribute("SilentAimIgnore") then
                return OldSend(...)
            end

            local part = target:FindFirstChild(TargetPartName)
            if part then
                local char = LocalPlayer.Character
                if not char then return OldSend(...) end

                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return OldSend(...) end

                local myPos = root.Position
                local targetPos = part.Position

                local vel = GetVelocity(target, targetPos)
                local velMagnitude = vel.Magnitude

                local predictedPos

                if velMagnitude >= HIGH_VEL_THRESHOLD then
                    predictedPos = targetPos
                else
                    local dir = targetPos - myPos
                    local gravity = Vector3.new(0, -workspace.Gravity, 0)
                    local speed = 1000

                    local t = getBallisticFlightTime(dir, gravity, speed)
                    predictedPos = PredictPosition(targetPos, vel, t, gravity)
                end

                local ignore = {LocalPlayer.Character, target}
                local behind = IsBehindWall(myPos, predictedPos, ignore)

                if behind then
                    args[3] = CFrame.new(math.huge, math.huge, math.huge)
                else
                    args[3] = CFrame.new(myPos, predictedPos)
                end

                for _, v in pairs(args[4] or {}) do
                    for _, x in pairs(v) do
                        x.Position = predictedPos
                        x.Instance = part
                    end
                end

                CreateTracer(myPos, predictedPos)
            end
        end
    end

    return OldSend(table.unpack(args))
end)

CombatTab:Toggle({
    Title = "Show FOV",
    Default = true,
    Callback = function(state)
        fovCircle.Visible = state
    end
})

CombatTab:Slider({
    Title = "FOV Size",
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
        Default = FOV
    },
    Callback = function(v)
        FOV = v
        fovCircle.Radius = v
    end
})

CombatTab:Dropdown({
    Title = "Target Part",
    Values = {"Head","HumanoidRootPart"},
    Multi = false,
    Default = "Head",
    Callback = function(v)
        TargetPartName = v
    end
})

CombatTab:Dropdown({
    Title = "Save Friend",
    Values = GetPlayerNames(),
    Multi = true,
    Default = {},
    Callback = function(selected)
        for _, plr in pairs(Players:GetPlayers()) do
            plr:SetAttribute("SilentAimIgnore", false)
        end

        for _, name in pairs(selected) do
            local plr = Players:FindFirstChild(name)
            if plr then
                plr:SetAttribute("SilentAimIgnore", true)
            end
        end
    end
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local NameESPEnabled = false

local Names = {}

function CreateName(player)

    local name = Drawing.new("Text")
    name.Visible = false
    name.Color = Color3.fromRGB(255,255,255)
    name.Size = 12
    name.Center = true
    name.Outline = true
    name.Font = 2

    Names[player] = name
end

for _,p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        CreateName(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        CreateName(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if Names[p] then
        Names[p]:Remove()
        Names[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()

    if not NameESPEnabled then
        for _,n in pairs(Names) do
            n.Visible = false
        end
        return
    end

    for player,name in pairs(Names) do

        local char = player.Character
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if head and hum and hum.Health > 0 then

            local pos, visible = Camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))

            if visible then
                name.Text = player.Name
                name.Position = Vector2.new(pos.X,pos.Y)
                name.Visible = true
            else
                name.Visible = false
            end

        else
            name.Visible = false
        end
    end
end)

VisualTab:Toggle({
Title = "ESP Name",
Default = false,
Callback = function(v)
NameESPEnabled = v
end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESPEnabled = false
local ESP_COLOR = Color3.fromRGB(0,170,255)

local Boxes = {}

function CreateBox(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = ESP_COLOR
    box.Thickness = 0.7
    box.Filled = false
    Boxes[player] = box
end

for _,p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        CreateBox(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        CreateBox(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if Boxes[p] then
        Boxes[p]:Remove()
        Boxes[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()

    if not ESPEnabled then
        for _,box in pairs(Boxes) do
            box.Visible = false
        end
        return
    end

    for player,box in pairs(Boxes) do

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then

            local pos, visible = Camera:WorldToViewportPoint(hrp.Position)

            if visible then

                local scale = (Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0)).Y -
                               Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0,3,0)).Y)

                local width = math.abs(scale) * 0.6
                local height = math.abs(scale)

                box.Size = Vector2.new(width,height)
                box.Position = Vector2.new(pos.X - width/2, pos.Y - height/2)
                box.Visible = true

            else
                box.Visible = false
            end
        else
            box.Visible = false
        end
    end
end)

VisualTab:Toggle({
Title = "ESP Box",
Default = false,
Callback = function(v)
ESPEnabled = v
end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local HealthESPEnabled = false

local HealthBars = {}

function CreateHealth(player)

    local bar = Drawing.new("Line")
    bar.Visible = false
    bar.Thickness = 1

    HealthBars[player] = bar

end

for _,p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        CreateHealth(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        CreateHealth(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if HealthBars[p] then
        HealthBars[p]:Remove()
        HealthBars[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()

    if not HealthESPEnabled then
        for _,bar in pairs(HealthBars) do
            bar.Visible = false
        end
        return
    end

    for player,bar in pairs(HealthBars) do

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then

            local pos, visible = Camera:WorldToViewportPoint(hrp.Position)

            if visible then

                local top = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0,3,0))
                local bottom = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))

                local height = math.abs(top.Y - bottom.Y)
                local healthPercent = hum.Health / hum.MaxHealth

                local barHeight = height * healthPercent

                local x = pos.X - (height * 0.35)

                bar.From = Vector2.new(x, bottom.Y)
                bar.To = Vector2.new(x, bottom.Y - barHeight)

                bar.Color = Color3.fromRGB(
                    255 - (255 * healthPercent),
                    255 * healthPercent,
                    0
                )

                bar.Visible = true

            else
                bar.Visible = false
            end
        else
            bar.Visible = false
        end
    end
end)

VisualTab:Toggle({
Title = "ESP Health Bar",
Default = false,
Callback = function(v)
HealthESPEnabled = v
end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local HighlightESPEnabled = false

local Highlights = {}

function AddHighlight(player)

    local function setup(char)

        if char:FindFirstChild("ESPHighlight") then return end

        local hl = Instance.new("Highlight")
        hl.Name = "ESPHighlight"
        hl.FillColor = Color3.fromRGB(0,170,255)
        hl.OutlineColor = Color3.fromRGB(0,170,255)
        hl.FillTransparency = 0.5
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = char

        Highlights[player] = hl

    end

    if player.Character then
        setup(player.Character)
    end

    player.CharacterAdded:Connect(setup)

end

function RemoveHighlight(player)

    if Highlights[player] then
        Highlights[player]:Destroy()
        Highlights[player] = nil
    end

end

for _,p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        AddHighlight(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        AddHighlight(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    RemoveHighlight(p)
end)

game:GetService("RunService").RenderStepped:Connect(function()

    for player,hl in pairs(Highlights) do
        hl.Enabled = HighlightESPEnabled
    end

end)

VisualTab:Toggle({
Title = "ESP Highlight",
Default = false,
Callback = function(v)
HighlightESPEnabled = v
end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local DistanceESPEnabled = false

local Distances = {}

function CreateDistance(player)

    local text = Drawing.new("Text")
    text.Visible = false
    text.Color = Color3.fromRGB(255,255,255)
    text.Size = 12
    text.Center = true
    text.Outline = true
    text.Font = 2

    Distances[player] = text

end

for _,p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        CreateDistance(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        CreateDistance(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if Distances[p] then
        Distances[p]:Remove()
        Distances[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()

    if not DistanceESPEnabled then
        for _,t in pairs(Distances) do
            t.Visible = false
        end
        return
    end

    for player,text in pairs(Distances) do

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then

            local pos, visible = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0,3,0))

            if visible then

                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                distance = math.floor(distance)

                text.Text = distance.."m"
                text.Position = Vector2.new(pos.X,pos.Y)
                text.Visible = true

            else
                text.Visible = false
            end

        else
            text.Visible = false
        end
    end
end)

VisualTab:Toggle({
Title = "ESP Distance",
Default = false,
Callback = function(v)
DistanceESPEnabled = v
end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local TracerEnabled = false

local Tracers = {}

function CreateTracer(player)

    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.fromRGB(0,170,255)
    line.Thickness = 1
    line.Transparency = 1

    Tracers[player] = line

end

for _,p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        CreateTracer(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        CreateTracer(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if Tracers[p] then
        Tracers[p]:Remove()
        Tracers[p] = nil
    end
end)

RunService.RenderStepped:Connect(function()

    if not TracerEnabled then
        for _,line in pairs(Tracers) do
            line.Visible = false
        end
        return
    end

    for player,line in pairs(Tracers) do

        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if hrp and hum and hum.Health > 0 then

            local pos, visible = Camera:WorldToViewportPoint(hrp.Position)

            if visible then

                local screenCenterX = Camera.ViewportSize.X / 2

                line.From = Vector2.new(screenCenterX, 0)
                line.To = Vector2.new(pos.X, pos.Y)

                line.Visible = true

            else
                line.Visible = false
            end

        else
            line.Visible = false
        end
    end
end)

VisualTab:Toggle({
Title = "ESP Tracer",
Default = false,
Callback = function(v)
TracerEnabled = v
end
})

VisualTab:Toggle({
	Title = 'Inventory Viewer',
	Default = true,
	Callback = function(Value)
		_G.InventoryViewerEnabled = Value
		local Players = game:GetService('Players')
		local ReplicatedStorage = game:GetService('ReplicatedStorage')
		local Client = Players.LocalPlayer
		local function GetColorFromRarity(rarityName)
			local colors = {
				['Common'] = Color3.fromRGB(255, 255, 255),
				['UnCommon'] = Color3.fromRGB(99, 255, 52),
				['Rare'] = Color3.fromRGB(51, 170, 255),
				['Legendary'] = Color3.fromRGB(255, 150, 0),
				['Epic'] = Color3.fromRGB(237, 44, 255),
				['Omega'] = Color3.fromRGB(255, 20, 51),
			}
			return colors[rarityName] or Color3.fromRGB(255, 255, 255)
		end
		if Value then
			if not _G.ViewerRunning then
				_G.ViewerRunning = true
				task.spawn(function()
					while task.wait(0.2) do
						if not _G.InventoryViewerEnabled then
							continue
						end
						pcall(function()
							for _, v in pairs(Players:GetPlayers()) do
								if v ~= Client and v.Character and v.Character:FindFirstChild('HumanoidRootPart') then
									local root = v.Character.HumanoidRootPart
									local gui = root:FindFirstChild('ItemBillboard')
									if not gui then
										gui = Instance.new('BillboardGui')
										gui.Name = 'ItemBillboard'
										gui.AlwaysOnTop = true
										gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
										gui.Size = UDim2.new(0, 200, 0, 50)
										gui.StudsOffset = Vector3.new(0, -5, 0)
										gui.ExtentsOffset = Vector3.new(0, 1, 0)
										gui.LightInfluence = 1
										gui.Parent = root
										local bg = Instance.new('Frame')
										bg.Name = 'BG'
										bg.BackgroundTransparency = 1
										bg.Size = UDim2.new(1, 0, 1, 0)
										bg.AnchorPoint = Vector2.new(0.5, 0.5)
										bg.Position = UDim2.new(0.5, 0, 0.5, 0)
										bg.Parent = gui
										local layout = Instance.new('UIListLayout')
										layout.FillDirection = Enum.FillDirection.Horizontal
										layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
										layout.VerticalAlignment = Enum.VerticalAlignment.Center
										layout.Padding = UDim.new(0, 5)
										layout.Parent = bg
									end
									local bg = gui:FindFirstChild('BG')
									if not bg then
										continue
									end
									local Items = {}

                                    
									for _, child in pairs(bg:GetChildren()) do
										if child:IsA('Frame') then
											child:Destroy()
										end
									end

                                    -- loop item ใน backpack + character
									for _, container in pairs({
										v:FindFirstChild('Backpack'),
										v.Character
									}) do
										if container then
											for _, tool in pairs(container:GetChildren()) do
												if tool:IsA('Tool') and not tool:GetAttribute('JobTool') and not tool:GetAttribute('Locked') then
													local itemFolder = tool:GetAttribute('AmmoType') and ReplicatedStorage.Items.gun or ReplicatedStorage.Items.melee
													for _, z in pairs(itemFolder:GetChildren()) do
														if tool:GetAttribute('RarityName') == z:GetAttribute('RarityName') and tool:GetAttribute('RarityPrice') == z:GetAttribute('RarityPrice') then
															local imageId = z:GetAttribute('ImageId')
															if imageId then
																Items[z.Name] = true
																if not bg:FindFirstChild(z.Name .. '_bg') then
																	local iconBg = Instance.new('Frame')
																	iconBg.Name = z.Name .. '_bg'
																	iconBg.Size = UDim2.new(0, 34, 0, 34)
																	iconBg.BackgroundColor3 = GetColorFromRarity(z:GetAttribute('RarityName'))
																	iconBg.BackgroundTransparency = 1
																	iconBg.BorderSizePixel = 0
																	iconBg.Parent = bg
																	local bgImage = Instance.new('ImageLabel')
																	bgImage.Name = 'Background'
																	bgImage.Size = UDim2.new(1, 0, 1, 0)
																	bgImage.BackgroundTransparency = 1
																	bgImage.Image = 'rbxassetid://137066731814190'
																	bgImage.ImageColor3 = GetColorFromRarity(z:GetAttribute('RarityName'))
																	bgImage.ZIndex = 0
																	bgImage.Parent = iconBg
																	local corner = Instance.new('UICorner')
																	corner.CornerRadius = UDim.new(0.15, 0)
																	corner.Parent = iconBg
																	local icon = Instance.new('ImageLabel')
																	icon.Name = z.Name
																	icon.Image = imageId
																	icon.BackgroundTransparency = 1
																	icon.BorderSizePixel = 0
																	icon.Size = UDim2.new(0.85, 0, 0.85, 0)
																	icon.Position = UDim2.new(0.075, 0, 0.075, 0)
																	icon.Parent = iconBg
																	local corner2 = Instance.new('UICorner')
																	corner2.CornerRadius = UDim.new(0, 9)
																	corner2.Parent = icon
																end
															end
														end
													end
												end
											end
										end
									end
									gui.Enabled = _G.InventoryViewerEnabled
									for _, child in pairs(bg:GetChildren()) do
										if child:IsA('Frame') then
											local itemName = child.Name:gsub('_bg$', '')
											if not Items[itemName] then
												child:Destroy()
											end
										end
									end
								end
							end
						end)
					end
				end)
			end
		else
            
			for _, v in pairs(Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild('HumanoidRootPart') then
					local gui = v.Character.HumanoidRootPart:FindFirstChild('ItemBillboard')
					if gui then
						gui:Destroy()
					end
				end
			end
		end
	end  
})

                    
