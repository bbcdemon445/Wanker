local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")

local ESP = {
	Enabled = true,
	Settings = {
		TextColor = Color3.new(1, 1, 1),
		BoxColor = Color3.new(1, 1, 1),
		HealthBarColor = Color3.new(0, 1, 0),
		ShowBoxes = true,
		ShowNames = true,
		ShowDistance = true,
		ShowHealthBar = true,
		NamePosition = "TopLeft",
		DistancePosition = "BottomLeft",
		MaxDistance = math.huge
	},
	Drawings = {}
}

local Folder = Instance.new("Folder")
Folder.Name = "ESP"
Folder.Parent = CoreGui

local function CreateLabel(Name)
	local Label = Instance.new("TextLabel")
	Label.Name = Name
	Label.BackgroundTransparency = 1
	Label.BorderSizePixel = 0
	Label.TextSize = 13
	Label.Font = Enum.Font.SourceSans
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextYAlignment = Enum.TextYAlignment.Top
	Label.Size = UDim2.new(0, 200, 0, 50)
	Label.ZIndex = 3
	Label.Parent = Folder
	return Label
end

local function CreateBoxFrame(Name)
	local Frame = Instance.new("Frame")
	Frame.Name = Name
	Frame.BorderSizePixel = 1
	Frame.BackgroundTransparency = 1
	Frame.ZIndex = 2
	Frame.Size = UDim2.new()
	Frame.Position = UDim2.new()
	Frame.BorderColor3 = Color3.new(1, 1, 1)
	Frame.Parent = Folder
	return Frame
end

local function CreateHealthBar(Name)
	local Bar = Instance.new("Frame")
	Bar.Name = Name
	Bar.BackgroundColor3 = Color3.new(0, 1, 0)
	Bar.BorderSizePixel = 0
	Bar.ZIndex = 3
	Bar.Size = UDim2.new()
	Bar.Position = UDim2.new()
	Bar.Parent = Folder
	return Bar
end

local function GetScreenPos(Position)
	local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Position)
	return Vector2.new(ScreenPos.X, ScreenPos.Y), OnScreen, ScreenPos.Z
end

local function GetBoxCorners(Head, Root)
	local Height = (Root - Head).Magnitude
	local Width = Height / 2.5
	local TopLeft = Vector3.new(Root.X - Width, Head.Y, Root.Z)
	local BottomRight = Vector3.new(Root.X + Width, Root.Y, Root.Z)
	return TopLeft, BottomRight
end

local function GetOffset(Pos, Width, Height, OffsetY)
	if Pos == "TopLeft" then
		return Vector2.new(-Width / 2, -OffsetY)
	elseif Pos == "TopRight" then
		return Vector2.new(Width / 2, -OffsetY)
	elseif Pos == "Top" then
		return Vector2.new(0, -OffsetY)
	elseif Pos == "BottomLeft" then
		return Vector2.new(-Width / 2, Height + OffsetY)
	elseif Pos == "BottomRight" then
		return Vector2.new(Width / 2, Height + OffsetY)
	elseif Pos == "Bottom" then
		return Vector2.new(0, Height + OffsetY)
	end
	return Vector2.zero
end

local function UpdateESP(Player, Character)
	local Head = Character:FindFirstChild("Head")
	local Root = Character:FindFirstChild("HumanoidRootPart")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not (Head and Root and Humanoid and Humanoid.Health > 0) then return end

	local ScreenPos, OnScreen, Z = GetScreenPos(Root.Position)
	if not OnScreen or Z > ESP.Settings.MaxDistance then return end

	local TopLeft, BottomRight = GetBoxCorners(Head.Position, Root.Position)
	local TL, V1 = GetScreenPos(TopLeft)
	local BR, V2 = GetScreenPos(BottomRight)
	if not (V1 and V2) then return end

	local Width = BR.X - TL.X
	local Height = BR.Y - TL.Y

	if not ESP.Drawings[Player] then
		ESP.Drawings[Player] = {
			Box = CreateBoxFrame(Player.Name .. "_Box"),
			Name = CreateLabel(Player.Name .. "_Name"),
			Distance = CreateLabel(Player.Name .. "_Distance"),
			HealthBar = CreateHealthBar(Player.Name .. "_Health")
		}
	end

	local D = ESP.Drawings[Player]

	if ESP.Settings.ShowBoxes then
		D.Box.Visible = true
		D.Box.Position = UDim2.fromOffset(TL.X, TL.Y)
		D.Box.Size = UDim2.fromOffset(Width, Height)
		D.Box.BorderColor3 = ESP.Settings.BoxColor
	else
		D.Box.Visible = false
	end

	if ESP.Settings.ShowNames then
		local Offset = GetOffset(ESP.Settings.NamePosition, Width, Height, 15)
		D.Name.Visible = true
		D.Name.Text = Player.Name
		D.Name.Position = UDim2.fromOffset(TL.X + Offset.X, TL.Y + Offset.Y)
		D.Name.TextColor3 = ESP.Settings.TextColor
	else
		D.Name.Visible = false
	end

	if ESP.Settings.ShowDistance then
		local Offset = GetOffset(ESP.Settings.DistancePosition, Width, Height, 30)
		D.Distance.Visible = true
		D.Distance.Text = tostring(math.floor(Z)) .. "m"
		D.Distance.Position = UDim2.fromOffset(TL.X + Offset.X, TL.Y + Offset.Y)
		D.Distance.TextColor3 = ESP.Settings.TextColor
	else
		D.Distance.Visible = false
	end

	if ESP.Settings.ShowHealthBar then
		local H = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
		local BarHeight = Height * H
		D.HealthBar.Visible = true
		D.HealthBar.Position = UDim2.fromOffset(TL.X - 4, BR.Y - BarHeight)
		D.HealthBar.Size = UDim2.fromOffset(2, BarHeight)
		D.HealthBar.BackgroundColor3 = ESP.Settings.HealthBarColor
	else
		D.HealthBar.Visible = false
	end
end

RunService.RenderStepped:Connect(function()
	if not ESP.Enabled then return end
	for _, Player in next, Players:GetPlayers() do
		if Player ~= Players.LocalPlayer then
			local Char = Player.Character
			if Char then
				UpdateESP(Player, Char)
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(Player)
	local D = ESP.Drawings[Player]
	if D then
		for _, V in next, D do
			if typeof(V) == "Instance" then
				V:Destroy()
			end
		end
		ESP.Drawings[Player] = nil
	end
end)

return ESP
