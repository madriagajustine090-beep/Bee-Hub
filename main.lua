-- BEE HUB
-- Safe Roblox Studio UI
-- Mobile-friendly draggable menu

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("BeeHub")
if old then
	old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "BeeHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- Main Menu
local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Size = UDim2.new(0, 350, 0, 350)
main.Position = UDim2.new(0.5, -175, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 27)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
titleBar.BorderSizePixel = 0
titleBar.Active = true
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "BEE HUB"
title.TextColor3 = Color3.fromRGB(255, 220, 60)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Script Box
local box = Instance.new("TextBox")
box.Name = "ScriptBox"
box.Size = UDim2.new(1, -20, 0, 190)
box.Position = UDim2.new(0, 10, 0, 60)
box.BackgroundColor3 = Color3.fromRGB(9, 9, 14)
box.BorderSizePixel = 0
box.TextColor3 = Color3.fromRGB(230, 230, 230)
box.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
box.PlaceholderText = "-- Type your Lua code here..."
box.Text = ""
box.TextSize = 13
box.Font = Enum.Font.Code
box.TextXAlignment = Enum.TextXAlignment.Left
box.TextYAlignment = Enum.TextYAlignment.Top
box.MultiLine = true
box.ClearTextOnFocus = false
box.TextWrapped = false
box.Parent = main

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 9)
boxCorner.Parent = box

-- Clear Button
local clear = Instance.new("TextButton")
clear.Size = UDim2.new(0, 100, 0, 42)
clear.Position = UDim2.new(0, 10, 1, -52)
clear.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
clear.BorderSizePixel = 0
clear.Text = "CLEAR"
clear.TextColor3 = Color3.new(1, 1, 1)
clear.TextSize = 14
clear.Font = Enum.Font.GothamBold
clear.Parent = main

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 9)
clearCorner.Parent = clear

clear.MouseButton1Click:Connect(function()
	box.Text = ""
end)

-- Safe Load Button
local load = Instance.new("TextButton")
load.Size = UDim2.new(0, 100, 0, 42)
load.Position = UDim2.new(0, 120, 1, -52)
load.BackgroundColor3 = Color3.fromRGB(220, 170, 40)
load.BorderSizePixel = 0
load.Text = "LOAD"
load.TextColor3 = Color3.fromRGB(20, 20, 20)
load.TextSize = 14
load.Font = Enum.Font.GothamBold
load.Parent = main

local loadCorner = Instance.new("UICorner")
loadCorner.CornerRadius = UDim.new(0, 9)
loadCorner.Parent = load

load.MouseButton1Click:Connect(function()
	load.Text = "READY"
	task.wait(1.2)
	load.Text = "LOAD"
end)

-- Hide Button
local hide = Instance.new("TextButton")
hide.Size = UDim2.new(0, 100, 0, 42)
hide.Position = UDim2.new(1, -110, 1, -52)
hide.BackgroundColor3 = Color3.fromRGB(150, 40, 105)
hide.BorderSizePixel = 0
hide.Text = "HIDE"
hide.TextColor3 = Color3.new(1, 1, 1)
hide.TextSize = 14
hide.Font = Enum.Font.GothamBold
hide.Parent = main

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 9)
hideCorner.Parent = hide

-- Show Button
local show = Instance.new("TextButton")
show.Size = UDim2.new(0, 125, 0, 45)
show.Position = UDim2.new(0, 15, 0.5, -22)
show.BackgroundColor3 = Color3.fromRGB(255, 210, 50)
show.BorderSizePixel = 0
show.Text = "SHOW MENU"
show.TextColor3 = Color3.fromRGB(20, 20, 20)
show.TextSize = 14
show.Font = Enum.Font.GothamBold
show.Visible = false
show.Parent = gui

local showCorner = Instance.new("UICorner")
showCorner.CornerRadius = UDim.new(0, 10)
showCorner.Parent = show

hide.MouseButton1Click:Connect(function()
	main.Visible = false
	show.Visible = true
end)

show.MouseButton1Click:Connect(function()
	main.Visible = true
	show.Visible = false
end)

-- Mobile Drag
local dragging = false
local dragStart
local startPosition

local function updateDrag(input)
	local delta = input.Position - dragStart

	main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)
end

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPosition = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging then
		if input.UserInputType == Enum.UserInputType.Touch
			or input.UserInputType == Enum.UserInputType.MouseMovement then
			updateDrag(input)
		end
	end
end)

print("BEE HUB loaded successfully!")
