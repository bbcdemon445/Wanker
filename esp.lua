local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local CoreGui = game:GetService("CoreGui")
local DrawingFolder = Instance.new("Folder")
DrawingFolder.Name = "ESP_Drawings"
DrawingFolder.Parent = CoreGui

local ESP = {
	Enabled = true,
	Settings = {
		TextColor = Color3.fromRGB(255, 255, 255),
		OutlineColor = Color3.fromRGB(0, 0, 0),
		BoxColor = Color3.fromRGB(255, 255, 255),
		HealthBarColor = Color3.fromRGB(0, 255, 0),
		ShowBoxes = true,
		ShowNames = true,
		ShowDistance = true,
		ShowHealthBar = true,
		NamePosition = "TopLeft", -- Options: TopLeft, TopRight, Top, BottomLeft, BottomRight, Bottom
		DistancePosition = "BottomLeft", -- Same options
		MaxDistance = math.huge
	},
	Drawings = {}
}

local function CreateDrawing(Type: string, Properties: any)
	local Obj = Drawing.new(Type)
	for Prop, Val in next, Properties do
		Obj[Prop] = Val
	end
	return Obj
end

local function GetPositionOnScreen(WorldPos: Vector3)
	local ScreenPos, OnScreen = Camera:WorldToViewportPoint(WorldPos)
	return Vector2.new(ScreenPos.X, ScreenPos.Y), OnScreen, ScreenPos.Z
end

local function GetBoxCorners(HeadPos: Vector3, RootPos: Vector3)
	local Height = (RootPos - HeadPos).Magnitude
	local Width = Height / 2.5
	local TopLeft = Vector3.new(RootPos.X - Width, HeadPos.Y, RootPos.Z)
	local BottomRight = Vector3.new(RootPos.X + Width, RootPos.Y, RootPos.Z)
	return TopLeft, BottomRight
end

local function UpdateESP(Player: Player, Character: Model)
	local Head = Character:FindFirstChild("Head")
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not (Head and HumanoidRootPart and Humanoid and Humanoid.Health > 0) then
		return
	end

	local ScreenPos, OnScreen, Z = GetPositionOnScreen(HumanoidRootPart.Position)
	if not OnScreen or Z > ESP.Settings.MaxDistance then
		return
	end

	local TopLeftWorld, BottomRightWorld = GetBoxCorners(Head.Position, HumanoidRootPart.Position)
	local TopLeftScreen, TLVisible = GetPositionOnScreen(TopLeftWorld)
	local BottomRightScreen, BRVisible = GetPositionOnScreen(BottomRightWorld)

	if not (TLVisible and BRVisible) then
		return
	end

	local Width = BottomRightScreen.X - TopLeftScreen.X
	local Height = BottomRightScreen.Y - TopLeftScreen.Y

	if not ESP.Drawings[Player] then
		ESP.Drawings[Player] = {
			Box = CreateDrawing("Square", {Thickness = 1, Filled = false, ZIndex = 2}),
			Name = CreateDrawing("Text", {Center = false, Outline = true, Size = 13, Font = 2, ZIndex = 3}),
			Distance = CreateDrawing("Text", {Center = false, Outline = true, Size = 13, Font = 2, ZIndex = 3}),
			HealthBar = CreateDrawing("Line", {Thickness = 2, ZIndex = 3})
		}
	end

	local D = ESP.Drawings[Player]

	if ESP.Settings.ShowBoxes then
		D.Box.Visible = true
		D.Box.Color = ESP.Settings.BoxColor
		D.Box.Position = TopLeftScreen
		D.Box.Size = Vector2.new(Width, Height)
	else
		D.Box.Visible = false
	end

	if ESP.Settings.ShowNames then
		local Pos = ESP.Settings.NamePosition
		local Offset = Vector2.new(0, -15)
		if Pos == "TopLeft" then Offset = Vector2.new(-Width / 2, -15)
		elseif Pos == "TopRight" then Offset = Vector2.new(Width / 2, -15)
		elseif Pos == "Top" then Offset = Vector2.new(0, -15)
		elseif Pos == "BottomLeft" then Offset = Vector2.new(-Width / 2, Height + 2)
		elseif Pos == "BottomRight" then Offset = Vector2.new(Width / 2, Height + 2)
		elseif Pos == "Bottom" then Offset = Vector2.new(0, Height + 2) end

		D.Name.Visible = true
		D.Name.Position = TopLeftScreen + Offset
		D.Name.Text = Player.Name
		D.Name.Color = ESP.Settings.TextColor
	else
		D.Name.Visible = false
	end

	if ESP.Settings.ShowDistance then
		local DistPos = ESP.Settings.DistancePosition
		local Offset = Vector2.new(0, Height + 15)
		if DistPos == "TopLeft" then Offset = Vector2.new(-Width / 2, -30)
		elseif DistPos == "TopRight" then Offset = Vector2.new(Width / 2, -30)
		elseif DistPos == "Top" then Offset = Vector2.new(0, -30)
		elseif DistPos == "BottomLeft" then Offset = Vector2.new(-Width / 2, Height + 15)
		elseif DistPos == "BottomRight" then Offset = Vector2.new(Width / 2, Height + 15)
		elseif DistPos == "Bottom" then Offset = Vector2.new(0, Height + 15) end

		D.Distance.Visible = true
		D.Distance.Position = TopLeftScreen + Offset
		D.Distance.Text = tostring(math.floor(Z)) .. "m"
		D.Distance.Color = ESP.Settings.TextColor
	else
		D.Distance.Visible = false
	end

	if ESP.Settings.ShowHealthBar then
		local HealthPercent = Humanoid.Health / Humanoid.MaxHealth
		local BarHeight = Height * HealthPercent
		local BarTop = Vector2.new(TopLeftScreen.X - 4, BottomRightScreen.Y - BarHeight)
		local BarBottom = Vector2.new(TopLeftScreen.X - 4, BottomRightScreen.Y)
		D.HealthBar.Visible = true
		D.HealthBar.From = BarBottom
		D.HealthBar.To = BarTop
		D.HealthBar.Color = ESP.Settings.HealthBarColor
	else
		D.HealthBar.Visible = false
	end
end

RunService.RenderStepped:Connect(function()
	if not ESP.Enabled then return end
	for _, Player in next, Players:GetPlayers() do
		if Player ~= Players.LocalPlayer and Player.Character then
			UpdateESP(Player, Player.Character)
		end
	end
end)

return ESP
