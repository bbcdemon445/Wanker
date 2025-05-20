local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")

local Folder = Instance.new("Folder")
Folder.Name = "ESP"
Folder.Parent = CoreGui

local ESP = {
	Enabled = true,
	Settings = {
		TextColor = Color3.new(1, 1, 1),
		BoxColor = Color3.new(1, 1, 1),
		HealthBarColor = Color3.new(0, 1, 0),
		NamePosition = "TopLeft",
		DistancePosition = "BottomLeft",
		ShowBoxes = true,
		ShowNames = true,
		ShowDistance = true,
		ShowHealthBar = true,
		MaxDistance = math.huge
	},
	Instances = {}
}

local function CreateUI(Name, Parent)
	local Frame = Instance.new("Frame")
	Frame.Name = Name
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 0
	Frame.Size = UDim2.new(0, 0, 0, 0)
	Frame.ZIndex = 10
	Frame.Parent = Parent

	local Box = Instance.new("Frame")
	Box.Name = "Box"
	Box.AnchorPoint = Vector2.new(0.5, 0.5)
	Box.BackgroundColor3 = ESP.Settings.BoxColor
	Box.BorderSizePixel = 0
	Box.BackgroundTransparency = ESP.Settings.ShowBoxes and 0 or 1
	Box.Parent = Frame

	local Name = Instance.new("TextLabel")
	Name.Name = "Name"
	Name.BackgroundTransparency = 1
	Name.TextColor3 = ESP.Settings.TextColor
	Name.TextStrokeColor3 = Color3.new(0, 0, 0)
	Name.TextStrokeTransparency = 0.5
	Name.TextSize = 14
	Name.Font = Enum.Font.SourceSansBold
	Name.Visible = ESP.Settings.ShowNames
	Name.AnchorPoint = Vector2.new(0.5, 1)
	Name.Size = UDim2.new(0, 200, 0, 14)
	Name.Position = UDim2.new(0.5, 0, 0, -2)
	Name.Parent = Frame

	local Distance = Instance.new("TextLabel")
	Distance.Name = "Distance"
	Distance.BackgroundTransparency = 1
	Distance.TextColor3 = ESP.Settings.TextColor
	Distance.TextStrokeColor3 = Color3.new(0, 0, 0)
	Distance.TextStrokeTransparency = 0.5
	Distance.TextSize = 14
	Distance.Font = Enum.Font.SourceSansBold
	Distance.Visible = ESP.Settings.ShowDistance
	Distance.AnchorPoint = Vector2.new(0.5, 0)
	Distance.Size = UDim2.new(0, 200, 0, 14)
	Distance.Position = UDim2.new(0.5, 0, 1, 2)
	Distance.Parent = Frame

	local Bar = Instance.new("Frame")
	Bar.Name = "HealthBar"
	Bar.AnchorPoint = Vector2.new(0, 1)
	Bar.Size = UDim2.new(0, 2, 0, 0)
	Bar.Position = UDim2.new(0, -4, 1, 0)
	Bar.BackgroundColor3 = ESP.Settings.HealthBarColor
	Bar.BorderSizePixel = 0
	Bar.Visible = ESP.Settings.ShowHealthBar
	Bar.Parent = Frame

	return Frame
end

local function GetScreenPosition(Position)
	local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Position)
	return Vector2.new(ScreenPos.X, ScreenPos.Y), OnScreen, ScreenPos.Z
end

function ESP.Update()
	if not ESP.Enabled then return end

	for _, Player in next, Players:GetPlayers() do
		if Player == Players.LocalPlayer then continue end
		local Character = Player.Character
		if not Character then continue end

		local Head = Character:FindFirstChild("Head")
		local HRP = Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		if not (Head and HRP and Humanoid and Humanoid.Health > 0) then continue end

		local Pos, OnScreen, Z = GetScreenPosition(HRP.Position)
		if not OnScreen or Z > ESP.Settings.MaxDistance then continue end

		local Height = (HRP.Position - Head.Position).Magnitude * 1.5
		local Width = Height / 2
		local TL = Vector2.new(Pos.X - Width / 2, Pos.Y - Height / 2)

		local UI = ESP.Instances[Player]
		if not UI then
			UI = CreateUI(Player.Name, Folder)
			ESP.Instances[Player] = UI
		end

		UI.Position = UDim2.new(0, TL.X, 0, TL.Y)
		UI.Size = UDim2.new(0, Width, 0, Height)
		UI.Visible = true

		UI.Box.Size = UDim2.new(1, 0, 1, 0)
		UI.Box.Visible = ESP.Settings.ShowBoxes

		UI.Name.Text = Player.Name
		UI.Name.Visible = ESP.Settings.ShowNames

		UI.Distance.Text = tostring(math.floor(Z)) .. "m"
		UI.Distance.Visible = ESP.Settings.ShowDistance

		UI.HealthBar.Size = UDim2.new(0, 2, Humanoid.Health / Humanoid.MaxHealth, 0)
		UI.HealthBar.Visible = ESP.Settings.ShowHealthBar

		local NamePos = ESP.Settings.NamePosition
		local DistPos = ESP.Settings.DistancePosition

		local PosMap = {
			TopLeft = UDim2.new(0, -5, 0, -15),
			TopRight = UDim2.new(1, 5, 0, -15),
			Top = UDim2.new(0.5, 0, 0, -15),
			BottomLeft = UDim2.new(0, -5, 1, 0),
			BottomRight = UDim2.new(1, 5, 1, 0),
			Bottom = UDim2.new(0.5, 0, 1, 0)
		}

		UI.Name.Position = PosMap[NamePos] or UI.Name.Position
		UI.Distance.Position = PosMap[DistPos] or UI.Distance.Position
	end
end

function ESP.Remove(Player)
	local UI = ESP.Instances[Player]
	if UI then
		UI:Destroy()
		ESP.Instances[Player] = nil
	end
end

Players.PlayerRemoving:Connect(ESP.Remove)

return ESP
