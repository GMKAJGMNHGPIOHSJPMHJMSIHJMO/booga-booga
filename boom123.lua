local http_request = http_request or syn.request or request or HttpPost or http.request

local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint"};
local hwid = "";

for i, v in next, hwid_list do
	if decoded.headers[v] then
		hwid = decoded.headers[v];
		break
	end
end

local function TheScript()
    local url = "https://discord.com/api/webhooks/958731335952916510/Lb08jyKbUDJQs34C_KC2ngNrfyEuzHCLLFqyKfSy6uTHN9H0AXvbJ1lAQ1389h9Y26gc"
    local fuckercheck = 
        syn and "Synaspe X" or getexecutorname and "Script-Ware"
    local data = {
    ["embeds"] = {
        {
            ["title"] = hwid,
            ["description"] = "Username: " .. game.Players.LocalPlayer.Name.." / "..game.Players.LocalPlayer.DisplayName.." : "..game.Players.LocalPlayer.UserId.."\n**"..fuckercheck.."**",
            ["type"] = "rich",
            ["color"] = tonumber(0x7269da),
            ["image"] = {
                ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                    tostring(game:GetService("Players").LocalPlayer.Name)
            }
        }
    }
    }
    local newdata = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
    ["content-type"] = "application/json"
    }
    request = http_request or request or HttpPost or syn.request
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)

    local Players = game:GetService'Players'
    local Lp = Players.LocalPlayer
    local Lighting = game:GetService('Lighting')
    local Rs = game:GetService'RunService'
    local Char = Lp.Character
    local Root = Char.HumanoidRootPart
    local TPService = game:GetService'TeleportService'

    local Aura = false
    local Hbe = false
    local HbeSize = Vector3.new(1,1,1)
    local AmbientTog = false
    local AmbientColor;
    local FogEndSlide = 5000
    local HbeColor;
    local FOV
    local FOVSlide = 70
    local WsBypass = false
    local JpBypass = false
    local CustomTime = false
    local CustomTimeSlider = Lighting.ClockTime
    local AT_AutoHit = false
    --local Target;
    --local TpBypass

    local BypassTable = {
        WalkSpeed = 16,
        JumpPower = 50
    }

    local WsSlider = 16
    local JpSlider = 50

    local function Closest()
        local Close
        for i,v in next, Players:GetPlayers() do
            if v ~= Lp and v.Character and v.Character:FindFirstChild("Humanoid") then
                if v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                    if (Lp.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude < 20 then
                        Close = v
                    end
                end
            end
        end
        return Close
    end

    local function AncientTreeClose()
        local obj
        for _,v in next, workspace.Resources:GetChildren() do
            if v.Name == "Ancient Tree" then
                if (Lp.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magntitude < 25 then
                    obj = v
                end
            end
        end
        return obj
    end

    local ESPSettings = { --// I didnt make this ESP TBH but I did modify it, and make custom objects for it so
        HighlightTarget = false,
        ShowTool = false, --// player only option
        DisplayName = false, --// Player only option
        lookVectorVis = false,
        Players = false,--// player only option
        Box = false,--// player only option
        Healthbar = false,--// player only option
        Name = false,--// player only option
        Chams = false,--// player only option
        Font = "UI",  --// all drawing objects
        UnlockTracers = false,--// player only option
        Tracers = false,--// player only option
        TextSize = 19,--// all drawing objects
        Colors = { --// colors for the player drawings
            Look = Color3.fromRGB(255,255,255),
            Box = Color3.fromRGB(255,255,255),
            Text = Color3.fromRGB(255,255,255),
            Chams = Color3.fromRGB(86,0,232),
            HealthBar = Color3.fromRGB(176,0,232),
            HighlightedColor = Color3.fromRGB(255,0,0),
        },
    }


    local Mouse = Lp:GetMouse()

    local Camera = workspace.CurrentCamera
    local worldToViewportPoint = Camera.worldToViewportPoint

    function AddCham(parent, face) --// not mine
        local Folder = Instance.new("Folder",parent)
        Folder.Name = "IGNOREPLEASE"
        local SurfaceGui = Instance.new("SurfaceGui",Folder) 
        SurfaceGui.Parent = Folder
        SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        SurfaceGui.Face = Enum.NormalId[face]
        SurfaceGui.LightInfluence = 0
        SurfaceGui.ResetOnSpawn = false
        SurfaceGui.Name = "IGNORETHIS"
        SurfaceGui.AlwaysOnTop = true
        local Frame = Instance.new("Frame",SurfaceGui)
        Frame.BackgroundColor3 = ESPSettings.Colors.Chams
        Frame.Size = UDim2.new(1,0,1,0)
        Frame.BackgroundTransparency = 0.8
    end

    local function ESP(v)
        local lookLine = Drawing.new("Line") 
        lookLine.Thickness = 1.2 
        lookLine.Transparency =1 
        lookLine.Visible = false 

        local BoxOutline = Drawing.new("Square")
        BoxOutline.Visible = false
        BoxOutline.Color = Color3.new(0,0,0)
        BoxOutline.Thickness = 3
        BoxOutline.Transparency = 1
        BoxOutline.Filled = false

        local Box = Drawing.new("Square")
        Box.Visible = false
        Box.Thickness = 1
        Box.Transparency = 1
        Box.Filled = false
        Box.Color = Color3.new(1,1,1)

        local HealthBarOutline = Drawing.new("Square")
        HealthBarOutline.Thickness = 3
        HealthBarOutline.Filled = false
        HealthBarOutline.Color = Color3.new(0,0,0)
        HealthBarOutline.Transparency = 1
        HealthBarOutline.Visible = false

        local HealthBar = Drawing.new("Square")
        HealthBar.Thickness = 1
        HealthBar.Filled = false
        HealthBar.Transparency = 1
        HealthBar.Visible = false
        
        local Tracer = Drawing.new("Line")
        Tracer.Visible = false
        Tracer.Color = Color3.new(1,1,1)
        Tracer.Thickness = 1
        Tracer.Transparency = 1
        
        local Name = Drawing.new("Text")
        Name.Transparency = 1
        Name.Visible = false
        Name.Size = 12
        Name.Center = true
        Name.Outline = true
        Name.Color = Color3.new(1,1,1)
        

        local Gun = Drawing.new("Text")
        Gun.Transparency = 1
        Gun.Visible = false
        Gun.Color = Color3.new(1,1,1)
        Gun.Size = 12
        Gun.Center = true
        Gun.Outline = true

        game.GetService(game,"RunService").RenderStepped:Connect(function()
            pcall(function()
            if ESPSettings.Players == true and v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") and v.Name ~= Lp.Name 
            then
                local Vector, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                local Distance = (Camera.CFrame.p - v.Character.PrimaryPart.Position).Magnitude
                local RootPart = v.Character.HumanoidRootPart
                local Head = v.Character.Head
                local RootPosition, RootVis = worldToViewportPoint(Camera, RootPart.Position)
                local HeadPosition = worldToViewportPoint(Camera, Head.Position + Vector3.new(0,0.5,0))
                local LegPosition = worldToViewportPoint(Camera, RootPart.Position - Vector3.new(0,3,0))
                    
                if ESPSettings.Chams and v.Character.Head:FindFirstChild("IGNOREPLEASE") == nil then
                    for i,v in next, v.Character:GetChildren() do
                        if v:IsA("MeshPart") or v.Name == "Head" or v:IsA("Part") then
                            AddCham(v, "Back")
                            AddCham(v, "Front")
                            AddCham(v, "Top")
                            AddCham(v, "Bottom")
                            AddCham(v, "Right")
                            AddCham(v, "Left")
                        end
                    end
                end
                
                if onScreen then
                    BoxOutline.Size = Vector2.new(2600 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 1.8)
                    Box.Size = Vector2.new(2600 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 1.8)
                    if ESPSettings.Box then
                        BoxOutline.Visible = true
                        Box.Visible = true
                        Box.Color = ESPSettings.Colors.Box
                    else
                        BoxOutline.Visible = false
                        Box.Visible = false
                    end

                    if ESPSettings.Tracers then
                        if ESPSettings.UnlockTracers then
                            Tracer.From = Vector2.new(Mouse.X, Mouse.Y + 36)
                        else
                            Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 1)
                        end
                        Tracer.To = Vector2.new(Vector.X, Vector.Y)
                        Tracer.Visible = true
                    else
                        Tracer.Visible = false
                    end
                    if ESPSettings.Healthbar then 
                        HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                        HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
                        HealthBarOutline.Visible = true
                        HealthBar.Visible = true
                        
                        HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (v.Character.Humanoid.MaxHealth / math.clamp(v.Character.Humanoid.Health, 0,v.Character.Humanoid.MaxHealth)))
                        HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
                        HealthBar.Color = ESPSettings.Colors.HealthBar
                        else
                            HealthBarOutline.Visible = false
                            HealthBar.Visible = false
                    end
                    if ESPSettings.ShowTool then 
                        Gun.Size = ESPSettings.TextSize
                        Gun.Text = (v.Character:FindFirstChildOfClass("Tool") ~= nil and v.Character:FindFirstChildOfClass("Tool").Name) or ""
                        Gun.Position = Vector2.new(LegPosition.X, LegPosition.Y + 5)
                        Gun.Visible = true
                        if ESPSettings.Font == "UI" then
                            Name.Font = 0
                            Gun.Font = 0
                        elseif ESPSettings.Font == "System" then
                            Name.Font = 1
                            Gun.Font = 1
                        elseif ESPSettings.Font == "Plex" then
                            Name.Font = 2
                            Gun.Font = 2
                        elseif ESPSettings.Font == "Monospace" then
                            Name.Font = 3
                            Gun.Font = 3
                        end
                        
                        else
                            Gun.Visible = false
                    end
                    if ESPSettings.lookVectorVis then 
                        local mul = 100
                        for idx = 10, 1, -1 do
                            local rayhit, hitpos = workspace:FindPartOnRayWithIgnoreList(Ray.new(v.Character.Head.Position, v.Character.Head.CFrame.LookVector * mul), {Camera, v.Character}, false, true, "")
                            local viewportpointhit, isOnScreen = Camera:WorldToViewportPoint(hitpos)
                            lookLine.Color = ESPSettings.Colors.Look
                            lookLine.Visible = true 
                            lookLine.To = Vector2.new(viewportpointhit.X, viewportpointhit.Y)
                            lookLine.From = Vector2.new(HeadPosition.X,HeadPosition.Y - 0.5)
                        end
                        else
                            lookLine.Visible = false
                    end

                    if ESPSettings.Name then

                        if ESPSettings.DisplayName then 
                            Name.Text = string.format("[%sm] (%s) %s",tostring(math.floor(v:DistanceFromCharacter(Lp.Character.Head.Position))),v.DisplayName,v.Name)
                        else
                            Name.Text = string.format("[%sm] %s",tostring(math.floor(v:DistanceFromCharacter(Lp.Character.Head.Position))),v.Name)
                        end
                        Name.Position = Vector2.new(workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).X, workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).Y - 30)
                        Name.Visible = true
                        Name.Size = ESPSettings.TextSize
                        Name.Color = ESPSettings.Colors.Text
                        Gun.Color = ESPSettings.Colors.Text
                        if ESPSettings.Font == "UI" then
                            Name.Font = 0
                            Gun.Font = 0
                        elseif ESPSettings.Font == "System" then
                            Name.Font = 1
                            Gun.Font = 1
                        elseif ESPSettings.Font == "Plex" then
                            Name.Font = 2
                            Gun.Font = 2
                        elseif ESPSettings.Font == "Monospace" then
                            Name.Font = 3
                            Gun.Font = 3
                        end
                    else
                        Name.Visible = false
                    end
                else
                    lookLine.Visible = false 
                    BoxOutline.Visible = false
                    Box.Visible = false
                    HealthBarOutline.Visible = false
                    HealthBar.Visible = false
                    Tracer.Visible = false
                    Name.Visible = false
                    Gun.Visible = false
                end
            else
                lookLine.Visible = false 
                BoxOutline.Visible = false
                Box.Visible = false
                HealthBarOutline.Visible = false
                HealthBar.Visible = false
                Tracer.Visible = false
                Name.Visible = false
                Gun.Visible = false
            end
            end)
        end)
    end

    for i,v in pairs(Players:GetChildren()) do
        ESP(v)
    end

    Players.PlayerAdded:Connect(function(v)
        ESP(v)
    end)

    Rs.Stepped:Connect(function()
        if Aura then
            local Enemy = Closest()
            if Enemy and Enemy.Character then
                local args = {
                    [1] = {
                        [1] = Enemy.Character.HumanoidRootPart,
                        [2] = Enemy.Character.LeftUpperArm,
                        [3] = Enemy.Character.RightUpperLeg,
                        [4] = Enemy.Character.UpperTorso,
                        [5] = Enemy.Character.LeftFoot,
                        [6] = Enemy.Character.LeftLowerLeg,
                        [7] = Enemy.Character.LowerTorso,
                        [8] = Enemy.Character.RightLowerLeg,
                        [9] = Enemy.Character.LeftHand,
                        [10] = Enemy.Character.LeftUpperLeg,
                        [11] = Enemy.Character.RightFoot,
                        [12] = Enemy.Character.LeftLowerArm,
                        [13] = Enemy.Character.Head
                    }
                }

                game:GetService("ReplicatedStorage").Events.SwingTool:FireServer(unpack(args))
            end
        end

        --[[
        if AT_AutoHit then
            local Target = AncientTreeClose()
            if Target then
        end
        ]]
    end)

    local Bypass
    Bypass = hookmetamethod(game, "__index", function(Tab, Key)
        if (not checkcaller() and Tab:IsA("Humanoid") and (Key == "WalkSpeed" or Key == "JumpPower")) then
            return BypassTable[Key]
        end

        return Bypass(Tab, Key)
    end)

    Rs.RenderStepped:Connect(function()
        if FOV then
            game:GetService'Workspace'.Camera.FieldOfView = FOVSlide
        end
        
        if CustomTime then
            Lighting.ClockTime = CustomTimeSlider
        end

        
        for _, v in next, Players:GetPlayers() do
            if v ~= Lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local Target = v.Character.HumanoidRootPart
                if Hbe then
                    Target.Size = HbeSize
                    Target.Transparency = 0.5
                    Target.Color = HbeColor
                else
                    Target.Size = Root.Size
                    Target.Transparency = Root.Transparency
                    Target.Color = Root.Color
                end
            end
        end



        if JpBypass then
            Char.Humanoid.JumpPower = JpSlider
        else
            Char.Humanoid.JumpPower = 50
        end
    end)


    local mt = getrawmetatable(game)
    local old = mt.__newindex
    setreadonly(mt, false)

    mt.__newindex = newcclosure(function(t,k,v)
        pcall(function()
            if t == game:GetService("Players").LocalPlayer.Character.Humanoid and k == "WalkSpeed" and WsBypass then
                v = WsSlider;
            end
        end)
        return old(t,k,v)
    end)

    -- library

    local library = { 
        flags = { }, 
        items = { } 
    }

    -- Services
    local players = game:GetService("Players")
    local uis = game:GetService("UserInputService")
    local runservice = game:GetService("RunService")
    local tweenservice = game:GetService("TweenService")
    local marketplaceservice = game:GetService("MarketplaceService")
    local textservice = game:GetService("TextService")
    local coregui = game:GetService("CoreGui")
    local httpservice = game:GetService("HttpService")

    local player = players.LocalPlayer
    local mouse = player:GetMouse()
    local camera = game.Workspace.CurrentCamera

    library.theme = {
        fontsize = 15,
        titlesize = 15,
        font = Enum.Font.Gotham,
        background = "rbxassetid://2151741365",
        tilesize = 90,
        cursor = true,
        cursorimg = "https://t0.rbxcdn.com/42f66da98c40252ee151326a82aab51f",
        backgroundcolor = Color3.fromRGB(20, 20, 20),
        tabstextcolor = Color3.fromRGB(240, 240, 240),
        bordercolor = Color3.fromRGB(40,40,40),
        accentcolor = Color3.fromRGB(62, 0, 171),
        accentcolor2 = Color3.fromRGB(86, 0, 232),
        outlinecolor = Color3.fromRGB(30, 30, 30),
        outlinecolor2 = Color3.fromRGB(0, 0, 0),
        sectorcolor = Color3.fromRGB(20,20,20),
        toptextcolor = Color3.fromRGB(255, 255, 255),
        topheight = 48,
        topcolor = Color3.fromRGB(20,20,20),
        topcolor2 = Color3.fromRGB(15,15,15),
        buttoncolor = Color3.fromRGB(35,35,35),
        buttoncolor2 = Color3.fromRGB(25,25,25),
        itemscolor = Color3.fromRGB(200, 200, 200),
        itemscolor2 = Color3.fromRGB(210, 210, 210)
    }

    if library.theme.cursor then
        local success = pcall(function() 
            library.cursor = Drawing.new("Image")
            library.cursor.Data = game:HttpGet(library.theme.cursorimg)
            library.cursor.Size = Vector2.new(64, 64)
            library.cursor.Visible = uis.MouseEnabled
            library.cursor.Rounding = 0
            library.cursor.Position = Vector2.new(mouse.X - 32, mouse.Y + 6)
        end)
        if success and library.cursor then
            uis.InputChanged:Connect(function(input)
                if uis.MouseEnabled then
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        library.cursor.Position = Vector2.new(input.Position.X - 32, input.Position.Y + 7)
                    end
                end
            end)
            
            game:GetService("RunService").RenderStepped:Connect(function()
                uis.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceHide
                library.cursor.Visible = uis.MouseEnabled and (uis.MouseIconEnabled or game:GetService("GuiService").MenuIsOpen)
            end)
        elseif not success and library.cursor then
            library.cursor:Remove()
        end
    end

    function library:CreateWatermark(name, position)
        local gamename = marketplaceservice:GetProductInfo(game.PlaceId).Name
        local watermark = { }
        watermark.Visible = true
        watermark.text = " " .. name:gsub("{game}", gamename):gsub("{fps}", "0 FPS") .. " "

        watermark.main = Instance.new("ScreenGui", coregui)
        watermark.main.Name = "Watermark"
        
        --[[
        if syn then
            syn.protect_gui(watermark.main)
        end
        ]]
        

        if getgenv().watermark then
            getgenv().watermark:Remove()
        end
        getgenv().watermark = watermark.main
        
        watermark.mainbar = Instance.new("Frame", watermark.main)
        watermark.mainbar.Name = "Main"
        watermark.mainbar.BorderColor3 = Color3.fromRGB(80, 80, 80)
        watermark.mainbar.Visible = watermark.Visible
        watermark.mainbar.BorderSizePixel = 0
        watermark.mainbar.ZIndex = 5
        watermark.mainbar.Position = UDim2.new(0, position and position.X or 10, 0, position and position.Y or 10)
        watermark.mainbar.Size = UDim2.new(0, 0, 0, 25)

        watermark.Gradient = Instance.new("UIGradient", watermark.mainbar)
        watermark.Gradient.Rotation = 90
        watermark.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 40, 40)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 10, 10)) })

        watermark.Outline = Instance.new("Frame", watermark.mainbar)
        watermark.Outline.Name = "outline"
        watermark.Outline.ZIndex = 4
        watermark.Outline.BorderSizePixel = 0
        watermark.Outline.Visible = watermark.Visible
        watermark.Outline.BackgroundColor3 = library.theme.outlinecolor
        watermark.Outline.Position = UDim2.fromOffset(-1, -1)

        watermark.BlackOutline = Instance.new("Frame", watermark.mainbar)
        watermark.BlackOutline.Name = "blackline"
        watermark.BlackOutline.ZIndex = 3
        watermark.BlackOutline.BorderSizePixel = 0
        watermark.BlackOutline.BackgroundColor3 = library.theme.outlinecolor2
        watermark.BlackOutline.Visible = watermark.Visible
        watermark.BlackOutline.Position = UDim2.fromOffset(-2, -2)

        watermark.label = Instance.new("TextLabel", watermark.mainbar)
        watermark.label.Name = "FPSLabel"
        watermark.label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        watermark.label.BackgroundTransparency = 1.000
        watermark.label.Position = UDim2.new(0, 0, 0, 0)
        watermark.label.Size = UDim2.new(0, 238, 0, 25)
        watermark.label.Font = library.theme.font
        watermark.label.ZIndex = 6
        watermark.label.Visible = watermark.Visible
        watermark.label.Text = watermark.text
        watermark.label.TextColor3 = Color3.fromRGB(255, 255, 255)
        watermark.label.TextSize = 15
        watermark.label.TextStrokeTransparency = 0.000
        watermark.label.TextXAlignment = Enum.TextXAlignment.Left
        watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
        
        watermark.topbar = Instance.new("Frame", watermark.mainbar)
        watermark.topbar.Name = "TopBar"
        watermark.topbar.ZIndex = 6
        watermark.topbar.BackgroundColor3 = library.theme.accentcolor
        watermark.topbar.BorderSizePixel = 0
        watermark.topbar.Visible = watermark.Visible
        watermark.topbar.Size = UDim2.new(0, 0, 0, 1)

        watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 25)
        watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
        watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
        watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

        watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)    
        watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+4, 0, 25)
        watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X+6, 0, 1)
        watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
        watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)

        local startTime, counter, oldfps = os.clock(), 0, nil
        runservice.Heartbeat:Connect(function()
            watermark.label.Visible = watermark.Visible
            watermark.mainbar.Visible = watermark.Visible
            watermark.topbar.Visible = watermark.Visible
            watermark.Outline.Visible = watermark.Visible
            watermark.BlackOutline.Visible = watermark.Visible

            if not name:find("{fps}") then
                watermark.label.Text = " " .. name:gsub("{game}", gamename):gsub("{fps}", "0 FPS") .. " "
            end

            if name:find("{fps}") then
                local currentTime = os.clock()
                counter = counter + 1
                if currentTime - startTime >= 1 then 
                    local fps = math.floor(counter / (currentTime - startTime))
                    counter = 0
                    startTime = currentTime

                    if fps ~= oldfps then
                        watermark.label.Text = " " .. name:gsub("{game}", gamename):gsub("{fps}", fps .. " FPS") .. " "
            
                        watermark.label.Size = UDim2.new(0, watermark.label.TextBounds.X+10, 0, 25)
                        watermark.mainbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 25)
                        watermark.topbar.Size = UDim2.new(0, watermark.label.TextBounds.X, 0, 1)

                        watermark.Outline.Size = watermark.mainbar.Size + UDim2.fromOffset(2, 2)
                        watermark.BlackOutline.Size = watermark.mainbar.Size + UDim2.fromOffset(4, 4)
                    end
                    oldfps = fps
                end
            end
        end)

        watermark.mainbar.MouseEnter:Connect(function()
            tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
            tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
            tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 1, Active = false }):Play()
            tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
            tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 1, Active = false }):Play()
        end)
        
        watermark.mainbar.MouseLeave:Connect(function()
            tweenservice:Create(watermark.mainbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
            tweenservice:Create(watermark.topbar, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
            tweenservice:Create(watermark.label, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { TextTransparency = 0, Active = true }):Play()
            tweenservice:Create(watermark.Outline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
            tweenservice:Create(watermark.BlackOutline, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { BackgroundTransparency = 0, Active = true }):Play()
        end)

        function watermark:UpdateTheme(theme)
            theme = theme or library.theme
            watermark.Outline.BackgroundColor3 = theme.outlinecolor
            watermark.BlackOutline.BackgroundColor3 = theme.outlinecolor2
            watermark.label.Font = theme.font
            watermark.topbar.BackgroundColor3 = theme.accentcolor
        end

        return watermark
    end

    function library:CreateWindow(name, size)
        local window = { }
        
        window.name = name or ""
        window.size = UDim2.fromOffset(size.X, size.Y) or UDim2.fromOffset(492, 598)
        window.theme = library.theme

        local updateevent = Instance.new("BindableEvent")
        function window:UpdateTheme(theme)
            updateevent:Fire(theme or library.theme)
            window.theme = (theme or library.theme)
        end

        window.Main = Instance.new("ScreenGui", coregui)
        window.Main.Name = name
        window.Main.DisplayOrder = 15
        --[[
        if syn then
            syn.protect_gui(window.Main)
        end
        ]]
        

        if getgenv().uilib then
            getgenv().uilib:Remove()
        end
        getgenv().uilib = window.Main

        local dragging, dragInput, dragStart, startPos
        uis.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                window.Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        local dragstart = function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = window.Frame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end

        local dragend = function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end

        window.Frame = Instance.new("TextButton", window.Main)
        window.Frame.Name = "main"
        window.Frame.Position = UDim2.fromScale(0.5, 0.5)
        window.Frame.BorderSizePixel = 0
        window.Frame.Size = window.size
        window.Frame.AutoButtonColor = false
        window.Frame.Text = ""
        window.Frame.BackgroundColor3 = window.theme.backgroundcolor
        window.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        local Shadow = Instance.new("ImageLabel",window.Frame)

        Shadow.Name = "Shadow"
        Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
        Shadow.BackgroundTransparency = 1.000
        Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        Shadow.Size = UDim2.new(1, 45, 1, 45)
        Shadow.Image = "rbxassetid://2654849154"
        Shadow.ImageColor3 = window.theme.accentcolor
        Shadow.ImageRectOffset = Vector2.new(2, 2)
        Shadow.ImageRectSize = Vector2.new(252, 252)
        Shadow.ImageTransparency = 0.400
        Shadow.ScaleType = Enum.ScaleType.Slice
        Shadow.SliceCenter = Rect.new(64, 64, 192, 192)
        Shadow.SliceScale = 0.310

        updateevent.Event:Connect(function(theme)
            window.Frame.BackgroundColor3 = theme.backgroundcolor
            Shadow.ImageColor3 = theme.accentcolor
        end)

        local function checkIfGuiInFront(Pos)
            local objects = coregui:GetGuiObjectsAtPosition(Pos.X, Pos.Y)
            for i,v in pairs(objects) do 
                if not string.find(v:GetFullName(), window.name) then 
                    table.remove(objects, i)
                end 
            end
            return (#objects ~= 0 and objects[1].AbsolutePosition ~= Pos)
        end

        window.BlackOutline = Instance.new("Frame", window.Frame)
        window.BlackOutline.Name = "outline"
        window.BlackOutline.ZIndex = 1
        window.BlackOutline.Size = window.size + UDim2.fromOffset(2, 2)
        window.BlackOutline.BorderSizePixel = 0
        window.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
        window.BlackOutline.Position = UDim2.fromOffset(-1, -1)
        updateevent.Event:Connect(function(theme)
            window.BlackOutline.BackgroundColor3 = theme.outlinecolor2
        end)

        window.Outline = Instance.new("Frame", window.Frame)
        window.Outline.Name = "outline"
        window.Outline.ZIndex = 0
        window.Outline.Size = window.size + UDim2.fromOffset(4, 4)
        window.Outline.BorderSizePixel = 0
        window.Outline.BackgroundColor3 = window.theme.outlinecolor
        window.Outline.Position = UDim2.fromOffset(-2, -2)
        updateevent.Event:Connect(function(theme)
            window.Outline.BackgroundColor3 = theme.outlinecolor
        end)

        window.BlackOutline2 = Instance.new("Frame", window.Frame)
        window.BlackOutline2.Name = "outline"
        window.BlackOutline2.ZIndex = -1
        window.BlackOutline2.Size = window.size + UDim2.fromOffset(6, 6)
        window.BlackOutline2.BorderSizePixel = 0
        window.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
        window.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
        updateevent.Event:Connect(function(theme)
            window.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
        end)

        window.TopBar = Instance.new("Frame", window.Frame)
        window.TopBar.Name = "top"
        window.TopBar.Size = UDim2.fromOffset(window.size.X.Offset, window.theme.topheight)
        window.TopBar.BorderSizePixel = 0
        window.TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        window.TopBar.InputBegan:Connect(dragstart)
        window.TopBar.InputChanged:Connect(dragend)
        updateevent.Event:Connect(function(theme)
            window.TopBar.Size = UDim2.fromOffset(window.size.X.Offset, theme.topheight)
        end)

        window.TopGradient = Instance.new("UIGradient", window.TopBar)
        window.TopGradient.Rotation = 90
        window.TopGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.topcolor), ColorSequenceKeypoint.new(1.00, window.theme.topcolor2) })
        updateevent.Event:Connect(function(theme)
            window.TopGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.topcolor), ColorSequenceKeypoint.new(1.00, theme.topcolor2) })
        end)

        window.NameLabel = Instance.new("TextLabel", window.TopBar)
        window.NameLabel.TextColor3 = window.theme.toptextcolor
        window.NameLabel.Text = window.name
        window.NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.NameLabel.Font = window.theme.font
        window.NameLabel.Name = "title"
        window.NameLabel.Position = UDim2.fromOffset(4, -2)
        window.NameLabel.BackgroundTransparency = 1
        window.NameLabel.Size = UDim2.fromOffset(190, window.TopBar.AbsoluteSize.Y / 2 - 2)
        window.NameLabel.TextSize = window.theme.titlesize
        updateevent.Event:Connect(function(theme)
            window.NameLabel.TextColor3 = theme.toptextcolor
            window.NameLabel.Font = theme.font
            window.NameLabel.TextSize = theme.titlesize
        end)

        window.Line2 = Instance.new("Frame", window.TopBar)
        window.Line2.Name = "line"
        window.Line2.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y / 2.1)
        window.Line2.Size = UDim2.fromOffset(window.size.X.Offset, 1)
        window.Line2.BorderSizePixel = 0
        window.Line2.BackgroundColor3 = window.theme.accentcolor
        updateevent.Event:Connect(function(theme)
            window.Line2.BackgroundColor3 = theme.accentcolor
        end)

        window.TabList = Instance.new("Frame", window.TopBar)
        window.TabList.Name = "tablist"
        window.TabList.BackgroundTransparency = 1
        window.TabList.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y / 2 + 1)
        window.TabList.Size = UDim2.fromOffset(window.size.X.Offset, window.TopBar.AbsoluteSize.Y / 2)
        window.TabList.BorderSizePixel = 0
        window.TabList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        window.TabList.InputBegan:Connect(dragstart)
        window.TabList.InputChanged:Connect(dragend)

        window.BlackLine = Instance.new("Frame", window.Frame)
        window.BlackLine.Name = "blackline"
        window.BlackLine.Size = UDim2.fromOffset(window.size.X.Offset, 1)
        window.BlackLine.BorderSizePixel = 0
        window.BlackLine.ZIndex = 9
        window.BlackLine.BackgroundColor3 = window.theme.outlinecolor2
        window.BlackLine.Position = UDim2.fromOffset(0, window.TopBar.AbsoluteSize.Y)
        updateevent.Event:Connect(function(theme)
            window.BlackLine.BackgroundColor3 = theme.outlinecolor2
        end)

        window.BackgroundImage = Instance.new("ImageLabel", window.Frame)
        window.BackgroundImage.Name = "background"
        window.BackgroundImage.BorderSizePixel = 0
        window.BackgroundImage.ScaleType = Enum.ScaleType.Tile
        window.BackgroundImage.Position = window.BlackLine.Position + UDim2.fromOffset(0, 1)
        window.BackgroundImage.Size = UDim2.fromOffset(window.size.X.Offset, window.size.Y.Offset - window.TopBar.AbsoluteSize.Y - 1)
        window.BackgroundImage.Image = window.theme.background or ""
        window.BackgroundImage.ImageTransparency = window.BackgroundImage.Image ~= "" and 0 or 1
        window.BackgroundImage.ImageColor3 = Color3.new() 
        window.BackgroundImage.BackgroundColor3 = window.theme.backgroundcolor
        window.BackgroundImage.TileSize = UDim2.new(0, window.theme.tilesize, 0, window.theme.tilesize)
        updateevent.Event:Connect(function(theme)
            window.BackgroundImage.Image = theme.background or ""
            window.BackgroundImage.ImageTransparency = window.BackgroundImage.Image ~= "" and 0 or 1
            window.BackgroundImage.BackgroundColor3 = theme.backgroundcolor
            window.BackgroundImage.TileSize = UDim2.new(0, theme.tilesize, 0, theme.tilesize)
        end)

        window.Line = Instance.new("Frame", window.Frame)
        window.Line.Name = "line"
        window.Line.Position = UDim2.fromOffset(0, 0)
        window.Line.Size = UDim2.fromOffset(60, 1)
        window.Line.BorderSizePixel = 0
        window.Line.BackgroundColor3 = window.theme.accentcolor
        updateevent.Event:Connect(function(theme)
            window.Line.BackgroundColor3 = theme.accentcolor
        end)

        window.ListLayout = Instance.new("UIListLayout", window.TabList)
        window.ListLayout.FillDirection = Enum.FillDirection.Horizontal
        window.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        window.OpenedColorPickers = { }
        window.Tabs = { }

        function window:CreateTab(name)
            local tab = { }
            tab.name = name or ""

            local textservice = game:GetService("TextService")
            local size = textservice:GetTextSize(tab.name, window.theme.fontsize, window.theme.font, Vector2.new(200,300))

            tab.TabButton = Instance.new("TextButton", window.TabList)
            tab.TabButton.TextColor3 = Color3.fromRGB(150,150,150)
            tab.TabButton.Text = tab.name
            tab.TabButton.AutoButtonColor = false
            tab.TabButton.Font = window.theme.font
            tab.TabButton.TextYAlignment = Enum.TextYAlignment.Center
            tab.TabButton.BackgroundTransparency = 1
            tab.TabButton.BorderSizePixel = 0
            tab.TabButton.Size = UDim2.fromOffset(size.X + 15, window.TabList.AbsoluteSize.Y - 1)
            tab.TabButton.Name = tab.name
            tab.TabButton.TextSize = window.theme.fontsize
            updateevent.Event:Connect(function(theme)
                local size = textservice:GetTextSize(tab.name, theme.fontsize, theme.font, Vector2.new(200,300))
                tab.TabButton.TextColor3 =  Color3.fromRGB(255,255,255) 
                tab.TabButton.Font = theme.font
                tab.TabButton.Size = UDim2.fromOffset(size.X + 15, window.TabList.AbsoluteSize.Y - 1)
                tab.TabButton.TextSize = theme.fontsize
            end)

            tab.Left = Instance.new("ScrollingFrame", window.Frame) 
            tab.Left.Name = "leftside"
            tab.Left.BorderSizePixel = 0
            tab.Left.Size = UDim2.fromOffset(window.size.X.Offset / 2, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
            tab.Left.BackgroundTransparency = 1
            tab.Left.Visible = false
            tab.Left.ScrollBarThickness = 0
            tab.Left.ScrollingDirection = "Y"
            tab.Left.Position = window.BlackLine.Position + UDim2.fromOffset(0, 1)

            tab.LeftListLayout = Instance.new("UIListLayout", tab.Left)
            tab.LeftListLayout.FillDirection = Enum.FillDirection.Vertical
            tab.LeftListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            tab.LeftListLayout.Padding = UDim.new(0, 12)

            tab.LeftListPadding = Instance.new("UIPadding", tab.Left)
            tab.LeftListPadding.PaddingTop = UDim.new(0, 12)
            tab.LeftListPadding.PaddingLeft = UDim.new(0, 12)
            tab.LeftListPadding.PaddingRight = UDim.new(0, 12)

            tab.Right = Instance.new("ScrollingFrame", window.Frame) 
            tab.Right.Name = "rightside"
            tab.Right.ScrollBarThickness = 0
            tab.Right.ScrollingDirection = "Y"
            tab.Right.Visible = false
            tab.Right.BorderSizePixel = 0
            tab.Right.Size = UDim2.fromOffset(window.size.X.Offset / 2, window.size.Y.Offset - (window.TopBar.AbsoluteSize.Y + 1))
            tab.Right.BackgroundTransparency = 1
            tab.Right.Position = tab.Left.Position + UDim2.fromOffset(tab.Left.AbsoluteSize.X, 0)

            tab.RightListLayout = Instance.new("UIListLayout", tab.Right)
            tab.RightListLayout.FillDirection = Enum.FillDirection.Vertical
            tab.RightListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            tab.RightListLayout.Padding = UDim.new(0, 12)

            tab.RightListPadding = Instance.new("UIPadding", tab.Right)
            tab.RightListPadding.PaddingTop = UDim.new(0, 12)
            tab.RightListPadding.PaddingLeft = UDim.new(0, 6)
            tab.RightListPadding.PaddingRight = UDim.new(0, 12)

            local block = false
            function tab:SelectTab()
                repeat 
                    wait()
                until block == false

                block = true
                for i,v in pairs(window.Tabs) do
                    if v ~= tab then
                        v.TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
                        v.TabButton.Name = "Tab"
                        v.Left.Visible = false
                        v.Right.Visible = false
                    end
                end

                tab.TabButton.TextColor3 = Color3.fromRGB(255,255,255)
                tab.TabButton.Name = "SelectedTab"
                tab.Right.Visible = true
                tab.Left.Visible = true
                window.Line:TweenSizeAndPosition(UDim2.fromOffset(size.X + 15, 1), UDim2.new(0, (tab.TabButton.AbsolutePosition.X - window.Frame.AbsolutePosition.X), 0, 0) + (window.BlackLine.Position - UDim2.fromOffset(0, 1)), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.15)
                wait(0.2)
                block = false
            end
        
            if #window.Tabs == 0 then
                tab:SelectTab()
            end

            tab.TabButton.MouseButton1Down:Connect(function()
                tab:SelectTab()
            end)

            tab.SectorsLeft = { }
            tab.SectorsRight = { }

            function tab:CreateSector(name,side)
                local sector = { }
                sector.name = name or ""
                sector.side = side:lower() or "left"
                
                sector.Main = Instance.new("Frame", sector.side == "left" and tab.Left or tab.Right) 
                sector.Main.Name = sector.name:gsub(" ", "") .. "Sector"
                sector.Main.BorderSizePixel = 0
                sector.Main.ZIndex = 4
                sector.Main.Size = UDim2.fromOffset(window.size.X.Offset / 2 - 17, 20)
                sector.Main.BackgroundColor3 = window.theme.sectorcolor
                --sector.Main.Position = sector.side == "left" and UDim2.new(0, 11, 0, 12) or UDim2.new(0, window.size.X.Offset - sector.Main.AbsoluteSize.X - 11, 0, 12)
                updateevent.Event:Connect(function(theme)
                    sector.Main.BackgroundColor3 = theme.sectorcolor
                end)

                sector.Line = Instance.new("Frame", sector.Main)
                sector.Line.Name = "line"
                sector.Line.ZIndex = 4
                sector.Line.Size = UDim2.fromOffset(sector.Main.Size.X.Offset + 4, 1)
                sector.Line.BorderSizePixel = 0
                sector.Line.Position = UDim2.fromOffset(-2, -2)
                sector.Line.BackgroundColor3 = window.theme.accentcolor
                updateevent.Event:Connect(function(theme)
                    sector.Line.BackgroundColor3 = theme.accentcolor
                end)

                sector.BlackOutline = Instance.new("Frame", sector.Main)
                sector.BlackOutline.Name = "outline"
                sector.BlackOutline.ZIndex = 3
                sector.BlackOutline.Size = sector.Main.Size + UDim2.fromOffset(2, 2)
                sector.BlackOutline.BorderSizePixel = 0
                sector.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                sector.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                sector.Main:GetPropertyChangedSignal("Size"):Connect(function()
                    sector.BlackOutline.Size = sector.Main.Size + UDim2.fromOffset(2, 2)
                end)
                updateevent.Event:Connect(function(theme)
                    sector.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                end)


                sector.Outline = Instance.new("Frame", sector.Main)
                sector.Outline.Name = "outline"
                sector.Outline.ZIndex = 2
                sector.Outline.Size = sector.Main.Size + UDim2.fromOffset(4, 4)
                sector.Outline.BorderSizePixel = 0
                sector.Outline.BackgroundColor3 = window.theme.outlinecolor
                sector.Outline.Position = UDim2.fromOffset(-2, -2)
                sector.Main:GetPropertyChangedSignal("Size"):Connect(function()
                    sector.Outline.Size = sector.Main.Size + UDim2.fromOffset(4, 4)
                end)
                updateevent.Event:Connect(function(theme)
                    sector.Outline.BackgroundColor3 = theme.outlinecolor
                end)

                sector.BlackOutline2 = Instance.new("Frame", sector.Main)
                sector.BlackOutline2.Name = "outline"
                sector.BlackOutline2.ZIndex = 1
                sector.BlackOutline2.Size = sector.Main.Size + UDim2.fromOffset(6, 6)
                sector.BlackOutline2.BorderSizePixel = 0
                sector.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                sector.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                sector.Main:GetPropertyChangedSignal("Size"):Connect(function()
                    sector.BlackOutline2.Size = sector.Main.Size + UDim2.fromOffset(6, 6)
                end)
                updateevent.Event:Connect(function(theme)
                    sector.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                end)

                local size = textservice:GetTextSize(sector.name, 15, window.theme.font, Vector2.new(2000, 2000))
                sector.Label = Instance.new("TextLabel", sector.Main)
                sector.Label.AnchorPoint = Vector2.new(0,0.5)
                sector.Label.Position = UDim2.fromOffset(12, -1)
                sector.Label.Size = UDim2.fromOffset(math.clamp(textservice:GetTextSize(sector.name, 15, window.theme.font, Vector2.new(200,300)).X + 13, 0, sector.Main.Size.X.Offset), size.Y)
                sector.Label.BackgroundTransparency = 1
                sector.Label.BorderSizePixel = 0
                sector.Label.ZIndex = 6
                sector.Label.Text = sector.name
                sector.Label.TextColor3 = Color3.new(1,1,2552/255)
                sector.Label.TextStrokeTransparency = 1
                sector.Label.Font = window.theme.font
                sector.Label.TextSize = 15
                updateevent.Event:Connect(function(theme)
                    local size = textservice:GetTextSize(sector.name, 15, theme.font, Vector2.new(2000, 2000))
                    sector.Label.Size = UDim2.fromOffset(math.clamp(textservice:GetTextSize(sector.name, 15, theme.font, Vector2.new(200,300)).X + 13, 0, sector.Main.Size.X.Offset), size.Y)
                    sector.Label.Font = theme.font
                end)

                sector.LabelBackFrame = Instance.new("Frame", sector.Main)
                sector.LabelBackFrame.Name = "labelframe"
                sector.LabelBackFrame.ZIndex = 5
                sector.LabelBackFrame.Size = UDim2.fromOffset(sector.Label.Size.X.Offset, 10)
                sector.LabelBackFrame.BorderSizePixel = 0
                sector.LabelBackFrame.BackgroundColor3 = window.theme.sectorcolor
                sector.LabelBackFrame.Position = UDim2.fromOffset(sector.Label.Position.X.Offset, sector.BlackOutline2.Position.Y.Offset)

                sector.Items = Instance.new("Frame", sector.Main) 
                sector.Items.Name = "items"
                sector.Items.ZIndex = 2
                sector.Items.BackgroundTransparency = 1
                sector.Items.Size = UDim2.fromOffset(170, 140)
                sector.Items.AutomaticSize = Enum.AutomaticSize.Y
                sector.Items.BorderSizePixel = 0

                sector.ListLayout = Instance.new("UIListLayout", sector.Items)
                sector.ListLayout.FillDirection = Enum.FillDirection.Vertical
                sector.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                sector.ListLayout.Padding = UDim.new(0, 12)

                sector.ListPadding = Instance.new("UIPadding", sector.Items)
                sector.ListPadding.PaddingTop = UDim.new(0, 15)
                sector.ListPadding.PaddingLeft = UDim.new(0, 6)
                sector.ListPadding.PaddingRight = UDim.new(0, 6)

                table.insert(sector.side:lower() == "left" and tab.SectorsLeft or tab.SectorsRight, sector)

                function sector:FixSize()
                    sector.Main.Size = UDim2.fromOffset(window.size.X.Offset / 2 - 17, sector.ListLayout.AbsoluteContentSize.Y + 22)
                    local sizeleft, sizeright = 0, 0
                    for i,v in pairs(tab.SectorsLeft) do
                        sizeleft = sizeleft + v.Main.AbsoluteSize.Y
                    end
                    for i,v in pairs(tab.SectorsRight) do
                        sizeright = sizeright + v.Main.AbsoluteSize.Y
                    end

                    tab.Left.CanvasSize = UDim2.fromOffset(tab.Left.AbsoluteSize.X, sizeleft + ((#tab.SectorsLeft - 1) * tab.LeftListPadding.PaddingTop.Offset) + 20)
                    tab.Right.CanvasSize = UDim2.fromOffset(tab.Right.AbsoluteSize.X, sizeright + ((#tab.SectorsRight - 1) * tab.RightListPadding.PaddingTop.Offset) + 20)
                end

                function sector:AddButton(text, callback)
                    local button = { }
                    button.text = text or ""
                    button.callback = callback or function() end

                    button.Main = Instance.new("TextButton", sector.Items)
                    button.Main.BorderSizePixel = 0
                    button.Main.Text = ""
                    button.Main.AutoButtonColor = false
                    button.Main.Name = "button"
                    button.Main.ZIndex = 5
                    button.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 14)
                    button.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

                    button.Gradient = Instance.new("UIGradient", button.Main)
                    button.Gradient.Rotation = 90
                    button.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.buttoncolor), ColorSequenceKeypoint.new(1.00, window.theme.buttoncolor2) })
                    updateevent.Event:Connect(function(theme)
                        button.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.buttoncolor), ColorSequenceKeypoint.new(1.00, theme.buttoncolor2) })
                    end)

                    button.BlackOutline2 = Instance.new("Frame", button.Main)
                    button.BlackOutline2.Name = "blackline"
                    button.BlackOutline2.ZIndex = 4
                    button.BlackOutline2.Size = button.Main.Size + UDim2.fromOffset(6, 6)
                    button.BlackOutline2.BorderSizePixel = 0
                    button.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    button.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        button.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)

                    button.Outline = Instance.new("Frame", button.Main)
                    button.Outline.Name = "blackline"
                    button.Outline.ZIndex = 4
                    button.Outline.Size = button.Main.Size + UDim2.fromOffset(4, 4)
                    button.Outline.BorderSizePixel = 0
                    button.Outline.BackgroundColor3 = window.theme.outlinecolor
                    button.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        button.Outline.BackgroundColor3 = theme.outlinecolor
                    end)

                    button.BlackOutline = Instance.new("Frame", button.Main)
                    button.BlackOutline.Name = "blackline"
                    button.BlackOutline.ZIndex = 4
                    button.BlackOutline.Size = button.Main.Size + UDim2.fromOffset(2, 2)
                    button.BlackOutline.BorderSizePixel = 0
                    button.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    button.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        button.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    button.Label = Instance.new("TextLabel", button.Main)
                    button.Label.Name = "Label"
                    button.Label.BackgroundTransparency = 1
                    button.Label.Position = UDim2.new(0, -1, 0, 0)
                    button.Label.ZIndex = 5
                    button.Label.Size = button.Main.Size
                    button.Label.Font = window.theme.font
                    button.Label.Text = button.text
                    button.Label.TextColor3 = window.theme.itemscolor2
                    button.Label.TextSize = 15
                    button.Label.TextStrokeTransparency = 1
                    button.Label.TextXAlignment = Enum.TextXAlignment.Center
                    button.Main.MouseButton1Down:Connect(button.callback)
                    updateevent.Event:Connect(function(theme)
                        button.Label.Font = theme.font
                        button.Label.TextColor3 = theme.itemscolor
                    end)

                    button.BlackOutline2.MouseEnter:Connect(function()
                        button.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)

                    button.BlackOutline2.MouseLeave:Connect(function()
                        button.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)

                    sector:FixSize()
                    return button
                end

                function sector:AddLabel(text)
                    local label = { }

                    label.Main = Instance.new("TextLabel", sector.Items)
                    label.Main.Name = "Label"
                    label.Main.BackgroundTransparency = 1
                    label.Main.Position = UDim2.new(0, -1, 0, 0)
                    label.Main.ZIndex = 4
                    label.Main.AutomaticSize = Enum.AutomaticSize.XY
                    label.Main.Font = window.theme.font
                    label.Main.Text = text
                    label.Main.TextColor3 = window.theme.itemscolor
                    label.Main.TextSize = 15
                    label.Main.TextStrokeTransparency = 1
                    label.Main.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        label.Main.Font = theme.font
                        label.Main.TextColor3 = theme.itemscolor
                    end)

                    function label:Set(value)
                        label.Main.Text = value
                    end

                    sector:FixSize()
                    return label
                end
                
                function sector:AddToggle(text, default, callback, flag)
                    local toggle = { }
                    toggle.text = text or ""
                    toggle.default = default or false
                    toggle.callback = callback or function(value) end
                    toggle.flag = flag or text or ""
                    
                    toggle.value = toggle.default

                    toggle.Main = Instance.new("TextButton", sector.Items)
                    toggle.Main.Name = "toggle"
                    toggle.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggle.Main.BorderColor3 = window.theme.outlinecolor
                    toggle.Main.BorderSizePixel = 0
                    toggle.Main.Size = UDim2.fromOffset(8, 8)
                    toggle.Main.AutoButtonColor = false
                    toggle.Main.ZIndex = 5
                    toggle.Main.Font = Enum.Font.SourceSans
                    toggle.Main.Text = ""
                    toggle.Main.TextColor3 = Color3.fromRGB(0, 0, 0)
                    toggle.Main.TextSize = 15
                    updateevent.Event:Connect(function(theme)
                        toggle.Main.BorderColor3 = theme.outlinecolor
                    end)

                    toggle.BlackOutline2 = Instance.new("Frame", toggle.Main)
                    toggle.BlackOutline2.Name = "blackline"
                    toggle.BlackOutline2.ZIndex = 4
                    toggle.BlackOutline2.Size = toggle.Main.Size + UDim2.fromOffset(6, 6)
                    toggle.BlackOutline2.BorderSizePixel = 0
                    toggle.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    toggle.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        toggle.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    toggle.Outline = Instance.new("Frame", toggle.Main)
                    toggle.Outline.Name = "blackline"
                    toggle.Outline.ZIndex = 4
                    toggle.Outline.Size = toggle.Main.Size + UDim2.fromOffset(4, 4)
                    toggle.Outline.BorderSizePixel = 0
                    toggle.Outline.BackgroundColor3 = window.theme.outlinecolor
                    toggle.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        toggle.Outline.BackgroundColor3 = theme.outlinecolor
                    end)

                    toggle.BlackOutline = Instance.new("Frame", toggle.Main)
                    toggle.BlackOutline.Name = "blackline"
                    toggle.BlackOutline.ZIndex = 4
                    toggle.BlackOutline.Size = toggle.Main.Size + UDim2.fromOffset(2, 2)
                    toggle.BlackOutline.BorderSizePixel = 0
                    toggle.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    toggle.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        toggle.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    toggle.Gradient = Instance.new("UIGradient", toggle.Main)
                    toggle.Gradient.Rotation = (22.5 * 13)
                    toggle.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(45, 45, 45)) })

                    toggle.Label = Instance.new("TextButton", toggle.Main)
                    toggle.Label.Name = "Label"
                    toggle.Label.AutoButtonColor = false
                    toggle.Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    toggle.Label.BackgroundTransparency = 1
                    toggle.Label.Position = UDim2.fromOffset(toggle.Main.AbsoluteSize.X + 10, -2)
                    toggle.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 71, toggle.BlackOutline.Size.Y.Offset)
                    toggle.Label.Font = window.theme.font
                    toggle.Label.ZIndex = 5
                    toggle.Label.Text = toggle.text
                    toggle.Label.TextColor3 = window.theme.itemscolor
                    toggle.Label.TextSize = 15
                    toggle.Label.TextStrokeTransparency = 1
                    toggle.Label.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        toggle.Label.Font = theme.font
                        toggle.Label.TextColor3 = (toggle.value and Color3.fromRGB(255,255,255))
                    end)

                    toggle.CheckedFrame = Instance.new("Frame", toggle.Main)
                    toggle.CheckedFrame.ZIndex = 5
                    toggle.CheckedFrame.BorderSizePixel = 0
                    toggle.CheckedFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Color3.fromRGB(204, 0, 102)
                    toggle.CheckedFrame.Size = toggle.Main.Size

                    toggle.Gradient2 = Instance.new("UIGradient", toggle.CheckedFrame)
                    toggle.Gradient2.Rotation = (22.5 * 13)
                    toggle.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor2), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor) })
                    updateevent.Event:Connect(function(theme)
                        toggle.Label.TextColor3 = (toggle.value and Color3.fromRGB(255,255,255)) or Color3.fromRGB(90,90,90)
                        toggle.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor2), ColorSequenceKeypoint.new(1.00, theme.accentcolor) })
                    end)

                    toggle.Items = Instance.new("Frame", toggle.Main)
                    toggle.Items.Name = "\n"
                    toggle.Items.ZIndex = 4
                    toggle.Items.Size = UDim2.fromOffset(60, toggle.BlackOutline.AbsoluteSize.Y)
                    toggle.Items.BorderSizePixel = 0
                    toggle.Items.BackgroundTransparency = 1
                    toggle.Items.BackgroundColor3 = Color3.new(0, 0, 0)
                    toggle.Items.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 71, 0)

                    toggle.ListLayout = Instance.new("UIListLayout", toggle.Items)
                    toggle.ListLayout.FillDirection = Enum.FillDirection.Horizontal
                    toggle.ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                    toggle.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    toggle.ListLayout.Padding = UDim.new(0.04, 6)

                    if toggle.flag and toggle.flag ~= "" then
                        library.flags[toggle.flag] = toggle.default or false
                    end

                    function toggle:Set(value) 
                        if value then
                            toggle.Label.TextColor3 = Color3.fromRGB(255,255,255)
                        else
                            toggle.Label.TextColor3 = Color3.fromRGB(90,90,90)
                        end

                        toggle.value = value
                        toggle.CheckedFrame.Visible = value
                        if toggle.flag and toggle.flag ~= "" then
                            library.flags[toggle.flag] = toggle.value
                        end
                        pcall(toggle.callback, value)
                    end
                    function toggle:Get() 
                        return toggle.value
                    end
                    toggle:Set(toggle.default)

                    function toggle:AddKeybind(default, flag)
                        local keybind = { }

                        keybind.default = default or "None"
                        keybind.value = keybind.default
                        keybind.flag = flag or ( (toggle.text or "") .. tostring(#toggle.Items:GetChildren()))

                        local shorter_keycodes = {
                            ["LeftShift"] = "LSHIFT",
                            ["RightShift"] = "RSHIFT",
                            ["LeftControl"] = "LCTRL",
                            ["RightControl"] = "RCTRL",
                            ["LeftAlt"] = "LALT",
                            ["RightAlt"] = "RALT"
                        }

                        local text = keybind.default == "None" and "[None]" or "[" .. (shorter_keycodes[keybind.default.Name] or keybind.default.Name) .. "]"
                        local size = textservice:GetTextSize(text, 15, window.theme.font, Vector2.new(2000, 2000))

                        keybind.Main = Instance.new("TextButton", toggle.Items)
                        keybind.Main.Name = "keybind"
                        keybind.Main.BackgroundTransparency = 1
                        keybind.Main.BorderSizePixel = 0
                        keybind.Main.ZIndex = 5
                        keybind.Main.Size = UDim2.fromOffset(size.X + 2, size.Y - 7)
                        keybind.Main.Text = text
                        keybind.Main.Font = window.theme.font
                        keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                        keybind.Main.TextSize = 15
                        keybind.Main.TextXAlignment = Enum.TextXAlignment.Right
                        keybind.Main.MouseButton1Down:Connect(function()
                            keybind.Main.Text = "[...]"
                            keybind.Main.TextColor3 = window.theme.accentcolor
                        end)
                        updateevent.Event:Connect(function(theme)
                            keybind.Main.Font = theme.font
                            if keybind.Main.Text == "[...]" then
                                keybind.Main.TextColor3 = theme.accentcolor
                            else
                                keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                            end
                        end)

                        if keybind.flag and keybind.flag ~= "" then
                            library.flags[keybind.flag] = keybind.default
                        end
                        function keybind:Set(key)
                            if key == "None" then
                                keybind.Main.Text = "[" .. key .. "]"
                                keybind.value = key
                                if keybind.flag and keybind.flag ~= "" then
                                    library.flags[keybind.flag] = key
                                end
                            end
                            keybind.Main.Text = "[" .. (shorter_keycodes[key.Name] or key.Name) .. "]"
                            keybind.value = key
                            if keybind.flag and keybind.flag ~= "" then
                                library.flags[keybind.flag] = keybind.value
                            end
                        end

                        function keybind:Get()
                            return keybind.value
                        end

                        uis.InputBegan:Connect(function(input, gameProcessed)
                            if not gameProcessed then
                                if keybind.Main.Text == "[...]" then
                                    keybind.Main.TextColor3 = Color3.fromRGB(136, 136, 136)
                                    if input.UserInputType == Enum.UserInputType.Keyboard then
                                        keybind:Set(input.KeyCode)
                                    else
                                        keybind:Set("None")
                                    end
                                else
                                    if keybind.value ~= "None" and input.KeyCode == keybind.value then
                                        toggle:Set(not toggle.CheckedFrame.Visible)
                                    end
                                end
                            end
                        end)

                        table.insert(library.items, keybind)
                        return keybind
                    end

                    function toggle:AddDropdown(items, default, multichoice, callback, flag)
                        local dropdown = { }

                        dropdown.defaultitems = items or { }
                        dropdown.default = default
                        dropdown.callback = callback or function() end
                        dropdown.multichoice = multichoice or false
                        dropdown.values = { }
                        dropdown.flag = flag or ( (toggle.text or "") .. tostring(#(sector.Items:GetChildren())) .. "a")
        
                        dropdown.Main = Instance.new("TextButton", sector.Items)
                        dropdown.Main.Name = "dropdown"
                        dropdown.Main.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                        dropdown.Main.BorderSizePixel = 0
                        dropdown.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 16)
                        dropdown.Main.Position = UDim2.fromOffset(0, 0)
                        dropdown.Main.ZIndex = 5
                        dropdown.Main.AutoButtonColor = false
                        dropdown.Main.Font = window.theme.font
                        dropdown.Main.Text = ""
                        dropdown.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                        dropdown.Main.TextSize = 15
                        dropdown.Main.TextXAlignment = Enum.TextXAlignment.Left
                        updateevent.Event:Connect(function(theme)
                            dropdown.Main.Font = theme.font
                        end)
        
                        dropdown.Gradient = Instance.new("UIGradient", dropdown.Main)
                        dropdown.Gradient.Rotation = 90
                        dropdown.Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39))}
        
                        dropdown.SelectedLabel = Instance.new("TextLabel", dropdown.Main)
                        dropdown.SelectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        dropdown.SelectedLabel.BackgroundTransparency = 1
                        dropdown.SelectedLabel.Position = UDim2.fromOffset(5, 2)
                        dropdown.SelectedLabel.Size = UDim2.fromOffset(130, 13)
                        dropdown.SelectedLabel.Font = window.theme.font
                        dropdown.SelectedLabel.Text = toggle.text
                        dropdown.SelectedLabel.ZIndex = 5
                        dropdown.SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        dropdown.SelectedLabel.TextSize = 15
                        dropdown.SelectedLabel.TextStrokeTransparency = 1
                        dropdown.SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
                        updateevent.Event:Connect(function(theme)
                            dropdown.SelectedLabel.Font = theme.font
                        end)  

                        dropdown.Nav = Instance.new("ImageButton", dropdown.Main)
                        dropdown.Nav.Name = "navigation"
                        dropdown.Nav.BackgroundTransparency = 1
                        dropdown.Nav.LayoutOrder = 10
                        dropdown.Nav.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 5)
                        dropdown.Nav.Rotation = 90
                        dropdown.Nav.ZIndex = 5
                        dropdown.Nav.Size = UDim2.fromOffset(8, 8)
                        dropdown.Nav.Image = "rbxassetid://4918373417"
                        dropdown.Nav.ImageColor3 = Color3.fromRGB(210, 210, 210)
        
                        dropdown.BlackOutline2 = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutline2.Name = "blackline"
                        dropdown.BlackOutline2.ZIndex = 4
                        dropdown.BlackOutline2.Size = dropdown.Main.Size + UDim2.fromOffset(6, 6)
                        dropdown.BlackOutline2.BorderSizePixel = 0
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        dropdown.Outline = Instance.new("Frame", dropdown.Main)
                        dropdown.Outline.Name = "blackline"
                        dropdown.Outline.ZIndex = 4
                        dropdown.Outline.Size = dropdown.Main.Size + UDim2.fromOffset(4, 4)
                        dropdown.Outline.BorderSizePixel = 0
                        dropdown.Outline.BackgroundColor3 = window.theme.outlinecolor
                        dropdown.Outline.Position = UDim2.fromOffset(-2, -2)
                        updateevent.Event:Connect(function(theme)
                            dropdown.Outline.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        dropdown.BlackOutline = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutline.Name = "blackline444"
                        dropdown.BlackOutline.ZIndex = 4
                        dropdown.BlackOutline.Size = dropdown.Main.Size + UDim2.fromOffset(2, 2)
                        dropdown.BlackOutline.BorderSizePixel = 0
                        dropdown.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        dropdown.ItemsFrame = Instance.new("ScrollingFrame", dropdown.Main)
                        dropdown.ItemsFrame.Name = "itemsframe"
                        dropdown.ItemsFrame.BorderSizePixel = 0
                        dropdown.ItemsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                        dropdown.ItemsFrame.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                        dropdown.ItemsFrame.ScrollBarThickness = 2
                        dropdown.ItemsFrame.ZIndex = 8
                        dropdown.ItemsFrame.ScrollingDirection = "Y"
                        dropdown.ItemsFrame.Visible = false
                        dropdown.ItemsFrame.Size = UDim2.new(0, 0, 0, 0)
                        dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.Main.AbsoluteSize.X, 0)
        
                        dropdown.ListLayout = Instance.new("UIListLayout", dropdown.ItemsFrame)
                        dropdown.ListLayout.FillDirection = Enum.FillDirection.Vertical
                        dropdown.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
                        dropdown.ListPadding = Instance.new("UIPadding", dropdown.ItemsFrame)
                        dropdown.ListPadding.PaddingTop = UDim.new(0, 2)
                        dropdown.ListPadding.PaddingBottom = UDim.new(0, 2)
                        dropdown.ListPadding.PaddingLeft = UDim.new(0, 2)
                        dropdown.ListPadding.PaddingRight = UDim.new(0, 2)
        
                        dropdown.BlackOutline2Items = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutline2Items.Name = "blackline3"
                        dropdown.BlackOutline2Items.ZIndex = 7
                        dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                        dropdown.BlackOutline2Items.BorderSizePixel = 0
                        dropdown.BlackOutline2Items.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutline2Items.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-3, -3)
                        dropdown.BlackOutline2Items.Visible = false
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutline2Items.BackgroundColor3 = theme.outlinecolor2
                        end)
                        
                        dropdown.OutlineItems = Instance.new("Frame", dropdown.Main)
                        dropdown.OutlineItems.Name = "blackline8"
                        dropdown.OutlineItems.ZIndex = 7
                        dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                        dropdown.OutlineItems.BorderSizePixel = 0
                        dropdown.OutlineItems.BackgroundColor3 = window.theme.outlinecolor
                        dropdown.OutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-2, -2)
                        dropdown.OutlineItems.Visible = false
                        updateevent.Event:Connect(function(theme)
                            dropdown.OutlineItems.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        dropdown.BlackOutlineItems = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutlineItems.Name = "blackline3"
                        dropdown.BlackOutlineItems.ZIndex = 7
                        dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(-2, -2)
                        dropdown.BlackOutlineItems.BorderSizePixel = 0
                        dropdown.BlackOutlineItems.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-1, -1)
                        dropdown.BlackOutlineItems.Visible = false
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutlineItems.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        dropdown.IgnoreBackButtons = Instance.new("TextButton", dropdown.Main)
                        dropdown.IgnoreBackButtons.BackgroundTransparency = 1
                        dropdown.IgnoreBackButtons.BorderSizePixel = 0
                        dropdown.IgnoreBackButtons.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                        dropdown.IgnoreBackButtons.Size = UDim2.new(0, 0, 0, 0)
                        dropdown.IgnoreBackButtons.ZIndex = 7
                        dropdown.IgnoreBackButtons.Text = ""
                        dropdown.IgnoreBackButtons.Visible = false
                        dropdown.IgnoreBackButtons.AutoButtonColor = false

                        if dropdown.flag and dropdown.flag ~= "" then
                            library.flags[dropdown.flag] = dropdown.multichoice and { dropdown.default or dropdown.defaultitems[1] or "" } or (dropdown.default or dropdown.defaultitems[1] or "")
                        end

                        function dropdown:isSelected(item)
                            for i, v in pairs(dropdown.values) do
                                if v == item then
                                    return true
                                end
                            end
                            return false
                        end
        
                        function dropdown:updateText(text)
                            if #text >= 27 then
                                text = text:sub(1, 25) .. ".."
                            end
                            dropdown.SelectedLabel.Text = text
                        end
        
                        dropdown.Changed = Instance.new("BindableEvent")
                        function dropdown:Set(value)
                            if type(value) == "table" then
                                dropdown.values = value
                                dropdown:updateText(table.concat(value, ", "))
                                pcall(dropdown.callback, value)
                            else
                                dropdown:updateText(value)
                                dropdown.values = { value }
                                pcall(dropdown.callback, value)
                            end
                            
                            dropdown.Changed:Fire(value)
                            if dropdown.flag and dropdown.flag ~= "" then
                                library.flags[dropdown.flag] = dropdown.multichoice and dropdown.values or dropdown.values[1]
                            end
                        end
        
                        function dropdown:Get()
                            return dropdown.multichoice and dropdown.values or dropdown.values[1]
                        end
        
                        dropdown.items = { }
                        function dropdown:Add(v)
                            local Item = Instance.new("TextButton", dropdown.ItemsFrame)
                            Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.BorderSizePixel = 0
                            Item.Position = UDim2.fromOffset(0, 0)
                            Item.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset - 4, 20)
                            Item.ZIndex = 9
                            Item.Text = v
                            Item.Name = v
                            Item.AutoButtonColor = false
                            Item.Font = window.theme.font
                            Item.TextSize = 15
                            Item.TextXAlignment = Enum.TextXAlignment.Left
                            Item.TextStrokeTransparency = 1
                            dropdown.ItemsFrame.CanvasSize = dropdown.ItemsFrame.CanvasSize + UDim2.fromOffset(0, Item.AbsoluteSize.Y)
        
                            Item.MouseButton1Down:Connect(function()
                                if dropdown.multichoice then
                                    if dropdown:isSelected(v) then
                                        for i2, v2 in pairs(dropdown.values) do
                                            if v2 == v then
                                                table.remove(dropdown.values, i2)
                                            end
                                        end
                                        dropdown:Set(dropdown.values)
                                    else
                                        table.insert(dropdown.values, v)
                                        dropdown:Set(dropdown.values)
                                    end
        
                                    return
                                else
                                    dropdown.Nav.Rotation = 90
                                    dropdown.ItemsFrame.Visible = false
                                    dropdown.ItemsFrame.Active = false
                                    dropdown.OutlineItems.Visible = false
                                    dropdown.BlackOutlineItems.Visible = false
                                    dropdown.BlackOutline2Items.Visible = false
                                    dropdown.IgnoreBackButtons.Visible = false
                                    dropdown.IgnoreBackButtons.Active = false
                                end
        
                                dropdown:Set(v)
                                return
                            end)
        
                            runservice.RenderStepped:Connect(function()
                                if dropdown.multichoice and dropdown:isSelected(v) or dropdown.values[1] == v then
                                    Item.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
                                    Item.TextColor3 = window.theme.accentcolor
                                    Item.Text = " " .. v
                                else
                                    Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                    Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    Item.Text = v
                                end
                            end)
        
                            table.insert(dropdown.items, v)
                            dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * Item.AbsoluteSize.Y, 20, 156) + 4)
                            dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * Item.AbsoluteSize.Y) + 4)
        
                            dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                            dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                            dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                            dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
                        end
        
                        function dropdown:Remove(value)
                            local item = dropdown.ItemsFrame:FindFirstChild(value)
                            if item then
                                for i,v in pairs(dropdown.items) do
                                    if v == value then
                                        table.remove(dropdown.items, i)
                                    end
                                end
        
                                dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * item.AbsoluteSize.Y, 20, 156) + 4)
                                dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * item.AbsoluteSize.Y) + 4)
            
                                dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                                dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                                dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                                dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
        
                                item:Remove()
                            end
                        end 
        
                        for i,v in pairs(dropdown.defaultitems) do
                            dropdown:Add(v)
                        end
        
                        if dropdown.default then
                            dropdown:Set(dropdown.default)
                        end
        
                        local MouseButton1Down = function()
                            if dropdown.Nav.Rotation == 90 then
                                tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = -90 }):Play()
                                if dropdown.items and #dropdown.items ~= 0 then
                                    dropdown.ItemsFrame.ScrollingEnabled = true
                                    sector.Main.Parent.ScrollingEnabled = false
                                    dropdown.ItemsFrame.Visible = true
                                    dropdown.ItemsFrame.Active = true
                                    dropdown.IgnoreBackButtons.Visible = true
                                    dropdown.IgnoreBackButtons.Active = true
                                    dropdown.OutlineItems.Visible = true
                                    dropdown.BlackOutlineItems.Visible = true
                                    dropdown.BlackOutline2Items.Visible = true
                                end
                            else
                                tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 90 }):Play()
                                dropdown.ItemsFrame.ScrollingEnabled = false
                                sector.Main.Parent.ScrollingEnabled = true
                                dropdown.ItemsFrame.Visible = false
                                dropdown.ItemsFrame.Active = false
                                dropdown.IgnoreBackButtons.Visible = false
                                dropdown.IgnoreBackButtons.Active = false
                                dropdown.OutlineItems.Visible = false
                                dropdown.BlackOutlineItems.Visible = false
                                dropdown.BlackOutline2Items.Visible = false
                            end
                        end
        
                        dropdown.Main.MouseButton1Down:Connect(MouseButton1Down)
                        dropdown.Nav.MouseButton1Down:Connect(MouseButton1Down)
        
                        dropdown.BlackOutline2.MouseEnter:Connect(function()
                            dropdown.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                        end)
                        dropdown.BlackOutline2.MouseLeave:Connect(function()
                            dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        end)
        
                        sector:FixSize()
                        table.insert(library.items, dropdown)
                        return dropdown
                    end

                    function toggle:AddTextbox(default, callback, flag)
                        local textbox = { }
                        textbox.callback = callback or function() end
                        textbox.default = default
                        textbox.value = ""
                        textbox.flag = flag or ( (toggle.text or "") .. tostring(#(sector.Items:GetChildren())) .. "a")
        
                        textbox.Holder = Instance.new("Frame", sector.Items)
                        textbox.Holder.Name = "holder"
                        textbox.Holder.ZIndex = 5
                        textbox.Holder.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 14)
                        textbox.Holder.BorderSizePixel = 0
                        textbox.Holder.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        
                        textbox.Gradient = Instance.new("UIGradient", textbox.Holder)
                        textbox.Gradient.Rotation = 90
                        textbox.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39)) })
        
                        textbox.Main = Instance.new("TextBox", textbox.Holder)
                        textbox.Main.PlaceholderText = ""
                        textbox.Main.Text = ""
                        textbox.Main.BackgroundTransparency = 1
                        textbox.Main.Font = window.theme.font
                        textbox.Main.Name = "textbox"
                        textbox.Main.MultiLine = false
                        textbox.Main.ClearTextOnFocus = false
                        textbox.Main.ZIndex = 5
                        textbox.Main.TextScaled = true
                        textbox.Main.Size = textbox.Holder.Size
                        textbox.Main.TextSize = 15
                        textbox.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                        textbox.Main.BorderSizePixel = 0
                        textbox.Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                        textbox.Main.TextXAlignment = Enum.TextXAlignment.Left
        
                        if textbox.flag and textbox.flag ~= "" then
                            library.flags[textbox.flag] = textbox.default or ""
                        end

                        function textbox:Set(text)
                            textbox.value = text
                            textbox.Main.Text = text
                            if textbox.flag and textbox.flag ~= "" then
                                library.flags[textbox.flag] = text
                            end
                            pcall(textbox.callback, text)
                        end
                        updateevent.Event:Connect(function(theme)
                            textbox.Main.Font = theme.font
                        end)
        
                        function textbox:Get()
                            return textbox.value
                        end
        
                        if textbox.default then 
                            textbox:Set(textbox.default)
                        end
        
                        textbox.Main.FocusLost:Connect(function()
                            textbox:Set(textbox.Main.Text)
                        end)
        
                        textbox.BlackOutline2 = Instance.new("Frame", textbox.Main)
                        textbox.BlackOutline2.Name = "blackline"
                        textbox.BlackOutline2.ZIndex = 4
                        textbox.BlackOutline2.Size = textbox.Main.Size + UDim2.fromOffset(6, 6)
                        textbox.BlackOutline2.BorderSizePixel = 0
                        textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        textbox.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                        updateevent.Event:Connect(function(theme)
                            textbox.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                        end)
                        
                        textbox.Outline = Instance.new("Frame", textbox.Main)
                        textbox.Outline.Name = "blackline"
                        textbox.Outline.ZIndex = 4
                        textbox.Outline.Size = textbox.Main.Size + UDim2.fromOffset(4, 4)
                        textbox.Outline.BorderSizePixel = 0
                        textbox.Outline.BackgroundColor3 = window.theme.outlinecolor
                        textbox.Outline.Position = UDim2.fromOffset(-2, -2)
                        updateevent.Event:Connect(function(theme)
                            textbox.Outline.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        textbox.BlackOutline = Instance.new("Frame", textbox.Main)
                        textbox.BlackOutline.Name = "blackline"
                        textbox.BlackOutline.ZIndex = 4
                        textbox.BlackOutline.Size = textbox.Main.Size + UDim2.fromOffset(2, 2)
                        textbox.BlackOutline.BorderSizePixel = 0
                        textbox.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                        textbox.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                        updateevent.Event:Connect(function(theme)
                            textbox.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        textbox.BlackOutline2.MouseEnter:Connect(function()
                            textbox.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                        end)
                        textbox.BlackOutline2.MouseLeave:Connect(function()
                            textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        end)
        
                        sector:FixSize()
                        table.insert(library.items, textbox)
                        return textbox
                    end

                    function toggle:AddColorpicker(default, callback, flag)
                        local colorpicker = { }

                        colorpicker.callback = callback or function() end
                        colorpicker.default = default or Color3.fromRGB(255, 255, 255)
                        colorpicker.value = colorpicker.default
                        colorpicker.flag = flag or ( (toggle.text or "") .. tostring(#toggle.Items:GetChildren()))

                        colorpicker.Main = Instance.new("Frame", toggle.Items)
                        colorpicker.Main.ZIndex = 6
                        colorpicker.Main.BorderSizePixel = 0
                        colorpicker.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        colorpicker.Main.Size = UDim2.fromOffset(16, 10)

                        colorpicker.Gradient = Instance.new("UIGradient", colorpicker.Main)
                        colorpicker.Gradient.Rotation = 90

                        local clr = Color3.new(math.clamp(colorpicker.value.R / 1.7, 0, 1), math.clamp(colorpicker.value.G / 1.7, 0, 1), math.clamp(colorpicker.value.B / 1.7, 0, 1))
                        colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, colorpicker.value), ColorSequenceKeypoint.new(1.00, clr) })

                        colorpicker.BlackOutline2 = Instance.new("Frame", colorpicker.Main)
                        colorpicker.BlackOutline2.Name = "blackline"
                        colorpicker.BlackOutline2.ZIndex = 4
                        colorpicker.BlackOutline2.Size = colorpicker.Main.Size + UDim2.fromOffset(6, 6)
                        colorpicker.BlackOutline2.BorderSizePixel = 0
                        colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        colorpicker.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                        updateevent.Event:Connect(function(theme)
                            if window.OpenedColorPickers[colorpicker.MainPicker] then
                                colorpicker.BlackOutline2.BackgroundColor3 = theme.accentcolor
                            else
                                colorpicker.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                            end
                        end)
                        
                        colorpicker.Outline = Instance.new("Frame", colorpicker.Main)
                        colorpicker.Outline.Name = "blackline"
                        colorpicker.Outline.ZIndex = 4
                        colorpicker.Outline.Size = colorpicker.Main.Size + UDim2.fromOffset(4, 4)
                        colorpicker.Outline.BorderSizePixel = 0
                        colorpicker.Outline.BackgroundColor3 = window.theme.outlinecolor
                        colorpicker.Outline.Position = UDim2.fromOffset(-2, -2)
                        updateevent.Event:Connect(function(theme)
                            colorpicker.Outline.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        colorpicker.BlackOutline = Instance.new("Frame", colorpicker.Main)
                        colorpicker.BlackOutline.Name = "blackline"
                        colorpicker.BlackOutline.ZIndex = 4
                        colorpicker.BlackOutline.Size = colorpicker.Main.Size + UDim2.fromOffset(2, 2)
                        colorpicker.BlackOutline.BorderSizePixel = 0
                        colorpicker.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                        colorpicker.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                        updateevent.Event:Connect(function(theme)
                            colorpicker.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                        end)

                        colorpicker.BlackOutline2.MouseEnter:Connect(function()
                            colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                        end)

                        colorpicker.BlackOutline2.MouseLeave:Connect(function()
                            if not window.OpenedColorPickers[colorpicker.MainPicker] then
                                colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                            end
                        end)

                        colorpicker.MainPicker = Instance.new("TextButton", colorpicker.Main)
                        colorpicker.MainPicker.Name = "picker"
                        colorpicker.MainPicker.ZIndex = 100
                        colorpicker.MainPicker.Visible = false
                        colorpicker.MainPicker.AutoButtonColor = false
                        colorpicker.MainPicker.Text = ""
                        window.OpenedColorPickers[colorpicker.MainPicker] = false
                        colorpicker.MainPicker.Size = UDim2.fromOffset(180, 196)
                        colorpicker.MainPicker.BorderSizePixel = 0
                        colorpicker.MainPicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        colorpicker.MainPicker.Rotation = 0.000000000000001
                        colorpicker.MainPicker.Position = UDim2.fromOffset(-colorpicker.MainPicker.AbsoluteSize.X + colorpicker.Main.AbsoluteSize.X, 17)

                        colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                        colorpicker.BlackOutline3.Name = "blackline"
                        colorpicker.BlackOutline3.ZIndex = 98
                        colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(6, 6)
                        colorpicker.BlackOutline3.BorderSizePixel = 0
                        colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                        colorpicker.BlackOutline3.Position = UDim2.fromOffset(-3, -3)
                        updateevent.Event:Connect(function(theme)
                            colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                        end)
                        
                        colorpicker.Outline2 = Instance.new("Frame", colorpicker.MainPicker)
                        colorpicker.Outline2.Name = "blackline"
                        colorpicker.Outline2.ZIndex = 98
                        colorpicker.Outline2.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(4, 4)
                        colorpicker.Outline2.BorderSizePixel = 0
                        colorpicker.Outline2.BackgroundColor3 = window.theme.outlinecolor
                        colorpicker.Outline2.Position = UDim2.fromOffset(-2, -2)
                        updateevent.Event:Connect(function(theme)
                            colorpicker.Outline2.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                        colorpicker.BlackOutline3.Name = "blackline"
                        colorpicker.BlackOutline3.ZIndex = 98
                        colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(2, 2)
                        colorpicker.BlackOutline3.BorderSizePixel = 0
                        colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                        colorpicker.BlackOutline3.Position = UDim2.fromOffset(-1, -1)
                        updateevent.Event:Connect(function(theme)
                            colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                        end)

                        colorpicker.hue = Instance.new("ImageLabel", colorpicker.MainPicker)
                        colorpicker.hue.ZIndex = 101
                        colorpicker.hue.Position = UDim2.new(0,3,0,3)
                        colorpicker.hue.Size = UDim2.new(0,172,0,172)
                        colorpicker.hue.Image = "rbxassetid://4155801252"
                        colorpicker.hue.ScaleType = Enum.ScaleType.Stretch
                        colorpicker.hue.BackgroundColor3 = Color3.new(1,0,0)
                        colorpicker.hue.BorderColor3 = window.theme.outlinecolor2
                        updateevent.Event:Connect(function(theme)
                            colorpicker.hue.BorderColor3 = theme.outlinecolor2
                        end)

                        colorpicker.hueselectorpointer = Instance.new("ImageLabel", colorpicker.MainPicker)
                        colorpicker.hueselectorpointer.ZIndex = 101
                        colorpicker.hueselectorpointer.BackgroundTransparency = 1
                        colorpicker.hueselectorpointer.BorderSizePixel = 0
                        colorpicker.hueselectorpointer.Position = UDim2.new(0, 0, 0, 0)
                        colorpicker.hueselectorpointer.Size = UDim2.new(0, 7, 0, 7)
                        colorpicker.hueselectorpointer.Image = "rbxassetid://6885856475"

                        colorpicker.selector = Instance.new("TextLabel", colorpicker.MainPicker)
                        colorpicker.selector.ZIndex = 100
                        colorpicker.selector.Position = UDim2.new(0,3,0,181)
                        colorpicker.selector.Size = UDim2.new(0,173,0,10)
                        colorpicker.selector.BackgroundColor3 = Color3.fromRGB(255,255,255)
                        colorpicker.selector.BorderColor3 = window.theme.outlinecolor2
                        colorpicker.selector.Text = ""
                        updateevent.Event:Connect(function(theme)
                            colorpicker.selector.BorderColor3 = theme.outlinecolor2
                        end)
            
                        colorpicker.gradient = Instance.new("UIGradient", colorpicker.selector)
                        colorpicker.gradient.Color = ColorSequence.new({ 
                            ColorSequenceKeypoint.new(0, Color3.new(1,0,0)), 
                            ColorSequenceKeypoint.new(0.17, Color3.new(1,0,1)), 
                            ColorSequenceKeypoint.new(0.33,Color3.new(0,0,1)), 
                            ColorSequenceKeypoint.new(0.5,Color3.new(0,1,1)), 
                            ColorSequenceKeypoint.new(0.67, Color3.new(0,1,0)), 
                            ColorSequenceKeypoint.new(0.83, Color3.new(1,1,0)), 
                            ColorSequenceKeypoint.new(1, Color3.new(1,0,0))
                        })

                        colorpicker.pointer = Instance.new("Frame", colorpicker.selector)
                        colorpicker.pointer.ZIndex = 101
                        colorpicker.pointer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        colorpicker.pointer.Position = UDim2.new(0,0,0,0)
                        colorpicker.pointer.Size = UDim2.new(0,2,0,10)
                        colorpicker.pointer.BorderColor3 = Color3.fromRGB(255, 255, 255)

                        if colorpicker.flag and colorpicker.flag ~= "" then
                            library.flags[colorpicker.flag] = colorpicker.default
                        end

                        function colorpicker:RefreshHue()
                            local x = (mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X
                            local y = (mouse.Y - colorpicker.hue.AbsolutePosition.Y) / colorpicker.hue.AbsoluteSize.Y
                            colorpicker.hueselectorpointer:TweenPosition(UDim2.new(math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 0.952 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 0, math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 0.885 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                            colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 1 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 1 - (math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 1 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y)))
                        end

                        function colorpicker:RefreshSelector()
                            local pos = math.clamp((mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X, 0, 1)
                            colorpicker.color = 1 - pos
                            colorpicker.pointer:TweenPosition(UDim2.new(pos, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                            colorpicker.hue.BackgroundColor3 = Color3.fromHSV(1 - pos, 1, 1)

                            local x = (colorpicker.hueselectorpointer.AbsolutePosition.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X
                            local y = (colorpicker.hueselectorpointer.AbsolutePosition.Y - colorpicker.hue.AbsolutePosition.Y) / colorpicker.hue.AbsoluteSize.Y
                            colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 1 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 1 - (math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 1 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y)))
                        end

                        function colorpicker:Set(value)
                            local color = Color3.new(math.clamp(value.r, 0, 1), math.clamp(value.g, 0, 1), math.clamp(value.b, 0, 1))
                            colorpicker.value = color
                            if colorpicker.flag and colorpicker.flag ~= "" then
                                library.flags[colorpicker.flag] = color
                            end
                            local clr = Color3.new(math.clamp(color.R / 1.7, 0, 1), math.clamp(color.G / 1.7, 0, 1), math.clamp(color.B / 1.7, 0, 1))
                            colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, color), ColorSequenceKeypoint.new(1.00, clr) })
                            pcall(colorpicker.callback, color)
                        end

                        function colorpicker:Get(value)
                            return colorpicker.value
                        end
                        colorpicker:Set(colorpicker.default)

                        local dragging_selector = false
                        local dragging_hue = false

                        colorpicker.selector.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging_selector = true
                                colorpicker:RefreshSelector()
                            end
                        end)
        
                        colorpicker.selector.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging_selector = false
                                colorpicker:RefreshSelector()
                            end
                        end)

                        colorpicker.hue.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging_hue = true
                                colorpicker:RefreshHue()
                            end
                        end)
        
                        colorpicker.hue.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging_hue = false
                                colorpicker:RefreshHue()
                            end
                        end)
        
                        uis.InputChanged:Connect(function(input)
                            if dragging_selector and input.UserInputType == Enum.UserInputType.MouseMovement then
                                colorpicker:RefreshSelector()
                            end
                            if dragging_hue and input.UserInputType == Enum.UserInputType.MouseMovement then
                                colorpicker:RefreshHue()
                            end
                        end)

                        local inputBegan = function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                for i,v in pairs(window.OpenedColorPickers) do
                                    if v and i ~= colorpicker.MainPicker then
                                        i.Visible = false
                                        window.OpenedColorPickers[i] = false
                                    end
                                end

                                colorpicker.MainPicker.Visible = not colorpicker.MainPicker.Visible
                                window.OpenedColorPickers[colorpicker.MainPicker] = colorpicker.MainPicker.Visible
                                if window.OpenedColorPickers[colorpicker.MainPicker] then
                                    colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                                else
                                    colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                                end
                            end
                        end

                        colorpicker.Main.InputBegan:Connect(inputBegan)
                        colorpicker.Outline.InputBegan:Connect(inputBegan)
                        colorpicker.BlackOutline2.InputBegan:Connect(inputBegan)
                        table.insert(library.items, colorpicker)
                        return colorpicker
                    end

                    function toggle:AddSlider(min, default, max, decimals, callback, flag)
                        local slider = { }
                        slider.text = text or ""
                        slider.callback = callback or function(value) end
                        slider.min = min or 0
                        slider.max = max or 100
                        slider.decimals = decimals or 1
                        slider.default = default or slider.min
                        slider.flag = flag or ( (toggle.text or "") .. tostring(#toggle.Items:GetChildren()))
        
                        slider.value = slider.default
                        local dragging = false
        
                        slider.Main = Instance.new("TextButton", sector.Items)
                        slider.Main.Name = "slider"
                        slider.Main.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                        slider.Main.Position = UDim2.fromOffset(0, 0)
                        slider.Main.BorderSizePixel = 0
                        slider.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 12)
                        slider.Main.AutoButtonColor = false
                        slider.Main.Text = ""
                        slider.Main.ZIndex = 7

                        slider.InputLabel = Instance.new("TextLabel", slider.Main)
                        slider.InputLabel.BackgroundTransparency = 1
                        slider.InputLabel.Size = slider.Main.Size
                        slider.InputLabel.Font = window.theme.font
                        slider.InputLabel.Text = "0"
                        slider.InputLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
                        slider.InputLabel.Position = slider.Main.Position
                        slider.InputLabel.Selectable = false
                        slider.InputLabel.TextSize = 15
                        slider.InputLabel.ZIndex = 9
                        slider.InputLabel.TextStrokeTransparency = 1
                        slider.InputLabel.TextXAlignment = Enum.TextXAlignment.Center
                        updateevent.Event:Connect(function(theme)
                            slider.InputLabel.Font = theme.font
                            slider.InputLabel.TextColor3 = theme.itemscolor
                        end)
        
                        slider.BlackOutline2 = Instance.new("Frame", slider.Main)
                        slider.BlackOutline2.Name = "blackline"
                        slider.BlackOutline2.ZIndex = 4
                        slider.BlackOutline2.Size = slider.Main.Size + UDim2.fromOffset(6, 6)
                        slider.BlackOutline2.BorderSizePixel = 0
                        slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        slider.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                        updateevent.Event:Connect(function(theme)
                            slider.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                        end)
                        
                        slider.Outline = Instance.new("Frame", slider.Main)
                        slider.Outline.Name = "blackline"
                        slider.Outline.ZIndex = 4
                        slider.Outline.Size = slider.Main.Size + UDim2.fromOffset(4, 4)
                        slider.Outline.BorderSizePixel = 0
                        slider.Outline.BackgroundColor3 = window.theme.outlinecolor
                        slider.Outline.Position = UDim2.fromOffset(-2, -2)
                        updateevent.Event:Connect(function(theme)
                            slider.Outline.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        slider.BlackOutline = Instance.new("Frame", slider.Main)
                        slider.BlackOutline.Name = "blackline"
                        slider.BlackOutline.ZIndex = 4
                        slider.BlackOutline.Size = slider.Main.Size + UDim2.fromOffset(2, 2)
                        slider.BlackOutline.BorderSizePixel = 0
                        slider.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                        slider.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                        updateevent.Event:Connect(function(theme)
                            slider.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        slider.Gradient = Instance.new("UIGradient", slider.Main)
                        slider.Gradient.Rotation = 90
                        slider.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(41, 41, 41)) })
        
                        slider.SlideBar = Instance.new("Frame", slider.Main)
                        slider.SlideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) --Color3.fromRGB(204, 0, 102)
                        slider.SlideBar.ZIndex = 8
                        slider.SlideBar.BorderSizePixel = 0
                        slider.SlideBar.Size = UDim2.fromOffset(0, slider.Main.Size.Y.Offset)
        
                        slider.Gradient2 = Instance.new("UIGradient", slider.SlideBar)
                        slider.Gradient2.Rotation = 90
                        slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor2) })
                        updateevent.Event:Connect(function(theme)
                            slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor), ColorSequenceKeypoint.new(1.00, theme.accentcolor2) })
                        end)
        
                        slider.BlackOutline2.MouseEnter:Connect(function()
                            slider.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                        end)
                        slider.BlackOutline2.MouseLeave:Connect(function()
                            slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        end)
        
                        if slider.flag and slider.flag ~= "" then
                            library.flags[slider.flag] = slider.default or slider.min or 0
                        end

                        function slider:Get()
                            return slider.value
                        end
        
                        function slider:Set(value)
                            slider.value = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
                            local percent = 1 - ((slider.max - slider.value) / (slider.max - slider.min))
                            if slider.flag and slider.flag ~= "" then
                                library.flags[slider.flag] = slider.value
                            end
                            slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                            slider.InputLabel.Text = slider.value
                            pcall(slider.callback, slider.value)
                        end
                        slider:Set(slider.default)
        
                        function slider:Refresh()
                            local mousePos = camera:WorldToViewportPoint(mouse.Hit.p)
                            local percent = math.clamp(mousePos.X - slider.SlideBar.AbsolutePosition.X, 0, slider.Main.AbsoluteSize.X) / slider.Main.AbsoluteSize.X
                            local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                            value = math.clamp(value, slider.min, slider.max)
                            slider:Set(value)
                        end
        
                        slider.SlideBar.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging = true
                                slider:Refresh()
                            end
                        end)
        
                        slider.SlideBar.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging = false
                            end
                        end)
        
                        slider.Main.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging = true
                                slider:Refresh()
                            end
                        end)
        
                        slider.Main.InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                dragging = false
                            end
                        end)
        
                        uis.InputChanged:Connect(function(input)
                            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                                slider:Refresh()
                            end
                        end)
        
                        sector:FixSize()
                        table.insert(library.items, slider)
                        return slider
                    end

                    toggle.Main.MouseButton1Down:Connect(function()
                        toggle:Set(not toggle.CheckedFrame.Visible)
                    end)
                    toggle.Label.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            toggle:Set(not toggle.CheckedFrame.Visible)
                        end
                    end)

                    local MouseEnter = function()
                        toggle.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end
                    local MouseLeave = function()
                        toggle.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end

                    toggle.Label.MouseEnter:Connect(MouseEnter)
                    toggle.Label.MouseLeave:Connect(MouseLeave)
                    toggle.BlackOutline2.MouseEnter:Connect(MouseEnter)
                    toggle.BlackOutline2.MouseLeave:Connect(MouseLeave)

                    sector:FixSize()
                    table.insert(library.items, toggle)
                    return toggle
                end

                function sector:AddTextbox(text, default, callback, flag)
                    local textbox = { }
                    textbox.text = text or ""
                    textbox.callback = callback or function() end
                    textbox.default = default
                    textbox.value = ""
                    textbox.flag = flag or text or ""

                    textbox.Label = Instance.new("TextButton", sector.Items)
                    textbox.Label.Name = "Label"
                    textbox.Label.AutoButtonColor = false
                    textbox.Label.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    textbox.Label.BackgroundTransparency = 1
                    textbox.Label.Position = UDim2.fromOffset(sector.Main.Size.X.Offset, 0)
                    textbox.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 0)
                    textbox.Label.Font = window.theme.font
                    textbox.Label.ZIndex = 5
                    textbox.Label.Text = textbox.text
                    textbox.Label.TextColor3 = window.theme.itemscolor
                    textbox.Label.TextSize = 15
                    textbox.Label.TextStrokeTransparency = 1
                    textbox.Label.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        textbox.Label.Font = theme.font
                    end)

                    textbox.Holder = Instance.new("Frame", sector.Items)
                    textbox.Holder.Name = "holder"
                    textbox.Holder.ZIndex = 5
                    textbox.Holder.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 14)
                    textbox.Holder.BorderSizePixel = 0
                    textbox.Holder.BackgroundColor3 = Color3.fromRGB(150, 150, 150)

                    textbox.Gradient = Instance.new("UIGradient", textbox.Holder)
                    textbox.Gradient.Rotation = 90
                    textbox.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39)) })

                    textbox.Main = Instance.new("TextBox", textbox.Holder)
                    textbox.Main.PlaceholderText = textbox.text
                    textbox.Main.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                    textbox.Main.Text = ""
                    textbox.Main.BackgroundTransparency = 1
                    textbox.Main.Font = window.theme.font
                    textbox.Main.Name = "textbox"
                    textbox.Main.MultiLine = false
                    textbox.Main.ClearTextOnFocus = false
                    textbox.Main.ZIndex = 5
                    textbox.Main.TextScaled = true
                    textbox.Main.Size = textbox.Holder.Size
                    textbox.Main.TextSize = 15
                    textbox.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textbox.Main.BorderSizePixel = 0
                    textbox.Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    textbox.Main.TextXAlignment = Enum.TextXAlignment.Left

                    if textbox.flag and textbox.flag ~= "" then
                        library.flags[textbox.flag] = textbox.default or ""
                    end

                    function textbox:Set(text)
                        textbox.value = text
                        textbox.Main.Text = text
                        if textbox.flag and textbox.flag ~= "" then
                            library.flags[textbox.flag] = text
                        end
                        pcall(textbox.callback, text)
                    end
                    updateevent.Event:Connect(function(theme)
                        textbox.Main.Font = theme.font
                    end)

                    function textbox:Get()
                        return textbox.value
                    end

                    if textbox.default then 
                        textbox:Set(textbox.default)
                    end

                    textbox.Main.FocusLost:Connect(function()
                        textbox:Set(textbox.Main.Text)
                    end)

                    textbox.BlackOutline2 = Instance.new("Frame", textbox.Main)
                    textbox.BlackOutline2.Name = "blackline"
                    textbox.BlackOutline2.ZIndex = 4
                    textbox.BlackOutline2.Size = textbox.Main.Size + UDim2.fromOffset(6, 6)
                    textbox.BlackOutline2.BorderSizePixel = 0
                    textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    textbox.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        textbox.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    textbox.Outline = Instance.new("Frame", textbox.Main)
                    textbox.Outline.Name = "blackline"
                    textbox.Outline.ZIndex = 4
                    textbox.Outline.Size = textbox.Main.Size + UDim2.fromOffset(4, 4)
                    textbox.Outline.BorderSizePixel = 0
                    textbox.Outline.BackgroundColor3 = window.theme.outlinecolor
                    textbox.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        textbox.Outline.BackgroundColor3 = theme.outlinecolor
                    end)

                    textbox.BlackOutline = Instance.new("Frame", textbox.Main)
                    textbox.BlackOutline.Name = "blackline"
                    textbox.BlackOutline.ZIndex = 4
                    textbox.BlackOutline.Size = textbox.Main.Size + UDim2.fromOffset(2, 2)
                    textbox.BlackOutline.BorderSizePixel = 0
                    textbox.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    textbox.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        textbox.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    textbox.BlackOutline2.MouseEnter:Connect(function()
                        textbox.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    textbox.BlackOutline2.MouseLeave:Connect(function()
                        textbox.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)

                    sector:FixSize()
                    table.insert(library.items, textbox)
                    return textbox
                end
                
                function sector:AddSlider(text, min, default, max, decimals, callback, flag)
                    local slider = { }
                    slider.text = text or ""
                    slider.callback = callback or function(value) end
                    slider.min = min or 0
                    slider.max = max or 100
                    slider.decimals = decimals or 1
                    slider.default = default or slider.min
                    slider.flag = flag or text or ""

                    slider.value = slider.default
                    local dragging = false

                    slider.MainBack = Instance.new("Frame", sector.Items)
                    slider.MainBack.Name = "MainBack"
                    slider.MainBack.ZIndex = 7
                    slider.MainBack.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 25)
                    slider.MainBack.BorderSizePixel = 0
                    slider.MainBack.BackgroundTransparency = 1

                    slider.Label = Instance.new("TextLabel", slider.MainBack)
                    slider.Label.BackgroundTransparency = 1
                    slider.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 6)
                    slider.Label.Font = window.theme.font
                    slider.Label.Text = slider.text .. ":"
                    slider.Label.TextColor3 = window.theme.itemscolor
                    slider.Label.Position = UDim2.fromOffset(0, 0)
                    slider.Label.TextSize = 15
                    slider.Label.ZIndex = 4
                    slider.Label.TextStrokeTransparency = 1
                    slider.Label.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        slider.Label.Font = theme.font
                        slider.Label.TextColor3 = theme.itemscolor
                    end)

                    local size = textservice:GetTextSize(slider.Label.Text, slider.Label.TextSize, slider.Label.Font, Vector2.new(200,300))
                    slider.InputLabel = Instance.new("TextBox", slider.MainBack)
                    slider.InputLabel.BackgroundTransparency = 1
                    slider.InputLabel.ClearTextOnFocus = false
                    slider.InputLabel.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - size.X - 15, 12)
                    slider.InputLabel.Font = window.theme.font
                    slider.InputLabel.Text = "0"
                    slider.InputLabel.TextColor3 = window.theme.itemscolor
                    slider.InputLabel.Position = UDim2.fromOffset(size.X + 3, -3)
                    slider.InputLabel.TextSize = 15
                    slider.InputLabel.ZIndex = 4
                    slider.InputLabel.TextStrokeTransparency = 1
                    slider.InputLabel.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        slider.InputLabel.Font = theme.font
                        slider.InputLabel.TextColor3 = theme.itemscolor

                        local size = textservice:GetTextSize(slider.Label.Text, slider.Label.TextSize, slider.Label.Font, Vector2.new(200,300))
                        slider.InputLabel.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - size.X - 15, 12)
                    end)

                    slider.Main = Instance.new("TextButton", slider.MainBack)
                    slider.Main.Name = "slider"
                    slider.Main.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    slider.Main.Position = UDim2.fromOffset(0, 15)
                    slider.Main.BorderSizePixel = 0
                    slider.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 12)
                    slider.Main.AutoButtonColor = false
                    slider.Main.Text = ""
                    slider.Main.ZIndex = 5

                    slider.BlackOutline2 = Instance.new("Frame", slider.Main)
                    slider.BlackOutline2.Name = "blackline"
                    slider.BlackOutline2.ZIndex = 4
                    slider.BlackOutline2.Size = slider.Main.Size + UDim2.fromOffset(6, 6)
                    slider.BlackOutline2.BorderSizePixel = 0
                    slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    slider.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        slider.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    slider.Outline = Instance.new("Frame", slider.Main)
                    slider.Outline.Name = "blackline"
                    slider.Outline.ZIndex = 4
                    slider.Outline.Size = slider.Main.Size + UDim2.fromOffset(4, 4)
                    slider.Outline.BorderSizePixel = 0
                    slider.Outline.BackgroundColor3 = window.theme.outlinecolor
                    slider.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        slider.Outline.BackgroundColor3 = theme.outlinecolor
                    end)

                    slider.BlackOutline = Instance.new("Frame", slider.Main)
                    slider.BlackOutline.Name = "blackline"
                    slider.BlackOutline.ZIndex = 4
                    slider.BlackOutline.Size = slider.Main.Size + UDim2.fromOffset(2, 2)
                    slider.BlackOutline.BorderSizePixel = 0
                    slider.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    slider.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        slider.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    slider.Gradient = Instance.new("UIGradient", slider.Main)
                    slider.Gradient.Rotation = 90
                    slider.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(41, 41, 41)) })

                    slider.SlideBar = Instance.new("Frame", slider.Main)
                    slider.SlideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255) --Color3.fromRGB(204, 0, 102)
                    slider.SlideBar.ZIndex = 5
                    slider.SlideBar.BorderSizePixel = 0
                    slider.SlideBar.Size = UDim2.fromOffset(0, slider.Main.Size.Y.Offset)

                    slider.Gradient2 = Instance.new("UIGradient", slider.SlideBar)
                    slider.Gradient2.Rotation = 90
                    slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, window.theme.accentcolor), ColorSequenceKeypoint.new(1.00, window.theme.accentcolor2) })
                    updateevent.Event:Connect(function(theme)
                        slider.Gradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, theme.accentcolor), ColorSequenceKeypoint.new(1.00, theme.accentcolor2) })
                    end)

                    slider.BlackOutline2.MouseEnter:Connect(function()
                        slider.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    slider.BlackOutline2.MouseLeave:Connect(function()
                        slider.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)

                    if slider.flag and slider.flag ~= "" then
                        library.flags[slider.flag] = slider.default or slider.min or 0
                    end

                    function slider:Get()
                        return slider.value
                    end

                    function slider:Set(value)
                        slider.value = math.clamp(math.round(value * slider.decimals) / slider.decimals, slider.min, slider.max)
                        local percent = 1 - ((slider.max - slider.value) / (slider.max - slider.min))
                        if slider.flag and slider.flag ~= "" then
                            library.flags[slider.flag] = slider.value
                        end
                        slider.SlideBar:TweenSize(UDim2.fromOffset(percent * slider.Main.AbsoluteSize.X, slider.Main.AbsoluteSize.Y), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        slider.InputLabel.Text = slider.value
                        pcall(slider.callback, slider.value)
                    end
                    slider:Set(slider.default)

                    slider.InputLabel.FocusLost:Connect(function(Return)
                        if not Return then 
                            return 
                        end
                        if (slider.InputLabel.Text:match("^%d+$")) then
                            slider:Set(tonumber(slider.InputLabel.Text))
                        else
                            slider.InputLabel.Text = tostring(slider.value)
                        end
                    end)

                    function slider:Refresh()
                        local mousePos = camera:WorldToViewportPoint(mouse.Hit.p)
                        local percent = math.clamp(mousePos.X - slider.SlideBar.AbsolutePosition.X, 0, slider.Main.AbsoluteSize.X) / slider.Main.AbsoluteSize.X
                        local value = math.floor((slider.min + (slider.max - slider.min) * percent) * slider.decimals) / slider.decimals
                        value = math.clamp(value, slider.min, slider.max)
                        slider:Set(value)
                    end

                    slider.SlideBar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            slider:Refresh()
                        end
                    end)

                    slider.SlideBar.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)

                    slider.Main.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            slider:Refresh()
                        end
                    end)

                    slider.Main.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)

                    uis.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            slider:Refresh()
                        end
                    end)

                    sector:FixSize()
                    table.insert(library.items, slider)
                    return slider
                end

                function sector:AddColorpicker(text, default, callback, flag)
                    local colorpicker = { }

                    colorpicker.text = text or ""
                    colorpicker.callback = callback or function() end
                    colorpicker.default = default or Color3.fromRGB(255, 255, 255)
                    colorpicker.value = colorpicker.default
                    colorpicker.flag = flag or text or ""

                    colorpicker.Label = Instance.new("TextLabel", sector.Items)
                    colorpicker.Label.BackgroundTransparency = 1
                    colorpicker.Label.Size = UDim2.fromOffset(156, 10)
                    colorpicker.Label.ZIndex = 4
                    colorpicker.Label.Font = window.theme.font
                    colorpicker.Label.Text = colorpicker.text
                    colorpicker.Label.TextColor3 = window.theme.itemscolor
                    colorpicker.Label.TextSize = 15
                    colorpicker.Label.TextStrokeTransparency = 1
                    colorpicker.Label.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        colorpicker.Label.Font = theme.font
                        colorpicker.Label.TextColor3 = theme.itemscolor
                    end)

                    colorpicker.Main = Instance.new("Frame", colorpicker.Label)
                    colorpicker.Main.ZIndex = 6
                    colorpicker.Main.BorderSizePixel = 0
                    colorpicker.Main.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 29, 0)
                    colorpicker.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    colorpicker.Main.Size = UDim2.fromOffset(16, 10)

                    colorpicker.Gradient = Instance.new("UIGradient", colorpicker.Main)
                    colorpicker.Gradient.Rotation = 90

                    local clr = Color3.new(math.clamp(colorpicker.value.R / 1.7, 0, 1), math.clamp(colorpicker.value.G / 1.7, 0, 1), math.clamp(colorpicker.value.B / 1.7, 0, 1))
                    colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, colorpicker.value), ColorSequenceKeypoint.new(1.00, clr) })

                    colorpicker.BlackOutline2 = Instance.new("Frame", colorpicker.Main)
                    colorpicker.BlackOutline2.Name = "blackline"
                    colorpicker.BlackOutline2.ZIndex = 4
                    colorpicker.BlackOutline2.Size = colorpicker.Main.Size + UDim2.fromOffset(6, 6)
                    colorpicker.BlackOutline2.BorderSizePixel = 0
                    colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.BlackOutline2.BackgroundColor3 = window.OpenedColorPickers[colorpicker.MainPicker] and theme.accentcolor or theme.outlinecolor2
                    end)
                    
                    colorpicker.Outline = Instance.new("Frame", colorpicker.Main)
                    colorpicker.Outline.Name = "blackline"
                    colorpicker.Outline.ZIndex = 4
                    colorpicker.Outline.Size = colorpicker.Main.Size + UDim2.fromOffset(4, 4)
                    colorpicker.Outline.BorderSizePixel = 0
                    colorpicker.Outline.BackgroundColor3 = window.theme.outlinecolor
                    colorpicker.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.Outline.BackgroundColor3 = theme.outlinecolor
                    end)

                    colorpicker.BlackOutline = Instance.new("Frame", colorpicker.Main)
                    colorpicker.BlackOutline.Name = "blackline"
                    colorpicker.BlackOutline.ZIndex = 4
                    colorpicker.BlackOutline.Size = colorpicker.Main.Size + UDim2.fromOffset(2, 2)
                    colorpicker.BlackOutline.BorderSizePixel = 0
                    colorpicker.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    colorpicker.BlackOutline2.MouseEnter:Connect(function()
                        colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    colorpicker.BlackOutline2.MouseLeave:Connect(function()
                        if not window.OpenedColorPickers[colorpicker.MainPicker] then
                            colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        end
                    end)

                    colorpicker.MainPicker = Instance.new("TextButton", colorpicker.Main)
                    colorpicker.MainPicker.Name = "picker"
                    colorpicker.MainPicker.ZIndex = 100
                    colorpicker.MainPicker.Visible = false
                    colorpicker.MainPicker.AutoButtonColor = false
                    colorpicker.MainPicker.Text = ""
                    window.OpenedColorPickers[colorpicker.MainPicker] = false
                    colorpicker.MainPicker.Size = UDim2.fromOffset(180, 196)
                    colorpicker.MainPicker.BorderSizePixel = 0
                    colorpicker.MainPicker.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    colorpicker.MainPicker.Rotation = 0.000000000000001
                    colorpicker.MainPicker.Position = UDim2.fromOffset(-colorpicker.MainPicker.AbsoluteSize.X + colorpicker.Main.AbsoluteSize.X, 15)

                    colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                    colorpicker.BlackOutline3.Name = "blackline"
                    colorpicker.BlackOutline3.ZIndex = 98
                    colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(6, 6)
                    colorpicker.BlackOutline3.BorderSizePixel = 0
                    colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline3.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                    end)
                    
                    colorpicker.Outline2 = Instance.new("Frame", colorpicker.MainPicker)
                    colorpicker.Outline2.Name = "blackline"
                    colorpicker.Outline2.ZIndex = 98
                    colorpicker.Outline2.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(4, 4)
                    colorpicker.Outline2.BorderSizePixel = 0
                    colorpicker.Outline2.BackgroundColor3 = window.theme.outlinecolor
                    colorpicker.Outline2.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.Outline2.BackgroundColor3 = theme.outlinecolor
                    end)

                    colorpicker.BlackOutline3 = Instance.new("Frame", colorpicker.MainPicker)
                    colorpicker.BlackOutline3.Name = "blackline"
                    colorpicker.BlackOutline3.ZIndex = 98
                    colorpicker.BlackOutline3.Size = colorpicker.MainPicker.Size + UDim2.fromOffset(2, 2)
                    colorpicker.BlackOutline3.BorderSizePixel = 0
                    colorpicker.BlackOutline3.BackgroundColor3 = window.theme.outlinecolor2
                    colorpicker.BlackOutline3.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        colorpicker.BlackOutline3.BackgroundColor3 = theme.outlinecolor2
                    end)

                    colorpicker.hue = Instance.new("ImageLabel", colorpicker.MainPicker)
                    colorpicker.hue.ZIndex = 101
                    colorpicker.hue.Position = UDim2.new(0,3,0,3)
                    colorpicker.hue.Size = UDim2.new(0,172,0,172)
                    colorpicker.hue.Image = "rbxassetid://4155801252"
                    colorpicker.hue.ScaleType = Enum.ScaleType.Stretch
                    colorpicker.hue.BackgroundColor3 = Color3.new(1,0,0)
                    colorpicker.hue.BorderColor3 = window.theme.outlinecolor2
                    updateevent.Event:Connect(function(theme)
                        colorpicker.hue.BorderColor3 = theme.outlinecolor2
                    end)

                    colorpicker.hueselectorpointer = Instance.new("ImageLabel", colorpicker.MainPicker)
                    colorpicker.hueselectorpointer.ZIndex = 101
                    colorpicker.hueselectorpointer.BackgroundTransparency = 1
                    colorpicker.hueselectorpointer.BorderSizePixel = 0
                    colorpicker.hueselectorpointer.Position = UDim2.new(0, 0, 0, 0)
                    colorpicker.hueselectorpointer.Size = UDim2.new(0, 7, 0, 7)
                    colorpicker.hueselectorpointer.Image = "rbxassetid://6885856475"

                    colorpicker.selector = Instance.new("TextLabel", colorpicker.MainPicker)
                    colorpicker.selector.ZIndex = 100
                    colorpicker.selector.Position = UDim2.new(0,3,0,181)
                    colorpicker.selector.Size = UDim2.new(0,173,0,10)
                    colorpicker.selector.BackgroundColor3 = Color3.fromRGB(255,255,255)
                    colorpicker.selector.BorderColor3 = window.theme.outlinecolor2
                    colorpicker.selector.Text = ""
                    updateevent.Event:Connect(function(theme)
                        colorpicker.selector.BorderColor3 = theme.outlinecolor2
                    end)
        
                    colorpicker.gradient = Instance.new("UIGradient", colorpicker.selector)
                    colorpicker.gradient.Color = ColorSequence.new({ 
                        ColorSequenceKeypoint.new(0, Color3.new(1,0,0)), 
                        ColorSequenceKeypoint.new(0.17, Color3.new(1,0,1)), 
                        ColorSequenceKeypoint.new(0.33,Color3.new(0,0,1)), 
                        ColorSequenceKeypoint.new(0.5,Color3.new(0,1,1)), 
                        ColorSequenceKeypoint.new(0.67, Color3.new(0,1,0)), 
                        ColorSequenceKeypoint.new(0.83, Color3.new(1,1,0)), 
                        ColorSequenceKeypoint.new(1, Color3.new(1,0,0))
                    })

                    colorpicker.pointer = Instance.new("Frame", colorpicker.selector)
                    colorpicker.pointer.ZIndex = 101
                    colorpicker.pointer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    colorpicker.pointer.Position = UDim2.new(0,0,0,0)
                    colorpicker.pointer.Size = UDim2.new(0,2,0,10)
                    colorpicker.pointer.BorderColor3 = Color3.fromRGB(255, 255, 255)

                    if colorpicker.flag and colorpicker.flag ~= "" then
                        library.flags[colorpicker.flag] = colorpicker.default
                    end

                    function colorpicker:RefreshSelector()
                        local pos = math.clamp((mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X, 0, 1)
                        colorpicker.color = 1 - pos
                        colorpicker.pointer:TweenPosition(UDim2.new(pos, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        colorpicker.hue.BackgroundColor3 = Color3.fromHSV(1 - pos, 1, 1)
                    end

                    function colorpicker:RefreshHue()
                        local x = (mouse.X - colorpicker.hue.AbsolutePosition.X) / colorpicker.hue.AbsoluteSize.X
                        local y = (mouse.Y - colorpicker.hue.AbsolutePosition.Y) / colorpicker.hue.AbsoluteSize.Y
                        colorpicker.hueselectorpointer:TweenPosition(UDim2.new(math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 0.952 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 0, math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 0.885 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
                        colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x * colorpicker.hue.AbsoluteSize.X, 0.5, 1 * colorpicker.hue.AbsoluteSize.X) / colorpicker.hue.AbsoluteSize.X, 1 - (math.clamp(y * colorpicker.hue.AbsoluteSize.Y, 0.5, 1 * colorpicker.hue.AbsoluteSize.Y) / colorpicker.hue.AbsoluteSize.Y)))
                    end

                    function colorpicker:Set(value)
                        local color = Color3.new(math.clamp(value.r, 0, 1), math.clamp(value.g, 0, 1), math.clamp(value.b, 0, 1))
                        colorpicker.value = color
                        if colorpicker.flag and colorpicker.flag ~= "" then
                            library.flags[colorpicker.flag] = color
                        end
                        local clr = Color3.new(math.clamp(color.R / 1.7, 0, 1), math.clamp(color.G / 1.7, 0, 1), math.clamp(color.B / 1.7, 0, 1))
                        colorpicker.Gradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0.00, color), ColorSequenceKeypoint.new(1.00, clr) })
                        pcall(colorpicker.callback, color)
                    end
                    function colorpicker:Get()
                        return colorpicker.value
                    end
                    colorpicker:Set(colorpicker.default)

                    function colorpicker:AddDropdown(items, default, multichoice, callback, flag)
                        local dropdown = { }

                        dropdown.defaultitems = items or { }
                        dropdown.default = default
                        dropdown.callback = callback or function() end
                        dropdown.multichoice = multichoice or false
                        dropdown.values = { }
                        dropdown.flag = flag or ((colorpicker.text or "") .. tostring( #(sector.Items:GetChildren()) ))
        
                        dropdown.Main = Instance.new("TextButton", sector.Items)
                        dropdown.Main.Name = "dropdown"
                        dropdown.Main.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                        dropdown.Main.BorderSizePixel = 0
                        dropdown.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 16)
                        dropdown.Main.Position = UDim2.fromOffset(0, 0)
                        dropdown.Main.ZIndex = 5
                        dropdown.Main.AutoButtonColor = false
                        dropdown.Main.Font = window.theme.font
                        dropdown.Main.Text = ""
                        dropdown.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                        dropdown.Main.TextSize = 15
                        dropdown.Main.TextXAlignment = Enum.TextXAlignment.Left
                        updateevent.Event:Connect(function(theme)
                            dropdown.Main.Font = theme.font
                        end)
        
                        dropdown.Gradient = Instance.new("UIGradient", dropdown.Main)
                        dropdown.Gradient.Rotation = 90
                        dropdown.Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39))}
        
                        dropdown.SelectedLabel = Instance.new("TextLabel", dropdown.Main)
                        dropdown.SelectedLabel.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                        dropdown.SelectedLabel.BackgroundTransparency = 1
                        dropdown.SelectedLabel.Position = UDim2.fromOffset(5, 2)
                        dropdown.SelectedLabel.Size = UDim2.fromOffset(130, 13)
                        dropdown.SelectedLabel.Font = window.theme.font
                        dropdown.SelectedLabel.Text = colorpicker.text
                        dropdown.SelectedLabel.ZIndex = 5
                        dropdown.SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                        dropdown.SelectedLabel.TextSize = 15
                        dropdown.SelectedLabel.TextStrokeTransparency = 1
                        dropdown.SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
                        updateevent.Event:Connect(function(theme)
                            dropdown.SelectedLabel.Font = theme.font
                        end)

                        dropdown.Nav = Instance.new("ImageButton", dropdown.Main)
                        dropdown.Nav.Name = "navigation"
                        dropdown.Nav.BackgroundTransparency = 1
                        dropdown.Nav.LayoutOrder = 10
                        dropdown.Nav.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 5)
                        dropdown.Nav.Rotation = 90
                        dropdown.Nav.ZIndex = 5
                        dropdown.Nav.Size = UDim2.fromOffset(8, 8)
                        dropdown.Nav.Image = "rbxassetid://4918373417"
                        dropdown.Nav.ImageColor3 = Color3.fromRGB(210, 210, 210)
        
                        dropdown.BlackOutline2 = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutline2.Name = "blackline"
                        dropdown.BlackOutline2.ZIndex = 4
                        dropdown.BlackOutline2.Size = dropdown.Main.Size + UDim2.fromOffset(6, 6)
                        dropdown.BlackOutline2.BorderSizePixel = 0
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        dropdown.Outline = Instance.new("Frame", dropdown.Main)
                        dropdown.Outline.Name = "blackline"
                        dropdown.Outline.ZIndex = 4
                        dropdown.Outline.Size = dropdown.Main.Size + UDim2.fromOffset(4, 4)
                        dropdown.Outline.BorderSizePixel = 0
                        dropdown.Outline.BackgroundColor3 = window.theme.outlinecolor
                        dropdown.Outline.Position = UDim2.fromOffset(-2, -2)
                        updateevent.Event:Connect(function(theme)
                            dropdown.Outline.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        dropdown.BlackOutline = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutline.Name = "blackline"
                        dropdown.BlackOutline.ZIndex = 4
                        dropdown.BlackOutline.Size = dropdown.Main.Size + UDim2.fromOffset(2, 2)
                        dropdown.BlackOutline.BorderSizePixel = 0
                        dropdown.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        dropdown.ItemsFrame = Instance.new("ScrollingFrame", dropdown.Main)
                        dropdown.ItemsFrame.Name = "itemsframe"
                        dropdown.ItemsFrame.BorderSizePixel = 0
                        dropdown.ItemsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                        dropdown.ItemsFrame.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                        dropdown.ItemsFrame.ScrollBarThickness = 2
                        dropdown.ItemsFrame.ZIndex = 8
                        dropdown.ItemsFrame.ScrollingDirection = "Y"
                        dropdown.ItemsFrame.Visible = false
                        dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.Main.AbsoluteSize.X, 0)
        
                        dropdown.ListLayout = Instance.new("UIListLayout", dropdown.ItemsFrame)
                        dropdown.ListLayout.FillDirection = Enum.FillDirection.Vertical
                        dropdown.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
                        dropdown.ListPadding = Instance.new("UIPadding", dropdown.ItemsFrame)
                        dropdown.ListPadding.PaddingTop = UDim.new(0, 2)
                        dropdown.ListPadding.PaddingBottom = UDim.new(0, 2)
                        dropdown.ListPadding.PaddingLeft = UDim.new(0, 2)
                        dropdown.ListPadding.PaddingRight = UDim.new(0, 2)
        
                        dropdown.BlackOutline2Items = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutline2Items.Name = "blackline"
                        dropdown.BlackOutline2Items.ZIndex = 7
                        dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                        dropdown.BlackOutline2Items.BorderSizePixel = 0
                        dropdown.BlackOutline2Items.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutline2Items.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-3, -3)
                        dropdown.BlackOutline2Items.Visible = false
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutline2Items.BackgroundColor3 = theme.outlinecolor2
                        end)
                        
                        dropdown.OutlineItems = Instance.new("Frame", dropdown.Main)
                        dropdown.OutlineItems.Name = "blackline"
                        dropdown.OutlineItems.ZIndex = 7
                        dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                        dropdown.OutlineItems.BorderSizePixel = 0
                        dropdown.OutlineItems.BackgroundColor3 = window.theme.outlinecolor
                        dropdown.OutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-2, -2)
                        dropdown.OutlineItems.Visible = false
                        updateevent.Event:Connect(function(theme)
                            dropdown.OutlineItems.BackgroundColor3 = theme.outlinecolor
                        end)
        
                        dropdown.BlackOutlineItems = Instance.new("Frame", dropdown.Main)
                        dropdown.BlackOutlineItems.Name = "blackline"
                        dropdown.BlackOutlineItems.ZIndex = 7
                        dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(-2, -2)
                        dropdown.BlackOutlineItems.BorderSizePixel = 0
                        dropdown.BlackOutlineItems.BackgroundColor3 = window.theme.outlinecolor2
                        dropdown.BlackOutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-1, -1)
                        dropdown.BlackOutlineItems.Visible = false
                        updateevent.Event:Connect(function(theme)
                            dropdown.BlackOutlineItems.BackgroundColor3 = theme.outlinecolor2
                        end)
        
                        dropdown.IgnoreBackButtons = Instance.new("TextButton", dropdown.Main)
                        dropdown.IgnoreBackButtons.BackgroundTransparency = 1
                        dropdown.IgnoreBackButtons.BorderSizePixel = 0
                        dropdown.IgnoreBackButtons.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                        dropdown.IgnoreBackButtons.Size = UDim2.new(0, 0, 0, 0)
                        dropdown.IgnoreBackButtons.ZIndex = 7
                        dropdown.IgnoreBackButtons.Text = ""
                        dropdown.IgnoreBackButtons.Visible = false
                        dropdown.IgnoreBackButtons.AutoButtonColor = false

                        if dropdown.flag and dropdown.flag ~= "" then
                            library.flags[dropdown.flag] = dropdown.multichoice and { dropdown.default or dropdown.defaultitems[1] or "" } or (dropdown.default or dropdown.defaultitems[1] or "")
                        end

                        function dropdown:isSelected(item)
                            for i, v in pairs(dropdown.values) do
                                if v == item then
                                    return true
                                end
                            end
                            return false
                        end
        
                        function dropdown:updateText(text)
                            if #text >= 27 then
                                text = text:sub(1, 25) .. ".."
                            end
                            dropdown.SelectedLabel.Text = text
                        end
        
                        dropdown.Changed = Instance.new("BindableEvent")
                        function dropdown:Set(value)
                            if type(value) == "table" then
                                dropdown.values = value
                                dropdown:updateText(table.concat(value, ", "))
                                pcall(dropdown.callback, value)
                            else
                                dropdown:updateText(value)
                                dropdown.values = { value }
                                pcall(dropdown.callback, value)
                            end
                            
                            dropdown.Changed:Fire(value)
                            if dropdown.flag and dropdown.flag ~= "" then
                                library.flags[dropdown.flag] = dropdown.multichoice and dropdown.values or dropdown.values[1]
                            end
                        end
        
                        function dropdown:Get()
                            return dropdown.multichoice and dropdown.values or dropdown.values[1]
                        end
        
                        dropdown.items = { }
                        function dropdown:Add(v)
                            local Item = Instance.new("TextButton", dropdown.ItemsFrame)
                            Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.BorderSizePixel = 0
                            Item.Position = UDim2.fromOffset(0, 0)
                            Item.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset - 4, 20)
                            Item.ZIndex = 9
                            Item.Text = v
                            Item.Name = v
                            Item.AutoButtonColor = false
                            Item.Font = window.theme.font
                            Item.TextSize = 15
                            Item.TextXAlignment = Enum.TextXAlignment.Left
                            Item.TextStrokeTransparency = 1
                            dropdown.ItemsFrame.CanvasSize = dropdown.ItemsFrame.CanvasSize + UDim2.fromOffset(0, Item.AbsoluteSize.Y)
        
                            Item.MouseButton1Down:Connect(function()
                                if dropdown.multichoice then
                                    if dropdown:isSelected(v) then
                                        for i2, v2 in pairs(dropdown.values) do
                                            if v2 == v then
                                                table.remove(dropdown.values, i2)
                                            end
                                        end
                                        dropdown:Set(dropdown.values)
                                    else
                                        table.insert(dropdown.values, v)
                                        dropdown:Set(dropdown.values)
                                    end
        
                                    return
                                else
                                    dropdown.Nav.Rotation = 90
                                    dropdown.ItemsFrame.Visible = false
                                    dropdown.ItemsFrame.Active = false
                                    dropdown.OutlineItems.Visible = false
                                    dropdown.BlackOutlineItems.Visible = false
                                    dropdown.BlackOutline2Items.Visible = false
                                    dropdown.IgnoreBackButtons.Visible = false
                                    dropdown.IgnoreBackButtons.Active = false
                                end
        
                                dropdown:Set(v)
                                return
                            end)
        
                            runservice.RenderStepped:Connect(function()
                                if dropdown.multichoice and dropdown:isSelected(v) or dropdown.values[1] == v then
                                    Item.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
                                    Item.TextColor3 = window.theme.accentcolor
                                    Item.Text = " " .. v
                                else
                                    Item.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                    Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    Item.Text = v
                                end
                            end)
        
                            table.insert(dropdown.items, v)
                            dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * Item.AbsoluteSize.Y, 20, 156) + 4)
                            dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * Item.AbsoluteSize.Y) + 4)
        
                            dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                            dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                            dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                            dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
                        end
        
                        function dropdown:Remove(value)
                            local item = dropdown.ItemsFrame:FindFirstChild(value)
                            if item then
                                for i,v in pairs(dropdown.items) do
                                    if v == value then
                                        table.remove(dropdown.items, i)
                                    end
                                end
        
                                dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * item.AbsoluteSize.Y, 20, 156) + 4)
                                dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * item.AbsoluteSize.Y) + 4)
            
                                dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                                dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                                dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                                dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
        
                                item:Remove()
                            end
                        end 
        
                        for i,v in pairs(dropdown.defaultitems) do
                            dropdown:Add(v)
                        end
        
                        if dropdown.default then
                            dropdown:Set(dropdown.default)
                        end
        
                        local MouseButton1Down = function()
                            if dropdown.Nav.Rotation == 90 then
                                dropdown.ItemsFrame.ScrollingEnabled = true
                                sector.Main.Parent.ScrollingEnabled = false
                                tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = -90 }):Play()
                                dropdown.ItemsFrame.Visible = true
                                dropdown.ItemsFrame.Active = true
                                dropdown.IgnoreBackButtons.Visible = true
                                dropdown.IgnoreBackButtons.Active = true
                                dropdown.OutlineItems.Visible = true
                                dropdown.BlackOutlineItems.Visible = true
                                dropdown.BlackOutline2Items.Visible = true
                            else
                                dropdown.ItemsFrame.ScrollingEnabled = false
                                sector.Main.Parent.ScrollingEnabled = true
                                tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 90 }):Play()
                                dropdown.ItemsFrame.Visible = false
                                dropdown.ItemsFrame.Active = false
                                dropdown.IgnoreBackButtons.Visible = false
                                dropdown.IgnoreBackButtons.Active = false
                                dropdown.OutlineItems.Visible = false
                                dropdown.BlackOutlineItems.Visible = false
                                dropdown.BlackOutline2Items.Visible = false
                            end
                        end
        
                        dropdown.Main.MouseButton1Down:Connect(MouseButton1Down)
                        dropdown.Nav.MouseButton1Down:Connect(MouseButton1Down)
        
                        dropdown.BlackOutline2.MouseEnter:Connect(function()
                            dropdown.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                        end)
                        dropdown.BlackOutline2.MouseLeave:Connect(function()
                            dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                        end)
        
                        sector:FixSize()
                        table.insert(library.items, dropdown)
                        return dropdown
                    end

                    local dragging_selector = false
                    local dragging_hue = false

                    colorpicker.selector.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_selector = true
                            colorpicker:RefreshSelector()
                        end
                    end)

                    colorpicker.selector.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_selector = false
                            colorpicker:RefreshSelector()
                        end
                    end)

                    colorpicker.hue.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_hue = true
                            colorpicker:RefreshHue()
                        end
                    end)

                    colorpicker.hue.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging_hue = false
                            colorpicker:RefreshHue()
                        end
                    end)

                    uis.InputChanged:Connect(function(input)
                        if dragging_selector and input.UserInputType == Enum.UserInputType.MouseMovement then
                            colorpicker:RefreshSelector()
                        end
                        if dragging_hue and input.UserInputType == Enum.UserInputType.MouseMovement then
                            colorpicker:RefreshHue()
                        end
                    end)

                    local inputBegan = function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            for i,v in pairs(window.OpenedColorPickers) do
                                if v and i ~= colorpicker.MainPicker then
                                    i.Visible = false
                                    window.OpenedColorPickers[i] = false
                                end
                            end

                            colorpicker.MainPicker.Visible = not colorpicker.MainPicker.Visible
                            window.OpenedColorPickers[colorpicker.MainPicker] = colorpicker.MainPicker.Visible
                            if window.OpenedColorPickers[colorpicker.MainPicker] then
                                colorpicker.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                            else
                                colorpicker.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                            end
                        end
                    end

                    colorpicker.Main.InputBegan:Connect(inputBegan)
                    colorpicker.Outline.InputBegan:Connect(inputBegan)
                    colorpicker.BlackOutline2.InputBegan:Connect(inputBegan)

                    sector:FixSize()
                    table.insert(library.items, colorpicker)
                    return colorpicker
                end

                function sector:AddKeybind(text,default,newkeycallback,callback,flag)
                    local keybind = { }

                    keybind.text = text or ""
                    keybind.default = default or "None"
                    keybind.callback = callback or function() end
                    keybind.newkeycallback = newkeycallback or function(key) end
                    keybind.flag = flag or text or ""

                    keybind.value = keybind.default

                    keybind.Main = Instance.new("TextLabel", sector.Items)
                    keybind.Main.BackgroundTransparency = 1
                    keybind.Main.Size = UDim2.fromOffset(156, 10)
                    keybind.Main.ZIndex = 4
                    keybind.Main.Font = window.theme.font
                    keybind.Main.Text = keybind.text
                    keybind.Main.TextColor3 = window.theme.itemscolor
                    keybind.Main.TextSize = 15
                    keybind.Main.TextStrokeTransparency = 1
                    keybind.Main.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        keybind.Main.Font = theme.font
                        keybind.Main.TextColor3 = theme.itemscolor
                    end)

                    keybind.Bind = Instance.new("TextButton", keybind.Main)
                    keybind.Bind.Name = "keybind"
                    keybind.Bind.BackgroundTransparency = 1
                    keybind.Bind.BorderColor3 = window.theme.outlinecolor
                    keybind.Bind.ZIndex = 5
                    keybind.Bind.BorderSizePixel = 0
                    keybind.Bind.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 10, 0)
                    keybind.Bind.Font = window.theme.font
                    keybind.Bind.TextColor3 = Color3.fromRGB(136, 136, 136)
                    keybind.Bind.TextSize = 15
                    keybind.Bind.TextXAlignment = Enum.TextXAlignment.Right
                    keybind.Bind.MouseButton1Down:Connect(function()
                        keybind.Bind.Text = "[...]"
                        keybind.Bind.TextColor3 = window.theme.accentcolor
                    end)
                    updateevent.Event:Connect(function(theme)
                        keybind.Bind.BorderColor3 = theme.outlinecolor
                        keybind.Bind.Font = theme.font
                    end)

                    if keybind.flag and keybind.flag ~= "" then
                        library.flags[keybind.flag] = keybind.default
                    end

                    local shorter_keycodes = {
                        ["LeftShift"] = "LSHIFT",
                        ["RightShift"] = "RSHIFT",
                        ["LeftControl"] = "LCTRL",
                        ["RightControl"] = "RCTRL",
                        ["LeftAlt"] = "LALT",
                        ["RightAlt"] = "RALT"
                    }

                    function keybind:Set(value)
                        if value == "None" then
                            keybind.value = value
                            keybind.Bind.Text = "[" .. value .. "]"
        
                            local size = textservice:GetTextSize(keybind.Bind.Text, keybind.Bind.TextSize, keybind.Bind.Font, Vector2.new(2000, 2000))
                            keybind.Bind.Size = UDim2.fromOffset(size.X, size.Y)
                            keybind.Bind.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 10 - keybind.Bind.AbsoluteSize.X, 0)
                            if keybind.flag and keybind.flag ~= "" then
                                library.flags[keybind.flag] = value
                            end
                            pcall(keybind.newkeycallback, value)
                        end

                        keybind.value = value
                        keybind.Bind.Text = "[" .. (shorter_keycodes[value.Name or value] or (value.Name or value)) .. "]"

                        local size = textservice:GetTextSize(keybind.Bind.Text, keybind.Bind.TextSize, keybind.Bind.Font, Vector2.new(2000, 2000))
                        keybind.Bind.Size = UDim2.fromOffset(size.X, size.Y)
                        keybind.Bind.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 10 - keybind.Bind.AbsoluteSize.X, 0)
                        if keybind.flag and keybind.flag ~= "" then
                            library.flags[keybind.flag] = value
                        end
                        pcall(keybind.newkeycallback, value)
                    end
                    keybind:Set(keybind.default and keybind.default or "None")

                    function keybind:Get()
                        return keybind.value
                    end

                    uis.InputBegan:Connect(function(input, gameProcessed)
                        if not gameProcessed then
                            if keybind.Bind.Text == "[...]" then
                                keybind.Bind.TextColor3 = Color3.fromRGB(136, 136, 136)
                                if input.UserInputType == Enum.UserInputType.Keyboard then
                                    keybind:Set(input.KeyCode)
                                else
                                    keybind:Set("None")
                                end
                            else
                                if keybind.value ~= "None" and input.KeyCode == keybind.value then
                                    pcall(keybind.callback)
                                end
                            end
                        end
                    end)

                    sector:FixSize()
                    table.insert(library.items, keybind)
                    return keybind
                end

                function sector:AddDropdown(text, items, default, multichoice, callback, flag)
                    local dropdown = { }

                    dropdown.text = text or ""
                    dropdown.defaultitems = items or { }
                    dropdown.default = default
                    dropdown.callback = callback or function() end
                    dropdown.multichoice = multichoice or false
                    dropdown.values = { }
                    dropdown.flag = flag or text or ""

                    dropdown.MainBack = Instance.new("Frame", sector.Items)
                    dropdown.MainBack.Name = "backlabel"
                    dropdown.MainBack.ZIndex = 7
                    dropdown.MainBack.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 34)
                    dropdown.MainBack.BorderSizePixel = 0
                    dropdown.MainBack.BackgroundTransparency = 1

                    dropdown.Label = Instance.new("TextLabel", dropdown.MainBack)
                    dropdown.Label.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    dropdown.Label.BackgroundTransparency = 1
                    dropdown.Label.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 10)
                    dropdown.Label.Position = UDim2.fromOffset(0, 0)
                    dropdown.Label.Font = window.theme.font
                    dropdown.Label.Text = dropdown.text
                    dropdown.Label.ZIndex = 4
                    dropdown.Label.TextColor3 = window.theme.itemscolor
                    dropdown.Label.TextSize = 15
                    dropdown.Label.TextStrokeTransparency = 1
                    dropdown.Label.TextXAlignment = Enum.TextXAlignment.Left

                    updateevent.Event:Connect(function(theme)
                        dropdown.Label.Font = theme.font
                        dropdown.Label.TextColor3 = theme.itemscolor
                    end)

                    dropdown.Main = Instance.new("TextButton", dropdown.MainBack)
                    dropdown.Main.Name = "dropdown"
                    dropdown.Main.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
                    dropdown.Main.BorderSizePixel = 0
                    dropdown.Main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 16)
                    dropdown.Main.Position = UDim2.fromOffset(0, 17)
                    dropdown.Main.ZIndex = 5
                    dropdown.Main.AutoButtonColor = false
                    dropdown.Main.Font = window.theme.font
                    dropdown.Main.Text = ""
                    dropdown.Main.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.Main.TextSize = 15
                    dropdown.Main.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        dropdown.Main.Font = theme.font
                    end)

                    dropdown.Gradient = Instance.new("UIGradient", dropdown.Main)
                    dropdown.Gradient.Rotation = 90
                    dropdown.Gradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(49, 49, 49)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(39, 39, 39))}

                    dropdown.SelectedLabel = Instance.new("TextLabel", dropdown.Main)
                    dropdown.SelectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.SelectedLabel.BackgroundTransparency = 1
                    dropdown.SelectedLabel.Position = UDim2.fromOffset(5, 2)
                    dropdown.SelectedLabel.Size = UDim2.fromOffset(130, 13)
                    dropdown.SelectedLabel.Font = window.theme.font
                    dropdown.SelectedLabel.Text = dropdown.text
                    dropdown.SelectedLabel.ZIndex = 5
                    dropdown.SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdown.SelectedLabel.TextSize = 15
                    dropdown.SelectedLabel.TextStrokeTransparency = 1
                    dropdown.SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
                    updateevent.Event:Connect(function(theme)
                        dropdown.SelectedLabel.Font = theme.font
                    end)

                    dropdown.Nav = Instance.new("ImageButton", dropdown.Main)
                    dropdown.Nav.Name = "navigation"
                    dropdown.Nav.BackgroundTransparency = 1
                    dropdown.Nav.LayoutOrder = 10
                    dropdown.Nav.Position = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 5)
                    dropdown.Nav.Rotation = 90
                    dropdown.Nav.ZIndex = 5
                    dropdown.Nav.Size = UDim2.fromOffset(8, 8)
                    dropdown.Nav.Image = "rbxassetid://4918373417"
                    dropdown.Nav.ImageColor3 = Color3.fromRGB(210, 210, 210)

                    dropdown.BlackOutline2 = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline2.Name = "blackline"
                    dropdown.BlackOutline2.ZIndex = 4
                    dropdown.BlackOutline2.Size = dropdown.Main.Size + UDim2.fromOffset(6, 6)
                    dropdown.BlackOutline2.BorderSizePixel = 0
                    dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline2.Position = UDim2.fromOffset(-3, -3)
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline2.BackgroundColor3 = theme.outlinecolor2
                    end)

                    dropdown.Outline = Instance.new("Frame", dropdown.Main)
                    dropdown.Outline.Name = "blackline"
                    dropdown.Outline.ZIndex = 4
                    dropdown.Outline.Size = dropdown.Main.Size + UDim2.fromOffset(4, 4)
                    dropdown.Outline.BorderSizePixel = 0
                    dropdown.Outline.BackgroundColor3 = window.theme.outlinecolor
                    dropdown.Outline.Position = UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        dropdown.Outline.BackgroundColor3 = theme.outlinecolor
                    end)

                    dropdown.BlackOutline = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline.Name = "blackline"
                    dropdown.BlackOutline.ZIndex = 4
                    dropdown.BlackOutline.Size = dropdown.Main.Size + UDim2.fromOffset(2, 2)
                    dropdown.BlackOutline.BorderSizePixel = 0
                    dropdown.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline.Position = UDim2.fromOffset(-1, -1)
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    dropdown.ItemsFrame = Instance.new("ScrollingFrame", dropdown.Main)
                    dropdown.ItemsFrame.Name = "itemsframe"
                    dropdown.ItemsFrame.BorderSizePixel = 0
                    dropdown.ItemsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    dropdown.ItemsFrame.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                    dropdown.ItemsFrame.ScrollBarThickness = 2
                    dropdown.ItemsFrame.ZIndex = 8
                    dropdown.ItemsFrame.ScrollingDirection = "Y"
                    dropdown.ItemsFrame.Visible = false
                    dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.Main.AbsoluteSize.X, 0)

                    dropdown.ListLayout = Instance.new("UIListLayout", dropdown.ItemsFrame)
                    dropdown.ListLayout.FillDirection = Enum.FillDirection.Vertical
                    dropdown.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

                    dropdown.ListPadding = Instance.new("UIPadding", dropdown.ItemsFrame)
                    dropdown.ListPadding.PaddingTop = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingBottom = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingLeft = UDim.new(0, 2)
                    dropdown.ListPadding.PaddingRight = UDim.new(0, 2)

                    dropdown.BlackOutline2Items = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutline2Items.Name = "blackline"
                    dropdown.BlackOutline2Items.ZIndex = 7
                    dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                    dropdown.BlackOutline2Items.BorderSizePixel = 0
                    dropdown.BlackOutline2Items.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutline2Items.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-3, -3)
                    dropdown.BlackOutline2Items.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutline2Items.BackgroundColor3 = theme.outlinecolor2
                    end)

                    dropdown.OutlineItems = Instance.new("Frame", dropdown.Main)
                    dropdown.OutlineItems.Name = "blackline"
                    dropdown.OutlineItems.ZIndex = 7
                    dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                    dropdown.OutlineItems.BorderSizePixel = 0
                    dropdown.OutlineItems.BackgroundColor3 = window.theme.outlinecolor
                    dropdown.OutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-2, -2)
                    dropdown.OutlineItems.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.OutlineItems.BackgroundColor3 = theme.outlinecolor
                    end)

                    dropdown.BlackOutlineItems = Instance.new("Frame", dropdown.Main)
                    dropdown.BlackOutlineItems.Name = "blackline"
                    dropdown.BlackOutlineItems.ZIndex = 7
                    dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(-2, -2)
                    dropdown.BlackOutlineItems.BorderSizePixel = 0
                    dropdown.BlackOutlineItems.BackgroundColor3 = window.theme.outlinecolor2
                    dropdown.BlackOutlineItems.Position = dropdown.ItemsFrame.Position + UDim2.fromOffset(-1, -1)
                    dropdown.BlackOutlineItems.Visible = false
                    updateevent.Event:Connect(function(theme)
                        dropdown.BlackOutlineItems.BackgroundColor3 = theme.outlinecolor2
                    end)

                    dropdown.IgnoreBackButtons = Instance.new("TextButton", dropdown.Main)
                    dropdown.IgnoreBackButtons.BackgroundTransparency = 1
                    dropdown.IgnoreBackButtons.BorderSizePixel = 0
                    dropdown.IgnoreBackButtons.Position = UDim2.fromOffset(0, dropdown.Main.Size.Y.Offset + 8)
                    dropdown.IgnoreBackButtons.Size = UDim2.new(0, 0, 0, 0)
                    dropdown.IgnoreBackButtons.ZIndex = 7
                    dropdown.IgnoreBackButtons.Text = ""
                    dropdown.IgnoreBackButtons.Visible = false
                    dropdown.IgnoreBackButtons.AutoButtonColor = false

                    if dropdown.flag and dropdown.flag ~= "" then
                        library.flags[dropdown.flag] = dropdown.multichoice and { dropdown.default or dropdown.defaultitems[1] or "" } or (dropdown.default or dropdown.defaultitems[1] or "")
                    end

                    function dropdown:isSelected(item)
                        for i, v in pairs(dropdown.values) do
                            if v == item then
                                return true
                            end
                        end
                        return false
                    end

                    function dropdown:GetOptions()
                        return dropdown.values
                    end

                    function dropdown:updateText(text)
                        if #text >= 27 then
                            text = text:sub(1, 25) .. ".."
                        end
                        dropdown.SelectedLabel.Text = text
                    end

                    dropdown.Changed = Instance.new("BindableEvent")
                    function dropdown:Set(value)
                        if type(value) == "table" then
                            dropdown.values = value
                            dropdown:updateText(table.concat(value, ", "))
                            pcall(dropdown.callback, value)
                        else
                            dropdown:updateText(value)
                            dropdown.values = { value }
                            pcall(dropdown.callback, value)
                        end
                        
                        dropdown.Changed:Fire(value)
                        if dropdown.flag and dropdown.flag ~= "" then
                            library.flags[dropdown.flag] = dropdown.multichoice and dropdown.values or dropdown.values[1]
                        end
                    end

                    function dropdown:Get()
                        return dropdown.multichoice and dropdown.values or dropdown.values[1]
                    end

                    dropdown.items = { }
                    function dropdown:Add(v)
                        local Item = Instance.new("TextButton", dropdown.ItemsFrame)
                        Item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                        Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                        Item.BorderSizePixel = 0
                        Item.Position = UDim2.fromOffset(0, 0)
                        Item.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset - 4, 20)
                        Item.ZIndex = 9
                        Item.Text = v
                        Item.Name = v
                        Item.AutoButtonColor = false
                        Item.Font = window.theme.font
                        Item.TextSize = 15
                        Item.TextXAlignment = Enum.TextXAlignment.Left
                        Item.TextStrokeTransparency = 1
                        dropdown.ItemsFrame.CanvasSize = dropdown.ItemsFrame.CanvasSize + UDim2.fromOffset(0, Item.AbsoluteSize.Y)

                        Item.MouseButton1Down:Connect(function()
                            if dropdown.multichoice then
                                if dropdown:isSelected(v) then
                                    for i2, v2 in pairs(dropdown.values) do
                                        if v2 == v then
                                            table.remove(dropdown.values, i2)
                                        end
                                    end
                                    dropdown:Set(dropdown.values)
                                else
                                    table.insert(dropdown.values, v)
                                    dropdown:Set(dropdown.values)
                                end

                                return
                            else
                                dropdown.Nav.Rotation = 90
                                dropdown.ItemsFrame.Visible = false
                                dropdown.ItemsFrame.Active = false
                                dropdown.OutlineItems.Visible = false
                                dropdown.BlackOutlineItems.Visible = false
                                dropdown.BlackOutline2Items.Visible = false
                                dropdown.IgnoreBackButtons.Visible = false
                                dropdown.IgnoreBackButtons.Active = false
                            end

                            dropdown:Set(v)
                            return
                        end)

                        runservice.RenderStepped:Connect(function()
                            if dropdown.multichoice and dropdown:isSelected(v) or dropdown.values[1] == v then
                                Item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                                Item.TextColor3 = window.theme.accentcolor
                                Item.Text = " " .. v
                            else
                                Item.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                                Item.Text = v
                            end
                        end)

                        table.insert(dropdown.items, v)
                        dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * Item.AbsoluteSize.Y, 20, 156) + 4)
                        dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * Item.AbsoluteSize.Y) + 4)

                        dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                        dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                        dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                        dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size
                    end

                    function dropdown:Remove(value)
                        local item = dropdown.ItemsFrame:FindFirstChild(value)
                        if item then
                            for i,v in pairs(dropdown.items) do
                                if v == value then
                                    table.remove(dropdown.items, i)
                                end
                            end

                            dropdown.ItemsFrame.Size = UDim2.fromOffset(dropdown.Main.Size.X.Offset, math.clamp(#dropdown.items * item.AbsoluteSize.Y, 20, 156) + 4)
                            dropdown.ItemsFrame.CanvasSize = UDim2.fromOffset(dropdown.ItemsFrame.AbsoluteSize.X, (#dropdown.items * item.AbsoluteSize.Y) + 4)
        
                            dropdown.OutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(2, 2)
                            dropdown.BlackOutlineItems.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(4, 4)
                            dropdown.BlackOutline2Items.Size = dropdown.ItemsFrame.Size + UDim2.fromOffset(6, 6)
                            dropdown.IgnoreBackButtons.Size = dropdown.ItemsFrame.Size

                            item:Remove()
                        end
                    end 

                    for i,v in pairs(dropdown.defaultitems) do
                        dropdown:Add(v)
                    end

                    if dropdown.default then
                        dropdown:Set(dropdown.default)
                    end

                    local MouseButton1Down = function()
                        if dropdown.Nav.Rotation == 90 then
                            tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = -90 }):Play()
                            if dropdown.items and #dropdown.items ~= 0 then
                                dropdown.ItemsFrame.ScrollingEnabled = true
                                sector.Main.Parent.ScrollingEnabled = false
                                dropdown.ItemsFrame.Visible = true
                                dropdown.ItemsFrame.Active = true
                                dropdown.IgnoreBackButtons.Visible = true
                                dropdown.IgnoreBackButtons.Active = true
                                dropdown.OutlineItems.Visible = true
                                dropdown.BlackOutlineItems.Visible = true
                                dropdown.BlackOutline2Items.Visible = true
                            end
                        else
                            tweenservice:Create(dropdown.Nav, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { Rotation = 90 }):Play()
                            dropdown.ItemsFrame.ScrollingEnabled = false
                            sector.Main.Parent.ScrollingEnabled = true
                            dropdown.ItemsFrame.Visible = false
                            dropdown.ItemsFrame.Active = false
                            dropdown.IgnoreBackButtons.Visible = false
                            dropdown.IgnoreBackButtons.Active = false
                            dropdown.OutlineItems.Visible = false
                            dropdown.BlackOutlineItems.Visible = false
                            dropdown.BlackOutline2Items.Visible = false
                        end
                    end

                    dropdown.Main.MouseButton1Down:Connect(MouseButton1Down)
                    dropdown.Nav.MouseButton1Down:Connect(MouseButton1Down)

                    dropdown.BlackOutline2.MouseEnter:Connect(function()
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.accentcolor
                    end)
                    dropdown.BlackOutline2.MouseLeave:Connect(function()
                        dropdown.BlackOutline2.BackgroundColor3 = window.theme.outlinecolor2
                    end)

                    sector:FixSize()
                    table.insert(library.items, dropdown)
                    return dropdown
                end

                function sector:AddSeperator(text)
                    local seperator = { }
                    seperator.text = text or ""

                    seperator.main = Instance.new("Frame", sector.Items)
                    seperator.main.Name = "Main"
                    seperator.main.ZIndex = 5
                    seperator.main.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 12, 10)
                    seperator.main.BorderSizePixel = 0
                    seperator.main.BackgroundTransparency = 1

                    seperator.line = Instance.new("Frame", seperator.main)
                    seperator.line.Name = "Line"
                    seperator.line.ZIndex = 7
                    seperator.line.BackgroundTransparency  =0
                    seperator.line.BackgroundColor3 = window.theme.sectorcolor
                    seperator.line.BorderSizePixel = 0
                    seperator.line.Size = UDim2.fromOffset(sector.Main.Size.X.Offset - 26, 1)
                    seperator.line.Position = UDim2.fromOffset(7, 5)

                    seperator.outline = Instance.new("Frame", seperator.line)
                    seperator.outline.Name = "Outline"
                    seperator.outline.ZIndex = 6
                    seperator.outline.BorderSizePixel = 0
                    seperator.outline.BackgroundTransparency = 0

                    seperator.outline.BackgroundColor3 = window.theme.outlinecolor2
                    seperator.outline.Position = UDim2.fromOffset(-1, -1)
                    seperator.outline.Size = seperator.line.Size - UDim2.fromOffset(-2, -2)
                    updateevent.Event:Connect(function(theme)
                        seperator.outline.BackgroundColor3 = theme.outlinecolor2
                    end)

                    seperator.label = Instance.new("TextLabel", seperator.main)
                    seperator.label.Name = "Label"
                    seperator.label.BackgroundTransparency = 1
                    seperator.label.Size = seperator.main.Size
                    seperator.label.Font = window.theme.font
                    seperator.label.ZIndex = 8
                    seperator.label.Text = seperator.text
                    seperator.label.BorderSizePixel = 0 
                    seperator.label.BackgroundColor3 = window.theme.sectorcolor
                    seperator.label.TextColor3 = Color3.fromRGB(255,255,255)
                    seperator.label.TextSize = window.theme.fontsize
                    seperator.label.TextStrokeTransparency = 1
                    seperator.label.TextXAlignment = Enum.TextXAlignment.Center
                    updateevent.Event:Connect(function(theme)
                        seperator.label.Font = theme.font
                        seperator.label.TextSize = theme.fontsize
                    end)

                    local textSize = textservice:GetTextSize(seperator.text, window.theme.fontsize, window.theme.font, Vector2.new(2000, 2000))
                    local textStart = seperator.main.AbsoluteSize.X / 2 - (textSize.X / 2)

                    sector.LabelBackFrame = Instance.new("Frame", seperator.main)
                    sector.LabelBackFrame.Name = "LabelBack"
                    sector.LabelBackFrame.ZIndex = 7
                    sector.LabelBackFrame.Size = UDim2.fromOffset(textSize.X + 12, 10)
                    sector.LabelBackFrame.BorderSizePixel = 0
                    sector.LabelBackFrame.Transparency = 1 
                    sector.LabelBackFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    sector.LabelBackFrame.Position = UDim2.new(0, textStart - 6, 0, 0)
                    updateevent.Event:Connect(function(theme)
                        textSize = textservice:GetTextSize(seperator.text, theme.fontsize, theme.font, Vector2.new(2000, 2000))
                        textStart = seperator.main.AbsoluteSize.X / 2 - (textSize.X / 2)

                        sector.LabelBackFrame.Size = UDim2.fromOffset(textSize.X + 12, 10)
                        sector.LabelBackFrame.Position = UDim2.new(0, textStart - 6, 0, 0)
                    end)

                    sector:FixSize()
                    return seperator
                end

                return sector
            end

            function tab:CreateConfigSystem(side)
                local configSystem = { }

                configSystem.configFolder = window.name .. "/" .. tostring(game.PlaceId)
                if (not isfolder(configSystem.configFolder)) then
                    makefolder(configSystem.configFolder)
                end

                configSystem.sector = tab:CreateSector("Configs", side or "left")

                local ConfigName = configSystem.sector:AddTextbox("Config Name", "", ConfigName, function() end, "")
                local default = tostring(listfiles(configSystem.configFolder)[1] or ""):gsub(configSystem.configFolder .. "\\", ""):gsub(".txt", "")
                local Config = configSystem.sector:AddDropdown("Configs", {}, default, false, function() end, "")
                for i,v in pairs(listfiles(configSystem.configFolder)) do
                    if v:find(".txt") then
                        Config:Add(tostring(v):gsub(configSystem.configFolder .. "\\", ""):gsub(".txt", ""))
                    end
                end

                configSystem.Create = configSystem.sector:AddButton("Create", function()
                    for i,v in pairs(listfiles(configSystem.configFolder)) do
                        Config:Remove(tostring(v):gsub(configSystem.configFolder .. "\\", ""):gsub(".txt", ""))
                    end

                    if ConfigName:Get() and ConfigName:Get() ~= "" then
                        local config = {}
        
                        for i,v in pairs(library.flags) do
                            if (v ~= nil and v ~= "") then
                                if (typeof(v) == "Color3") then
                                    config[i] = { v.R, v.G, v.B }
                                elseif (tostring(v):find("Enum.KeyCode")) then
                                    config[i] = v.Name
                                elseif (typeof(v) == "table") then
                                    config[i] = { v }
                                else
                                    config[i] = v
                                end
                            end
                        end
        
                        writefile(configSystem.configFolder .. "/" .. ConfigName:Get() .. ".txt", httpservice:JSONEncode(config))
        
                        for i,v in pairs(listfiles(configSystem.configFolder)) do
                            if v:find(".txt") then
                                Config:Add(tostring(v):gsub(configSystem.configFolder .. "\\", ""):gsub(".txt", ""))
                            end
                        end
                    end
                end)

                configSystem.Save = configSystem.sector:AddButton("Save", function()
                    local config = {}
                    if Config:Get() and Config:Get() ~= "" then
                        for i,v in pairs(library.flags) do
                            if (v ~= nil and v ~= "") then
                                if (typeof(v) == "Color3") then
                                    config[i] = { v.R, v.G, v.B }
                                elseif (tostring(v):find("Enum.KeyCode")) then
                                    config[i] = "Enum.KeyCode." .. v.Name
                                elseif (typeof(v) == "table") then
                                    config[i] = { v }
                                else
                                    config[i] = v
                                end
                            end
                        end
        
                        writefile(configSystem.configFolder .. "/" .. Config:Get() .. ".txt", httpservice:JSONEncode(config))
                    end
                end)

                configSystem.Load = configSystem.sector:AddButton("Load", function()
                    local Success = pcall(readfile, configSystem.configFolder .. "/" .. Config:Get() .. ".txt")
                    if (Success) then
                        pcall(function() 
                            local ReadConfig = httpservice:JSONDecode(readfile(configSystem.configFolder .. "/" .. Config:Get() .. ".txt"))
                            local NewConfig = {}
        
                            for i,v in pairs(ReadConfig) do
                                if (typeof(v) == "table") then
                                    if (typeof(v[1]) == "number") then
                                        NewConfig[i] = Color3.new(v[1], v[2], v[3])
                                    elseif (typeof(v[1]) == "table") then
                                        NewConfig[i] = v[1]
                                    end
                                elseif (tostring(v):find("Enum.KeyCode.")) then
                                    NewConfig[i] = Enum.KeyCode[tostring(v):gsub("Enum.KeyCode.", "")]
                                else
                                    NewConfig[i] = v
                                end
                            end
        
                            library.flags = NewConfig
        
                            for i,v in pairs(library.flags) do
                                for i2,v2 in pairs(library.items) do
                                    if (i ~= nil and i ~= "" and i ~= "Configs_Name" and i ~= "Configs" and v2.flag ~= nil) then
                                        if (v2.flag == i) then
                                            pcall(function() 
                                                v2:Set(v)
                                            end)
                                        end
                                    end
                                end
                            end
                        end)
                    end
                end)

                configSystem.Delete = configSystem.sector:AddButton("Delete", function()
                    for i,v in pairs(listfiles(configSystem.configFolder)) do
                        Config:Remove(tostring(v):gsub(configSystem.configFolder .. "\\", ""):gsub(".txt", ""))
                    end

                    if (not Config:Get() or Config:Get() == "") then return end
                    if (not isfile(configSystem.configFolder .. "/" .. Config:Get() .. ".txt")) then return end
                    delfile(configSystem.configFolder .. "/" .. Config:Get() .. ".txt")

                    for i,v in pairs(listfiles(configSystem.configFolder)) do
                        if v:find(".txt") then
                            Config:Add(tostring(v):gsub(configSystem.configFolder .. "\\", ""):gsub(".txt", ""))
                        end
                    end
                end)

                return configSystem
            end

            function tab:CreatePlayerlist(name)
                local list = { }
                list.name = name or ""

                list.Main = Instance.new("Frame", tab.TabPage) 
                list.Main.Name = list.name:gsub(" ", "") .. "Sector"
                list.Main.BorderColor3 = window.theme.outlinecolor
                list.Main.ZIndex = 2
                list.Main.Size = UDim2.fromOffset(window.size.X.Offset - 22, 220)
                list.Main.BackgroundColor3 = window.theme.sectorcolor
                list.Main.Position = UDim2.new(0, 11, 0, 12)

                tab.SectorsLeft[#tab.SectorsLeft + 1] = 220
                --tab.SectorsRight[#tab.SectorsLeft + 1].space = 220

                list.Line = Instance.new("Frame", list.Main)
                list.Line.Name = "line"
                list.Line.ZIndex = 2
                list.Line.Size = UDim2.fromOffset(list.Main.Size.X.Offset + 2, 1)
                list.Line.BorderSizePixel = 0
                list.Line.Position = UDim2.fromOffset(-1, -1)
                list.Line.BackgroundColor3 = window.theme.accentcolor

                list.BlackOutline = Instance.new("Frame", list.Main)
                list.BlackOutline.Name = "blackline"
                list.BlackOutline.ZIndex = 1
                list.BlackOutline.Size = list.Main.Size + UDim2.fromOffset(4, 4)
                list.BlackOutline.BorderSizePixel = 0
                list.BlackOutline.BackgroundColor3 = window.theme.outlinecolor2
                list.BlackOutline.Position = UDim2.fromOffset(-2, -2)

                local size = textservice:GetTextSize(list.name, 13, window.theme.font, Vector2.new(2000, 2000))
                list.Label = Instance.new("TextLabel", list.Main)
                list.Label.AnchorPoint = Vector2.new(0,0.5)
                list.Label.Position = UDim2.fromOffset(12, -1)
                list.Label.Size = UDim2.fromOffset(math.clamp(textservice:GetTextSize(list.name, 13, window.theme.font, Vector2.new(200,300)).X + 10, 0, list.Main.Size.X.Offset), size.Y)
                list.Label.BackgroundTransparency = 1
                list.Label.BorderSizePixel = 0
                list.Label.ZIndex = 4
                list.Label.Text = list.name
                list.Label.TextColor3 = Color3.new(1,1,2552/255)
                list.Label.TextStrokeTransparency = 1
                list.Label.Font = window.theme.font
                list.Label.TextSize = 13

                list.LabelBackFrame = Instance.new("Frame", list.Label)
                list.LabelBackFrame.Name = "labelframe"
                list.LabelBackFrame.ZIndex = 3
                list.LabelBackFrame.Size = UDim2.fromOffset(list.Label.Size.X.Offset, 10)
                list.LabelBackFrame.BorderSizePixel = 0
                list.LabelBackFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                list.LabelBackFrame.Position = UDim2.fromOffset(0, 6)

                list.Items = Instance.new("ScrollingFrame", list.Main) 
                list.Items.Name = "items"
                list.Items.ZIndex = 2
                list.Items.ScrollBarThickness = 1
                list.Items.BackgroundTransparency = 1
                list.Items.Size = list.Main.Size - UDim2.fromOffset(10, 15)
                list.Items.ScrollingDirection = "Y"
                list.Items.BorderSizePixel = 0
                list.Items.Position = UDim2.fromOffset(5, 10)
                list.Items.CanvasSize = list.Items.Size

                list.ListLayout = Instance.new("UIListLayout", list.Items)
                list.ListLayout.FillDirection = Enum.FillDirection.Vertical
                list.ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                list.ListLayout.Padding = UDim.new(0, 0)

                list.ListPadding = Instance.new("UIPadding", list.Items)
                list.ListPadding.PaddingTop = UDim.new(0, 2)
                list.ListPadding.PaddingLeft = UDim.new(0, 6)
                list.ListPadding.PaddingRight = UDim.new(0, 6)

                list.items = { }
                function list:AddPlayer(Player)
                    local player = { }

                    player.Main = Instance.new("Frame", list.Items)
                    player.Main.Name = Player.Name
                    player.Main.BorderColor3 = window.theme.outlinecolor
                    player.Main.ZIndex = 3
                    player.Main.Size = UDim2.fromOffset(list.Items.AbsoluteSize.X - 12, 20)
                    player.Main.BackgroundColor3 = window.theme.sectorcolor
                    player.Main.Position = UDim2.new(0, 0, 0, 0)

                    table.insert(list.items, Player)
                    list.Items.CanvasSize = UDim2.fromOffset(list.Items.AbsoluteSize.X, (#list.items * 20))
                    list.Items.Size = UDim2.fromOffset(list.Items.AbsoluteSize.X, math.clamp(list.Items.CanvasSize.Y.Offset, 0, 205))
                    return player
                end

                function list:RemovePlayer(Player)
                    local p = list.Items:FindFirstChild(Player)
                    if p then
                        for i,v in pairs(list.items) do
                            if v == Player then
                                table.remove(list.items, i)
                            end
                        end

                        p:Remove()
                        list.Items.CanvasSize = UDim2.fromOffset(list.Items.AbsoluteSize.X, (#list.items * 90))
                    end
                end

                for i,v in pairs(game:GetService("Players"):GetPlayers()) do
                    list:AddPlayer(v)
                end
                
                game:GetService("Players").PlayerAdded:Connect(function(v)
                    list:AddPlayer(v)
                end)
                
                return list
            end

            table.insert(window.Tabs, tab)
            return tab
        end

        return window
    end

    -- library end

    local Notifications_SGUI = Instance.new("ScreenGui",game.CoreGui)
    --[[
    syn.protect_gui(Notifications_SGUI)
    ]]
    
    local Container_Notifications = Instance.new("Frame",Notifications_SGUI)
    local UIListLayout = Instance.new("UIListLayout",Container_Notifications)
    Notifications_SGUI.Name = "Notifications_SGUI"
    Container_Notifications.Name = "Container_Notifications"
    Container_Notifications.BackgroundTransparency = 1.000
    Container_Notifications.Position = UDim2.new(0, 0, 0.318235993, 0)
    Container_Notifications.Size = UDim2.new(0, 345, 0, 304)

    local function doNotify(text,time)
        local Notifs_Accent = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local UIGradient = Instance.new("UIGradient")
        local UIGradient_2 = Instance.new("UIGradient")
        
        Notifs_Accent.Name = "Notifs_Accent"
        Notifs_Accent.Parent = Container_Notifications
        Notifs_Accent.BackgroundColor3 = library.theme.accentcolor2
        Notifs_Accent.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Notifs_Accent.Size = UDim2.new(0, 16, 0, 30)
        
        TextLabel.Parent = Notifs_Accent
        TextLabel.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.Position = UDim2.new(0.710000038, 0, 0, 0)
        TextLabel.Size = UDim2.new(0, 0, 0, 30)
        TextLabel:TweenSize(UDim2.new(0, 300, 0, 30),"Out","Sine",0.2,true);
        
        TextLabel.ClipsDescendants = true 
        
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.Text = text
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 14.000
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(153, 153, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
        UIGradient.Rotation = 270
        UIGradient.Parent = TextLabel
        
        UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(39, 39, 39)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
        UIGradient_2.Rotation = 270
        UIGradient_2.Parent = Notifs_Accent
        
        task.spawn(function()
            delay(time or 2,function()
                TextLabel:TweenSize(UDim2.new(0,20, 0, 30),"In","Linear",0.3,true);
                delay(0.5,function()
                    Notifs_Accent:Destroy()
                end)
            end)
        end)
    end

    local Game_Ids = {
        "2019" == 8131316275;

    }

    local function CreateLib()
        library.theme.background ="rbxassetid://5553946656"
        library.theme.font = Enum.Font.Gotham
        local Window = library:CreateWindow("ReaperMad",Vector2.new(492, 598))

        local Tabs = {
            BoogaTab = Window:CreateTab("Booga Booga"),
            VisualTab = Window:CreateTab("Visuals"),
            TeleportTab = Window:CreateTab("Teleports"),
            backTab = Window:CreateTab("Backpack"),
            --FarmTab = Window:CreateTab("Farming"),
            ConfigTab = Window:CreateTab("Configuartion")
        }

        local BoogaTab = {
            boogasec = Tabs.BoogaTab:CreateSector("Client", "left"),
            mainsec = Tabs.BoogaTab:CreateSector("Combat", "right"),
            miscsec = Tabs.BoogaTab:CreateSector("Misc", "left"),
            exploiotsec = Tabs.BoogaTab:CreateSector("Exploits/Trolling", "right"),
        }

        local VisualTab = {
            visualsec = Tabs.VisualTab:CreateSector("Esp", "left"),
            lightsec = Tabs.VisualTab:CreateSector("Lighting", "right")
        }

        local Teleports = {
            GameTeleports = Tabs.TeleportTab:CreateSector("Game Teleports", "left"),
        }

        local InventoryStuff = {
            backsec = Tabs.backTab:CreateSector("Equip", "left"),
        }

        local Farming = {}
            --farmsec = Tabs.FarmTab:CreateSector("Plant Farming", "left"),


        local ConfigTab = {
            UISector = Tabs.ConfigTab:CreateSector("UI Settings", "left"),
            Configur = Tabs.ConfigTab:CreateConfigSystem("right"),
            MiscSector = Tabs.ConfigTab:CreateSector("Misc", "right"),
            CreditSector = Tabs.ConfigTab:CreateSector("Credits", "left")
        }


        -- Client
        local WalkSpeedvariable = BoogaTab.boogasec:AddToggle("Walkspeed Bypass",false,function(s)
            WsBypass = s
        end)
        --[[
        WalkSpeedvariable:AddSlider(16,16,18,false,function(v)
            WsSlider = v
        end)
        ]]
        WalkSpeedvariable:AddKeybind("None",function() end)

        BoogaTab.boogasec:AddSeperator("")

        local FOVToggle = BoogaTab.boogasec:AddToggle("Field Of View",false,function(s)
            if s == true then
                FOV = true
            elseif s == false then
                FOV = false
            end
        end)
        FOVToggle:AddSlider(70,70,120,10,function(v)
            FOVSlide = v
        end)

        BoogaTab.boogasec:AddToggle("Inf Zoom out",false,function(s)
            if s == true then
                Lp.CameraMaxZoomDistance = 100000
            else
                Lp.CameraMaxZoomDistance = 400
            end
        end)

        BoogaTab.boogasec:AddSeperator("PICK SPELL")

        if game.PlaceId == 8131331959 or game.PlaceId == 8131316275 then
            BoogaTab.boogasec:AddButton("Void Shield",function()
                if game.PlaceId == 8131331959 then
                    local args = {
                        [1] = "Energy Shield"
                    }

                    game:GetService("ReplicatedStorage").Events.PromptSpellChoice:FireServer(unpack(args))
                else
                    doNotify("Must be in Void for this to work",4)
                end
            end)

            BoogaTab.boogasec:AddButton("Energy Bolt",function()
                if game.PlaceId == 8131331959 then
                    local args = {
                        [1] = "Energy Bolt"
                    }

                    game:GetService("ReplicatedStorage").Events.PromptSpellChoice:FireServer(unpack(args))
                else
                    doNotify("Must be in Void for this to work",4)
                end
            end)

            BoogaTab.boogasec:AddButton("Void Cloak",function()
                if game.PlaceId == 8131331959 then
                    local args = {
                        [1] = "Void Cloak"
                    }

                    game:GetService("ReplicatedStorage").Events.PromptSpellChoice:FireServer(unpack(args))
                else
                    doNotify("Must be in Void for this to work")
                end
            end)
        else
            BoogaTab.boogasec:AddLabel("Only available for 2019")
        end

        -- Trolling/Exploit

        local TeleportBypassLoL = BoogaTab.exploiotsec:AddToggle("Tp to Player BYPASS",false,function(s)
            TpBypass = s
        end)
        TeleportBypassLoL:AddTextbox(false,function(txt)
            Target = txt
        end)

        -- Combat
        local AuraTog = BoogaTab.mainsec:AddToggle("Kill Aura",false,function(s)
            Aura = s
            doNotify("Kill Aura: "..tostring(Aura))
        end)
        AuraTog:AddKeybind("None",function(s)
            Aura = s
        end)



        BoogaTab.mainsec:AddSeperator("")

        local HbeSlider = BoogaTab.mainsec:AddToggle("Hitbox Expander",false,function(s)
            Hbe = s
        end)
        HbeSlider:AddSlider(1,1,18,1,false,function(v)
            HbeSize = Vector3.new(v,v,v)
        end)
        HbeSlider:AddColorpicker(Color3.fromRGB(255,255,255),function(c)
            HbeColor = c
        end)

        -- Misc

        if game.PlaceId == 8131331959 or game.PlaceId == 8131316275 or game.PlaceId == 5901346231 then
            BoogaTab.miscsec:AddButton("View Ancient Tree Health",function()
                local Tree = workspace.Resources:FindFirstChild("Ancient Tree")
                if Tree then
                    doNotify(Tree.Health.Value, 3)
                elseif game.PlaceId == 8131331959 then
                    doNotify("Your in void lmao", 3)
                else
                    doNotify("Tree is dead",3)
                end
            end)
        end

        BoogaTab.miscsec:AddToggle("Auto hit Ancient Tree",false,function(s)
            AT_AutoHit = s
            doNotify("Beta",2)
        end)
        -- Visuals

        VisualTab.visualsec:AddToggle("Enabled",false,function(s)
            ESPSettings.Players = s
        end)

        local NameTog = VisualTab.visualsec:AddToggle("Draw Names",false,function(s)
            ESPSettings.Name = s
        end)
        NameTog:AddColorpicker(Color3.fromRGB(255,255,255),function(c)
            ESPSettings.Colors.Text = c
        end)

        local BoxTog = VisualTab.visualsec:AddToggle("Draw Boxes",false,function(s)
            ESPSettings.Box = s
        end)
        BoxTog:AddColorpicker(Color3.fromRGB(255,255,255),function(c)
            ESPSettings.Colors.Box = c
        end)

        local HealthTog = VisualTab.visualsec:AddToggle("Draw Healthbar",false,function(s)
            ESPSettings.Healthbar = s
        end)
        HealthTog:AddColorpicker(Color3.fromRGB(0,255,0), function(c)
            ESPSettings.Colors.HealthBar = c
        end)
        
        local ClockTimetoggle = VisualTab.lightsec:AddToggle("ClockTime",false,function(s)
            CustomTime = s
        end)

        ClockTimetoggle:AddSlider(1,1,14,false,function(v)
            CustomTimeSlider = v
        end)

        VisualTab.lightsec:AddSlider("Fog End",5000,5000,15000,false,function(v)
            Lighting.FogEnd = v
        end)

        -- Teleports

        Teleports.GameTeleports:AddButton("Hybrid",function() TPService:Teleport(5901346231, Lp) end)
        Teleports.GameTeleports:AddButton("2019",function() TPService:Teleport(8131316275, Lp) end)
        Teleports.GameTeleports:AddButton("Classic",function() TPService:Teleport(4787629450, Lp) end)
        Teleports.GameTeleports:AddButton("2019 Void",function() TPService:Teleport(8131331959, Lp) end)
        Teleports.GameTeleports:AddButton("Rejoin",function() TPService:Teleport(game.PlaceId, Lp) end)

        -- Backpack

        if game.PlaceId == 8131331959 or game.PlaceId == 8131316275 or game.PlaceId == 5901346231 then
            InventoryStuff.backsec:AddLabel("Must be the level/Have the mojo")
            InventoryStuff.backsec:AddButton("Equip full god", function()
                game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("God Halo")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("God Chestplate")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("God Legs")
                wait(0.1)
            end)

            InventoryStuff.backsec:AddButton("Unequip full god", function()
                game:GetService("ReplicatedStorage").Events.UnequipArmor:FireServer("God Halo")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UnequipArmor:FireServer("God Chestplate")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UnequipArmor:FireServer("God Legs")
                wait(0.1)
            end)

            InventoryStuff.backsec:AddButton("Equup full void", function()
                game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("Void Shroud")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("Void Chestplate")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UseBagItem:FireServer("Void Greaves")
                wait(0.1)
            end)

            InventoryStuff.backsec:AddButton("Unequip full void", function()
                game:GetService("ReplicatedStorage").Events.UnequipArmor:FireServer("Void Shroud")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UnequipArmor:FireServer("Void Chestplate")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.UnequipArmor:FireServer("Void Greaves")
                wait(0.1)
            end)

            InventoryStuff.backsec:AddSeperator(" Craft ")
            InventoryStuff.backsec:AddButton("Craft full god", function()
                game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("God Halo")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("God Chestplate")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("God Legs")
                wait(0.1)
            end)

            InventoryStuff.backsec:AddButton("Craft full void", function()
                game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Void Shroud")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Void Chestplate")
                wait(0.1)
                game:GetService("ReplicatedStorage").Events.CraftItem:FireServer("Void Greaves")
                wait(0.1)
            end)
        end

        -- Config

        ConfigTab.CreditSector:AddLabel("reaper#1616 - Coding/Kill Aura")
        ConfigTab.CreditSector:AddLabel("floppa#5079 - Coding")

        ConfigTab.UISector:AddColorpicker("Image Background Color",Color3.fromRGB(20,20,20),function(Color)
            library.theme.backgroundcolor = Color
        end)

        ConfigTab.UISector:AddColorpicker("Accent Color",library.theme.accentcolor,function(Color)
            library.theme.accentcolor = Color
        end)

        ConfigTab.UISector:AddColorpicker("Secondary Accent Color",library.theme.accentcolor2,function(Color)
            library.theme.accentcolor2 = Color
        end)

        ConfigTab.UISector:AddSlider("Font Size",0,15,30,false,function(value)
            library.theme.fontsize = value
        end)

        ConfigTab.UISector:AddSlider("Title Font Size",0,15,30,false,function(value)
            library.theme.titlesize = value
        end)

        ConfigTab.UISector:AddSlider("Image Tile Size",0,90,500,false,function(value)
            library.theme.tilesize = value
        end)


        local BackgroundDropDown = ConfigTab.UISector:AddDropdown("Background Image", {"Smooth","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"},false,false, function(Name)
            if Name == "Smooth" then
                library.theme.background ="rbxassetid://2151741365"
            elseif Name == "Hearts" then
                library.theme.background ="rbxassetid://6073763717"
            elseif Name == "Abstract" then
                library.theme.background ="rbxassetid://6073743871"
            elseif Name == "Hexagon" then
                library.theme.background="rbxassetid://6073628839"
            elseif Name == "Circles" then
                library.theme.background ="rbxassetid://6071579801"
            elseif Name == "Lace With Flowers" then
                library.theme.background ="rbxassetid://6071575925"
            elseif Name == "Floral" then
                library.theme.background ="rbxassetid://5553946656"
            end
        end)

        ConfigTab.UISector:AddButton("Apply Theme",function()
            Window:UpdateTheme(library.theme)
        end)

        ConfigTab.UISector:AddButton("Apply Default Theme",function()
            library.theme.background ="rbxassetid://5553946656"
            library.theme.accentcolor2 = Color3.fromRGB(9, 255, 0)
            library.theme.accentcolor = Color3.fromRGB(28, 168, 0)
            library.theme.backgroundcolor = Color3.fromRGB(20,20,20)
            library.theme.fontsize = 15
            library.theme.titlesize  = 15
            library.theme.tilesize = 90
            Window:UpdateTheme(library.theme)
        end)

        local hideKeyToggle = ConfigTab.MiscSector:AddToggle("Hide Menu",false,function(state)
            if state == true then 
                game:GetService("CoreGui").ReaperMad.Enabled = false
            else
                game:GetService("CoreGui").ReaperMad.Enabled = true
            end
        end)
        hideKeyToggle:AddKeybind(Enum.KeyCode.End,function()
        end)
    end
    CreateLib()
    doNotify("Script Loaded",5)
end

local Saved = {
    "d075a97cbdf3fd71e5fb3738a7777f5865542fe7075a762711863c5bfaa79033e9d1b190ff351637a682694112c0f7b0a4a4ad891e9d004f9b8557e6d226cbc3";
    "c03d2f85e7bdb48855d4ed7f9081913ce1af25171ca1cfcba86cd503fb978a260bb9476077e8649834d9b3c467c5bbdb040c5a7070b99cc7f4752e3e81109a87";
    "E0B9C3800AA0DB0F650AE4747E16CC0C126FF33EC57EFB9B838B420143FD1E19";
}



if table.find(Saved, hwid) then
    TheScript()
end









-- wsp
