-- Script tự động copy settings.json và đổi tên thành "name".json (name là tên acc)

local player = game.Players.LocalPlayer
local workspaceFolder = "True W-azure V2_Beta/ConfigMain/"
local defaultSettingsFile = workspaceFolder .. "settings.json"
local nameSettingsFile = workspaceFolder .. player.Name .. ".json"

-- Hàm copy file
local function copyFile(source, destination)
    if isfile(source) then
        local content = readfile(source)
        writefile(destination, content)
        print("Đã copy " .. source .. " sang " .. destination)
        return true
    else
        print("Không tìm thấy file " .. source)
        return false
    end
end

-- Chờ player load
while not player do
    wait(0.1)
    player = game.Players.LocalPlayer
end

-- Copy settings.json sang "name".json khi bắt đầu
copyFile(defaultSettingsFile, nameSettingsFile)

-- Theo dõi file settings.json, nếu có thay đổi thì tự động copy lại
local lastModified = nil
if isfile(defaultSettingsFile) then
    lastModified = getfilelastmodified(defaultSettingsFile) or 0
end

while true do
    if isfile(defaultSettingsFile) then
        local currentModified = getfilelastmodified(defaultSettingsFile) or 0
        if currentModified ~= lastModified then
            copyFile(defaultSettingsFile, nameSettingsFile)
            lastModified = currentModified
        end
    end
    wait(1)
end
