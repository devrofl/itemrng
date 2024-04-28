local replicatedStorage = game:GetService("ReplicatedStorage")
local dataRemote = replicatedStorage:FindFirstChild("Shared"):FindFirstChild("GitHubData")
local text = script.Parent:FindFirstChild("Background"):FindFirstChild("yup")

dataRemote.OnClientEvent:Connect(function(commitDate, commitID)
    text.Text = "proto-"..commitDate.." (build "..commitID..")"
end)

dataRemote:FireServer("https://github.com/devrofl/itemrng")

while task.wait(300) do
    dataRemote:FireServer("https://github.com/devrofl/itemrng")
end