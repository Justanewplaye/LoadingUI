local folder = "High.XD"
if not isfolder(folder) then makefolder(folder) end

-- Download assets
local files = {
    {url = "https://raw.githubusercontent.com/Justanewplaye/LoadingUI/main/bg.png", name = "bg.png"},
    {url = "https://raw.githubusercontent.com/Justanewplaye/LoadingUI/main/background.png", name = "background.png"},
    {url = "https://raw.githubusercontent.com/Justanewplaye/LoadingUI/main/open.wav", name = "open.ogg"},
}
for _, file in pairs(files) do
    local content = game:HttpGet(file.url)
    writefile(folder.."/"..file.name, content)
end

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HighXDLoader"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 9999

local bg = Instance.new("ImageLabel", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Position = UDim2.new(0, 0, 0, 0)
bg.Image = getcustomasset(folder.."/background.png")
bg.BackgroundTransparency = 1
bg.ImageTransparency = 1

local overlay = Instance.new("ImageLabel", gui)
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.Position = UDim2.new(0, 0, 0, 0)
overlay.Image = getcustomasset(folder.."/bg.png")
overlay.BackgroundTransparency = 1
overlay.ImageTransparency = 1

-- the logo lmao
local logoMain = Instance.new("TextLabel", gui)
logoMain.Size = UDim2.new(1, 0, 0, 100)
logoMain.Position = UDim2.new(0, 0, 0.02, 0)
logoMain.BackgroundTransparency = 1
logoMain.Text = "Federal"
logoMain.TextColor3 = Color3.fromRGB(255, 255, 255)
logoMain.Font = Enum.Font.Cartoon
logoMain.TextScaled = true
logoMain.TextTransparency = 1

local logoSub = Instance.new("TextLabel", gui)
logoSub.Size = UDim2.new(1, 0, 0, 100)
logoSub.Position = UDim2.new(0, 0, 0.02, 0)
logoSub.BackgroundTransparency = 1
logoSub.Text = "REMASTERED"
logoSub.TextColor3 = Color3.fromRGB(0, 255, 150)
logoSub.Font = Enum.Font.Cartoon
logoSub.TextScaled = true
logoSub.TextTransparency = 1
logoSub.Rotation = -15

-- loading bar
local barContainer = Instance.new("Frame", gui)
barContainer.Size = UDim2.new(0.3, 0, 0, 25)
barContainer.Position = UDim2.new(0.35, 0, 0.85, 0)
barContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
barContainer.BorderSizePixel = 0
barContainer.ClipsDescendants = true
local cornerContainer = Instance.new("UICorner", barContainer)
cornerContainer.CornerRadius = UDim.new(0, 12)

local bar = Instance.new("Frame", barContainer)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
bar.BorderSizePixel = 0
local cornerBar = Instance.new("UICorner", bar)
cornerBar.CornerRadius = UDim.new(0, 12)

local status = Instance.new("TextLabel", gui)
status.Size = UDim2.new(1, 0, 0, 40)
status.Position = UDim2.new(0, 0, 0.78, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Text = "Starting..."
status.Font = Enum.Font.GothamBold
status.TextScaled = true
status.TextTransparency = 1

-- stolen federal sound 🤑 
local sound = Instance.new("Sound", workspace)
sound.SoundId = getcustomasset(folder.."/open.ogg")
sound.Volume = 2
sound:Play()

-- use fade in
for i = 1, 30 do
	local t = i / 30
	bg.ImageTransparency = 1 - t
	overlay.ImageTransparency = 1 - t
	status.TextTransparency = 1 - t
	logoMain.TextTransparency = 1 - t
	logoSub.TextTransparency = 1 - t
	task.wait(0.015)
end

-- the stages of it
local stages = {
	{percent = 0.10, label = "Starting Script..."},
	{percent = 0.50, label = "Creating Folders..."},
	{percent = 0.70, label = "Final Checks..."},
	{percent = 1.00, label = "Loaded!"}
}

for _, stage in ipairs(stages) do
	local current = bar.Size.X.Scale
	status.Text = stage.label .. "  [" .. tostring(stage.percent * 100) .. " %]"
	local target = stage.percent
	for step = 1, 30 do
		local new = current + ((target - current) * (step / 30))
		bar.Size = UDim2.new(new, 0, 1, 0)
		task.wait(0.012)
	end
	bar.Size = UDim2.new(target, 0, 1, 0)
	task.wait(1.7)
end

-- Fade out all
for i = 1, 30 do
	local t = i / 30
	bg.ImageTransparency = t
	overlay.ImageTransparency = t
	status.TextTransparency = t
	logoMain.TextTransparency = t
	logoSub.TextTransparency = t
	bar.BackgroundTransparency = t
	barContainer.BackgroundTransparency = t
	task.wait(0.015)
end

gui:Destroy()
