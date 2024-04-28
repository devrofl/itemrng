local http = game:GetService("HttpService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local dataRemote = replicatedStorage:FindFirstChild("Shared"):FindFirstChild("GitHubData")

local function getInfo(url)
    local name, repo = url:match("https://github.com/([^/]+)/([^/]+)")

    if name and repo then
        local commitUrl = string.format("https://api.github.com/repos/%s/%s/commits/main", name, repo)
        
        local success, commitResponse = pcall(function()
            return http:GetAsync(commitUrl)
        end)
        
        if success then
            local commitData = http:JSONDecode(commitResponse)
            
            if commitData then
                local commitDate = commitData.commit.author.date
                local commitIDSHA = commitData.sha
                
                local commitID = commitIDSHA:sub(1, 7)
                
                local year, month, day = commitDate:match("(%d+)-(%d+)-(%d+)T")
                if year and month and day then
                    local formattedDate = month..day..year
                    return formattedDate, commitID
                else
                    warn("failed to extract date components from:", commitDate)
                    return "N/A", commitID
                end
            else
                warn("failed to decode commit data")
                return "N/A", "N/A"
            end
        else
            return "N/A", "N/A"
        end
    else
        warn("Invalid repository URL")
        return "N/A", "N/A"
    end
end

dataRemote.OnServerEvent:Connect(function(player, repo)
    local commitDate, commitID = getInfo(repo)
    dataRemote:FireClient(player, commitDate, commitID)
end)
