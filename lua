local Plr, RS, Rep, UIS, CG, Deb, Light, TP, Http =
    game:GetService("Players"),
    game:GetService("RunService"),
    game:GetService("ReplicatedStorage"),
    game:GetService("UserInputService"),
    game:GetService("CoreGui"),
    game:GetService("Debris"),
    game:GetService("Lighting"),
    game:GetService("TeleportService"),
    game:GetService("HttpService")

local WindUI = loadstring(game:HttpGet(
"https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local player = game.Players.LocalPlayer

if not getgenv().ACBYPASS then
    task.spawn(xpcall,function()
        repeat task.wait(2)
            if game.Players.LocalPlayer.PlayerGui:FindFirstChild('SplashScreenGui') 
            and not game.Players.LocalPlayer:GetAttribute('InMenuCharacterCreator') 
            and not game.Players.LocalPlayer.PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder').Visible then
                
                game:GetService("GuiService").SelectedObject = game.Players.LocalPlayer.PlayerGui:FindFirstChild('SplashScreenGui').Frame.PlayButton
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)

            elseif not game.Players.LocalPlayer.PlayerGui:FindFirstChild('SplashScreenGui') 
            and game.Players.LocalPlayer:GetAttribute('InMenuCharacterCreator') then
                
                game:GetService("GuiService").SelectedObject = game.Players.LocalPlayer.PlayerGui:FindFirstChild('CharacterCreator'):FindFirstChild('MenuFrame').AvatarMenuSkipButton
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)

            elseif game.Players.LocalPlayer.PlayerGui:FindFirstChild('SplashScreenGui') 
            and not game.Players.LocalPlayer:GetAttribute('InMenuCharacterCreator') 
            and game.Players.LocalPlayer.PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder').Visible then
                
                game:GetService("GuiService").SelectedObject = game.Players.LocalPlayer.PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder'):FindFirstChild('SlideshowCloseButton')
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)

            elseif not game.Players.LocalPlayer.PlayerGui:FindFirstChild('SplashScreenGui') 
            and not game.Players.LocalPlayer:GetAttribute('InMenuCharacterCreator') 
            and not game.Players.LocalPlayer.PlayerGui:FindFirstChild('Slideshow'):FindFirstChild('SlideshowHolder').Visible then
                
                local Net = require(game.ReplicatedStorage.Modules.Core.Net)

                local func = debug.getupvalue(Net.get,2)
                debug.setconstant(func,3,"___Bypass")
                debug.setconstant(func,4,"___Bypass")

                warn("Bypass success")

                identifyexecutor = nil 
                task.wait()
                game:GetService("GuiService").SelectedObject = nil
                getgenv().ACBYPASS = true
            end
        until getgenv().ACBYPASS
    end,warn)
end

repeat task.wait() until getgenv().ACBYPASS


local avatar = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="
..player.UserId.."&size=420x420&format=Png"

