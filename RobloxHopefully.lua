local DSS = game:GetService("DataStoreService")
local MyData = DSS:GetDataStore("MyData")


local Presets = {
	{"Strength", 0},
	{"Psychic", 0},
	{"Endurance", 0}
}


local Values = {
	{"NumberValue", nil},
	{"NumberValue", nil},
	{"NumberValue", nil}
}


local function CreateStats(player,  Matrices)

	local Folder = Instance.new("Folder")
	Folder.Name = "leaderstats"
	Folder.Parent = player


	for i, v in Matrices do
		local Value = Instance.new(Matrices[1][1])
		Value.Value = Matrices[i][2]
		Value.Name = Presets[i][1]
		Value.Parent = Folder
	end

end


local function LoadData(player)
	
	local data
	
	local success, err = pcall(function()
		data = MyData:GetAsync(tostring(player.UserId))
	end)
  
	if not data[1] then
		for i, v in Values do
			v[2] = Presets[i][2]
		end
	else
		for i, v in Values do
			v[2] = data[i][2]
		end
	end

	if not success then
		warn(err)
	end
	
	CreateStats(player, Values)
    
end

local function SaveData(player)

	local data = {}

	local folder = player.leaderstats

	for i, v in folder:GetChildren() do
		data[i] = {v.Name, v.Value}
	end
	
	local success, err = pcall(function()
		MyData:SetAsync(tostring(player.UserId), data)
	end)

	if not success then
		warn(err)
	end

end


game.Players.PlayerAdded:Connect(LoadData)
game.Players.PlayerRemoving:Connect(SaveData)

game:BindToClose(function()

	for _, Player in game.Players:GetPlayers() do
		SaveData(Player)
	end

end)