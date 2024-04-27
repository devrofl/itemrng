local http = game:GetService("HttpService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local dataRemote = replicatedStorage:FindFirstChild("Shared"):FindFirstChild("GitHubData")

local function getInfo(url)
    local name, repo = url:match("https://github.com/([^/]+)/([^/]+)")

    if name and repo then
        local commitUrl = string.format("https://api.github.com/repos/%s/%s/commits/master", name, repo)
        print("Fetching data from:", commitUrl)
        local commitResponse = http:GetAsync(commitUrl)
        print("Response:", commitResponse)
        local commitData = http:JSONDecode(commitResponse)
        
        if commitData then
            local commitDate = commitData.commit.author.date
            local commitID = commitData.sha
            print("Commit Date:", commitDate)
            print("Commit ID:", commitID)

            local dateComponents = commitDate:match("(%d+)-(%d+)-(%d+)T")
            if dateComponents then
                local year, month, day = dateComponents[1], dateComponents[2], dateComponents[3]
                local formattedDate = month .. day .. year
                return formattedDate, commitID
            else
                return "N/A", "N/A"
            end
        else
            return "N/A", "N/A"
        end
    else
        return "N/A", "N/A"
    end
end

dataRemote.OnServerEvent:Connect(function(player, repo)
    print("Received request from", player.Name, "for repo:", repo)
    local commitDate, commitID = getInfo(repo)
    dataRemote:FireClient(player, commitDate, commitID)
end)
