local Blacklist = {
    [2735237971] = true
}

local NameStore = {}
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local function checkPlayer(player)
    if Blacklist[player.UserId] then
        table.insert(NameStore, player.Name)
        if player.Character then
            player.Character:Destroy()
        end
        task.wait(0.1)
        player:Destroy()
    end
end

local function checkWorkspaceChild(child)
    for _, name in ipairs(NameStore) do
        if child.Name == name then
            task.wait(0.1)
            child:Destroy()
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    task.wait(0.1)
    checkPlayer(player)
end

Players.PlayerAdded:Connect(checkPlayer)

Players.PlayerAdded:Connect(function(player)
    if Blacklist[player.UserId] then
        player.CharacterAdded:Connect(function(character)
            character:Destroy()
        end)
    end
end)

for _, child in ipairs(Workspace:GetChildren()) do
    task.wait(0.1)
    checkWorkspaceChild(child)
end

Workspace.ChildAdded:Connect(checkWorkspaceChild)
