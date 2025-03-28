-- HIGH.XD CLEAN CENTERED LOGO VERSION

local folder = "High.XD"
if not isfolder(folder) then makefolder(folder) end

local files = {
    {url = "https://raw.githubusercontent.com/Justanewplaye/LoadingUI/main/bg.png", name = "bg.png"},
    {url = "https://raw.githubusercontent.com/Justanewplaye/LoadingUI/main/background.png", name = "background.png"},
    {url = "https://raw.githubusercontent.com/Justanewplaye/LoadingUI/main/open.wav", name = "open.ogg"},
}
for _, file in ipairs(files) do
    local content = game:HttpGet(file.url)
    writefile(folder.."/"..file.name, content)
end

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HighXDLoader"
gui.IgnoreGuiInset = true
gui.DisplayOrder = 9999
gui.ResetOnSpawn = false

local bg = Instance.new("ImageLabel", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.Image = getcustomasset(folder.."/background.png")
bg.ImageTransparency = 1
bg.BackgroundTransparency = 1

local overlay = Instance.new("ImageLabel", gui)
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.Image = getcustomasset(folder.."/bg.png")
overlay.ImageTransparency = 1
overlay.BackgroundTransparency = 1

-- Combined logo: High.XD centered and raised lower mid
local logo = Instance.new("TextLabel", gui)
logo.Size = UDim2.new(1, 0, 0, 80)
logo.Position = UDim2.new(0, 0, 0.15, 0) -- closer to center but still raised
logo.BackgroundTransparency = 1
logo.Text = "High.XD"
logo.TextColor3 = Color3.fromRGB(240, 255, 240)
logo.Font = Enum.Font.FredokaOne -- more rounded and modern
logo.TextScaled = true
logo.TextTransparency = 1

-- Loading bar
local barContainer = Instance.new("Frame", gui)
barContainer.Size = UDim2.new(0.25, 0, 0, 18)
barContainer.Position = UDim2.new(0.375, 0, 0.85, 0)
barContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barContainer.BorderSizePixel = 0
barContainer.ClipsDescendants = true
Instance.new("UICorner", barContainer).CornerRadius = UDim.new(0, 10)

local bar = Instance.new("Frame", barContainer)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
bar.BorderSizePixel = 0
Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 10)

local status = Instance.new("TextLabel", gui)
status.Size = UDim2.new(1, 0, 0, 30)
status.Position = UDim2.new(0, 0, 0.81, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Text = "Starting..."
status.Font = Enum.Font.GothamBold
status.TextScaled = true
status.TextTransparency = 1

-- Sound
local sound = Instance.new("Sound", workspace)
sound.SoundId = getcustomasset(folder.."/open.ogg")
sound.Volume = 2
sound:Play()

-- Fade in
for i = 1, 30 do
	local t = i / 30
	bg.ImageTransparency = 1 - t
	overlay.ImageTransparency = 1 - t
	status.TextTransparency = 1 - t
	logo.TextTransparency = 1 - t
	task.wait(0.012)
end

-- Progress
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
	for step = 1, 25 do
		local new = current + ((target - current) * (step / 25))
		bar.Size = UDim2.new(new, 0, 1, 0)
		task.wait(0.010)
	end
	bar.Size = UDim2.new(target, 0, 1, 0)
	task.wait(1.4)
end

-- Fade out
for i = 1, 30 do
	local t = i / 30
	bg.ImageTransparency = t
	overlay.ImageTransparency = t
	status.TextTransparency = t
	logo.TextTransparency = t
	bar.BackgroundTransparency = t
	barContainer.BackgroundTransparency = t
	task.wait(0.012)
end

gui:Destroy()
