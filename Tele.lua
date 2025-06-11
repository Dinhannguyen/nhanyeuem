-- Tự động chọn phe khi vào game (Pirates hoặc Marines)
local preferredTeam = "Pirates" -- hoặc "Marines"

repeat wait() until game:IsLoaded()
wait(1)

local Player = game.Players.LocalPlayer

-- Nếu chưa có team thì chọn
if not Player.Team or (Player.Team.Name ~= preferredTeam) then
    local args = {
        [1] = "SetTeam",
        [2] = preferredTeam
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end
-- Tự động bay đến quán cà phê Sea 2 (Second Sea)
local TweenService = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Vị trí quán cà phê Sea 2
local cafePosition = CFrame.new( -417.981, 73.070, 297.055 ) -- bạn có thể chỉnh vị trí nếu cần

-- Cấu hình Tween
local speed = 300 -- tốc độ bay, có thể chỉnh nhanh hơn nếu cần
local distance = (HRP.Position - cafePosition.Position).Magnitude
local time = distance / speed

-- Cho phép nhân vật bay xuyên block
local function NoClip()
	local conn
	conn = game:GetService("RunService").Stepped:Connect(function()
		if Character and Character:FindFirstChild("HumanoidRootPart") then
			Character:FindFirstChild("Humanoid"):ChangeState(11) -- 11 = Flying/NoClip state
		end
	end)
	return conn
end

-- Thực hiện teleport
local function TeleportToCafe()
	local noclip = NoClip()
	local tween = TweenService:Create(HRP, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = cafePosition})
	tween:Play()
	tween.Completed:Wait()
	noclip:Disconnect()
end

TeleportToCafe()
