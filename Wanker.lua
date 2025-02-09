local Library = {}; do
    Library = {
        Accent = Color3.fromRGB(106, 191, 247);
        Inline = Color3.fromRGB(21,21,21);
        Background = Color3.fromRGB(15,15,15);
        Text = Color3.fromRGB(255,255,255);
        TextInactive = Color3.fromRGB(135,135,135);
        Border = Color3.fromRGB(35,35,35);
        Risky = Color3.fromRGB(255,0,0);

        FolderName = "Celestial";

        Key = Enum.KeyCode.End;
        Open = true;

        Tabs = {};
        RealTabs = {};
        Sections = {};
        Connections = {};
        Flags = {};
        Registry = {};
        RegistryMap = {};

        Holder = nil;
        MainFrame = nil;
        CurrentColorpicker = nil;
        NotificationHolder = nil;
        LoadedConfig = nil;
        KeybindList = nil;
        Watermark = nil;

        Dragging = false;
    };

    Library.__index = Library;
    Library.Tabs.__index = Library.Tabs;
    Library.Sections.__index = Library.Sections;

    do
        -- Folders

        if not isfolder(Library.FolderName) then
            makefolder(Library.FolderName);
        end;

        if not isfolder(Library.FolderName .. '/Configs') then
            makefolder(Library.FolderName .. '/Configs');
        end;

        if not isfolder(Library.FolderName .. '/Utilities') then
            makefolder(Library.FolderName .. '/Utilities')
        end;

        -- Files

        if not isfile(Library.FolderName .. '/Utilities/Hue.png') then
            writefile(Library.FolderName .. '/Utilities/Hue.png', game:HttpGet("https://raw.githubusercontent.com/sametexe001/celestial.club/refs/heads/main/images/hue.png"));
        end;

        if not isfile(Library.FolderName .. '/Utilities/Saturation.png') then
            writefile(Library.FolderName .. '/Utilities/Saturation.png', game:HttpGet("https://raw.githubusercontent.com/sametexe001/celestial.club/refs/heads/main/images/saturation.png"));
        end;

        if not isfile(Library.FolderName .. '/Utilities/Value.png') then
            writefile(Library.FolderName .. '/Utilities/Value.png', game:HttpGet("https://raw.githubusercontent.com/sametexe001/celestial.club/refs/heads/main/images/value.png"));
        end;

        if not isfile(Library.FolderName .. '/Utilities/Shadow.png') then
            writefile(Library.FolderName .. '/Utilities/Shadow.png', game:HttpGet("https://raw.githubusercontent.com/sametexe001/celestial.club/refs/heads/main/images/shadow.png"));
        end;

        if not isfile(Library.FolderName .. '/Utilities/Logo.png') then
            writefile(Library.FolderName .. '/Utilities/Logo.png', game:HttpGet("https://raw.githubusercontent.com/sametexe001/celestial.club/refs/heads/main/images/celestiallogo-removebg-preview.png"));
        end;
    end;

    local Keys                = {
        ["Unknown"]          = "UNK";
        ["Backspace"]        = "BACK";
        ["Tab"]              = "TAB";
        ["Clear"]            = "CLR";
        ["Return"]           = "RTN";
        ["Pause"]            = "PSE";
        ["Escape"]           = "ESC";
        ["Space"]            = "SPC";
        ["QuotedDouble"]     = '"';
        ["Hash"]             = "#";
        ["Dollar"]           = "$";
        ["Percent"]          = "%";
        ["Ampersand"]        = "&";
        ["Quote"]            = "'";
        ["LeftParenthesis"]  = "(";
        ["RightParenthesis"] = " )";
        ["Asterisk"]         = "*";
        ["Plus"]             = "+";
        ["Comma"]            = ",";
        ["Minus"]            = "-";
        ["Period"]           = ".";
        ["Slash"]            = "`";
        ["Three"]            = "THR";
        ["Seven"]            = "SEV";
        ["Eight"]            = "EGHT";
        ["Colon"]            = ":";
        ["Semicolon"]        = ";";
        ["LessThan"]         = "<";
        ["GreaterThan"]      = ">";
        ["Question"]         = "?";
        ["Equals"]           = "=";
        ["At"]               = "@";
        ["LeftBracket"]      = "LB";
        ["RightBracket"]     = "RB";
        ["BackSlash"]        = "BSL";
        ["Caret"]            = "^";
        ["Underscore"]       = "_";
        ["Backquote"]        = "`";
        ["LeftCurly"]        = "{";
        ["Pipe"]             = "|";
        ["RightCurly"]       = "}";
        ["Tilde"]            = "~";
        ["Delete"]           = "DEL";
        ["End"]              = "END";
        ["KeypadZero"]       = "NP0";
        ["KeypadOne"]        = "NP1";
        ["KeypadTwo"]        = "NP2";
        ["KeypadThree"]      = "NP3";
        ["KeypadFour"]       = "NP4";
        ["KeypadFive"]       = "NP5";
        ["KeypadSix"]        = "NP6";
        ["KeypadSeven"]      = "NP7";
        ["KeypadEight"]      = "NP8";
        ["KeypadNine"]       = "NP9";
        ["KeypadPeriod"]     = "NPP";
        ["KeypadDivide"]     = "NPD";
        ["KeypadMultiply"]   = "NPM";
        ["KeypadMinus"]      = "NPM";
        ["KeypadPlus"]       = "NPP";
        ["KeypadEnter"]      = "NPE";
        ["KeypadEquals"]     = "NPE";
    
        ["Insert"]           = "INS";
        ["Home"]             = "HOME";
        ["PageUp"]           = "PGUP";
        ["PageDown"]         = "PGD";
        ["RightShift"]       = "RSHIFT";
        ["LeftShift"]        = "LSHIFT";
        ["RightControl"]     = "CTRL";
        ["LeftControl"]      = "CTRL";
        ["LeftAlt"]          = "ALT";
        ["RightAlt"]         = "ALT";
    }; 

    do
        local Objects = {};
        Objects["big_paste_omg"] = Instance.new("ScreenGui")
        Objects["big_paste_omg"].ResetOnSpawn = false
        Objects["big_paste_omg"].Name = "big_paste_omg"
        Objects["big_paste_omg"].Parent = gethui and gethui() or game:GetService("CoreGui");
        Objects["big_paste_omg"].ZIndexBehavior = Enum.ZIndexBehavior.Global;
        Library.Holder = Objects["big_paste_omg"];
    end;

    local fonts = {};
    do -- custom font (this is pasted from my other ui)
        local fonts_folder = Library.FolderName .. '/Utilities';
        fonts = {
            ["windows-xp-tahoma"] = {
                file_name = {"windowsXPTahoma.ttf", "windowsXPTahoma.json"},
                url = "https://raw.githubusercontent.com/sametexe001/luas/main/fonts/windows-xp-tahoma.ttf"
            };

            ["proggy-square"] = {
                file_name = {"proggySquare.ttf", "proggySquare.json"},
                url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/proggy-square.ttf"
            };

            ["proggy-clean"] = {
                file_name = {"proggyClean.ttf", "proggySquare.json"},
                url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/proggy-clean.ttf"
            };

            ["proggy-tiny"] = {
                file_name = {"proggyTiny.ttf", "proggyTiny.json"},
                url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/proggy-tiny.ttf"
            };

            ["minecraftia"] = {
                file_name = {"minecraftia.ttf", "minecraftia.json"},
                url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/minecraftia.ttf"
            };
        };

        for font_name, font_data in fonts do
            if not isfile(fonts_folder .. "/" .. font_data.file_name[1]) then
                writefile(fonts_folder .. "/" .. font_data.file_name[1], game:HttpGet(font_data.url));
            end;

            local data = {
                name = font_name,
                faces = {{
                    name = "Regular",
                    weight = 200,
                    style = "Regular",
                    assetId = getcustomasset(fonts_folder .. "/" .. font_data.file_name[1]);
                }};
            };

            if not isfile(fonts_folder .. "/" .. font_data.file_name[2]) then
                writefile(fonts_folder .. "/" .. font_data.file_name[2], game:GetService("HttpService"):JSONEncode(data));
            end;
        end;

        fonts.get_font_from_name = function(font_name)
            for name, data in fonts do
                if name == font_name then
                    return Font.new(getcustomasset(fonts_folder .. "/" .. data.file_name[2]))
                end;
            end;
        end;
    end;

    local LibFont = fonts.get_font_from_name("windows-xp-tahoma");

    function Library:Connect(Signal, Callback)
        local Connection = Signal:Connect(Callback);
        table.insert(self.Connections, Connection);
        return Connection;
    end;

    function Library:Disconnect(Signal)
        Signal:Disconnect();
        table.remove(self.Connections, table.find(self.Connections, Signal));
    end;

    function Library:SetOpen(Bool)
        Library.MainFrame.Visible = Bool;
        Library.Open = Bool;
    end;

    function Library:Round(Number, Float)
        return Float * math.floor(Number / Float);
    end;

    function Library:AddToRegistry(Instance, Properties)
        local Idx = #Library.Registry + 1;
        local Data = {
            Instance = Instance;
            Properties = Properties;
            Idx = Idx;
        };
    
        table.insert(Library.Registry, Data);
        Library.RegistryMap[Instance] = Data;
    end;

    function Library:RemoveFromRegistry(Instance)
        local Data = Library.RegistryMap[Instance];
    
        if Data then
            for Idx = #Library.Registry, 1, -1 do
                if Library.Registry[Idx] == Data then
                    table.remove(Library.Registry, Idx);
                end;
            end;
    
            Library.RegistryMap[Instance] = nil;
        end;
    end;

    function Library:UpdateTheme()
        for Idx, Object in next, Library.Registry do
            for Property, ColorIdx in next, Object.Properties do
                if type(ColorIdx) == 'string' then
                    Object.Instance[Property] = Library[ColorIdx];
                elseif type(ColorIdx) == 'function' then
                    Object.Instance[Property] = ColorIdx()
                end
            end;
        end;
    end;

    function Library:Notify(Text, Duration, Color)
        local Objects = {};
        Objects["notification"] = Instance.new("Frame")
        Objects["notification"].Name = "notification"
        Objects["notification"].Size = UDim2.new(0, 0, 0, 18)
        Objects["notification"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["notification"].BorderSizePixel = 0
        Objects["notification"].BackgroundColor3 = Library.Background
        Objects["notification"].Parent = Library.NotificationHolder
        Objects["notification"].ClipsDescendants = true;

        Library:AddToRegistry(Objects["notification"], {
            BackgroundColor3 = "Background";
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].Color = Library.Border
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke"].Parent = Objects["notification"]
        Objects["UIStroke"].Enabled = false;

        Library:AddToRegistry(Objects["UIStroke"], {
            Color = "Border";
        })

        Objects["liner"] = Instance.new("Frame")
        Objects["liner"].Name = "liner"
        Objects["liner"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["liner"].Size = UDim2.new(0, 1, 1, 0)
        Objects["liner"].BorderSizePixel = 0
        Objects["liner"].BackgroundColor3 = Color
        Objects["liner"].Parent = Objects["notification"]

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Text
        Objects["text"].Name = "text"
        Objects["text"].Size = UDim2.new(0, 100, 0, 13)
        Objects["text"].AnchorPoint = Vector2.new(0, 0.5)
        Objects["text"].Position = UDim2.new(0, 7, 0.5, 0)
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].TextTransparency = 1
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["notification"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text";
        })

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].Parent = Objects["text"]

        task.spawn(function()
            Objects["UIStroke"].Enabled = true;
            local Tween1 = game:GetService("TweenService"):Create(Objects["notification"], TweenInfo.new(0.265, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, Objects["text"].TextBounds.X + 14, 0, 18)});
            Tween1:Play();
            Tween1.Completed:Wait();
            local Tween2 = game:GetService("TweenService"):Create(Objects["text"], TweenInfo.new(0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextTransparency  = 0});
            Tween2:Play();
            Tween2.Completed:Wait();

            task.delay(Duration, function()
                local Tween3 = game:GetService("TweenService"):Create(Objects["notification"], TweenInfo.new(0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size  = UDim2.new(0,0,0,18)});
                Tween3:Play();
                Tween3.Completed:Wait();
                Library:RemoveFromRegistry(Objects["notification"]);
                Objects["notification"]:Destroy();
            end);
        end);
    end;

    function Library:GetConfig()
        local Config = {};

        for Index, Value in self.Flags do
            if typeof(Value) == "table" then
                if Value.Value then
                    Config[Index] = Value.Value;
                elseif Value.Color then
                    Config[Index] = {Color = {R = Value.Color.R, G = Value.Color.G, B = Value.Color.B}, Transparency = Value.Transparency};
                elseif rawget(Value, "Key") and rawget(Value, "Name") then
                    Config[Index] = {Name = Value.Key.Name};
                else
                    if not Config[Index] then 
                        Config[Index] = Value.Value;
                    end;
                end;
            end;
        end;

        return Config, game:GetService("HttpService"):JSONEncode(Config);
    end;

    function Library:LoadConfig(Config)
        if not Config or Config == nil then
            Library:Notify("Config not found", 3, Color3.fromRGB(255,0,0));
        end;
        
        local Decoded = game:GetService("HttpService"):JSONDecode(Config);

        for Index, Value in Decoded do
            task.spawn(function()
                local Succ, Err = pcall(function()
                    local ToLib = Library.Flags[Index];

                    if ToLib then 
                        if rawget(ToLib, "Key") and type(Value) ~= "boolean" then 
                            if table.find({"MouseButton1","MouseWheel","MouseButton2","MouseButton3"}, tostring(Value.Name)) then
                                ToLib:Set(Value, true)
                            else 
                                ToLib:Set(Value);
                            end 
                        elseif rawget(ToLib, "Color") then 
                            ToLib:Set({
                                Color = Color3.new(Value.Color.R, Value.Color.G, Value.Color.B),
                                Transparency = Value.Transparency
                            });
                        elseif rawget(ToLib, "Value") and not rawget(ToLib, "Color") and not rawget(ToLib, "Key") then 
                            if rawget(ToLib, "Multi") and type(Value) ~= "table" then 
                                ToLib:Set({Value})
                            else
                                if ToLib.Min then 
                                    if Value > ToLib.Max then 
                                        ToLib:Set(ToLib.Max);
                                    else 
                                        ToLib:Set(Value);
                                    end;
                                else
                                    ToLib:Set(Value);
                                end;
                            end
                        else 
                            ToLib:Set(Value)
                        end;
                    end;
                end);
            end);
        end;
    end;

    function Library:SaveConfig(ConfigName)
        local UnusedVariable, Encoded = Library:GetConfig();

        if ConfigName and type(ConfigName) == "string" then 
            writefile(`{Library.FolderName}/Configs/`..ConfigName..".json", Encoded);
        end;
    end;

    function Library:DeleteConfig(ConfigName)
        if isfile(`{Library.FolderName}/Configs/`..ConfigName..".json") then 
            delfile(`{Library.FolderName}/Configs/`..ConfigName..".json");
        end;
    end;

    function Library:Watermark(Data)
        local Objects = {};
        local Watermark = {};

        Objects["watermark"] = Instance.new("Frame")
        Objects["watermark"].AnchorPoint = Vector2.new(0.5, 0)
        Objects["watermark"].Name = "watermark"
        Objects["watermark"].Position = UDim2.new(0.5, 0, 0, 20)
        Objects["watermark"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["watermark"].Size = UDim2.new(0, 300, 0, 25)
        Objects["watermark"].BorderSizePixel = 2
        Objects["watermark"].BackgroundColor3 = Library.Background
        Objects["watermark"].Parent = Library.Holder;

        Library:AddToRegistry(Objects["watermark"], {
            BackgroundColor3 = "Background";
        });

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].Color = Library.Border
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke"].Parent = Objects["watermark"]

        Library:AddToRegistry(Objects["UIStroke"], {
            Color = "Border";
        });

        Objects["logo"] = Instance.new("ImageLabel")
        Objects["logo"].ScaleType = Enum.ScaleType.Fit
        Objects["logo"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["logo"].AnchorPoint = Vector2.new(0, 0.5)
        Objects["logo"].Image = getcustomasset(Library.FolderName .. "/Utilities/Logo.png");
        Objects["logo"].BackgroundTransparency = 1
        Objects["logo"].Position = UDim2.new(0, -5, 0.5, -1)
        Objects["logo"].Name = "logo"
        Objects["logo"].Size = UDim2.new(0, 38, 0, 47)
        Objects["logo"].BorderSizePixel = 0
        Objects["logo"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["logo"].Parent = Objects["watermark"]
        Objects["logo"].ImageColor3 = Library.Accent;

        Library:AddToRegistry(Objects["logo"], {
            ImageColor3 = "Accent";
        });

        Objects["UIGradient"] = Instance.new("UIGradient")
        Objects["UIGradient"].Rotation = 90
        Objects["UIGradient"].Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
        }
        Objects["UIGradient"].Parent = Objects["watermark"]

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Data.Name
        Objects["text"].Name = "text"
        Objects["text"].Size = UDim2.new(0, 0, 1, 0)
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].Position = UDim2.new(0, 28, 0, 0)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].AutomaticSize = Enum.AutomaticSize.X
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["watermark"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text";
        });

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].Parent = Objects["text"]

        Objects["accent"] = Instance.new("Frame")
        Objects["accent"].Name = "accent"
        Objects["accent"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["accent"].Size = UDim2.new(1, 0, 0, 1)
        Objects["accent"].BorderSizePixel = 0
        Objects["accent"].BackgroundColor3 = Library.Accent
        Objects["accent"].Parent = Objects["watermark"]

        Library:AddToRegistry(Objects["accent"], {
            BackgroundColor3 = "Accent";
        });

        Objects["shadow"] = Instance.new("ImageLabel")
        Objects["shadow"].ImageColor3 = Library.Accent
        Objects["shadow"].ScaleType = Enum.ScaleType.Slice
        Objects["shadow"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["shadow"].Name = "shadow"
        Objects["shadow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["shadow"].Size = UDim2.new(1, 25, 1, 25)
        Objects["shadow"].AnchorPoint = Vector2.new(0.5, 0.5)
        Objects["shadow"].Image = getcustomasset(Library.FolderName .. "/Utilities/Shadow.png");
        Objects["shadow"].BackgroundTransparency = 1
        Objects["shadow"].Position = UDim2.new(0.5, 0, 0.5, 0)
        Objects["shadow"].SliceScale = 0.75
        Objects["shadow"].ZIndex = -1
        Objects["shadow"].BorderSizePixel = 0
        Objects["shadow"].SliceCenter = Rect.new(Vector2.new(112, 112), Vector2.new(147, 147))
        Objects["shadow"].Parent = Objects["watermark"]
        Objects["shadow"].Visible = true;

        Library:AddToRegistry(Objects["shadow"], {
            ImageColor3 = "Accent";
        });

        function Watermark:SetVisiblity(Boolean)
            Objects["watermark"].Visible = Boolean;
        end;

        task.spawn(function()
            Objects["watermark"].Size = UDim2.new(0,Objects["text"].TextBounds.X + 32,0,25);
            local FrameTime = tick();
            local FrameCount = 0;
            local FPS = 60;

            local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
                local CurrentCFG = Library.LoadedConfig;
                FrameCount += 1;

                if (tick() - FrameTime) >= 1 then
                    FPS = FrameCount;
                    FrameTime = tick();
                    FrameCount = 0;
                end;

                Objects["text"].Text = (`%s  |  %s fps  |  %s ms  |  %s`):format(
                    Data.Name,
                    math.floor(FPS),
                    math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()),
                    game.Players.LocalPlayer.UserId
                );
                Objects["watermark"].Size = UDim2.new(0,Objects["text"].TextBounds.X + 32,0,25);
            end);
        end);

        return Watermark;
    end;
    

    function Library:KeybindList()
        local Objects = {};
        local KeyList = {};

        Objects["keybindlist"] = Instance.new("Frame")
        Objects["keybindlist"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["keybindlist"].AnchorPoint = Vector2.new(0, 0.5)
        Objects["keybindlist"].Name = "keybindlist"
        Objects["keybindlist"].Position = UDim2.new(0, 20, 0.5, 0)
        Objects["keybindlist"].Size = UDim2.new(0, 0, 0, 18)
        Objects["keybindlist"].BorderSizePixel = 2
        Objects["keybindlist"].AutomaticSize = Enum.AutomaticSize.XY
        Objects["keybindlist"].BackgroundColor3 = Library.Background
        Objects["keybindlist"].Parent = Library.Holder

        Library:AddToRegistry(Objects["keybindlist"], {
            BackgroundColor3 = "Background";
        });

        Objects["UIGradient"] = Instance.new("UIGradient")
        Objects["UIGradient"].Rotation = 90
        Objects["UIGradient"].Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(17, 17, 17))
        }
        Objects["UIGradient"].Parent = Objects["keybindlist"]

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].Color = Library.Border
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke"].Parent = Objects["keybindlist"]

        Library:AddToRegistry(Objects["UIStroke"], {
            Color = "Border";
        });

        Objects["value"] = Instance.new("TextLabel")
        Objects["value"].FontFace = LibFont
        Objects["value"].TextColor3 = Library.Text
        Objects["value"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["value"].Text = "Keybinds"
        Objects["value"].TextStrokeTransparency = 0
        Objects["value"].Name = "value"
        Objects["value"].Size = UDim2.new(0, 100, 0, 20)
        Objects["value"].BackgroundTransparency = 1
        Objects["value"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["value"].Position = UDim2.new(0, 4, 0, 0)
        Objects["value"].BorderSizePixel = 0
        Objects["value"].TextSize = 12
        Objects["value"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["value"].Parent = Objects["keybindlist"]

        Library:AddToRegistry(Objects["value"], {
            TextColor3 = "Text";
        });

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].Parent = Objects["value"]

        Objects["accent"] = Instance.new("Frame")
        Objects["accent"].Name = "accent"
        Objects["accent"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["accent"].Size = UDim2.new(1, 6, 0, 1)
        Objects["accent"].BorderSizePixel = 0
        Objects["accent"].BackgroundColor3 = Library.Accent
        Objects["accent"].Parent = Objects["keybindlist"]

        Library:AddToRegistry(Objects["accent"], {
            BackgroundColor3 = "Accent";
        });

        Objects["content"] = Instance.new("Frame")
        Objects["content"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["content"].Name = "content"
        Objects["content"].BackgroundTransparency = 1
        Objects["content"].Position = UDim2.new(0, 10, 0, 20)
        Objects["content"].Size = UDim2.new(0, 100, 0, 0)
        Objects["content"].BorderSizePixel = 0
        Objects["content"].AutomaticSize = Enum.AutomaticSize.XY
        Objects["content"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["content"].Parent = Objects["keybindlist"]

        Objects["UIListLayout"] = Instance.new("UIListLayout")
        Objects["UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout"].Parent = Objects["content"]
        
        function KeyList:SetVisibility(Boolean)
            Objects["keybindlist"].Visible = Boolean;
        end;

        function KeyList:AddNewKey(Key, Name)
            local SubObjects = {};
            local NewKey = {};

            SubObjects["newkey"] = Instance.new("TextLabel")
            SubObjects["newkey"].FontFace = LibFont
            SubObjects["newkey"].TextColor3 = Library.Accent
            SubObjects["newkey"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["newkey"].Text = `[{Key}]: {Name}`
            SubObjects["newkey"].Name = "newkey"
            SubObjects["newkey"].BackgroundTransparency = 1
            SubObjects["newkey"].TextXAlignment = Enum.TextXAlignment.Left
            SubObjects["newkey"].Size = UDim2.new(0, 100, 0, 20)
            SubObjects["newkey"].BorderSizePixel = 0
            SubObjects["newkey"].TextSize = 12
            SubObjects["newkey"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["newkey"].Parent = Objects["content"]

            Library:AddToRegistry(SubObjects["newkey"], {
                TextColor3 = "Accent";
            });

            SubObjects["UIStroke"] = Instance.new("UIStroke")
            SubObjects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke"].Parent = SubObjects["newkey"]

            function NewKey:SetVisiblity(Boolean)
                SubObjects["newkey"].Visible = Boolean;
            end;

            function NewKey:Set(Key, Name)
                SubObjects["newkey"].Text = `[{Key}]: {Name}`;
            end;

            return NewKey;
        end;

        Library.KeybindList = KeyList;
    end;

    function Library:Window(Data)
        local Window = {
            Name = Data.Name;
            Objects = {};
        };

        local Objects = {};

        Objects["main"] = Instance.new("Frame")
        Objects["main"].AnchorPoint = Vector2.new(0.5, 0.5)
        Objects["main"].Name = "main"
        Objects["main"].Position = UDim2.new(0.5, 0, 0.5, 0)
        Objects["main"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["main"].Size = UDim2.new(0, 500, 0, 481)
        Objects["main"].BorderSizePixel = 2
        Objects["main"].BorderColor3 = Color3.fromRGB(0,0,0);
        Objects["main"].BackgroundColor3 = Library.Background
        Objects["main"].Parent = Library.Holder

        Library:AddToRegistry(Objects["main"], {
            BackgroundColor3 = "Background";
        })

        Library.MainFrame = Objects["main"];

        Objects["notifholders"] = Instance.new("Frame")
        Objects["notifholders"].Name = "notifholders"
        Objects["notifholders"].BackgroundTransparency = 1
        Objects["notifholders"].Position = UDim2.new(0, 6, 0, 15)
        Objects["notifholders"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["notifholders"].BorderSizePixel = 0
        Objects["notifholders"].AutomaticSize = Enum.AutomaticSize.XY
        Objects["notifholders"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["notifholders"].Parent = Library.Holder

        Objects["UIListLayout"] = Instance.new("UIListLayout")
        Objects["UIListLayout"].Padding = UDim.new(0, 6)
        Objects["UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout"].Parent = Objects["notifholders"]

        Library.NotificationHolder = Objects["notifholders"];

        Objects["title"] = Instance.new("TextLabel")
        Objects["title"].FontFace = LibFont;
        Objects["title"].TextColor3 = Library.Text
        Objects["title"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["title"].Text = Window.Name;
        Objects["title"].Name = "title"
        Objects["title"].Size = UDim2.new(0, 0, 0, 20)
        Objects["title"].Position = UDim2.new(0, 7, 0, 0)
        Objects["title"].BorderSizePixel = 0
        Objects["title"].BackgroundTransparency = 1
        Objects["title"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["title"].RichText = true
        Objects["title"].AutomaticSize = Enum.AutomaticSize.X
        Objects["title"].TextSize = 12
        Objects["title"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["title"].Parent = Objects["main"];

        Library:AddToRegistry(Objects["title"], {
            TextColor3 = "Text";
        })

        Objects["UIStroke24"] = Instance.new("UIStroke")
        Objects["UIStroke24"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke24"].Parent = Objects["title"]
        
        Objects["inline"] = Instance.new("Frame")
        Objects["inline"].Name = "inline"
        Objects["inline"].Position = UDim2.new(0, 7, 0, 21)
        Objects["inline"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["inline"].Size = UDim2.new(1, -14, 1, -28)
        Objects["inline"].BorderSizePixel = 0
        Objects["inline"].BackgroundColor3 = Library.Inline
        Objects["inline"].Parent = Objects["main"]

        Library:AddToRegistry(Objects["inline"], {
            BackgroundColor3 = "Inline";
        })
        
        Objects["UIStroke1"] = Instance.new("UIStroke")
        Objects["UIStroke1"].Color = Library.Border
        Objects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke1"].Parent = Objects["inline"]

        Library:AddToRegistry(Objects["UIStroke1"], {
            Color = "Border";
        })
        
        Objects["tabs"] = Instance.new("Frame")
        Objects["tabs"].Name = "tabs"
        Objects["tabs"].BackgroundTransparency = 1
        Objects["tabs"].Position = UDim2.new(0, 5, 0, 5)
        Objects["tabs"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["tabs"].Size = UDim2.new(1, -10, 0, 18)
        Objects["tabs"].BorderSizePixel = 0
        Objects["tabs"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["tabs"].Parent = Objects["inline"]
        
        Objects["UIListLayout"] = Instance.new("UIListLayout")
        Objects["UIListLayout"].FillDirection = Enum.FillDirection.Horizontal
        Objects["UIListLayout"].HorizontalFlex = Enum.UIFlexAlignment.Fill
        Objects["UIListLayout"].Padding = UDim.new(0, 7)
        Objects["UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout"].Parent = Objects["tabs"]

        Objects["UIStroke3"] = Instance.new("UIStroke")
        Objects["UIStroke3"].Color = Library.Accent
        Objects["UIStroke3"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke3"].Parent = Objects["main"]

        
        Library:AddToRegistry(Objects["UIStroke3"], {
            Color = "Accent";
        })

        Objects["shadow"] = Instance.new("ImageLabel")
        Objects["shadow"].ImageColor3 = Library.Accent
        Objects["shadow"].ScaleType = Enum.ScaleType.Slice
        Objects["shadow"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["shadow"].Name = "shadow"
        Objects["shadow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["shadow"].Size = UDim2.new(1, 75, 1, 75)
        Objects["shadow"].AnchorPoint = Vector2.new(0.5, 0.5)
        Objects["shadow"].Image = getcustomasset(Library.FolderName .. "/Utilities/Shadow.png");
        Objects["shadow"].BackgroundTransparency = 1
        Objects["shadow"].Position = UDim2.new(0.5, 0, 0.5, 0)
        Objects["shadow"].SliceScale = 0.75
        Objects["shadow"].ZIndex = -1
        Objects["shadow"].BorderSizePixel = 0
        Objects["shadow"].SliceCenter = Rect.new(Vector2.new(112, 112), Vector2.new(147, 147))
        Objects["shadow"].Parent = Objects["main"]
        Objects["shadow"].Visible = true;

        Library:AddToRegistry(Objects["shadow"], {
            ImageColor3 = "Accent";
        })

        Objects["innerline"] = Instance.new("Frame")
        Objects["innerline"].Name = "innerline"
        Objects["innerline"].Position = UDim2.new(0, 5, 0, 26)
        Objects["innerline"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["innerline"].Size = UDim2.new(1, -10, 1, -32)
        Objects["innerline"].BorderSizePixel = 0
        Objects["innerline"].BackgroundColor3 = Library.Background
        Objects["innerline"].Parent = Objects["inline"]

        Library:AddToRegistry(Objects["innerline"], {
            BackgroundColor3 = "Background";
        })

        Objects["UIStroke6"] = Instance.new("UIStroke")
        Objects["UIStroke6"].Color = Library.Border
        Objects["UIStroke6"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke6"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke6"].Parent = Objects["innerline"]

        Library:AddToRegistry(Objects["UIStroke6"], {
            Color = "Border";
        })

        Window.Objects = {
            Tabs = Objects["tabs"];
            Content = Objects["innerline"];
        }

        Library:Connect(game:GetService("UserInputService").InputBegan,  function(Input)
            if Input.KeyCode == Library.Key then
                Library:SetOpen(not Library.Open);
            end;
        end);

        local  function dragify()local UserInputService = game:GetService("UserInputService") local a=Objects["main"];local b,c,d;local function e(f)local g=f.Position-c;a.Position=UDim2.new(d.X.Scale,d.X.Offset+g.X,d.Y.Scale,d.Y.Offset+g.Y)end;a.InputBegan:Connect(function(f)if f.UserInputType==Enum.UserInputType.MouseButton1 or f.UserInputType==Enum.UserInputType.Touch then Library.Dragging=true;c=f.Position;d=a.Position;f.Changed:Connect(function()if f.UserInputState==Enum.UserInputState.End then Library.Dragging=false end end)end end)a.InputChanged:Connect(function(f)if f.UserInputType==Enum.UserInputType.MouseMovement or f.UserInputType==Enum.UserInputType.Touch then b=f end end)UserInputService.InputChanged:Connect(function(f)if f==b and Library.Dragging then e(f)end end) end
        dragify();

        return setmetatable(Window, self);
    end;

    function Library:Tab(Data)
        local Tab = {
            Window = self;
            Name = Data.Name;
            Hovered = false;
            Active = false;
            Objects = {};
        };

        local Objects = {};

        Objects["inactive"] = Instance.new("TextButton")
        Objects["inactive"].FontFace = LibFont
        Objects["inactive"].TextColor3 = Color3.fromRGB(255, 255, 255)
        Objects["inactive"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["inactive"].Text = ""
        Objects["inactive"].AutoButtonColor = false
        Objects["inactive"].Name = "inactive"
        Objects["inactive"].Size = UDim2.new(0, 0, 0, 22)
        Objects["inactive"].BorderSizePixel = 0
        Objects["inactive"].AutomaticSize = Enum.AutomaticSize.X
        Objects["inactive"].TextSize = 12
        Objects["inactive"].BackgroundColor3 = Library.Inline
        Objects["inactive"].Parent = Tab.Window.Objects.Tabs;

        Library:AddToRegistry(Objects["inactive"], {
            BackgroundColor3 = "Inline";
        })

        Objects["UIStroke1"] = Instance.new("UIStroke")
        Objects["UIStroke1"].Color = Library.Border
        Objects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke1"].Parent = Objects["inactive"]

        Library:AddToRegistry(Objects["UIStroke1"], {
            Color = "Border";
        })

        Objects["hide"] = Instance.new("Frame")
        Objects["hide"].Visible = false
        Objects["hide"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["hide"].AnchorPoint = Vector2.new(0, 1)
        Objects["hide"].Name = "hide"
        Objects["hide"].Position = UDim2.new(0, 0, 1, -1)
        Objects["hide"].Size = UDim2.new(1, 0, 0, 3)
        Objects["hide"].ZIndex = 1
        Objects["hide"].BorderSizePixel = 0
        Objects["hide"].BackgroundColor3 = Library.Background
        Objects["hide"].Parent = Objects["inactive"]

        Library:AddToRegistry(Objects["hide"], {
            BackgroundColor3 = "Background";
        })

        Objects["UIGradient1"] = Instance.new("UIGradient")
        Objects["UIGradient1"].Rotation = -90
        Objects["UIGradient1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 165, 165))}
        Objects["UIGradient1"].Parent = Objects["inactive"]

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.TextInactive
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Tab.Name
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].Name = "text"
        Objects["text"].Size = UDim2.new(1, 0, 1, -3)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].Parent = Objects["inactive"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "TextInactive";
        })

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].Parent = Objects["text"]

        Objects["tabcontent"] = Instance.new("Frame")
        Objects["tabcontent"].BackgroundTransparency = 1
        Objects["tabcontent"].Visible = false;
        Objects["tabcontent"].Name = Tab.Name
        Objects["tabcontent"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["tabcontent"].Size = UDim2.new(1, 0, 1, 0)
        Objects["tabcontent"].BorderSizePixel = 0
        Objects["tabcontent"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["tabcontent"].Parent = Tab.Window.Objects.Content

        Objects["sectionholders"] = Instance.new("ScrollingFrame")
        Objects["sectionholders"].ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
        Objects["sectionholders"].Active = true
        Objects["sectionholders"].AutomaticCanvasSize = Enum.AutomaticSize.Y
        Objects["sectionholders"].ScrollBarThickness = 0
        Objects["sectionholders"].BackgroundTransparency = 1
        Objects["sectionholders"].Name = "sectionholders"
        Objects["sectionholders"].Size = UDim2.new(1, 0, 1, 0)
        Objects["sectionholders"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["sectionholders"].BorderSizePixel = 0
        Objects["sectionholders"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["sectionholders"].Parent = Objects["tabcontent"]

        Objects["left"] = Instance.new("Frame")
        Objects["left"].Name = "left"
        Objects["left"].BackgroundTransparency = 1
        Objects["left"].Position = UDim2.new(0, 7, 0, 7)
        Objects["left"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["left"].Size = UDim2.new(0.4749999940395355, 0, 1, -7)
        Objects["left"].BorderSizePixel = 0
        Objects["left"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["left"].Parent = Objects["sectionholders"]

        Objects["UIListLayout1"] = Instance.new("UIListLayout")
        Objects["UIListLayout1"].Padding = UDim.new(0, 8)
        Objects["UIListLayout1"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout1"].Parent = Objects["left"]

        Objects["right"] = Instance.new("Frame")
        Objects["right"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["right"].AnchorPoint = Vector2.new(1, 0)
        Objects["right"].BackgroundTransparency = 1
        Objects["right"].Position = UDim2.new(1, -7, 0, 7)
        Objects["right"].Name = "right"
        Objects["right"].Size = UDim2.new(0.4749999940395355, 0, 1, -7)
        Objects["right"].BorderSizePixel = 0
        Objects["right"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["right"].Parent = Objects["sectionholders"]

        Objects["UIListLayout2"] = Instance.new("UIListLayout")
        Objects["UIListLayout2"].Padding = UDim.new(0, 8)
        Objects["UIListLayout2"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout2"].Parent = Objects["right"]

        Tab.Objects = {
            Right = Objects["right"];
            Left = Objects["left"];
            Main = Objects["sectionholders"]
        };

        function Tab:Switch(Bool)
            Tab.Active = Bool;
            Objects["UIGradient1"].Rotation = Bool and 90 or -90;
            game:GetService("TweenService"):Create(Objects["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Bool and Library.Accent or Library.TextInactive}):Play();
            Objects["hide"].Visible = Bool;
            Objects["hide"].ZIndex = Bool and 5 or 1;
            Objects["tabcontent"].Visible = Bool;
            if Bool then
                Library:RemoveFromRegistry(Objects["text"]);
                Library:AddToRegistry(Objects["text"], {
                    TextColor3 = "Accent";
                })
            else
                Library:RemoveFromRegistry(Objects["text"]);
                Library:AddToRegistry(Objects["text"], {
                    TextColor3 = "TextInactive";
                })
            end
        end;

        Library:Connect(Objects["inactive"].MouseButton1Down, function()
            for Index, Value in Library.RealTabs do
                Value:Switch(Value == Tab);
            end;
        end);

        table.insert(Library.RealTabs, Tab);
        return setmetatable(Tab, self.Tabs);
    end;

    function Library.Tabs:Section(Data)
        local Section = {
            Tab = self;
            Name = Data.Name;
            Side = Data.Side or "Left";
            Objects =  {};
        };

        local Objects = {};

        Objects["section"] = Instance.new("Frame")
        Objects["section"].Name = "section"
        Objects["section"].Size = UDim2.new(1, 0, 0, 25)
        Objects["section"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["section"].BorderSizePixel = 0
        Objects["section"].AutomaticSize = Enum.AutomaticSize.Y
        Objects["section"].BackgroundColor3 = Library.Background
        Objects["section"].Parent = Section.Side:lower() == "left" and Section.Tab.Objects.Left or Section.Side:lower() == "right" and Section.Tab.Objects.Right;

        Library:AddToRegistry(Objects["section"], {
            BackgroundColor3 = "Background";
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].Color = Library.Border
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke"].Parent = Objects["section"]

        Library:AddToRegistry(Objects["UIStroke"], {
            Color = "Border";
        })

        Objects["liner"] = Instance.new("Frame")
        Objects["liner"].Name = "liner"
        Objects["liner"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["liner"].Size = UDim2.new(1, 0, 0, 1)
        Objects["liner"].BorderSizePixel = 0
        Objects["liner"].BackgroundColor3 = Library.Accent
        Objects["liner"].Parent = Objects["section"]

        Library:AddToRegistry(Objects["liner"], {
            BackgroundColor3 = "Accent";
        })

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text;
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Section.Name
        Objects["text"].Size = UDim2.new(0, 50, 0, 13)
        Objects["text"].Name = "text"
        Objects["text"].Position = UDim2.new(0, 10, 0, -7)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].AutomaticSize = Enum.AutomaticSize.X
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Library.Background
        Objects["text"].Parent = Objects["section"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text";
            BackgroundColor3 = "Background";
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].Parent = Objects["text"]

        Objects["content"] = Instance.new("Frame")
        Objects["content"].Name = "content"
        Objects["content"].BackgroundTransparency = 1
        Objects["content"].Position = UDim2.new(0, 6, 0, 10)
        Objects["content"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["content"].Size = UDim2.new(1, -12, 1, -4)
        Objects["content"].BorderSizePixel = 0
        Objects["content"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["content"].Parent = Objects["section"]

        Objects["UIListLayout"] = Instance.new("UIListLayout")
        Objects["UIListLayout"].Padding = UDim.new(0, 6)
        Objects["UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout"].Parent = Objects["content"]

        Objects["text"].Size = UDim2.new(0, Objects["text"].TextBounds.X + 14, 0, 15); -- Real Size

        Section.Objects = {
            Main = Objects["content"];
        };

        return setmetatable(Section, Library.Sections)
    end;

    function Library.Sections:Toggle(Data)
        local Toggle = {
            Section = self;
            Name = Data.Name;
            Flag = Data.Flag;
            Callback = Data.Callback or function() end;
            State = Data.Default;
            Value = false;
            Pickers = 0;
            Risky = Data.Risky or false;
        };

        local Objects = {};

        Objects["toggle"] = Instance.new("TextButton")
        Objects["toggle"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Objects["toggle"].TextColor3 = Color3.fromRGB(0, 0, 0)
        Objects["toggle"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["toggle"].Text = ""
        Objects["toggle"].BackgroundTransparency = 1
        Objects["toggle"].Name = Toggle.Name
        Objects["toggle"].Size = UDim2.new(0, 200, 0, 12)
        Objects["toggle"].BorderSizePixel = 0
        Objects["toggle"].TextSize = 14
        Objects["toggle"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["toggle"].Parent = Toggle.Section.Objects.Main

        Objects["indicator"] = Instance.new("Frame")
        Objects["indicator"].Name = "indicator"
        Objects["indicator"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["indicator"].Size = UDim2.new(0, 12, 0, 12)
        Objects["indicator"].BorderSizePixel = 0
        Objects["indicator"].BackgroundColor3 = Library.Inline
        Objects["indicator"].Parent = Objects["toggle"]

        Library:AddToRegistry(Objects["indicator"], {
            BackgroundColor3 = "Inline";
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].Color = Library.Border
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke"].Parent = Objects["indicator"]

        Library:AddToRegistry(Objects["UIStroke"], {
            Color = "Border";
        })

        Objects["UIGradient"] = Instance.new("UIGradient")
        Objects["UIGradient"].Rotation = 90
        Objects["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient"].Parent = Objects["indicator"]

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Toggle.Name
        Objects["text"].Name = "text"
        Objects["text"].Size = UDim2.new(1, 0, 1, 0)
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].Position = UDim2.new(0, 19, 0, 0)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].TextTransparency = 0.5
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["toggle"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text";
        })

        if Toggle.Risky then
            Objects["text"].TextColor3 = Library.Risky;
            Library:RemoveFromRegistry(Objects["text"]);
            Library:AddToRegistry(Objects["text"], {
                TextColor3 = "Risky";
            });
        end;

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].Parent = Objects["text"]

        function Toggle:Set(Value)
            Toggle.Value = Value;
            if Toggle.Value then
                game:GetService("TweenService"):Create(Objects["indicator"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Library.Accent}):Play();  
                game:GetService("TweenService"):Create(Objects["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextTransparency = 0}):Play();
                Library:RemoveFromRegistry(Objects["indicator"]);
                Library:AddToRegistry(Objects["indicator"], {
                    BackgroundColor3 = "Accent";
                })
            else
                game:GetService("TweenService"):Create(Objects["indicator"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundColor3 = Library.Inline}):Play();  
                game:GetService("TweenService"):Create(Objects["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextTransparency = 0.5}):Play();
                Library:RemoveFromRegistry(Objects["indicator"]);
                Library:AddToRegistry(Objects["indicator"], {
                    BackgroundColor3 = "Inline";
                })
            end;
            if Toggle.Callback then
                Toggle.Callback(Toggle.Value);
            end;
        end;

        function Toggle:SetVisibility(Boolean)
            Objects["toggle"].Visible = Boolean;
        end;

        Library:Connect(Objects["toggle"].MouseButton1Down, function()
            Toggle:Set(not Toggle.Value);
        end);

        function Toggle:Colorpicker(Data)
            local Colorpicker = {
                Section = self;
                Name = Data.Name;
                Flag = Data.Flag;
                Default = Data.Default;
                Alpha = Data.Alpha;
                Callback = Data.Callback or function() end;
            };
            self.Pickers += 1;
    
            local Picker = {
                Color = Color3.fromRGB(255,255,255), 
                Transparency = 0.1,
                IsOpen = false;
            };

    
            local SubObjects = {};
    
            SubObjects["button"] = Instance.new("TextButton")
            SubObjects["button"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            SubObjects["button"].TextColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["button"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["button"].Text = ""
            SubObjects["button"].AutoButtonColor = false
            SubObjects["button"].AnchorPoint = Vector2.new(1, 0)
            SubObjects["button"].Name = "button"
            SubObjects["button"].Position = UDim2.new(1, 14, 0, 0)
            SubObjects["button"].Size = UDim2.new(0, 22, 1, 0)
            SubObjects["button"].BorderSizePixel = 0
            SubObjects["button"].TextSize = 14
            SubObjects["button"].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            SubObjects["button"].Parent = Objects["toggle"]

            if self.Pickers == 2 then
                SubObjects["button"].Position = UDim2.new(1, -10, 0, 0);
            else
                SubObjects["button"].Position = UDim2.new(1, 14, 0, 0)
            end
    
            SubObjects["UIGradient1"] = Instance.new("UIGradient")
            SubObjects["UIGradient1"].Rotation = 90
            SubObjects["UIGradient1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
            SubObjects["UIGradient1"].Parent = SubObjects["button"]
    
            SubObjects["UIStroke2"] = Instance.new("UIStroke")
            SubObjects["UIStroke2"].Color = Library.Border
            SubObjects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke2"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SubObjects["UIStroke2"].Parent = SubObjects["button"]

            Library:AddToRegistry(SubObjects["UIStroke2"], {
                Color = "Border";
            })

            -- Window
            SubObjects["pickerwindow"] = Instance.new("Frame")
            SubObjects["pickerwindow"].Visible = false
            SubObjects["pickerwindow"].Name = "pickerwindow"
            SubObjects["pickerwindow"].Position = UDim2.new(1, 7, 0, 0)
            SubObjects["pickerwindow"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["pickerwindow"].Size = UDim2.new(0, 225, 0, 165)
            SubObjects["pickerwindow"].BorderSizePixel = 0
            SubObjects["pickerwindow"].BackgroundColor3 = Library.Background
            SubObjects["pickerwindow"].Parent = Library.MainFrame

            Library:AddToRegistry(SubObjects["pickerwindow"], {
                BackgroundColor3 = "Background";
            })
    
            SubObjects["UIStroke3"] = Instance.new("UIStroke")
            SubObjects["UIStroke3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SubObjects["UIStroke3"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke3"].Name = "border"
            SubObjects["UIStroke3"].Color = Library.Border
            SubObjects["UIStroke3"].Parent = SubObjects["pickerwindow"]

            Library:AddToRegistry(SubObjects["UIStroke3"], {
                Color = "Border";
            })
    
            SubObjects["palette"] = Instance.new("TextButton")
            SubObjects["palette"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            SubObjects["palette"].TextColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["palette"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["palette"].Text = ""
            SubObjects["palette"].AutoButtonColor = false
            SubObjects["palette"].Name = "color"
            SubObjects["palette"].Position = UDim2.new(0, 6, 0, 7)
            SubObjects["palette"].Size = UDim2.new(0, 185, 0, 150)
            SubObjects["palette"].BorderSizePixel = 0
            SubObjects["palette"].TextSize = 14
            SubObjects["palette"].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            SubObjects["palette"].Parent = SubObjects["pickerwindow"]
    
            SubObjects["sat"] = Instance.new("ImageLabel")
            SubObjects["sat"].Image = getcustomasset(Library.FolderName .. "/Utilities/Saturation.png");
            SubObjects["sat"].BackgroundTransparency = 1
            SubObjects["sat"].Name = "sat"
            SubObjects["sat"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["sat"].Size = UDim2.new(1, 0, 1, 0)
            SubObjects["sat"].BorderSizePixel = 0
            SubObjects["sat"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["sat"].Parent = SubObjects["palette"]
    
            SubObjects["val"] = Instance.new("ImageLabel")
            SubObjects["val"].Image = getcustomasset(Library.FolderName .. "/Utilities/Value.png");
            SubObjects["val"].BackgroundTransparency = 1
            SubObjects["val"].Name = "val"
            SubObjects["val"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["val"].Size = UDim2.new(1, 0, 1, 0)
            SubObjects["val"].BorderSizePixel = 0
            SubObjects["val"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["val"].Parent = SubObjects["palette"]
    
            SubObjects["UIStroke4"] = Instance.new("UIStroke")
            SubObjects["UIStroke4"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SubObjects["UIStroke4"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke4"].Name = "border"
            SubObjects["UIStroke4"].Color = Library.Border;
            SubObjects["UIStroke4"].Parent = SubObjects["palette"];

            Library:AddToRegistry(SubObjects["UIStroke4"], {
                Color = "Border";
            })
    
            SubObjects["palettedragger"] = Instance.new("Frame")
            SubObjects["palettedragger"].Name = "dragger"
            SubObjects["palettedragger"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["palettedragger"].Size = UDim2.new(0, 2, 0, 2)
            SubObjects["palettedragger"].BorderSizePixel = 0
            SubObjects["palettedragger"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["palettedragger"].Parent = SubObjects["palette"]
    
            SubObjects["UIStroke5"] = Instance.new("UIStroke")
            SubObjects["UIStroke5"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SubObjects["UIStroke5"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke5"].Name = "border"
            SubObjects["UIStroke5"].Color = Library.Border
            SubObjects["UIStroke5"].Parent = SubObjects["palettedragger"];

            Library:AddToRegistry(SubObjects["UIStroke5"], {
                Color = "Border";
            })
    
            SubObjects["hue"] = Instance.new("ImageButton")
            SubObjects["hue"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["hue"].AutoButtonColor = false
            SubObjects["hue"].AnchorPoint = Vector2.new(1, 0)
            SubObjects["hue"].Image = getcustomasset(Library.FolderName .. "/Utilities/Hue.png");
            SubObjects["hue"].Name = "hue"
            SubObjects["hue"].Position = UDim2.new(1, -8, 0, 7)
            SubObjects["hue"].Size = UDim2.new(0, 17, 0, 150)
            SubObjects["hue"].BorderSizePixel = 0
            SubObjects["hue"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["hue"].Parent = SubObjects["pickerwindow"]
    
            SubObjects["UIStroke6"] = Instance.new("UIStroke")
            SubObjects["UIStroke6"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SubObjects["UIStroke6"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke6"].Name = "border"
            SubObjects["UIStroke6"].Color = Library.Border
            SubObjects["UIStroke6"].Parent = SubObjects["hue"]

            Library:AddToRegistry(SubObjects["UIStroke6"], {
                Color = "Border";
            })
    
            SubObjects["huedragger"] = Instance.new("Frame")
            SubObjects["huedragger"].Name = "dragger"
            SubObjects["huedragger"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["huedragger"].Size = UDim2.new(1, 0, 0, 1)
            SubObjects["huedragger"].BorderSizePixel = 0
            SubObjects["huedragger"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["huedragger"].Parent = SubObjects["hue"]
    
            SubObjects["UIStroke7"] = Instance.new("UIStroke")
            SubObjects["UIStroke7"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SubObjects["UIStroke7"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke7"].Name = "border"
            SubObjects["UIStroke7"].Color = Library.Border
            SubObjects["UIStroke7"].Parent = SubObjects["huedragger"]

            Library:AddToRegistry(SubObjects["UIStroke7"], {
                Color = "Border";
            })
    
            SubObjects["shadow"] = Instance.new("ImageLabel")
            SubObjects["shadow"].ImageColor3 = Library.Accent
            SubObjects["shadow"].ScaleType = Enum.ScaleType.Slice
            SubObjects["shadow"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["shadow"].Name = "shadow"
            SubObjects["shadow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["shadow"].Size = UDim2.new(1, 75, 1, 75)
            SubObjects["shadow"].AnchorPoint = Vector2.new(0.5, 0.5)
            SubObjects["shadow"].Image = getcustomasset(Library.FolderName .. "/Utilities/Shadow.png");
            SubObjects["shadow"].BackgroundTransparency = 1
            SubObjects["shadow"].Position = UDim2.new(0.5, 0, 0.5, 0)
            SubObjects["shadow"].SliceScale = 0.75
            SubObjects["shadow"].ZIndex = -1
            SubObjects["shadow"].BorderSizePixel = 0
            SubObjects["shadow"].SliceCenter = Rect.new(Vector2.new(112, 112), Vector2.new(147, 147))
            SubObjects["shadow"].Parent = SubObjects["pickerwindow"];

            Library:AddToRegistry(SubObjects["shadow"], {
                ImageColor3 = "Accent";
            })
    
            function Colorpicker:Close()
                SubObjects["pickerwindow"].Visible = false;
            end
    
            function Colorpicker:Toggle()
                Picker.IsOpen = not Picker.IsOpen;
    
                if Picker.IsOpen then
                    if Library.CurrentColorpicker then
                        Library.CurrentColorpicker:Close();
                    end;
                    Library.CurrentColorpicker = Colorpicker;
                    SubObjects["pickerwindow"].Visible = true;
                else
                    SubObjects["pickerwindow"].Visible = false;
                end;
            end;
    
            Library:Connect(SubObjects["button"].MouseButton1Down, function()
                Colorpicker:Toggle();
            end);
    
            local Mouse = game:GetService("Players").LocalPlayer:GetMouse();
            local IsInColor2 = false;
            local IsInColor1 = false;
            local IsInTransparency = false;
            local Colors = {}; do 
                Colors.h = (math.clamp(SubObjects["huedragger"].AbsolutePosition.Y-SubObjects["hue"].AbsolutePosition.Y, 0, SubObjects["hue"].AbsoluteSize.Y)/SubObjects["hue"].AbsoluteSize.Y)
                Colors.s = 1-(math.clamp(SubObjects["palettedragger"].AbsolutePosition.X-SubObjects["palettedragger"].AbsolutePosition.X, 0, SubObjects["palettedragger"].AbsoluteSize.X)/SubObjects["palettedragger"].AbsoluteSize.X)
                Colors.v = 1-(math.clamp(SubObjects["palettedragger"].AbsolutePosition.Y-SubObjects["palettedragger"].AbsolutePosition.Y, 0, SubObjects["palettedragger"].AbsoluteSize.Y)/SubObjects["palettedragger"].AbsoluteSize.Y)
            end;
    
            function Picker:Get()
                return Color3.fromHSV(Colors.h, Colors.s, Colors.v)
            end

            function Picker:UpdateColor()
                local ColorX = (math.clamp(Mouse.X - SubObjects["palette"].AbsolutePosition.X, 0, SubObjects["palette"].AbsoluteSize.X)/SubObjects["palette"].AbsoluteSize.X)
                local ColorY = (math.clamp(Mouse.Y - SubObjects["palette"].AbsolutePosition.Y, 0, SubObjects["palette"].AbsoluteSize.Y)/SubObjects["palette"].AbsoluteSize.Y)
                SubObjects["palettedragger"].Position = UDim2.new(ColorX, 0, ColorY, 0)
    
                Colors.s = 1 - ColorX
                Colors.v = 1 - ColorY
    
                SubObjects["button"].BackgroundColor3 = Color3.fromHSV(Colors.h, Colors.s, Colors.v);
                SubObjects["palette"].BackgroundColor3 = Color3.fromHSV(Colors.h, 1, 1);
    
                local R = math.floor((Picker.Color.R * 255) * 255);
                local G = math.floor((Picker.Color.G * 255) * 255);
                local B = math.floor((Picker.Color.B * 255) * 255);
    
                local ToRGB = Color3.fromRGB(math.ceil(R), math.ceil(G), math.ceil(B));
    
                if Colorpicker.Callback then pcall(Colorpicker.Callback) end
            end;
            
            function Picker:Set(new_Value, cb)
                local NColor, NTransparency = new_Value.Color, new_Value.Transparency;
    
                Picker.Color = NColor; Picker.Transparency = NTransparency;
    
                local duplicate = Color3.new(new_Value.Color.R, new_Value.Color.G, new_Value.Color.B);
                Colors.h, Colors.s, Colors.v = duplicate:ToHSV()
                Colors.h = math.clamp(Colors.h, 0, 1)
                Colors.s = math.clamp(Colors.s, 0, 1)
                Colors.v = math.clamp(Colors.v, 0, 1)
    
                local R = math.floor((Picker.Color.R * 255) * 255);
                local G = math.floor((Picker.Color.G * 255) * 255);
                local B = math.floor((Picker.Color.B * 255) * 255);
    
                local ToRGB = Color3.fromRGB(math.ceil(R), math.ceil(G), math.ceil(B));
    
                SubObjects["button"].BackgroundColor3 = Color3.fromHSV(Colors.h, Colors.s, Colors.v);
                SubObjects["palette"].BackgroundColor3 = Color3.fromHSV(Colors.h, 1, 1);
    
                SubObjects["palettedragger"].Position = UDim2.new(1 - Colors.s, 0, 1 - Colors.v, 0)
                SubObjects["huedragger"].Position = UDim2.new(0, 0, 1 - Colors.h, -1)
                
                if Colorpicker.Callback then pcall(Colorpicker.Callback) end;
    
                if cb == nil or not cb then
                end;
            end;
    
            function Picker:UpdateHue()
                local y = math.clamp(Mouse.Y - SubObjects["hue"].AbsolutePosition.Y, 0, 150)
                SubObjects["huedragger"].Position = UDim2.new(0, 0, 0, y)
                local hue = y/150
                Colors.h = 1-hue
                SubObjects["palette"].BackgroundColor3 = Color3.fromHSV(Colors.h, 1, 1)
                SubObjects["button"].BackgroundColor3 = Color3.fromHSV(Colors.h, Colors.s, Colors.v)
                local R = math.floor((Picker.Color.R * 255) * 255);
                local G = math.floor((Picker.Color.G * 255) * 255);
                local B = math.floor((Picker.Color.B * 255) * 255);
    
                local ToRGB = Color3.fromRGB(math.ceil(R), math.ceil(G), math.ceil(B));
            end;
    
            Library:Connect(SubObjects["palette"].MouseButton1Down, function()
                Picker:UpdateColor()
                local MoveConnection = Mouse.Move:Connect(function()
                    Picker:UpdateColor()
                end)
                local ReleaseConnection
                ReleaseConnection = Library:Connect(game:GetService("UserInputService").InputEnded, function(Mouse)
                    if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                        Picker:UpdateColor()
                        MoveConnection:Disconnect()
                        ReleaseConnection:Disconnect()
                    end
                end)
            end);
    
            Library:Connect(SubObjects["hue"].MouseButton1Down, function()
                Picker:UpdateHue()
                local MoveConnection = Mouse.Move:Connect(function()
                    Picker:UpdateHue()
                end)
                local ReleaseConnection
                ReleaseConnection = Library:Connect(game:GetService("UserInputService").InputEnded, function(Mouse)
                    if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                        Picker:UpdateHue()
                        MoveConnection:Disconnect()
                        ReleaseConnection:Disconnect()
                    end
                end)
            end);
    
            Picker:Set({Color = Colorpicker.Default, Transparency = Colorpicker.Alpha}, true)
            Library.Flags[Colorpicker.Flag] = Picker;
            if Colorpicker.Callback then Colorpicker.Callback(Picker:Get()) end;
            return Colorpicker;
        end;

        function Toggle:Keybind(Data)
            local Keybind = {
                Section = self;
                Name = Data.Name;
                Flag = Data.Flag;
                Mode = Data.Mode;
                IsEnabled = false;
                Callback = Data.Callback or function() end;
                IsBeingSelected = false;
                Default = Data.Default;
                Components = nil;
                AbKey = "";
            };
    
            local SubObjects = {};
    
            SubObjects["key"] = Instance.new("TextButton")
            SubObjects["key"].FontFace = LibFont
            SubObjects["key"].TextColor3 = Library.Text
            SubObjects["key"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["key"].Text = "[MB2]"
            SubObjects["key"].Name = "key"
            SubObjects["key"].AnchorPoint = Vector2.new(1, 0)
            SubObjects["key"].Size = UDim2.new(0, 0, 1, 0)
            SubObjects["key"].BackgroundTransparency = 1
            SubObjects["key"].Position = UDim2.new(1, 14, 0, 0)
            SubObjects["key"].BorderSizePixel = 0
            SubObjects["key"].AutomaticSize = Enum.AutomaticSize.X
            SubObjects["key"].TextSize = 12
            SubObjects["key"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["key"].Parent = Objects["toggle"]

            Library:AddToRegistry(SubObjects["key"], {
                TextColor3 = Library.Text;
            })
    
            SubObjects["UIStroke2"] = Instance.new("UIStroke")
            SubObjects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke2"].Parent = SubObjects["key"]
    
            local KeyObject = Library.KeybindList:AddNewKey("None", "None");

            function Keybind:Set(Key, IsMouse)
                if not IsMouse then 
                    if Key and (type(Key) == "table" or typeof(Key) == "EnumItem") and Key.Name then
                        Keybind.IsBeingSelected = true;
    
                        if Keys[Key.Name] then 
                            KeyObject:Set(Keys[Key.Name], Toggle.Name);
                            SubObjects["key"].Text = "["..Keys[Key.Name].."]";
                            Keybind.AbKey = Keys[Key.Name]
                        else 
                            KeyObject:Set(Key.Name:sub(1, 2), Toggle.Name);
                            SubObjects["key"].Text = "["..Key.Name:sub(1, 2).."]";
    
                            Keybind.AbKey = Key.Name:sub(1, 2)
                        end;
    
                        if type(Key) == "table" and Key.Name ~= "" then
                            Keybind.Key = Enum.KeyCode[Key.Name];
                        else 
                            Keybind.Key = Key;
                        end;
                        Keybind.IsBeingSelected = false;
                    end;
                    game:GetService("TweenService"):Create(SubObjects["key"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                else
                    if type(Key) == "table" then 
                        Key = Enum.UserInputType[Key.Name];
                    end
                    Keybind.IsBeingSelected = true; 
                    local Shortened = "";
                    if Key == Enum.UserInputType.MouseButton1 then 
                        Shortened = "M1";
                    elseif Key == Enum.UserInputType.MouseButton2 then 
                        Shortened = "M2";
                    elseif Key == Enum.UserInputType.MouseButton3 then 
                        Shortened = "M3";
                    elseif Key == Enum.UserInputType.MouseWheel then 
                        Shortened = "M4";
                    end;
    
                    Keybind.Key = Key;
                    Keybind.AbKey = Shortened;
    
                    KeyObject:Set(Shortened, Toggle.Name);
                    SubObjects["key"].Text = "["..Shortened.."]";
                    Keybind.IsBeingSelected = false
                    game:GetService("TweenService"):Create(SubObjects["key"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                end;
            end;
    
            Library:Connect(SubObjects["key"].MouseButton1Down, function()
                task.wait(0.1)
                game:GetService("TweenService"):Create(SubObjects["key"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Accent}):Play();
                Keybind.IsBeingSelected = true;
    
                Library:Connect(game:GetService("UserInputService").InputBegan, function(Input)
                    if Input.UserInputType == Enum.UserInputType.Keyboard and Keybind.IsBeingSelected then
                        Keybind:Set(Input.KeyCode);
                        Keybind.IsBeingSelected = false;
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.IsBeingSelected then 
                        Keybind:Set(Enum.UserInputType.MouseButton1, true)
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and Keybind.IsBeingSelected then 
                        Keybind:Set(Enum.UserInputType.MouseButton2, true)
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton3 and Keybind.IsBeingSelected then 
                        Keybind:Set(Enum.UserInputType.MouseButton3, true)
                    elseif Input.UserInputType == Enum.UserInputType.MouseWheel and Keybind.IsBeingSelected then 
                        Keybind:Set(Enum.UserInputType.MouseWheel, true)
                    else 
                        Keybind.IsBeingSelected = false;
                    end;
                end);
            end);
    
            Library:Connect(game:GetService("UserInputService").InputBegan,  function(Input)
                if Input.KeyCode == Keybind["Key"] and not Keybind.IsBeingSelected then 
                    if Keybind["Mode"] == "Toggle" then 
                        Keybind.Value = not Keybind.Value;
                        Keybind.Callback(Keybind.Value)
                    elseif Keybind["Mode"] == "Hold" then 
                        Keybind.Value = true;
                        Keybind.Callback(Keybind.Value)
                    elseif Keybind["Mode"] == "Press" then 
                        Keybind.Callback(Keybind.Value)
                    end;
                end
    
                if Input.UserInputType == Keybind["Key"] and not Keybind.IsBeingSelected then 
                    if Keybind["Mode"] == "Toggle" then 
                        Keybind.Value = not Keybind.Value;
                        Keybind.Callback(Keybind.Value)
                    elseif Keybind["Mode"] == "Hold" then 
                        Keybind.Value = true;
                        Keybind.Callback(Keybind.Value)
                    elseif Keybind["Mode"] == "Press" then 
                        Keybind.Callback(Keybind.Value)
                    end
                end

                KeyObject:SetVisiblity(Keybind.Value and Toggle.Value);
            end)
    
            Library:Connect(game:GetService("UserInputService").InputEnded, function(Input)
                if Input.KeyCode == Keybind["Key"] and not Keybind.IsBeingSelected then 
                    if Keybind["Mode"] == "Hold" then
                        Keybind.Value = false;
                        if Data.Callback then Data.Callback(Keybind.Value) end;
                    end
                end
    
                if Input.UserInputType == Keybind["Key"] and not Keybind.IsBeingSelected then 
                    if Keybind["Mode"] == "Hold" then 
                        Keybind.Value = false;
                        Keybind.Callback(Keybind.Value)
                    end
                end

                KeyObject:SetVisiblity(Keybind.Value and Toggle.Value);
            end);
    
            function Keybind:Get()
                return Keybind.Value
            end
    
            if Keybind.Default then 
                Keybind:Set(Keybind.Default);
            end;
    
            Library.Flags[Keybind.Flag] = Keybind;
            return Keybind;
        end;

        if Toggle.State then
            Toggle:Set(Toggle.State);
        end;
        
        function Toggle:Get()
            return Toggle.Value;
        end
        
        Library.Flags[Toggle.Flag] = Toggle;
        return Toggle;
    end;

    function Library.Sections:Button(Data)
        local Button = {
            Section = self;
            Name = Data.Name;
            Callback = Data.Callback or function() end;
        };

        local Objects = {};

        Objects["button"] = Instance.new("TextButton")
        Objects["button"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Objects["button"].TextColor3 = Color3.fromRGB(0, 0, 0)
        Objects["button"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["button"].Text = ""
        Objects["button"].AutoButtonColor = false
        Objects["button"].Name = "button"
        Objects["button"].Size = UDim2.new(1, 0, 0, 15)
        Objects["button"].BorderSizePixel = 0
        Objects["button"].TextSize = 14
        Objects["button"].BackgroundColor3 =Library.Inline
        Objects["button"].Parent = Button.Section.Objects.Main

        Library:AddToRegistry(Objects["button"], {
            BackgroundColor3 = "Inline"
        })

        Objects["UIGradient"] = Instance.new("UIGradient")
        Objects["UIGradient"].Rotation = 90
        Objects["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient"].Parent = Objects["button"]

        Objects["UIStroke1"] = Instance.new("UIStroke")
        Objects["UIStroke1"].Color = Library.Border
        Objects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke1"].Parent = Objects["button"]

        Library:AddToRegistry(Objects["UIStroke1"], {
            Color = "Border"
        })

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Button.Name
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].Name = "text"
        Objects["text"].Size = UDim2.new(1, 0, 1, 0)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["button"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].Parent = Objects["text"]

        function Button:Sub(Data)
            local SubButton = {
                Name = Data.Name;
                Callback = Data.Callback or function() end;
            };
    
            local SubObjects = {};

            Objects["button"].Size = UDim2.new(0.487,0,0,15);

            SubObjects["sub"] = Instance.new("TextButton")
            SubObjects["sub"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            SubObjects["sub"].TextColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["sub"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["sub"].Text = ""
            SubObjects["sub"].AutoButtonColor = false
            SubObjects["sub"].Name = "sub"
            SubObjects["sub"].Position = UDim2.new(1, 5, 0, 0)
            SubObjects["sub"].Size = UDim2.new(1, 0, 0, 15)
            SubObjects["sub"].BorderSizePixel = 0
            SubObjects["sub"].TextSize = 14
            SubObjects["sub"].BackgroundColor3 = Library.Inline
            SubObjects["sub"].Parent = Objects["button"]

            SubObjects["UIGradient"] = Instance.new("UIGradient")
            SubObjects["UIGradient"].Rotation = 90
            SubObjects["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
            SubObjects["UIGradient"].Parent = SubObjects["sub"]

            SubObjects["UIStroke1"] = Instance.new("UIStroke")
            SubObjects["UIStroke1"].Color = Library.Border
            SubObjects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SubObjects["UIStroke1"].Parent = SubObjects["sub"]

            SubObjects["text"] = Instance.new("TextLabel")
            SubObjects["text"].FontFace = LibFont
            SubObjects["text"].TextColor3 = Library.Text
            SubObjects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            SubObjects["text"].Text = SubButton.Name
            SubObjects["text"].BackgroundTransparency = 1
            SubObjects["text"].Name = "text"
            SubObjects["text"].Size = UDim2.new(1, 0, 1, 0)
            SubObjects["text"].BorderSizePixel = 0
            SubObjects["text"].TextSize = 12
            SubObjects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SubObjects["text"].Parent = SubObjects["sub"]

            SubObjects["UIStroke"] = Instance.new("UIStroke")
            SubObjects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
            SubObjects["UIStroke"].Parent = SubObjects["text"]

            Library:AddToRegistry(SubObjects["sub"], {
                BackgroundColor3 = "Inline"
            })

            Library:AddToRegistry(SubObjects["UIStroke1"], {
                Color = "Border"
            })

            Library:AddToRegistry(SubObjects["text"], {
                TextColor3 = "Text"
            })

            Library:Connect(SubObjects["sub"].MouseButton1Down, function()
                if SubButton.Callback then
                    game:GetService("TweenService"):Create(SubObjects["UIStroke1"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Color = Library.Accent}):Play();
                    Library:RemoveFromRegistry(SubObjects["UIStroke1"]);
                    Library:AddToRegistry(SubObjects["UIStroke1"], {
                        Color = "Accent"
                    })
                    task.wait(0.1);
                    Library:RemoveFromRegistry(SubObjects["UIStroke1"]);
                    Library:AddToRegistry(SubObjects["UIStroke1"], {
                        Color = "Border"
                    })
                    pcall(SubButton.Callback);
                    game:GetService("TweenService"):Create(SubObjects["UIStroke1"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Color = Library.Border}):Play();
                end;
            end);
        
            return SubButton
        end

        Library:Connect(Objects["button"].MouseButton1Down, function()
            if Button.Callback then
                game:GetService("TweenService"):Create(Objects["UIStroke1"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Color = Library.Accent}):Play();
                Library:RemoveFromRegistry(Objects["UIStroke1"]);
                Library:AddToRegistry(Objects["UIStroke1"], {
                    Color = "Accent"
                })
                task.wait(0.1);
                Library:RemoveFromRegistry(Objects["UIStroke1"]);
                Library:AddToRegistry(Objects["UIStroke1"], {
                    Color = "Border"
                })
                pcall(Button.Callback);
                game:GetService("TweenService"):Create(Objects["UIStroke1"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Color = Library.Border}):Play();
            end;
        end);

        return Button;
    end;

    function Library.Sections:Slider(Data)
        local Slider = {
            Section = self;
            Name = Data.Name;
            Min = Data.Min;
            Max = Data.Max;
            Suffix = Data.Sub;
            State = Data.Default;
            Flag = Data.Flag;
            Value = 0;
            Decimals = Data.Decimals;
            Callback = Data.Callback or function() end
        };

        local TextValue = ("[value]" .. Slider.Suffix);

        local Objects = {};
        
        Objects["slider"] = Instance.new("Frame")
        Objects["slider"].BackgroundTransparency = 1
        Objects["slider"].Name = "slider"
        Objects["slider"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["slider"].Size = UDim2.new(1, 0, 0, 25)
        Objects["slider"].BorderSizePixel = 0
        Objects["slider"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["slider"].Parent = Slider.Section.Objects.Main

        function Slider:SetVisibility(Boolean)
            Objects["slider"].Visible = Boolean;
        end;

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Slider.Name
        Objects["text"].Name = "text"
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].Size = UDim2.new(1, 0, 0, 13)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["slider"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].Parent = Objects["text"]

        Objects["realslider"] = Instance.new("TextButton")
        Objects["realslider"].AnchorPoint = Vector2.new(0, 1)
        Objects["realslider"].Name = "realslider"
        Objects["realslider"].Position = UDim2.new(0, 0, 1, 0)
        Objects["realslider"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["realslider"].Size = UDim2.new(1, 0, 0, 8)
        Objects["realslider"].BorderSizePixel = 0
        Objects["realslider"].BackgroundColor3 = Library.Inline
        Objects["realslider"].Parent = Objects["slider"]
        Objects["realslider"].AutoButtonColor = false;
        Objects["realslider"].Text = ""

        Library:AddToRegistry(Objects["realslider"], {
            BackgroundColor3 = "Inline"
        })

        Objects["UIStroke1"] = Instance.new("UIStroke")
        Objects["UIStroke1"].Color = Library.Border
        Objects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke1"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke1"].Parent = Objects["realslider"]

        Library:AddToRegistry(Objects["UIStroke1"], {
            Color = "Border"
        })

        Objects["indicator"] = Instance.new("Frame")
        Objects["indicator"].Name = "indicator"
        Objects["indicator"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["indicator"].Size = UDim2.new(0.6499999761581421, 0, 1, 0)
        Objects["indicator"].BorderSizePixel = 0
        Objects["indicator"].BackgroundColor3 = Library.Accent
        Objects["indicator"].Parent = Objects["realslider"]

        Library:AddToRegistry(Objects["indicator"], {
            BackgroundColor3 = "Accent"
        })

        Objects["UIGradient1"] = Instance.new("UIGradient")
        Objects["UIGradient1"].Rotation = 90
        Objects["UIGradient1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient1"].Parent = Objects["indicator"]

        Objects["UIGradient2"] = Instance.new("UIGradient")
        Objects["UIGradient2"].Rotation = 90
        Objects["UIGradient2"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient2"].Parent = Objects["realslider"]

        Objects["value"] = Instance.new("TextLabel")
        Objects["value"].FontFace = LibFont;
        Objects["value"].TextColor3 = Library.Text;
        Objects["value"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["value"].Text = "65/100"
        Objects["value"].BackgroundTransparency = 1
        Objects["value"].Name = "value"
        Objects["value"].Size = UDim2.new(1, 0, 1, 0)
        Objects["value"].BorderSizePixel = 0
        Objects["value"].TextSize = 12
        Objects["value"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["value"].Parent = Objects["realslider"]

        Library:AddToRegistry(Objects["value"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].Parent = Objects["value"]

        local Sliding = false;
        local Val = Slider.State;

        local function Set(value)
            value = math.clamp(Library:Round(value, Slider.Decimals), Slider.Min, Slider.Max);

            local SizeX = ((value - Slider.Min) / (Slider.Max - Slider.Min));
            Objects["indicator"].Size = UDim2.new(SizeX, 0, 1, 0);
            Objects["value"].Text = TextValue:gsub("%[value%]", string.format("%.14g", value));
            Val = value;

            if Slider.Callback then
                Slider.Callback(Val);
            end;
        end;

        function Slider:Get()
            return Val;
        end;

        local function InputSlide(input)
            local SizeX = (input.Position.X - Objects["realslider"].AbsolutePosition.X) / Objects["realslider"].AbsoluteSize.X;
            local value = ((Slider.Max - Slider.Min) * SizeX) + Slider.Min;
            Set(value);
        end;

        Library:Connect(Objects["indicator"].InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = true;
                InputSlide(input);
            end;
        end);

        Library:Connect(Objects["indicator"].InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = false;
            end;
        end);

        Library:Connect(Objects["realslider"].InputBegan, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = true;
                InputSlide(input);
            end;
        end);

        Library:Connect(Objects["realslider"].InputEnded, function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                Sliding = false;
            end;
        end);

        Library:Connect(game:GetService("UserInputService").InputChanged, function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if Sliding then
                    InputSlide(input);
                end;
            end;
        end);
        
        function Slider:Set(Value)
            Set(Value);
        end;

        if Slider.State then
            Slider:Set(Slider.State);
        end;

        Library.Flags[Slider.Flag] = Slider;
        return Slider
    end;
    function Library.Sections:Dropdown(Data)
        local Dropdown = {
            Section = self;
            Flag = Data.Flag;
            Name = Data.Name or 'Dropdown';
            Default = Data.Default or nil;
            Options = {};
            Multi = Data.Multi or false;
            Callback = Data.Callback or function() end;
            Value = nil;
            Compact = Data.Compact or false;
        };

        local Objects = {};

        Objects["dropdown"] = Instance.new("Frame")
        Objects["dropdown"].BackgroundTransparency = 1
        Objects["dropdown"].Name = "dropdown"
        Objects["dropdown"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["dropdown"].Size = UDim2.new(1, 0, 0, 31)
        Objects["dropdown"].BorderSizePixel = 0
        Objects["dropdown"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["dropdown"].Parent = Dropdown.Section.Objects.Main

        function Dropdown:SetVisibility(Boolean)
            Objects["dropdown"].Visible = Boolean;
        end;

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Dropdown.Name
        Objects["text"].Name = "text"
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].Size = UDim2.new(1, 0, 0, 13)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["dropdown"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke1"] = Instance.new("UIStroke")
        Objects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke1"].Parent = Objects["text"]

        Objects["realdropdown"] = Instance.new("Frame")
        Objects["realdropdown"].AnchorPoint = Vector2.new(0, 1)
        Objects["realdropdown"].Name = "realdropdown"
        Objects["realdropdown"].Position = UDim2.new(0, 0, 1, 0)
        Objects["realdropdown"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["realdropdown"].Size = UDim2.new(1, 0, 0, 14)
        Objects["realdropdown"].BorderSizePixel = 0
        Objects["realdropdown"].BackgroundColor3 = Library.Inline
        Objects["realdropdown"].Parent = Objects["dropdown"]

        Library:AddToRegistry(Objects["realdropdown"], {
            BackgroundColor3 = "Inline"
        })

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].Color = Library.Border
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke2"].Parent = Objects["realdropdown"]

        Library:AddToRegistry(Objects["UIStroke2"], {
            Color = Library.Border
        })

        Objects["UIGradient1"] = Instance.new("UIGradient")
        Objects["UIGradient1"].Rotation = 90
        Objects["UIGradient1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient1"].Parent = Objects["realdropdown"]

        Objects["value"] = Instance.new("TextLabel")
        Objects["value"].FontFace = LibFont
        Objects["value"].TextColor3 = Library.Text;
        Objects["value"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["value"].Text = "Penis"
        Objects["value"].Name = "value"
        Objects["value"].Size = UDim2.new(1, -20, 1, 0)
        Objects["value"].BackgroundTransparency = 1
        Objects["value"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["value"].Position = UDim2.new(0, 5, 0, 0)
        Objects["value"].BorderSizePixel = 0
        Objects["value"].TextSize = 12
        Objects["value"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["value"].Parent = Objects["realdropdown"]

        Library:AddToRegistry(Objects["value"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke3"] = Instance.new("UIStroke")
        Objects["UIStroke3"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke3"].Parent = Objects["value"]

        Objects["open1"] = Instance.new("TextButton")
        Objects["open1"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Objects["open1"].TextColor3 = Color3.fromRGB(0, 0, 0)
        Objects["open1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["open1"].Text = ""
        Objects["open1"].BackgroundTransparency = 1
        Objects["open1"].Name = "open"
        Objects["open1"].Size = UDim2.new(1, 0, 1, 0)
        Objects["open1"].BorderSizePixel = 0
        Objects["open1"].TextSize = 14
        Objects["open1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["open1"].Parent = Objects["realdropdown"]

        Objects["open2"] = Instance.new("TextLabel")
        Objects["open2"].FontFace = LibFont
        Objects["open2"].TextColor3 = Library.Text
        Objects["open2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["open2"].Text = "+"
        Objects["open2"].Name = "open"
        Objects["open2"].AnchorPoint = Vector2.new(1, 0)
        Objects["open2"].Size = UDim2.new(0, 15, 0, 15)
        Objects["open2"].BackgroundTransparency = 1
        Objects["open2"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["open2"].Position = UDim2.new(1, 4, 0, -2)
        Objects["open2"].BorderSizePixel = 0
        Objects["open2"].TextSize = 12
        Objects["open2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["open2"].Parent = Objects["realdropdown"]

        Library:AddToRegistry(Objects["open2"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke4"] = Instance.new("UIStroke")
        Objects["UIStroke4"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke4"].Parent = Objects["open"]

        Objects["optionholder"] = Instance.new("Frame")
        Objects["optionholder"].Visible = false
        Objects["optionholder"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["optionholder"].Name = "optionholder"
        Objects["optionholder"].Position = UDim2.new(0, 0, 1, 4)
        Objects["optionholder"].Size = UDim2.new(1, 0, 0, 15)
        Objects["optionholder"].BorderSizePixel = 0
        Objects["optionholder"].AutomaticSize = Enum.AutomaticSize.Y
        Objects["optionholder"].BackgroundColor3 = Library.Inline
        Objects["optionholder"].Parent = Objects["dropdown"]

        Library:AddToRegistry(Objects["optionholder"], {
            BackgroundColor3 = "Inline"
        })

        Objects["UIStroke5"] = Instance.new("UIStroke")
        Objects["UIStroke5"].Color = Library.Border
        Objects["UIStroke5"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke5"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke5"].Parent = Objects["optionholder"]

        Library:AddToRegistry(Objects["UIStroke5"], {
            Color = Library.Border
        })

        Objects["UIGradient2"] = Instance.new("UIGradient")
        Objects["UIGradient2"].Rotation = 90
        Objects["UIGradient2"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient2"].Parent = Objects["optionholder"]

        Objects["UIListLayout"] = Instance.new("UIListLayout")
        Objects["UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout"].Parent = Objects["optionholder"]

        function Dropdown:Toggle()
            Objects["optionholder"].Visible = not Objects["optionholder"].Visible;

            if Objects["optionholder"].Visible then
                for Index, Value in Objects["dropdown"]:GetDescendants() do
                    if not string.find(Value.ClassName, "UI") then
                        Value.ZIndex = 15;
                    end
                end
                Objects["open2"].Text = "-";
                Objects["open2"].Position = UDim2.new(1, 7, 0, -2)
            else
                for Index, Value in Objects["dropdown"]:GetDescendants() do
                    if not string.find(Value.ClassName, "UI") then
                        Value.ZIndex = 1;
                    end
                end
                Objects["open2"].Position = UDim2.new(1, 4, 0, -2)
                Objects["open2"].Text = "+";
            end;
        end

        Library:Connect(Objects["open1"].MouseButton1Down, function()
            Dropdown:Toggle();
        end);

        function Dropdown:Set(Value)
            if Dropdown.Options[Value] then
                Dropdown.Value = Value;
                Objects["value"].Text = tostring(Value); 
                Dropdown.Options[Value].IsSelected = true;
                Library:RemoveFromRegistry(Dropdown.Options[Value].Text);
                Library:AddToRegistry(Dropdown.Options[Value].Text, {
                    TextColor3 = "Accent"
                })
                game:GetService("TweenService"):Create(Dropdown.Options[Value].Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Accent}):Play();
                game:GetService("TweenService"):Create(Dropdown.Options[Value].Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,9,0,-1)}):Play();
                game:GetService("TweenService"):Create(Dropdown.Options[Value].Selector, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play();
            end;

            for Index, Val in pairs(Dropdown.Options) do 
                if Val ~= Dropdown.Options[Value] then 
                    Val.IsSelected = false; 
                    Library:RemoveFromRegistry(Val.Text);
                    Library:AddToRegistry(Val.Text, {
                        TextColor3 = "Text"
                    })
                    game:GetService("TweenService"):Create(Val.Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                    game:GetService("TweenService"):Create(Val.Selector, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(Val.Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,4,0,-1)}):Play();
                end;    
            end;

            if Dropdown.Callback then Dropdown.Callback(Dropdown.Value); end;
        end;

        function Dropdown:AddOption(Name)
            local OptionInsts = {};

            OptionInsts["option"] = Instance.new("TextButton")
            OptionInsts["option"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            OptionInsts["option"].TextColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["option"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["option"].Text = ""
            OptionInsts["option"].BackgroundTransparency = 1
            OptionInsts["option"].Name = "option"
            OptionInsts["option"].Size = UDim2.new(1, 0, 0, 15)
            OptionInsts["option"].BorderSizePixel = 0
            OptionInsts["option"].TextSize = 14
            OptionInsts["option"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            OptionInsts["option"].Parent = Objects["optionholder"]

            OptionInsts["text"] = Instance.new("TextLabel")
            OptionInsts["text"].FontFace = LibFont;
            OptionInsts["text"].TextColor3 = Library.Text
            OptionInsts["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["text"].Text = Name
            OptionInsts["text"].Name = "text"
            OptionInsts["text"].Size = UDim2.new(1, 0, 1, 0)
            OptionInsts["text"].BackgroundTransparency = 1
            OptionInsts["text"].TextXAlignment = Enum.TextXAlignment.Left
            OptionInsts["text"].Position = UDim2.new(0, 5, 0, -1)
            OptionInsts["text"].BorderSizePixel = 0
            OptionInsts["text"].TextSize = 12
            OptionInsts["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            OptionInsts["text"].Parent = OptionInsts["option"]

            Library:AddToRegistry(OptionInsts["text"], {
                TextColor3 = "Text";
            })

            OptionInsts["UIStroke"] = Instance.new("UIStroke")
            OptionInsts["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
            OptionInsts["UIStroke"].Parent = OptionInsts["text"]

            OptionInsts["liner"] = Instance.new("Frame")
            OptionInsts["liner"].BackgroundTransparency = 1
            OptionInsts["liner"].Name = "liner"
            OptionInsts["liner"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["liner"].Size = UDim2.new(0, 1, 1, 0)
            OptionInsts["liner"].BorderSizePixel = 0
            OptionInsts["liner"].BackgroundColor3 = Library.Accent
            OptionInsts["liner"].Parent = OptionInsts["option"]

            Library:AddToRegistry(OptionInsts["liner"], {
                BackgroundColor3 = "Accent";
            })

            local Option = {
                Name = Name;
                IsSelected = false;
                Selector = OptionInsts["liner"];
                Text = OptionInsts["text"];
                Button = OptionInsts["option"];
            };
            Library:Connect(OptionInsts["option"].MouseButton1Down, function()
                Option.IsSelected = not Option.IsSelected

                for Index, Value in next, Dropdown.Options do 
                    if Value ~= Option then 
                        Value.IsSelected = false;
                        Library:RemoveFromRegistry(Value.Text);
                        Library:AddToRegistry(Value.Text, {
                            TextColor3 = "Text"
                        })
                        game:GetService("TweenService"):Create(Value.Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                        game:GetService("TweenService"):Create(Value.Selector, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                        game:GetService("TweenService"):Create(Value.Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,4,0,-1)}):Play();
                    end;
                end;
                
                if Option.IsSelected then 
                    Dropdown:Set(Option.Name);
                else
                    Library:RemoveFromRegistry(OptionInsts["text"]);
                    Library:AddToRegistry(OptionInsts["text"], {
                        TextColor3 = "Text"
                    })
                    game:GetService("TweenService"):Create(OptionInsts["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                    game:GetService("TweenService"):Create(OptionInsts["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,4,0,-1)}):Play();
                    game:GetService("TweenService"):Create(OptionInsts["liner"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                end;
            end)
            Dropdown.Options[Option.Name] = Option;

            return Option;
        end;

        function Dropdown:RemoveOption(Name)
            if Dropdown.Options[Name] then
                Dropdown.Options[Name].Button:Destroy();
                Dropdown.Options[Name] = nil;
            end;
        end;

        function Dropdown:Get()
            return Dropdown.Value
        end;

        for Index, Value in Data.Options do
            Dropdown:AddOption(Value);
        end;

        if Dropdown.Default then
            Dropdown:Set(Dropdown.Default);
        else 
            Dropdown:Set(Data.Options[1])
        end;

        Library.Flags[Dropdown.Flag] = Dropdown;
        return Dropdown
    end;

    function Library.Sections:Keybind(Data)
        local Keybind = {
            Section = self;
            Name = Data.Name;
            Flag = Data.Flag;
            Mode = Data.Mode;
            IsEnabled = false;
            Callback = Data.Callback or function() end;
            IsBeingSelected = false;
            Default = Data.Default;
            Components = nil;
            AbKey = "";
        };

        local Objects = {};

        Objects["keybind"] = Instance.new("Frame")
        Objects["keybind"].BackgroundTransparency = 1
        Objects["keybind"].Name = "keybind"
        Objects["keybind"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["keybind"].Size = UDim2.new(1, 0, 0, 15)
        Objects["keybind"].BorderSizePixel = 0
        Objects["keybind"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["keybind"].Parent = Keybind.Section.Objects.Main

        function Keybind:SetVisibility(Boolean)
            Objects["keybind"].Visible = Boolean;
        end;

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Keybind.Name
        Objects["text"].Name = "text"
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].Size = UDim2.new(1, 0, 1, 0)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["keybind"]

        Library:AddToRegistry(Objects["text"], {
            TextColor = "Text"
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].Parent = Objects["text"]

        Objects["key"] = Instance.new("TextButton")
        Objects["key"].FontFace = LibFont
        Objects["key"].TextColor3 = Library.Text
        Objects["key"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["key"].Text = "[MB2]"
        Objects["key"].Name = "key"
        Objects["key"].AnchorPoint = Vector2.new(1, 0)
        Objects["key"].Size = UDim2.new(0, 0, 1, 0)
        Objects["key"].BackgroundTransparency = 1
        Objects["key"].Position = UDim2.new(1, 0, 0, 0)
        Objects["key"].BorderSizePixel = 0
        Objects["key"].AutomaticSize = Enum.AutomaticSize.X
        Objects["key"].TextSize = 12
        Objects["key"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["key"].Parent = Objects["keybind"]

        Library:AddToRegistry(Objects["key"], {
            TextColor = "Text"
        })

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].Parent = Objects["key"]

        local KeyObject = Library.KeybindList:AddNewKey("None", "None");

        function Keybind:Set(Key, IsMouse)
            if not IsMouse then 
                if Key and (type(Key) == "table" or typeof(Key) == "EnumItem") and Key.Name then
                    Keybind.IsBeingSelected = true;

                    if Keys[Key.Name] then 
                        KeyObject:Set(Keys[Key.Name], Keybind.Name);
                        Objects["key"].Text = "["..Keys[Key.Name].."]";
                        Keybind.AbKey = Keys[Key.Name]
                    else 
                        KeyObject:Set(Key.Name:sub(1, 2), Keybind.Name);
                        Objects["key"].Text = "["..Key.Name:sub(1, 2).."]";

                        Keybind.AbKey = Key.Name:sub(1, 2)
                    end;

                    if type(Key) == "table" and Key.Name ~= "" then

                    
                        Keybind.Key = Enum.KeyCode[Key.Name];
                    else 
                        Keybind.Key = Key;
                    end;
                    Keybind.IsBeingSelected = false;
                end;
                Library:RemoveFromRegistry(Objects["key"])
                Library:AddToRegistry(Objects["key"], {
                    TextColor = "Text"
                })
                game:GetService("TweenService"):Create(Objects["key"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
            else
                if type(Key) == "table" then 
                    Key = Enum.UserInputType[Key.Name];
                end
                Keybind.IsBeingSelected = true; 
                local Shortened = "";
                if Key == Enum.UserInputType.MouseButton1 then 
                    Shortened = "M1";
                elseif Key == Enum.UserInputType.MouseButton2 then 
                    Shortened = "M2";
                elseif Key == Enum.UserInputType.MouseButton3 then 
                    Shortened = "M3";
                elseif Key == Enum.UserInputType.MouseWheel then 
                    Shortened = "M4";
                end;

                Keybind.Key = Key;
                Keybind.AbKey = Shortened;

                Objects["key"].Text = "["..Shortened.."]";
                KeyObject:Set(Shortened, Keybind.Name);
                Keybind.IsBeingSelected = false
                Library:RemoveFromRegistry(Objects["key"])
                Library:AddToRegistry(Objects["key"], {
                    TextColor = "Text"
                })
                game:GetService("TweenService"):Create(Objects["key"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
            end;
        end;

        Library:Connect(Objects["key"].MouseButton1Down, function()
            task.wait(0.1)
            Library:RemoveFromRegistry(Objects["key"])
            Library:AddToRegistry(Objects["key"], {
                TextColor = "Accent"
            })
            game:GetService("TweenService"):Create(Objects["key"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Accent}):Play();
            Keybind.IsBeingSelected = true;

            Library:Connect(game:GetService("UserInputService").InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.Keyboard and Keybind.IsBeingSelected then
                    Keybind:Set(Input.KeyCode);
                    Keybind.IsBeingSelected = false;
                elseif Input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.IsBeingSelected then 
                    Keybind:Set(Enum.UserInputType.MouseButton1, true)
                elseif Input.UserInputType == Enum.UserInputType.MouseButton2 and Keybind.IsBeingSelected then 
                    Keybind:Set(Enum.UserInputType.MouseButton2, true)
                elseif Input.UserInputType == Enum.UserInputType.MouseButton3 and Keybind.IsBeingSelected then 
                    Keybind:Set(Enum.UserInputType.MouseButton3, true)
                elseif Input.UserInputType == Enum.UserInputType.MouseWheel and Keybind.IsBeingSelected then 
                    Keybind:Set(Enum.UserInputType.MouseWheel, true)
                else 
                    Keybind.IsBeingSelected = false;
                end;
            end);
        end);

        Library:Connect(game:GetService("UserInputService").InputBegan,  function(Input)
            if Input.KeyCode == Keybind["Key"] and not Keybind.IsBeingSelected then 
                if Keybind["Mode"] == "Toggle" then 
                    Keybind.Value = not Keybind.Value;
                    Keybind.Callback(Keybind.Value)
                elseif Keybind["Mode"] == "Hold" then 
                    Keybind.Value = true;
                    Keybind.Callback(Keybind.Value)
                elseif Keybind["Mode"] == "Press" then 
                    Keybind.Callback(Keybind.Value)
                end
            end

            if Input.UserInputType == Keybind["Key"] and not Keybind.IsBeingSelected then 
                if Keybind["Mode"] == "Toggle" then 
                    Keybind.Value = not Keybind.Value;
                    Keybind.Callback(Keybind.Value)
                elseif Keybind["Mode"] == "Hold" then 
                    Keybind.Value = true;
                    Keybind.Callback(Keybind.Value)
                elseif Keybind["Mode"] == "Press" then 
                    Keybind.Callback(Keybind.Value)
                end
            end
            KeyObject:SetVisiblity(Keybind.Value)
        end)

        Library:Connect(game:GetService("UserInputService").InputEnded, function(Input)
            if Input.KeyCode == Keybind["Key"] and not Keybind.IsBeingSelected then 
                if Keybind["Mode"] == "Hold" then
                    Keybind.Value = false;
                    if Data.Callback then Data.Callback(Keybind.Value) end;
                end
            end

            if Input.UserInputType == Keybind["Key"] and not Keybind.IsBeingSelected then 
                if Keybind["Mode"] == "Hold" then 
                    Keybind.Value = false;
                    Keybind.Callback(Keybind.Value)
                end
            end

            KeyObject:SetVisiblity(Keybind.Value)
        end);

        function Keybind:Get()
            return Keybind.Value
        end

        if Keybind.Default then 
            Keybind:Set(Keybind.Default);
        end;

        Library.Flags[Keybind.Flag] = Keybind;
        return Keybind;
    end;

    function Library.Sections:Colorpicker(Data)
        local Colorpicker = {
            Section = self;
            Name = Data.Name;
            Flag = Data.Flag;
            Default = Data.Default;
            Alpha = Data.Alpha;
            Callback = Data.Callback or function() end;
        };

        local Picker = {
            Color = Color3.fromRGB(255,255,255), 
            Transparency = 0.1,
            IsOpen = false;
        };

        local Objects = {};
        Objects["colorpicker"] = Instance.new("Frame")
        Objects["colorpicker"].BackgroundTransparency = 1
        Objects["colorpicker"].Name = "colorpicker"
        Objects["colorpicker"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["colorpicker"].Size = UDim2.new(1, 0, 0, 12)
        Objects["colorpicker"].BorderSizePixel = 0
        Objects["colorpicker"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["colorpicker"].Parent = Colorpicker.Section.Objects.Main

        function Colorpicker:SetVisibility(Boolean)
            Objects["colorpicker"].Visible = Boolean;
        end;

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Colorpicker.Name
        Objects["text"].Name = "text"
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].Size = UDim2.new(1, 0, 1, 0)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["colorpicker"]

        Library:AddToRegistry(Objects["text"], {
            TextColor = "Text"
        })

        Objects["UIStroke1"] = Instance.new("UIStroke")
        Objects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke1"].Parent = Objects["text"]

        Objects["button"] = Instance.new("TextButton")
        Objects["button"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Objects["button"].TextColor3 = Color3.fromRGB(0, 0, 0)
        Objects["button"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["button"].Text = ""
        Objects["button"].AutoButtonColor = false
        Objects["button"].AnchorPoint = Vector2.new(1, 0)
        Objects["button"].Name = "button"
        Objects["button"].Position = UDim2.new(1, 0, 0, 0)
        Objects["button"].Size = UDim2.new(0, 22, 1, 0)
        Objects["button"].BorderSizePixel = 0
        Objects["button"].TextSize = 14
        Objects["button"].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        Objects["button"].Parent = Objects["colorpicker"]

        Objects["UIGradient1"] = Instance.new("UIGradient")
        Objects["UIGradient1"].Rotation = 90
        Objects["UIGradient1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient1"].Parent = Objects["button"]

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].Color = Library.Border
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke2"].Parent = Objects["button"]

        Library:AddToRegistry(Objects["UIStroke2"], {
            Color = "Border"
        })
        -- Window
        Objects["pickerwindow"] = Instance.new("Frame")
        Objects["pickerwindow"].Visible = false
        Objects["pickerwindow"].Name = "pickerwindow"
        Objects["pickerwindow"].Position = UDim2.new(1, 7, 0, 0)
        Objects["pickerwindow"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["pickerwindow"].Size = UDim2.new(0, 225, 0, 165)
        Objects["pickerwindow"].BorderSizePixel = 0
        Objects["pickerwindow"].BackgroundColor3 = Library.Background
        Objects["pickerwindow"].Parent = Library.MainFrame

        Library:AddToRegistry(Objects["pickerwindow"], {
            BackgroundColor3 = "Background"
        })

        Objects["UIStroke3"] = Instance.new("UIStroke")
        Objects["UIStroke3"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke3"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke3"].Name = "border"
        Objects["UIStroke3"].Color = Library.Border
        Objects["UIStroke3"].Parent = Objects["pickerwindow"]

        Library:AddToRegistry(Objects["UIStroke3"], {
            Color = "Border"
        })

        Objects["palette"] = Instance.new("TextButton")
        Objects["palette"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Objects["palette"].TextColor3 = Color3.fromRGB(0, 0, 0)
        Objects["palette"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["palette"].Text = ""
        Objects["palette"].AutoButtonColor = false
        Objects["palette"].Name = "color"
        Objects["palette"].Position = UDim2.new(0, 6, 0, 7)
        Objects["palette"].Size = UDim2.new(0, 185, 0, 150)
        Objects["palette"].BorderSizePixel = 0
        Objects["palette"].TextSize = 14
        Objects["palette"].BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        Objects["palette"].Parent = Objects["pickerwindow"]

        Objects["sat"] = Instance.new("ImageLabel")
        Objects["sat"].Image = "rbxassetid://130624743341203"
        Objects["sat"].BackgroundTransparency = 1
        Objects["sat"].Name = "sat"
        Objects["sat"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["sat"].Size = UDim2.new(1, 0, 1, 0)
        Objects["sat"].BorderSizePixel = 0
        Objects["sat"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["sat"].Parent = Objects["palette"]

        Objects["val"] = Instance.new("ImageLabel")
        Objects["val"].Image = "rbxassetid://96192970265863"
        Objects["val"].BackgroundTransparency = 1
        Objects["val"].Name = "val"
        Objects["val"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["val"].Size = UDim2.new(1, 0, 1, 0)
        Objects["val"].BorderSizePixel = 0
        Objects["val"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["val"].Parent = Objects["palette"]

        Objects["UIStroke4"] = Instance.new("UIStroke")
        Objects["UIStroke4"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke4"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke4"].Name = "border"
        Objects["UIStroke4"].Color = Library.Border;
        Objects["UIStroke4"].Parent = Objects["palette"];

        Library:AddToRegistry(Objects["UIStroke4"], {
            Color = "Border"
        })

        Objects["palettedragger"] = Instance.new("Frame")
        Objects["palettedragger"].Name = "dragger"
        Objects["palettedragger"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["palettedragger"].Size = UDim2.new(0, 2, 0, 2)
        Objects["palettedragger"].BorderSizePixel = 0
        Objects["palettedragger"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["palettedragger"].Parent = Objects["palette"]
        

        Objects["UIStroke5"] = Instance.new("UIStroke")
        Objects["UIStroke5"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke5"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke5"].Name = "border"
        Objects["UIStroke5"].Color = Library.Border
        Objects["UIStroke5"].Parent = Objects["palettedragger"];

        Library:AddToRegistry(Objects["UIStroke5"], {
            Color = "Border"
        })

        Objects["hue"] = Instance.new("ImageButton")
        Objects["hue"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["hue"].AutoButtonColor = false
        Objects["hue"].AnchorPoint = Vector2.new(1, 0)
        Objects["hue"].Image = "rbxassetid://133334110106525"
        Objects["hue"].Name = "hue"
        Objects["hue"].Position = UDim2.new(1, -8, 0, 7)
        Objects["hue"].Size = UDim2.new(0, 17, 0, 150)
        Objects["hue"].BorderSizePixel = 0
        Objects["hue"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["hue"].Parent = Objects["pickerwindow"]

        Objects["UIStroke6"] = Instance.new("UIStroke")
        Objects["UIStroke6"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke6"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke6"].Name = "border"
        Objects["UIStroke6"].Color = Library.Border
        Objects["UIStroke6"].Parent = Objects["hue"]

        Library:AddToRegistry(Objects["UIStroke6"], {
            Color = "Border"
        })

        Objects["huedragger"] = Instance.new("Frame")
        Objects["huedragger"].Name = "dragger"
        Objects["huedragger"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["huedragger"].Size = UDim2.new(1, 0, 0, 1)
        Objects["huedragger"].BorderSizePixel = 0
        Objects["huedragger"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["huedragger"].Parent = Objects["hue"]

        Objects["UIStroke7"] = Instance.new("UIStroke")
        Objects["UIStroke7"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke7"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke7"].Name = "border"
        Objects["UIStroke7"].Color = Library.Border
        Objects["UIStroke7"].Parent = Objects["huedragger"]

        Library:AddToRegistry(Objects["UIStroke7"], {
            Color = "Border"
        })

        Objects["shadow"] = Instance.new("ImageLabel")
        Objects["shadow"].ImageColor3 = Library.Accent
        Objects["shadow"].ScaleType = Enum.ScaleType.Slice
        Objects["shadow"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["shadow"].Name = "shadow"
        Objects["shadow"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["shadow"].Size = UDim2.new(1, 75, 1, 75)
        Objects["shadow"].AnchorPoint = Vector2.new(0.5, 0.5)
        Objects["shadow"].Image = "rbxassetid://112971167999062"
        Objects["shadow"].BackgroundTransparency = 1
        Objects["shadow"].Position = UDim2.new(0.5, 0, 0.5, 0)
        Objects["shadow"].SliceScale = 0.75
        Objects["shadow"].ZIndex = -1
        Objects["shadow"].BorderSizePixel = 0
        Objects["shadow"].SliceCenter = Rect.new(Vector2.new(112, 112), Vector2.new(147, 147))
        Objects["shadow"].Parent = Objects["pickerwindow"];

        Library:AddToRegistry(Objects["shadow"], {
            ImageColor3 = "Accent"
        })

        function Colorpicker:Close()
            Objects["pickerwindow"].Visible = false;
        end

        function Colorpicker:Toggle()
            Picker.IsOpen = not Picker.IsOpen;

            if Picker.IsOpen then
                if Library.CurrentColorpicker then
                    Library.CurrentColorpicker:Close();
                end;
                Library.CurrentColorpicker = Colorpicker;
                Objects["pickerwindow"].Visible = true;
            else
                Objects["pickerwindow"].Visible = false;
            end;
        end;

        Library:Connect(Objects["button"].MouseButton1Down, function()
            Colorpicker:Toggle();
        end);

        local Mouse = game:GetService("Players").LocalPlayer:GetMouse();
        local IsInColor2 = false;
        local IsInColor1 = false;
        local IsInTransparency = false;
        local Colors = {}; do 
            Colors.h = (math.clamp(Objects["huedragger"].AbsolutePosition.Y-Objects["hue"].AbsolutePosition.Y, 0, Objects["hue"].AbsoluteSize.Y)/Objects["hue"].AbsoluteSize.Y)
            Colors.s = 1-(math.clamp(Objects["palettedragger"].AbsolutePosition.X-Objects["palettedragger"].AbsolutePosition.X, 0, Objects["palettedragger"].AbsoluteSize.X)/Objects["palettedragger"].AbsoluteSize.X)
            Colors.v = 1-(math.clamp(Objects["palettedragger"].AbsolutePosition.Y-Objects["palettedragger"].AbsolutePosition.Y, 0, Objects["palettedragger"].AbsoluteSize.Y)/Objects["palettedragger"].AbsoluteSize.Y)
        end;

        
        function Picker:Get()
            return Color3.fromHSV(Colors.h, Colors.s, Colors.v)
        end

        function Picker:UpdateColor()
            local ColorX = (math.clamp(Mouse.X - Objects["palette"].AbsolutePosition.X, 0, Objects["palette"].AbsoluteSize.X)/Objects["palette"].AbsoluteSize.X)
            local ColorY = (math.clamp(Mouse.Y - Objects["palette"].AbsolutePosition.Y, 0, Objects["palette"].AbsoluteSize.Y)/Objects["palette"].AbsoluteSize.Y)
            Objects["palettedragger"].Position = UDim2.new(ColorX, 0, ColorY, 0)

            Colors.s = 1 - ColorX
            Colors.v = 1 - ColorY

            Objects["button"].BackgroundColor3 = Color3.fromHSV(Colors.h, Colors.s, Colors.v);
            Objects["palette"].BackgroundColor3 = Color3.fromHSV(Colors.h, 1, 1);

            local R = math.floor((Picker.Color.R * 255) * 255);
            local G = math.floor((Picker.Color.G * 255) * 255);
            local B = math.floor((Picker.Color.B * 255) * 255);

            local ToRGB = Color3.fromRGB(math.ceil(R), math.ceil(G), math.ceil(B));

            if Colorpicker.Callback then pcall(Colorpicker.Callback) end
        end;
        
        function Picker:Set(new_Value, cb)
            local NColor, NTransparency = new_Value.Color, new_Value.Transparency;

            Picker.Color = NColor; Picker.Transparency = NTransparency;

            local duplicate = Color3.new(new_Value.Color.R, new_Value.Color.G, new_Value.Color.B);
            Colors.h, Colors.s, Colors.v = duplicate:ToHSV()
            Colors.h = math.clamp(Colors.h, 0, 1)
            Colors.s = math.clamp(Colors.s, 0, 1)
            Colors.v = math.clamp(Colors.v, 0, 1)

            local R = math.floor((Picker.Color.R * 255) * 255);
            local G = math.floor((Picker.Color.G * 255) * 255);
            local B = math.floor((Picker.Color.B * 255) * 255);

            local ToRGB = Color3.fromRGB(math.ceil(R), math.ceil(G), math.ceil(B));

            Objects["button"].BackgroundColor3 = Color3.fromHSV(Colors.h, Colors.s, Colors.v);
            Objects["palette"].BackgroundColor3 = Color3.fromHSV(Colors.h, 1, 1);

            Objects["palettedragger"].Position = UDim2.new(1 - Colors.s, 0, 1 - Colors.v, 0)
            Objects["huedragger"].Position = UDim2.new(0, 0, 1 - Colors.h, -1)
            
            if Colorpicker.Callback then pcall(Colorpicker.Callback) end;

            if cb == nil or not cb then
            end;
        end;

        function Picker:UpdateHue()
            local y = math.clamp(Mouse.Y - Objects["hue"].AbsolutePosition.Y, 0, 150)
            Objects["huedragger"].Position = UDim2.new(0, 0, 0, y)
            local hue = y/150
            Colors.h = 1-hue
            Objects["palette"].BackgroundColor3 = Color3.fromHSV(Colors.h, 1, 1)
            Objects["button"].BackgroundColor3 = Color3.fromHSV(Colors.h, Colors.s, Colors.v)
            local R = math.floor((Picker.Color.R * 255) * 255);
            local G = math.floor((Picker.Color.G * 255) * 255);
            local B = math.floor((Picker.Color.B * 255) * 255);

            local ToRGB = Color3.fromRGB(math.ceil(R), math.ceil(G), math.ceil(B));
        end;

        Library:Connect(Objects["palette"].MouseButton1Down, function()
            Picker:UpdateColor()
            local MoveConnection = Mouse.Move:Connect(function()
                Picker:UpdateColor()
            end)
            local ReleaseConnection
            ReleaseConnection = Library:Connect(game:GetService("UserInputService").InputEnded, function(Mouse)
                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                    Picker:UpdateColor()
                    MoveConnection:Disconnect()
                    ReleaseConnection:Disconnect()
                end
            end)
        end);

        Library:Connect(Objects["hue"].MouseButton1Down, function()
            Picker:UpdateHue()
            local MoveConnection = Mouse.Move:Connect(function()
                Picker:UpdateHue()
            end)
            local ReleaseConnection
            ReleaseConnection = Library:Connect(game:GetService("UserInputService").InputEnded, function(Mouse)
                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                    Picker:UpdateHue()
                    MoveConnection:Disconnect()
                    ReleaseConnection:Disconnect()
                end
            end)
        end);

        Picker:Set({Color = Colorpicker.Default, Transparency = Colorpicker.Alpha}, true)
        Library.Flags[Colorpicker.Flag] = Picker;
        if Colorpicker.Callback then Colorpicker.Callback(Picker:Get()) end;
        return Colorpicker;
    end;

    function Library.Sections:Textbox(Data)
        local Textbox = {
            Section = self;
            Name = Data.Name;
            Flag = Data.Flag;
            Default = Data.Default;
            Callback = Data.Callback or function() end;
            Compact = Data.Compact;
            Placeholder = Data.Placeholder;
            Value = nil;
        };

        local Objects = {};

        Objects["textbox"] = Instance.new("Frame")
        Objects["textbox"].BackgroundTransparency = 1
        Objects["textbox"].Name = "textbox"
        Objects["textbox"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["textbox"].Size = UDim2.new(1, 0, 0, 32)
        Objects["textbox"].BorderSizePixel = 0
        Objects["textbox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["textbox"].Parent = Textbox.Section.Objects.Main

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Textbox.Name
        Objects["text"].Name = "text"
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].Size = UDim2.new(1, 0, 0, 13)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["textbox"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].Parent = Objects["text"]

        Objects["background"] = Instance.new("Frame")
        Objects["background"].AnchorPoint = Vector2.new(0, 1)
        Objects["background"].Name = "background"
        Objects["background"].Position = UDim2.new(0, 0, 1, 0)
        Objects["background"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["background"].Size = UDim2.new(1, 0, 0, 15)
        Objects["background"].BorderSizePixel = 0
        Objects["background"].BackgroundColor3 = Library.Inline
        Objects["background"].Parent = Objects["textbox"]

        Library:AddToRegistry(Objects["background"], {
            BackgroundColor3 = "Inline"
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].Color = Library.Border
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke"].Parent = Objects["background"]

        Library:AddToRegistry(Objects["UIStroke"], {
            Color = "Border"
        })

        Objects["UIGradient"] = Instance.new("UIGradient")
        Objects["UIGradient"].Rotation = 90
        Objects["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient"].Parent = Objects["background"]

        Objects["realbox"] = Instance.new("TextBox")
        Objects["realbox"].CursorPosition = -1
        Objects["realbox"].TextColor3 = Color3.fromRGB(255, 255, 255)
        Objects["realbox"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["realbox"].Text = ""
        Objects["realbox"].Name = "realbox"
        Objects["realbox"].Size = UDim2.new(1, 0, 1, -1)
        Objects["realbox"].BorderSizePixel = 0
        Objects["realbox"].BackgroundTransparency = 1
        Objects["realbox"].FontFace = LibFont
        Objects["realbox"].PlaceholderText = Textbox.Placeholder
        Objects["realbox"].ClearTextOnFocus = false
        Objects["realbox"].TextSize = 12
        Objects["realbox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["realbox"].Parent = Objects["background"]

        Library:AddToRegistry(Objects["realbox"], {
            TextColor3 = "Text"
        })

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].Parent = Objects["realbox"]

        function Textbox:SetVisibility(Boolean)
            Objects["textbox"].Visible = Boolean;
        end;

        do
            function Textbox:Get()
                return Textbox.Value;
            end;

            function Textbox:Set(Value)
                Textbox.Value = Value;
                Objects["realbox"].Text = Value;
            end;

            if Data.Compact then
                Objects["text"]:Destroy();
                Objects["textbox"].Size = UDim2.new(1,0,0,15);
            end;

            Library:Connect(Objects["realbox"].Focused, function()
                Library:RemoveFromRegistry(Objects["realbox"])
                Library:AddToRegistry(Objects["realbox"], {
                    TextColor3 = "Accent"
                })
                game:GetService("TweenService"):Create(Objects["realbox"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Accent}):Play();
            end);

            Library:Connect(Objects["realbox"].FocusLost, function()
                Library:RemoveFromRegistry(Objects["realbox"])
                Library:AddToRegistry(Objects["realbox"], {
                    TextColor3 = "Text"
                })
                game:GetService("TweenService"):Create(Objects["realbox"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                Textbox:Set(Objects["realbox"].Text);
            end);

            if Textbox.Callback then Textbox.Callback(Textbox.Value) end
        end;

        if Textbox.Default then
            Textbox:Set(Textbox.Default);
        end;

        Library.Flags[Textbox.Flag] = Textbox;
        return Textbox;
    end;
    
    function Library.Sections:Multidropdown(Data)
        local Dropdown = {
            Section = self;
            Flag = Data.Flag;
            Name = Data.Name or 'Dropdown';
            Default = Data.Default or nil;
            Options = {};
            Multi = Data.Multi or false;
            Callback = Data.Callback or function() end;
            Value = nil;
            Compact = Data.Compact or false;
        };

        local Objects = {};

        Objects["dropdown"] = Instance.new("Frame")
        Objects["dropdown"].BackgroundTransparency = 1
        Objects["dropdown"].Name = "dropdown"
        Objects["dropdown"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["dropdown"].Size = UDim2.new(1, 0, 0, 31)
        Objects["dropdown"].BorderSizePixel = 0
        Objects["dropdown"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["dropdown"].Parent = Dropdown.Section.Objects.Main

        function Dropdown:SetVisibility(Boolean)
            Objects["dropdown"].Visible = Boolean;
        end;

        Objects["text"] = Instance.new("TextLabel")
        Objects["text"].FontFace = LibFont
        Objects["text"].TextColor3 = Library.Text
        Objects["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["text"].Text = Dropdown.Name
        Objects["text"].Name = "text"
        Objects["text"].BackgroundTransparency = 1
        Objects["text"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["text"].Size = UDim2.new(1, 0, 0, 13)
        Objects["text"].BorderSizePixel = 0
        Objects["text"].TextSize = 12
        Objects["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["text"].Parent = Objects["dropdown"]

        Library:AddToRegistry(Objects["text"], {
            TextColor3 = "Text";
        })

        Objects["UIStroke1"] = Instance.new("UIStroke")
        Objects["UIStroke1"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke1"].Parent = Objects["text"]

        Objects["realdropdown"] = Instance.new("Frame")
        Objects["realdropdown"].AnchorPoint = Vector2.new(0, 1)
        Objects["realdropdown"].Name = "realdropdown"
        Objects["realdropdown"].Position = UDim2.new(0, 0, 1, 0)
        Objects["realdropdown"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["realdropdown"].Size = UDim2.new(1, 0, 0, 14)
        Objects["realdropdown"].BorderSizePixel = 0
        Objects["realdropdown"].BackgroundColor3 = Library.Inline
        Objects["realdropdown"].Parent = Objects["dropdown"]
        
        Library:AddToRegistry(Objects["realdropdown"], {
            BackgroundColor3 = "Inline";
        })

        Objects["UIStroke2"] = Instance.new("UIStroke")
        Objects["UIStroke2"].Color = Library.Border
        Objects["UIStroke2"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke2"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke2"].Parent = Objects["realdropdown"]

        Library:AddToRegistry(Objects["UIStroke2"], {
            Color = "Border";
        })

        Objects["UIGradient1"] = Instance.new("UIGradient")
        Objects["UIGradient1"].Rotation = 90
        Objects["UIGradient1"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient1"].Parent = Objects["realdropdown"]

        Objects["value"] = Instance.new("TextLabel")
        Objects["value"].FontFace = LibFont
        Objects["value"].TextColor3 = Library.Text;
        Objects["value"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["value"].Text = "Penis"
        Objects["value"].Name = "value"
        Objects["value"].Size = UDim2.new(1, -20, 1, 0)
        Objects["value"].BackgroundTransparency = 1
        Objects["value"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["value"].Position = UDim2.new(0, 5, 0, 0)
        Objects["value"].BorderSizePixel = 0
        Objects["value"].TextSize = 12
        Objects["value"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["value"].Parent = Objects["realdropdown"]

        Library:AddToRegistry(Objects["value"], {
            TextColor3 = "Text";
        })

        Objects["UIStroke3"] = Instance.new("UIStroke")
        Objects["UIStroke3"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke3"].Parent = Objects["value"]

        Objects["open1"] = Instance.new("TextButton")
        Objects["open1"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        Objects["open1"].TextColor3 = Color3.fromRGB(0, 0, 0)
        Objects["open1"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["open1"].Text = ""
        Objects["open1"].BackgroundTransparency = 1
        Objects["open1"].Name = "open"
        Objects["open1"].Size = UDim2.new(1, 0, 1, 0)
        Objects["open1"].BorderSizePixel = 0
        Objects["open1"].TextSize = 14
        Objects["open1"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["open1"].Parent = Objects["realdropdown"]

        Objects["open2"] = Instance.new("TextLabel")
        Objects["open2"].FontFace = LibFont
        Objects["open2"].TextColor3 = Library.Text
        Objects["open2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["open2"].Text = "+"
        Objects["open2"].Name = "open"
        Objects["open2"].AnchorPoint = Vector2.new(1, 0)
        Objects["open2"].Size = UDim2.new(0, 15, 0, 15)
        Objects["open2"].BackgroundTransparency = 1
        Objects["open2"].TextXAlignment = Enum.TextXAlignment.Left
        Objects["open2"].Position = UDim2.new(1, 4, 0, -2)
        Objects["open2"].BorderSizePixel = 0
        Objects["open2"].TextSize = 12
        Objects["open2"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["open2"].Parent = Objects["realdropdown"]

        Library:AddToRegistry(Objects["open2"], {
            TextColor3 = "Text";
        })

        Objects["UIStroke4"] = Instance.new("UIStroke")
        Objects["UIStroke4"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke4"].Parent = Objects["open"]

        Objects["optionholder"] = Instance.new("Frame")
        Objects["optionholder"].Visible = false
        Objects["optionholder"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["optionholder"].Name = "optionholder"
        Objects["optionholder"].Position = UDim2.new(0, 0, 1, 4)
        Objects["optionholder"].Size = UDim2.new(1, 0, 0, 15)
        Objects["optionholder"].BorderSizePixel = 0
        Objects["optionholder"].AutomaticSize = Enum.AutomaticSize.Y
        Objects["optionholder"].BackgroundColor3 = Library.Inline
        Objects["optionholder"].Parent = Objects["dropdown"]

        Library:AddToRegistry(Objects["optionholder"], {
            BackgroundColor3 = "Inline";
        })

        Objects["UIStroke5"] = Instance.new("UIStroke")
        Objects["UIStroke5"].Color = Library.Border
        Objects["UIStroke5"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke5"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke5"].Parent = Objects["optionholder"]

        Library:AddToRegistry(Objects["UIStroke5"], {
            Color = "Border";
        })

        Objects["UIGradient2"] = Instance.new("UIGradient")
        Objects["UIGradient2"].Rotation = 90
        Objects["UIGradient2"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient2"].Parent = Objects["optionholder"]

        Objects["UIListLayout"] = Instance.new("UIListLayout")
        Objects["UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout"].Parent = Objects["optionholder"]

        function Dropdown:Toggle()
            Objects["optionholder"].Visible = not Objects["optionholder"].Visible;

            if Objects["optionholder"].Visible then
                for Index, Value in Objects["dropdown"]:GetDescendants() do
                    if not string.find(Value.ClassName, "UI") then
                        Value.ZIndex = 15;
                    end
                end
                Objects["open2"].Text = "-";
                Objects["open2"].Position = UDim2.new(1, 7, 0, -2)
            else
                for Index, Value in Objects["dropdown"]:GetDescendants() do
                    if not string.find(Value.ClassName, "UI") then
                        Value.ZIndex = 1;
                    end
                end
                Objects["open2"].Position = UDim2.new(1, 4, 0, -2)
                Objects["open2"].Text = "+";
            end;
        end

        Library:Connect(Objects["open1"].MouseButton1Down, function()
            Dropdown:Toggle();
        end);

        function Dropdown:Set(Value)
            Dropdown.Value = {};
            Objects["value"].Text = "";

            for Index, Value in next, Dropdown.Options do 
                Dropdown.Options[Index].IsSelected = false; 
                Library:RemoveFromRegistry(Dropdown.Options[Index].Text);
                Library:AddToRegistry(Dropdown.Options[Index].Text, {
                    TextColor3 = "Text";
                })
                game:GetService("TweenService"):Create(Dropdown.Options[Index].Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                game:GetService("TweenService"):Create(Dropdown.Options[Index].Selector, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                game:GetService("TweenService"):Create(Dropdown.Options[Index].Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,4,0,-1)}):Play();
            end;

            if type(Value) == "table" then 
                for Index, Value in next, Value do 
                    Objects["value"].Text = Objects["value"].Text .. Value..", "
                end;
                Objects["value"].Text = Objects["value"].Text:sub(1, -3);
                local Split = Objects["value"].Text:split();
                
                if Objects["value"].TextBounds.X > (Objects["value"].AbsoluteSize.X - 10) then 
                    Objects["value"].Text = Objects["value"].Text:sub(1, 17) .. "...";
                end;

            end;

            for Index, Value in next, Value do
                if Dropdown.Options[Value] then
                    table.insert(Dropdown.Value, Value)
                    Library:RemoveFromRegistry(Dropdown.Options[Index].Text);
                    Library:AddToRegistry(Dropdown.Options[Index].Text, {
                        TextColor3 = "Accent";
                    })
                    game:GetService("TweenService"):Create(Dropdown.Options[Value].Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                    game:GetService("TweenService"):Create(Dropdown.Options[Value].Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,9,0,-1)}):Play();
                    game:GetService("TweenService"):Create(Dropdown.Options[Value].Selector, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play();
                    Dropdown.Options[Value].IsSelected = true;
                end;
            end;
            if Dropdown.Callback then Dropdown.Callback(Dropdown.Value); end;
        end;

        function Dropdown:AddOption(Name)
            local OptionInsts = {};

            OptionInsts["option"] = Instance.new("TextButton")
            OptionInsts["option"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            OptionInsts["option"].TextColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["option"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["option"].Text = ""
            OptionInsts["option"].BackgroundTransparency = 1
            OptionInsts["option"].Name = "option"
            OptionInsts["option"].Size = UDim2.new(1, 0, 0, 15)
            OptionInsts["option"].BorderSizePixel = 0
            OptionInsts["option"].TextSize = 14
            OptionInsts["option"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            OptionInsts["option"].Parent = Objects["optionholder"]

            OptionInsts["text"] = Instance.new("TextLabel")
            OptionInsts["text"].FontFace = LibFont;
            OptionInsts["text"].TextColor3 = Library.Text
            OptionInsts["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["text"].Text = Name
            OptionInsts["text"].Name = "text"
            OptionInsts["text"].Size = UDim2.new(1, 0, 1, 0)
            OptionInsts["text"].BackgroundTransparency = 1
            OptionInsts["text"].TextXAlignment = Enum.TextXAlignment.Left
            OptionInsts["text"].Position = UDim2.new(0, 5, 0, -1)
            OptionInsts["text"].BorderSizePixel = 0
            OptionInsts["text"].TextSize = 12
            OptionInsts["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            OptionInsts["text"].Parent = OptionInsts["option"]

            Library:AddToRegistry(OptionInsts["text"], {
                TextColor3 = "Text";
            })

            OptionInsts["UIStroke"] = Instance.new("UIStroke")
            OptionInsts["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
            OptionInsts["UIStroke"].Parent = OptionInsts["text"]

            OptionInsts["liner"] = Instance.new("Frame")
            OptionInsts["liner"].BackgroundTransparency = 1
            OptionInsts["liner"].Name = "liner"
            OptionInsts["liner"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["liner"].Size = UDim2.new(0, 1, 1, 0)
            OptionInsts["liner"].BorderSizePixel = 0
            OptionInsts["liner"].BackgroundColor3 = Library.Accent
            OptionInsts["liner"].Parent = OptionInsts["option"]

            Library:AddToRegistry(OptionInsts["liner"], {
                BackgroundColor3 = "Accent";
            })

            local Option = {
                Name = Name;
                IsSelected = false;
                Selector = OptionInsts["liner"];
                Text = OptionInsts["text"];
                Button = OptionInsts["option"];
            };
            Library:Connect(OptionInsts["option"].MouseButton1Down, function()
                Option.IsSelected = not Option.IsSelected;
                if Option.IsSelected then
                    Library:RemoveFromRegistry(Dropdown.Options[Index].Text);
                    Library:AddToRegistry(Dropdown.Options[Index].Text, {
                        TextColor3 = "Accent";
                    })
                    game:GetService("TweenService"):Create(OptionInsts["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                    game:GetService("TweenService"):Create(OptionInsts["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,9,0,-1)}):Play();
                    game:GetService("TweenService"):Create(OptionInsts["liner"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play();
                    task.spawn(function()
                        Dropdown.Value[#Dropdown.Value+1] = Option.Name
                        Dropdown:Set(Dropdown.Value);
                    end);
                else
                    task.spawn(function()
                        for Index, Value in next, Dropdown.Value do 
                            if Value == Option.Name then 
                                Dropdown.Value[Index] = nil;
                            end;
                        end;

                        Dropdown:Set(Dropdown.Value);
                    end);
                    Library:RemoveFromRegistry(Dropdown.Options[Index].Text);
                    Library:AddToRegistry(Dropdown.Options[Index].Text, {
                        TextColor3 = "Text";
                    })
                    game:GetService("TweenService"):Create(OptionInsts["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                    game:GetService("TweenService"):Create(OptionInsts["liner"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    game:GetService("TweenService"):Create(OptionInsts["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Position = UDim2.new(0,4,0,-1)}):Play();
                end;
            end)
            Dropdown.Options[Option.Name] = Option;
            return Option;
        end;

        for Index, Value in next, Data.Options do 
            Dropdown:AddOption(Value);
        end;

        if Dropdown.Default then
            Dropdown:Set(Dropdown.Default);
        else 
            Dropdown:Set({Data.Options[1]});
        end;

        function Dropdown:Get()
            return Dropdown.Value;
        end;

        Library.Flags[Dropdown.Flag] = Dropdown;
        return Dropdown
    end;

    function Library.Sections:Listbox(Data)
        local Listbox = {
            Section = self;
            Flag = Data.Flag;
            Default = Data.Default or nil;
            Options = {};
            Callback = Data.Callback or function() end;
            Value = nil;
        };

        local Objects = {}

        Objects["listbox"] = Instance.new("Frame")
        Objects["listbox"].Name = "listbox"
        Objects["listbox"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["listbox"].Size = UDim2.new(1, 0, 0, 125)
        Objects["listbox"].BorderSizePixel = 0
        Objects["listbox"].BackgroundColor3 = Library.Inline
        Objects["listbox"].Parent = Listbox.Section.Objects.Main

        function Listbox:SetVisibility(Boolean)
            Objects["listbox"].Visible = Boolean;
        end;

        Library:AddToRegistry(Objects["listbox"], {
            BackgroundColor3 = "Inline";
        })

        Objects["UIGradient"] = Instance.new("UIGradient")
        Objects["UIGradient"].Rotation = 90
        Objects["UIGradient"].Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 135, 135))}
        Objects["UIGradient"].Parent = Objects["listbox"]

        Objects["UIStroke"] = Instance.new("UIStroke")
        Objects["UIStroke"].Color = Library.Border
        Objects["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
        Objects["UIStroke"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        Objects["UIStroke"].Parent = Objects["listbox"]

        Library:AddToRegistry(Objects["UIStroke"], {
            Color = "Border";
        })

        Objects["realbox"] = Instance.new("ScrollingFrame")
        Objects["realbox"].ScrollBarImageColor3 = Library.Accent
        Objects["realbox"].Active = true
        Objects["realbox"].AutomaticCanvasSize = Enum.AutomaticSize.Y
        Objects["realbox"].ScrollBarThickness = 1
        Objects["realbox"].Name = "realbox"
        Objects["realbox"].BackgroundTransparency = 1
        Objects["realbox"].Size = UDim2.new(1, 0, 1, 0)
        Objects["realbox"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Objects["realbox"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["realbox"].BorderSizePixel = 0
        Objects["realbox"].CanvasSize = UDim2.new(0, 0, 1, 0)
        Objects["realbox"].Parent = Objects["listbox"]

        Library:AddToRegistry(Objects["realbox"], {
            ScrollBarImageColor3 = "Accent";
        })

        Objects["UIListLayout"] = Instance.new("UIListLayout")
        Objects["UIListLayout"].SortOrder = Enum.SortOrder.LayoutOrder
        Objects["UIListLayout"].Parent = Objects["realbox"]

        Objects["fade"] = Instance.new("Frame")
        Objects["fade"].AnchorPoint = Vector2.new(0, 1)
        Objects["fade"].Name = "fade"
        Objects["fade"].Position = UDim2.new(0, 1, 1, 0)
        Objects["fade"].BorderColor3 = Color3.fromRGB(0, 0, 0)
        Objects["fade"].Size = UDim2.new(1, -2, 0, 45)
        Objects["fade"].BorderSizePixel = 0
        Objects["fade"].BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Objects["fade"].Parent = Objects["listbox"]

        Objects["UIGradient"] = Instance.new("UIGradient")
        Objects["UIGradient"].Rotation = -90
        Objects["UIGradient"].Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.797, 0.800000011920929), NumberSequenceKeypoint.new(1, 1)}
        Objects["UIGradient"].Parent = Objects["fade"]

        function Listbox:Set(Value)
            if Listbox.Options[Value] then
                Listbox.Value = Value;
                Listbox.Options[Value].IsSelected = true;
                Library:RemoveFromRegistry(Listbox.Options[Value].Text);
                Library:AddToRegistry(Listbox.Options[Value].Text, {
                    TextColor3 = "Accent";
                })
                game:GetService("TweenService"):Create(Listbox.Options[Value].Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Accent}):Play();
            end;

            for Index, Val in pairs(Listbox.Options) do 
                if Val ~= Listbox.Options[Value] then 
                    Val.IsSelected = false; 
                    Library:RemoveFromRegistry(Val.Text);
                    Library:AddToRegistry(Val.Text, {
                        TextColor3 = "Text";
                    })
                    game:GetService("TweenService"):Create(Val.Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                end;    
            end;

            if Listbox.Callback then Listbox.Callback(Listbox.Value); end;
        end;

        function Listbox:AddOption(Name)
            local OptionInsts = {};

            OptionInsts["option"] = Instance.new("TextButton")
            OptionInsts["option"].FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            OptionInsts["option"].TextColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["option"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["option"].Text = ""
            OptionInsts["option"].BackgroundTransparency = 1
            OptionInsts["option"].Name = "option"
            OptionInsts["option"].Size = UDim2.new(1, 0, 0, 15)
            OptionInsts["option"].BorderSizePixel = 0
            OptionInsts["option"].TextSize = 14
            OptionInsts["option"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            OptionInsts["option"].Parent = Objects["realbox"]

            OptionInsts["text"] = Instance.new("TextLabel")
            OptionInsts["text"].FontFace = LibFont;
            OptionInsts["text"].TextColor3 = Library.Text
            OptionInsts["text"].BorderColor3 = Color3.fromRGB(0, 0, 0)
            OptionInsts["text"].Text = Name
            OptionInsts["text"].Name = "text"
            OptionInsts["text"].Size = UDim2.new(1, 0, 1, 0)
            OptionInsts["text"].BackgroundTransparency = 1
            OptionInsts["text"].TextXAlignment = Enum.TextXAlignment.Center
            OptionInsts["text"].Position = UDim2.new(0, 5, 0, -1)
            OptionInsts["text"].BorderSizePixel = 0
            OptionInsts["text"].TextSize = 12
            OptionInsts["text"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            OptionInsts["text"].Parent = OptionInsts["option"]

            Library:AddToRegistry(OptionInsts["text"], {
                TextColor3 = "Text";
            })

            OptionInsts["UIStroke"] = Instance.new("UIStroke")
            OptionInsts["UIStroke"].LineJoinMode = Enum.LineJoinMode.Miter
            OptionInsts["UIStroke"].Parent = OptionInsts["text"]

            local Option = {
                Name = Name;
                IsSelected = false;
                Text = OptionInsts["text"];
                Button = OptionInsts["option"];
            };
            Library:Connect(OptionInsts["option"].MouseButton1Down, function()
                Option.IsSelected = not Option.IsSelected

                for Index, Value in next, Listbox.Options do 
                    if Value ~= Option then 
                        Value.IsSelected = false;
                        Library:RemoveFromRegistry(Value.Text);
                        Library:AddToRegistry(Value.Text, {
                            TextColor3 = "Text";
                        })
                        game:GetService("TweenService"):Create(Value.Text, TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                    end;
                end;
                
                if Option.IsSelected then 
                    Listbox:Set(Option.Name);
                else
                    Library:RemoveFromRegistry(OptionInsts["text"]);
                    Library:AddToRegistry(OptionInsts["text"], {
                        TextColor3 = "Text";
                    })
                    game:GetService("TweenService"):Create(OptionInsts["text"], TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextColor3 = Library.Text}):Play();
                end;
            end)
            Listbox.Options[Option.Name] = Option;
            return Option;
        end;

        
        function Listbox:RemoveOption(Name)
            if Listbox.Options[Name] then
                Listbox.Options[Name].Button:Destroy();
                Listbox.Options[Name] = nil;
            end;
        end;

        for Index, Value in next, Data.Options do 
            Listbox:AddOption(Value);
        end;

        if Listbox.Default then
            Listbox:Set(Listbox.Default);
        end;

        Library.Flags[Listbox.Flag] = Listbox;
        return Listbox;
    end;
end;

return Library;