local Window = WindUI:CreateWindow({
    Title = "Dipper HUB | Premium [ BLOCK SPIN] ",
    Author = "Dipper TEAM",
    Folder = "N HUB",
    Size = UDim2.fromOffset(700, 540),
    Background = "rbxassetid://124339558110081",
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

local ModTab = Window:Tab({
    Title = "Gun mods",
    Icon = "airplay"
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

local defaultJumpPower = 3.89
local maxJumpPower = 100
local highJumpPower = 25
local walkSpeedMultiplier = 2

local highJumpActive = false
local speedActive = false

local function getChar()
    local char = player.Character or player.CharacterAdded:Wait()
    return char, char:WaitForChild("Humanoid"), char:WaitForChild("HumanoidRootPart")
end

local function setJumpPower(power)
    local _, hum = getChar()
    hum.JumpHeight = power
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

MainTab:Toggle({
    Title = "Walk Speed",
    Default = false,
    Callback = function(state)
        speedActive = state
    end
})

MainTab:Slider({
    Title = "Speed Multiplier",
    Value = {Min = 1, Max = 5, Default = walkSpeedMultiplier},
    Step = 1,
    Callback = function(value)
        walkSpeedMultiplier = tonumber(value)
    end
})

RunService.RenderStepped:Connect(function()
    local _, hum, root = getChar()

    if highJumpActive then
        hum.JumpHeight = highJumpPower
    end

    if speedActive then
        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then
            if hum.WalkSpeed ~= 30 then
                hum.WalkSpeed = 30
            end
            root.CFrame = root.CFrame + (dir.Unit * (walkSpeedMultiplier / 5))
        end
    end
end)


local RagdollModule = require(game.ReplicatedStorage.Modules.Game.Ragdoll)
local Network = require(game.ReplicatedStorage.Modules.Core.Net)

local OldGet = RagdollModule.is_ragdolling.get

RagdollModule.is_ragdolling.get = function(...)
    local result = OldGet(...)
    if result == true and _G.AntiRagdoll then
        RagdollModule.is_ragdolling.set(false)
        Network.send("end_ragdoll_early")
        Network.send("clear_ragdoll")
    end
    return result
end

MainTab:Toggle({
    Title = "Anti Ragdoll",
    Flag = "AntiRagdoll",
    Value = false,
    Callback = function(Value)
        _G.AntiRagdoll = Value
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Client = Players.LocalPlayer
local Char = require(game.ReplicatedStorage.Modules.Core.Char)

getgenv().AntiAimAssiant = false

RunService.Heartbeat:Connect(function()
    if getgenv().AntiAimAssiant then   
        local HumanoidModule = Char.get_hum()
        if HumanoidModule and not HumanoidModule:GetAttribute("HasBeenDowned") then 
            local RootPartModule = Char.get_hrp()
            if not RootPartModule then return end

            local A = RootPartModule.Velocity
            local B = RootPartModule.AssemblyLinearVelocity
            local C = RootPartModule.AssemblyAngularVelocity

            RootPartModule.Velocity = Vector3.new(
                math.random(-100000,999999),
                math.random(-100000,999999),
                math.random(-100000,999999)
            )

            RootPartModule.AssemblyLinearVelocity = Vector3.new(
                math.random(-100000,999999),
                math.random(-100000,999999),
                math.random(-100000,999999)
            )

            RootPartModule.AssemblyAngularVelocity = Vector3.new(
                math.random(-100000,999999),
                math.random(-100000,999999),
                math.random(-100000,999999)
            )

            RunService.RenderStepped:Wait()

            RootPartModule.Velocity = A
            RootPartModule.AssemblyLinearVelocity = B
            RootPartModule.AssemblyAngularVelocity = C
        end
    end
end)

MainTab:Toggle({
    Title = "Anti Aim Assiant",
    Flag = "antiaim_assist",
    Value = false,
    Callback = function(v)
        getgenv().AntiAimAssiant = v
    end
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SprintModule = require(ReplicatedStorage.Modules.Game.Sprint)

local ConsumeStamina = SprintModule.consume_stamina
local SprintBar = debug.getupvalue(ConsumeStamina, 2).sprint_bar
local OldUpdate = SprintBar.update

MainTab:Toggle({
    Title = "infinity stamina(วิ่งไม่จำกัด)",
    Default = false,
    Callback = function(state)
        getgenv().InfStamina = state

        if state then
            if not getgenv().Bypassed then
                SprintBar.update = function(...)
                    if getgenv().InfStamina then
                        return (function()
                            return 1
                        end)
                    end
                    return OldUpdate(...)
                end
                getgenv().Bypassed = true
            end
        else
            SprintBar.update = OldUpdate
            getgenv().Bypassed = false
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


MainTab:Section(
    {
        Title = "Snap:"
    }
)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Client = Players.LocalPlayer
local Char = require(ReplicatedStorage.Modules.Core.Char)

local EnabledSnapRunning = false
local YoffsetValue = 10
local snapThread

local function GetDeltaY(baseY, currentY, offset)
    local targetY = baseY - offset
    return targetY - currentY
end

local function SetSnapState(state)
    EnabledSnapRunning = state
    getgenv().Snap = state

    if state then
        snapThread = task.spawn(function()
            local BasePosition = Char.get_hrp().Position

            while EnabledSnapRunning do
                task.wait()
                local hrp = Char.get_hrp()
                if hrp then
                    local currentY = hrp.Position.Y
                    local deltaY = GetDeltaY(BasePosition.Y, currentY, YoffsetValue)
                    Char.get():PivotTo(hrp.CFrame * CFrame.new(0, deltaY, 0))
                end
            end
        end)
    else
        if snapThread then
            task.cancel(snapThread)
            snapThread = nil
        end
    end
end

MainTab:Toggle({
    Title = "Snap Under Map (มุดดิน)",
    Default = false,
    Callback = function(state)
        SetSnapState(state)
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
    Value = { Min = 1, Max = 50, Default = YoffsetValue },
    Callback = function(value)
        YoffsetValue = value
    end
})


local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer


local SilentAimEnabled = false
local ShowFOV = false
local FOV = 200
local HIGH_VEL_THRESHOLD = 250
local TargetPartName = "Head"

local TargetHistory = {}

local fovCircle = Drawing.new("Circle")
fovCircle.Radius = FOV
fovCircle.Thickness = 1
fovCircle.Filled = false
fovCircle.Color = Color3.fromRGB(255,255,255)
fovCircle.Visible = ShowFOV

local tracer = Drawing.new("Line")
tracer.Thickness = 2
tracer.Color = Color3.fromRGB(255,0,0)
tracer.Visible = false

local function GetPlayerNames()
    local t = {}
    for _,v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(t, v.Name)
        end
    end
    return t
end

CombatTab:Toggle({
    Title = "Silent Aim(ล็อคเป้า)",
    Default = false,
    Callback = function(v)
        SilentAimEnabled = v
    end
})

CombatTab:Toggle({
    Title = "Show FOV",
    Default = false,
    Callback = function(v)
        ShowFOV = v
        fovCircle.Visible = v
    end
})

CombatTab:Slider({
    Title = "FOV Size(ปรับขนาดวงFov)",
    Step = 1,
    Value = {Min = 50, Max = 800, Default = FOV},
    Callback = function(v)
        FOV = v
        fovCircle.Radius = v
    end
})

CombatTab:Dropdown({
    Title = "Save Friend(ไม่ยิงเพื่อน)",
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

CombatTab:Dropdown({
    Title = "Target Part(ปรับยิงหัวกับตัว)",
    Values = {"Head","HumanoidRootPart"},
    Multi = false,
    Default = "Head",
    Callback = function(v)
        TargetPartName = v
    end
})

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
    local closest, dist = nil, math.huge

    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and IsAlive(v.Character) and not v:GetAttribute("SilentAimIgnore") then
            local part = v.Character:FindFirstChild(TargetPartName)
            if part then
                local pos, onScreen = WorldToViewPoint(part.Position)
                if onScreen then
                    local d = (Vector2.new(pos.X,pos.Y) - Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)).Magnitude
                    if d < FOV and d < dist then
                        closest = v.Character
                        dist = d
                    end
                end
            end
        end
    end

    return closest
end

RunService.RenderStepped:Connect(function()
    fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    if not SilentAimEnabled then
        tracer.Visible = false
        return
    end

    local target = GetClosestTarget()

    if target then
        local part = target:FindFirstChild(TargetPartName)
        if part then
            local pos, onScreen = WorldToViewPoint(part.Position)
            if onScreen then
                tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
                tracer.To = Vector2.new(pos.X, pos.Y)
                tracer.Visible = true
            else
                tracer.Visible = false
            end
        end
    else
        tracer.Visible = false
    end
end)

local function GetVelocity(target, pos)
    local t = tick()
    TargetHistory[target] = TargetHistory[target] or {}
    local hist = TargetHistory[target]

    if #hist >= 3 then table.remove(hist,1) end
    table.insert(hist,{pos=pos,time=t})

    if #hist < 2 then return Vector3.zero end

    local p1 = hist[#hist-1]
    local p2 = hist[#hist]

    local dt = math.max(p2.time - p1.time,1e-6)
    return (p2.pos - p1.pos)/dt
end

local OldSend
OldSend = hookfunction(Network.send,function(...)
    local args = {...}

    if args[1] == "shoot_gun" and SilentAimEnabled then
        local target = GetClosestTarget()

        if target then
            local part = target:FindFirstChild(TargetPartName)
            if part then
                local char = LocalPlayer.Character
                if not char then return OldSend(...) end

                local root = char:FindFirstChild("HumanoidRootPart")
                if not root then return OldSend(...) end

                local myPos = root.Position
                local targetPos = part.Position

                local vel = GetVelocity(target,targetPos)

                local predictedPos
                if vel.Magnitude >= HIGH_VEL_THRESHOLD then
                    predictedPos = targetPos
                else
                    predictedPos = targetPos + vel * 0.1
                end

                local ignore = {LocalPlayer.Character, target}
                local behind = IsBehindWall(myPos, predictedPos, ignore)

                if behind then
                    args[3] = CFrame.new(math.huge, math.huge, math.huge)
                else
                    args[3] = CFrame.new(myPos, predictedPos)
                end

                for _,v in pairs(args[4] or {}) do
                    for _,x in pairs(v) do
                        x.Position = predictedPos
                        x.Instance = part
                    end
                end
            end
        end
    end

    return OldSend(table.unpack(args))
end)




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
Title = "ESP Name(มองชื่อ)",
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
Title = "ESP Box(กล่อง)",
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
Title = "ESP Health(มองเลือด)",
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
Title = "ESP Highlight(มองทะลุ)",
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
Title = "ESP Distance(มองระยะ)",
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
Title = "ESP Tracer(มองเส้น)",
Default = false,
Callback = function(v)
TracerEnabled = v
end
})





VisualTab:Toggle({
	Title = 'Inventory Viewer(มองของ)',
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

                    
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local DroppedFolder = workspace:WaitForChild("DroppedItems")

local ItemESPs = {}
local ShowItemESP = true

local BlueColor  = Color3.fromRGB(0,150,255)
local GreenColor = Color3.fromRGB(0,255,0)

local function getItemColor(item)
    if item.Name:lower():find("money") then
        return GreenColor
    end
    return BlueColor
end

local function createItemESP(item)
    if ItemESPs[item] then return end

    local color = getItemColor(item)
    local highlights = {}
    local label

    local function addHighlight(part)
        local hl = Instance.new("Highlight")
        hl.Adornee = part
        hl.FillColor = color
        hl.OutlineColor = color
        hl.FillTransparency = 0.8
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Enabled = true
        hl.Parent = part
        table.insert(highlights, hl)
    end

    if item:IsA("BasePart") then
        addHighlight(item)
    elseif item:IsA("Model") then
        for _, v in ipairs(item:GetDescendants()) do
            if v:IsA("BasePart") then
                addHighlight(v)
            end
        end
    end

    local basePart =
        item:IsA("BasePart") and item
        or item.PrimaryPart
        or item:FindFirstChildWhichIsA("BasePart")

    if basePart then
        local bb = Instance.new("BillboardGui")
        bb.Adornee = basePart
        bb.Size = UDim2.new(0, 55, 0, 9)
        bb.StudsOffset = Vector3.new(0, basePart.Size.Y/2 + 0.6, 0)
        bb.AlwaysOnTop = true
        bb.Parent = basePart

        label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = "[" .. item.Name .. "]"
        label.Font = Enum.Font.GothamBold
        label.TextScaled = false
        label.TextSize = 8
        label.TextColor3 = color
        label.TextStrokeTransparency = 0.5
        label.Visible = true
        label.Parent = bb
    end

    ItemESPs[item] = {
        highlights = highlights,
        label = label
    }
end

local function removeItemESP(item)
    local data = ItemESPs[item]
    if not data then return end

    for _, hl in ipairs(data.highlights) do
        if hl then hl:Destroy() end
    end

    if data.label and data.label.Parent then
        data.label.Parent:Destroy()
    end

    ItemESPs[item] = nil
end

for _, item in ipairs(DroppedFolder:GetChildren()) do
    createItemESP(item)
end

DroppedFolder.ChildAdded:Connect(createItemESP)
DroppedFolder.ChildRemoved:Connect(removeItemESP)

local function BumpAuraLoop()
    while _G.BumpAura do
        task.wait(0.1)

        local car = Vechine.get_car_player_is_in()
        if not car or not car:FindFirstChild("DriverSeat") then
            continue
        end

        for _, target in pairs(CharModule.get_all()) do
            if target ~= Character and target then
                local hrp = target:FindFirstChild("HumanoidRootPart")
                if hrp and GetDistanceFromRootPart(hrp) < 100 then
                    
                    local Assembly = car.DriverSeat.AssemblyLinearVelocity + Vector3.new(65, 65, 65)

                    Net.send("run_over", car, target, Assembly)
                end
            end 
        end
    end
end

CarTab:Toggle({
    Title = "Bump Aura",
    Flag = "BumpAura",
    Value = false,
    Callback = function(Value)
        _G.BumpAura = Value

        if Value then
            task.spawn(BumpAuraLoop)
        end
    end
})

local CrateController = require(game.ReplicatedStorage.Modules.Game.CrateSystem.Crate)

local EnabledSkip = false

MiscTab:Toggle({
    Title = "Skip Animation",
    Flag = "skip_anim",
    Value = false,
    Callback = function(Value)
        EnabledSkip = Value
        if Value then
            task.spawn(function()
                while EnabledSkip do
                    pcall(function()
                        if not CrateController.spinning.get() then
                            CrateController.skip_spin()
                        end
                    end)
                    task.wait(0.2)
                end
            end)
        end
    end
})​

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

local SPEED = 260
local SPEED_MIN = 10
local SPEED_MAX = 500
local DEBOUNCE = 0.35
local SMOOTH = 0

local UI_WIDTH = 132
local UI_HEIGHT = 44
local SPEEDBOX_W = 56
local SPEEDBOX_H = 14

local freecam = false
local dummy = nil
local char, humanoid, hrp = nil, nil, nil
local saved = {}
local pendingStamp = 0
local allowMovement = false
local initialDummyCFrame = nil
local initialCameraCFrame = nil
local savedCameraFOV = nil
local initialDistance = nil
local savedPartAnchors = {}
local savedPlatformStand = nil
local yaw = 0
local pitch = 0
local ROT_SENS = 0.0025
local lastInputPos = Vector2.new(0,0)
local ignoreNextInput = false

local function safeSet(fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok then warn("Spectator: safeSet error:", err) end
end

local function createGui()
    if playerGui:FindFirstChild("SpectatorCleanGUI") then
        local g = playerGui.SpectatorCleanGUI
        return {Gui = g, Frame = g.Container, Toggle = g.Container.Toggle, SpeedBox = g.Container.SpeedBox, Info = g.Container.Info}
    end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SpectatorCleanGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    local frame = Instance.new("Frame")
    frame.Name = "Container"
    frame.Size = UDim2.new(0, UI_WIDTH, 0, UI_HEIGHT)
    frame.Position = UDim2.new(0, 8, 0, 8)
    frame.BackgroundColor3 = Color3.fromRGB(18,20,24)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(45,50,60); stroke.Transparency = 0.7; stroke.Thickness = 1
    local title = Instance.new("TextLabel", frame)
    title.Name = "Title"
    title.Size = UDim2.new(0.64, 0, 0, 22)
    title.Position = UDim2.new(0, 8, 0, 6)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.TextColor3 = Color3.fromRGB(235,235,235)
    title.Text = "Free camera"
    title.TextXAlignment = Enum.TextXAlignment.Left
    local toggle = Instance.new("TextButton", frame)
    toggle.Name = "Toggle"
    toggle.Size = UDim2.new(0.32, -8, 0, 22)
    toggle.Position = UDim2.new(0.62, 0, 0, 6)
    toggle.BackgroundColor3 = Color3.fromRGB(36,40,48)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 12
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(220,220,220)
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke", toggle).Color = Color3.fromRGB(60,70,80)
    local speedBox = Instance.new("TextBox", frame)
    speedBox.Name = "SpeedBox"
    speedBox.Size = UDim2.new(0, SPEEDBOX_W, 0, SPEEDBOX_H)
    speedBox.Position = UDim2.new(0, 8, 1, -18)
    speedBox.BackgroundColor3 = Color3.fromRGB(34,38,46)
    speedBox.PlaceholderText = tostring(SPEED)
    speedBox.Text = ""
    speedBox.Font = Enum.Font.Gotham
    speedBox.TextSize = 12
    speedBox.TextColor3 = Color3.fromRGB(235,235,235)
    Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,5)
    local sbstroke = Instance.new("UIStroke", speedBox)
    sbstroke.Color = Color3.fromRGB(55,65,75); sbstroke.Transparency = 0.8
    local info = Instance.new("TextLabel", frame)
    info.Name = "Info"
    info.Size = UDim2.new(1, -10, 0, 10)
    info.Position = UDim2.new(0, 5, 1, -10)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.Gotham
    info.TextSize = 10
    info.TextColor3 = Color3.fromRGB(210,195,110)
    info.Text = ""
    return {Gui = screenGui, Frame = frame, Toggle = toggle, SpeedBox = speedBox, Info = info}
end

local gui = createGui()
local toggleBtn = gui.Toggle
local speedBox = gui.SpeedBox
local infoLabel = gui.Info

local function makeDummy()
    local name = "SpecDummy_" .. player.UserId
    local ex = workspace:FindFirstChild(name)
    if ex then
        safeSet(function()
            if ex:IsA("BasePart") then
                ex.Anchored = true
                ex.CanCollide = false
                ex.Transparency = 1
            end
        end)
        return ex
    end
    local p = Instance.new("Part")
    p.Name = name
    p.Size = Vector3.new(1,1,1)
    p.Anchored = true
    p.CanCollide = false
    p.Transparency = 1
    p.Parent = workspace
    return p
end

local function saveHumanoidValues(h)
    if not h then return end
    saved.WalkSpeed = h.WalkSpeed
    saved.JumpPower = h.JumpPower
    saved.AutoRotate = h.AutoRotate
end

local function restoreHumanoidValues(h)
    if not h then return end
    safeSet(function() if saved.WalkSpeed then h.WalkSpeed = saved.WalkSpeed end end)
    safeSet(function() if saved.JumpPower then h.JumpPower = saved.JumpPower end end)
    safeSet(function() if saved.AutoRotate ~= nil then h.AutoRotate = saved.AutoRotate end end)
end

local function setInfo(text)
    if infoLabel and infoLabel.Parent then
        infoLabel.Text = tostring(text or "")
        delay(1.2, function()
            if infoLabel and infoLabel.Parent then infoLabel.Text = "" end
        end)
    end
end

local function tryApplySpeed(txt)
    if not txt or txt == "" then return end
    local n = tonumber(txt)
    if not n then setInfo("Invalid number"); return end
    n = math.clamp(n, SPEED_MIN, SPEED_MAX)
    SPEED = n
    speedBox.PlaceholderText = tostring(SPEED)
    speedBox.Text = ""
    setInfo("Speed set: " .. tostring(SPEED))
end

local function anchorAllCharacterParts(character)
    savedPartAnchors = {}
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            savedPartAnchors[part] = part.Anchored
            safeSet(function()
                if part.AssemblyLinearVelocity then part.AssemblyLinearVelocity = Vector3.new(0,0,0) end
                if part.AssemblyAngularVelocity then part.AssemblyAngularVelocity = Vector3.new(0,0,0) end
                part.Anchored = true
            end)
        end
    end
end

local function restoreAllCharacterParts()
    for part, prev in pairs(savedPartAnchors) do
        safeSet(function()
            if part and part.Parent then
                part.Anchored = (prev == true)
            end
        end)
    end
    savedPartAnchors = {}
end

UserInputService.InputChanged:Connect(function(input, processed)
    if not freecam then return end
    if allowMovement then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local pos
        if input.Position and typeof(input.Position) == "Vector2" then
            pos = input.Position
        else
            pos = UserInputService:GetMouseLocation()
        end
        if ignoreNextInput then
            lastInputPos = pos
            ignoreNextInput = false
            return
        end
        local d = pos - lastInputPos
        lastInputPos = pos
        yaw = yaw - d.X * ROT_SENS
        pitch = math.clamp(pitch - d.Y * ROT_SENS, -math.rad(89), math.rad(89))
    end
end)

local function startSpectator()
    char = player.Character or player.CharacterAdded:Wait()
    humanoid = char:FindFirstChildOfClass("Humanoid")
    hrp = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then warn("Spectator: no humanoid/hrp"); return end
    dummy = makeDummy()
    local camCFrame = camera.CFrame
    dummy.CFrame = camCFrame
    initialDummyCFrame = dummy.CFrame
    initialCameraCFrame = camCFrame
    local rel = (camera.CFrame.Position - dummy.Position)
    local r = rel.Magnitude
    initialDistance = math.max(r, 1)
    local look = rel.Unit
    yaw = math.atan2(look.X, look.Z)
    pitch = math.asin(math.clamp(look.Y, -1, 1))
    saveHumanoidValues(humanoid)
    anchorAllCharacterParts(char)
    savedPlatformStand = humanoid.PlatformStand
    safeSet(function() humanoid.PlatformStand = true end)
    safeSet(function() humanoid.WalkSpeed = 0 end)
    safeSet(function() humanoid.JumpPower = 0 end)
    safeSet(function() humanoid.AutoRotate = false end)
    savedCameraFOV = camera.FieldOfView or 70
    camera.CameraType = Enum.CameraType.Scriptable
    camera.FieldOfView = savedCameraFOV
    lastInputPos = UserInputService:GetMouseLocation()
    ignoreNextInput = true
    freecam = true
    toggleBtn.Text = "ON"
    toggleBtn.TextColor3 = Color3.fromRGB(120,235,120)
    allowMovement = false
    setInfo("Locked. Move to unlock.")
end

local function stopSpectator()
    freecam = false
    local targetHum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if targetHum then
        camera.CameraType = Enum.CameraType.Custom
        camera.CameraSubject = targetHum
    else
        camera.CameraType = Enum.CameraType.Custom
    end
    if savedCameraFOV then
        safeSet(function() camera.FieldOfView = savedCameraFOV end)
        savedCameraFOV = nil
    end
    initialDistance = nil
    initialDummyCFrame = nil
    initialCameraCFrame = nil
    lastInputPos = Vector2.new(0,0)
    ignoreNextInput = false
    safeSet(function()
        if humanoid and humanoid.Parent then
            if savedPlatformStand ~= nil then
                humanoid.PlatformStand = savedPlatformStand
            else
                humanoid.PlatformStand = false
            end
        end
    end)
    savedPlatformStand = nil
    restoreAllCharacterParts()
    if dummy and dummy.Parent then
        safeSet(function() dummy:Destroy() end)
        dummy = nil
    end
    if humanoid then restoreHumanoidValues(humanoid) end
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(220,220,220)
    setInfo("Disabled")
end

RunService.RenderStepped:Connect(function(dt)
    if not freecam then return end
    if not dummy then return end
    if not allowMovement and initialDummyCFrame and initialCameraCFrame and initialDistance then
        safeSet(function() dummy.CFrame = initialDummyCFrame end)
        for part, _ in pairs(savedPartAnchors) do
            safeSet(function()
                if part and part.Parent then
                    if part.AssemblyLinearVelocity then part.AssemblyLinearVelocity = Vector3.new(0,0,0) end
                    if part.AssemblyAngularVelocity then part.AssemblyAngularVelocity = Vector3.new(0,0,0) end
                    part.Anchored = true
                end
            end)
        end
        local lx = math.sin(yaw) * math.cos(pitch)
        local ly = math.sin(pitch)
        local lz = math.cos(yaw) * math.cos(pitch)
        local lookFromDummy = Vector3.new(lx, ly, lz)
        local camPos = dummy.Position + lookFromDummy * initialDistance
        safeSet(function() camera.CFrame = CFrame.new(camPos, dummy.Position) end)
        if savedCameraFOV and camera.FieldOfView > savedCameraFOV then
            camera.FieldOfView = savedCameraFOV
        end
        local md = (humanoid and humanoid.MoveDirection) or Vector3.new()
        local mdMag = md.Magnitude
        local kbVec = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then kbVec = kbVec + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then kbVec = kbVec - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then kbVec = kbVec - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then kbVec = kbVec + camera.CFrame.RightVector end
        local kbMag = kbVec.Magnitude
        local JOYSTICK_THRESHOLD = 0.14
        if mdMag > JOYSTICK_THRESHOLD or kbMag > 0.01 then
            allowMovement = true
            camera.CameraType = Enum.CameraType.Custom
            camera.CameraSubject = dummy
            setInfo("Unlocked")
        end
        return
    end
    if camera.CameraSubject ~= dummy then safeSet(function() camera.CameraSubject = dummy end) end
    if savedCameraFOV and camera.FieldOfView > savedCameraFOV then camera.FieldOfView = savedCameraFOV end
    local md = (humanoid and humanoid.MoveDirection) or Vector3.new()
    local mdMag = md.Magnitude
    local kbVec = Vector3.new()
    if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then kbVec = kbVec + camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then kbVec = kbVec - camera.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then kbVec = kbVec - camera.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then kbVec = kbVec + camera.CFrame.RightVector end
    local kbMag = kbVec.Magnitude
    local moveVec
    if mdMag > 0.001 and humanoid then
        local camForward = camera.CFrame.LookVector
        local forwardFlat = Vector3.new(camForward.X, 0, camForward.Z)
        if forwardFlat.Magnitude < 1e-6 then forwardFlat = Vector3.new(0,0,-1) end
        forwardFlat = forwardFlat.Unit
        local camRight = camera.CFrame.RightVector
        local xAxis = md:Dot(camRight)
        local zAxis = md:Dot(forwardFlat)
        moveVec = (camRight * xAxis) + (camera.CFrame.LookVector * zAxis)
    else
        moveVec = kbVec
    end
    if moveVec.Magnitude < 1e-6 then return end
    local appliedSpeed = math.clamp(SPEED, SPEED_MIN, SPEED_MAX)
    local displacement = moveVec.Unit * appliedSpeed * dt * math.clamp(mdMag, 0, 1)
    local newC = dummy.CFrame + displacement
    if SMOOTH and SMOOTH > 0 then
        dummy.CFrame = dummy.CFrame:Lerp(newC, math.clamp(SMOOTH*60*dt, 0, 1))
    else
        dummy.CFrame = newC
    end
end)

toggleBtn.MouseButton1Click:Connect(function()
    if freecam then stopSpectator() else startSpectator() end
end)

speedBox:GetPropertyChangedSignal("Text"):Connect(function()
    pendingStamp = tick()
    local stamp = pendingStamp
    delay(DEBOUNCE, function()
        if pendingStamp == stamp then tryApplySpeed(speedBox.Text) end
    end)
end)
speedBox.FocusLost:Connect(function()
    tryApplySpeed(speedBox.Text)
end)

player.CharacterAdded:Connect(function(c)
    if savedPlatformStand ~= nil and humanoid and humanoid.Parent then
        safeSet(function() humanoid.PlatformStand = savedPlatformStand end)
        savedPlatformStand = nil
    end
    if next(savedPartAnchors) then restoreAllCharacterParts() end
    char = c
    humanoid = c:FindFirstChildOfClass("Humanoid")
    hrp = c:FindFirstChild("HumanoidRootPart")
    if freecam then stopSpectator() end
end)

speedBox.PlaceholderText = tostring(SPEED)

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local function Bootsfps()
	for _, v in ipairs(Lighting:GetChildren()) do
		if v:IsA("Sky")
		or v:IsA("Atmosphere")
		or v:IsA("BloomEffect")
		or v:IsA("SunRaysEffect")
		or v:IsA("ColorCorrectionEffect")
		or v:IsA("DepthOfFieldEffect") then
			v:Destroy()
		end
	end

	Lighting.GlobalShadows = false
	Lighting.Brightness = 0
	Lighting.FogEnd = 9e9
	Lighting.EnvironmentDiffuseScale = 0
	Lighting.EnvironmentSpecularScale = 0

	if Terrain then
		Terrain.WaterWaveSize = 0
		Terrain.WaterWaveSpeed = 0
		Terrain.WaterReflectance = 0
		Terrain.WaterTransparency = 1
	end

	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.Reflectance = 0
			v.CastShadow = false
			v.Color = Color3.fromRGB(120,120,120)
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter")
		or v:IsA("Trail")
		or v:IsA("Beam") then
			v.Enabled = false
		end
	end
end

if MiscTab then
	MiscTab:Button({
		Title = "Bootsfps",
		Icon = "zap",
		Callback = function()
			Bootsfps()
		end
	})
else
	Bootsfps()
end

local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

local function RTX_ON()
	for _, v in ipairs(Lighting:GetChildren()) do
		if v:IsA("Atmosphere")
		or v:IsA("BloomEffect")
		or v:IsA("SunRaysEffect")
		or v:IsA("ColorCorrectionEffect")
		or v:IsA("DepthOfFieldEffect")
		or v:IsA("Sky") then
			v:Destroy()
		end
	end

	local Sky = Instance.new("Sky")
	Sky.SkyboxBk = "rbxassetid://159454299"
	Sky.SkyboxDn = "rbxassetid://159454296"
	Sky.SkyboxFt = "rbxassetid://159454293"
	Sky.SkyboxLf = "rbxassetid://159454286"
	Sky.SkyboxRt = "rbxassetid://159454300"
	Sky.SkyboxUp = "rbxassetid://159454288"
	Sky.SunAngularSize = 21
	Sky.Parent = Lighting

	Lighting.Technology = Enum.Technology.Future
	Lighting.GlobalShadows = true
	Lighting.ShadowSoftness = 1
	Lighting.Brightness = 3
	Lighting.ExposureCompensation = 0.25
	Lighting.EnvironmentDiffuseScale = 1
	Lighting.EnvironmentSpecularScale = 1
	Lighting.ClockTime = 14

	local Atmosphere = Instance.new("Atmosphere")
	Atmosphere.Density = 0.35
	Atmosphere.Offset = 0.25
	Atmosphere.Color = Color3.fromRGB(190, 210, 255)
	Atmosphere.Decay = Color3.fromRGB(120, 150, 200)
	Atmosphere.Glare = 0.35
	Atmosphere.Haze = 1.2
	Atmosphere.Parent = Lighting

	local Bloom = Instance.new("BloomEffect")
	Bloom.Intensity = 1.2
	Bloom.Size = 56
	Bloom.Threshold = 0.85
	Bloom.Parent = Lighting

	local SunRays = Instance.new("SunRaysEffect")
	SunRays.Intensity = 0.25
	SunRays.Spread = 0.85
	SunRays.Parent = Lighting

	local CC = Instance.new("ColorCorrectionEffect")
	CC.Brightness = 0.05
	CC.Contrast = 0.25
	CC.Saturation = 0.35
	CC.TintColor = Color3.fromRGB(255, 245, 235)
	CC.Parent = Lighting

	local DOF = Instance.new("DepthOfFieldEffect")
	DOF.FarIntensity = 0.25
	DOF.NearIntensity = 0.05
	DOF.FocusDistance = 60
	DOF.InFocusRadius = 40
	DOF.Parent = Lighting

	if Terrain then
		Terrain.WaterWaveSize = 1
		Terrain.WaterWaveSpeed = 15
		Terrain.WaterReflectance = 1
		Terrain.WaterTransparency = 0.05
	end

	for _, v in ipairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CastShadow = true
			if v.Material == Enum.Material.Plastic then
				v.Material = Enum.Material.SmoothPlastic
			end
		end
	end
end

if MiscTab then
	MiscTab:Button({
		Title = "RTX ON",
		Icon = "sparkles",
		Callback = function()
			RTX_ON()
		end
	})
else
	RTX_ON()
end

local function GetJobID()
    return game.JobId or "Unknown"
end

if ServerTab then
    local ServerCodeLabel = ServerTab:Code({
        Title = "Current Server",
        Code = " " .. GetJobID()
    })

    ServerTab:Divider()

    ServerTab:Section({
        Title = "Server Utilities:"
    })

    local ServerCode = ""

    ServerTab:Input({
        Title = "Enter Server Code",
        Placeholder = "Paste server JobId here...",
        Callback = function(Value)
            ServerCode = Value or ""
        end
    })

    ServerTab:Button({
        Title = "Join Code",
        Icon = "log-in",
        Callback = function()
            if ServerCode == "" then
                warn("ใส่codeดิน้อง")
                return
            end
            local TeleportService = game:GetService("TeleportService")
            TeleportService:TeleportToPlaceInstance(game.PlaceId, ServerCode, game.Players.LocalPlayer)
        end
    })

    ServerTab:Button({
        Title = "Rejoin",
        Icon = "refresh-ccw",
        Callback = function()
            local TeleportService = game:GetService("TeleportService")
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
        end
    })

    ServerTab:Button({
        Title = "Hop Server (Low Player)",
        Icon = "shuffle",
        Callback = function()
            local HttpService = game:GetService("HttpService")
            local TeleportService = game:GetService("TeleportService")

            local servers = {}
            local success, req = pcall(function()
                return game:HttpGet(string.format(
                    "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
                    game.PlaceId
                ))
            end)

            if success then
                local data = HttpService:JSONDecode(req)
                if data and data.data then
                    for _, v in pairs(data.data) do
                        if v.playing < v.maxPlayers then
                            table.insert(servers, v.id)
                        end
                    end
                end
            end

            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(
                    game.PlaceId,
                    servers[math.random(1, #servers)],
                    game.Players.LocalPlayer
                )
            else
                warn("หาเซิฟไม่ได้")
            end
        end
    })
else
    warn("ServerTab not found")
end

local HttpService = game:GetService("HttpService")

local ConfigFile = "my_script_config.json"
local Config = {}

local function LoadConfig()
    if isfile and isfile(ConfigFile) then
        local data = readfile(ConfigFile)
        Config = HttpService:JSONDecode(data)
    end
end

local function SaveConfig()
    if writefile then
        writefile(ConfigFile, HttpService:JSONEncode(Config))
    end
end

LoadConfig()

MiscTab:Section({
    Title = "Config"
})

MiscTab:Button({
    Title = "Save Settings",
    Icon = "save",
    Callback = function()
        Config.ESPEnabled = _G.ESPEnabled
        Config.ItemESP = _G.ItemESP
        Config.BumpAura = _G.BumpAura
        Config.SkipAnim = _G.SkipAnim
        Config.FreecamSpeed = SPEED

        SaveConfig()
    end
})

MiscTab:Button({
    Title = "Load Settings",
    Icon = "folder",
    Callback = function()
        LoadConfig()

        if Config.ESPEnabled ~= nil then
            _G.ESPEnabled = Config.ESPEnabled
        end

        if Config.ItemESP ~= nil then
            _G.ItemESP = Config.ItemESP
        end

        if Config.BumpAura ~= nil then
            _G.BumpAura = Config.BumpAura
        end

        if Config.SkipAnim ~= nil then
            _G.SkipAnim = Config.SkipAnim
        end

        if Config.FreecamSpeed then
            SPEED = Config.FreecamSpeed
        end
    end
})

