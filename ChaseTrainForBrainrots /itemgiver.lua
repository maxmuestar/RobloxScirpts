local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

print("=== SCRIPT START ===")

local player = Players.LocalPlayer
print("Player gevonden:", player.Name)

-- Assets zoeken
local assets = ReplicatedStorage:FindFirstChild("Assets")

if not assets then
	warn("Assets map NIET gevonden!")
	return
end

print("Assets gevonden:", assets:GetFullName())

local gearsFolder = assets:FindFirstChild("Gears")
local toolsFolder = assets:FindFirstChild("Tools")

print("Gears folder:", gearsFolder)
print("Tools folder:", toolsFolder)

if not gearsFolder then
	warn("Gears folder ontbreekt!")
end

if not toolsFolder then
	warn("Tools folder ontbreekt!")
end

-- GUI maken
local gui = Instance.new("ScreenGui")
gui.Name = "ToolGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

print("GUI aangemaakt")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.Parent = gui

print("Frame aangemaakt")

-- Topbar
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1,0,0,40)
topbar.BackgroundColor3 = Color3.fromRGB(25,25,25)
topbar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,1,0)
title.BackgroundTransparency = 1
title.Text = "Tool Selector"
title.TextColor3 = Color3.new(1,1,1)
title.Parent = topbar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0,40,1,0)
closeButton.Position = UDim2.new(1,-40,0,0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(170,0,0)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Parent = topbar

closeButton.MouseButton1Click:Connect(function()
	print("Close button geklikt")
	gui.Enabled = false
end)

-- Scrollframe
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,0,1,-40)
scroll.Position = UDim2.new(0,0,0,40)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Parent = scroll

print("Scrollframe aangemaakt")

-- Dragging
local dragging = false
local dragStart
local startPos
local dragInput

topbar.InputBegan:Connect(function(input)
	print("InputBegan:", input.UserInputType)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				print("Dragging gestopt")
			end
		end)
	end
end)

topbar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input == dragInput then
		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Tool knop maken
local function createButton(tool)
	print("Knop maken voor:", tool.Name)

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1,-10,0,35)
	button.Text = tool.Name
	button.Parent = scroll

	button.MouseButton1Click:Connect(function()
		print("Tool gekozen:", tool.Name)

		local success, err = pcall(function()
			local clone = tool:Clone()
			clone.Parent = player.Backpack
		end)

		if success then
			print("Tool gegeven:", tool.Name)
		else
			warn("Fout bij geven tool:", err)
		end
	end)
end

-- Gears laden
if gearsFolder then
	print("Aantal items in Gears:", #gearsFolder:GetChildren())

	for _, item in ipairs(gearsFolder:GetChildren()) do
		print("Gears item:", item.Name, item.ClassName)

		if item:IsA("Tool") then
			createButton(item)
		end
	end
end

-- Tools laden
if toolsFolder then
	print("Aantal items in Tools:", #toolsFolder:GetChildren())

	for _, item in ipairs(toolsFolder:GetChildren()) do
		print("Tools item:", item.Name, item.ClassName)

		if item:IsA("Tool") then
			createButton(item)
		end
	end
end

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(
		0,
		0,
		0,
		layout.AbsoluteContentSize.Y
	)
end)

print("=== SCRIPT EINDE ===")
