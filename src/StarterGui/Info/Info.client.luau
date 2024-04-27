local replicatedStorage = game:GetService("ReplicatedStorage")
local dataRemote = replicatedStorage:FindFirstChild("Shared"):FindFirstChild("GitHubData")

dataRemote.OnClientEvent:Connect(function(commitDate, commitID)
    print("commit date:", commitDate)
    print("commit ID:", commitID)
end)

dataRemote:FireServer("https://github.com/devrofl/itemrng")
