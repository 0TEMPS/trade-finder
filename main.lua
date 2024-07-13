local Config = {
	
}


local HTTP = game:GetService("HttpService")
local Players = game:GetService("Players")
local Run = game:GetService("RunService")
local STATS = game:GetService("Stats")
local TP = game:GetService("TeleportService")
local TCS = game:GetService("TextChatService")
local LogService = game:GetService("LogService")
local PFS = game:GetService("PathfindingService")
local UGS = game:GetService("UserGameSettings")
local MS = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")

local PlayerData = {}
local TradeQueue = {}

local InventoryRequestQueue = {}

local FS = loadstring(game:HttpGet("https://raw.githubusercontent.com/0TEMPS/CharBot/main/FunctionService.lua"))()
local RolimonsItemTable = FS.RolimonsValueTable()

function GetInventory(PlayerID)
	local InventoryData = FS.Get_Request("https://inventory.roblox.com/v1/users/"..tostring(PlayerID).."/assets/collectibles?limit=100&sortOrder=Asc")
	InventoryData = HTTP:JSONDecode(InventoryData)
	
	return InventoryData
end


for i,v in pairs(Players:GetChildren()) do
	table.insert(InventoryRequestQueue, v)
end

Players.PlayerAdded:Connect(function(player)
	table.insert(InventoryRequestQueue, player)
end)

Players.PlayerRemoving:Connect(function(player)
	if table.find(InventoryRequestQueue, player) then
		table.remove(InventoryRequestQueue, player)
	end
end)

print("got here")
wait(5)

print("getting inv of "..InventoryRequestQueue[1].Name)

local thing = GetInventory(InventoryRequestQueue[1].UserId)
print(thing)

FS.PrintTable(thing)
