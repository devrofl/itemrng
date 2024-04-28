local http = game:GetService("HttpService")

local items = {}

function items:init(api)
    self.api = api
    return self
end

function items:getItems()
    local response = http:GetAsync(self.api)
    local data = http:JSONDecode(response)

    if data.success then
        return data.items
    else
        return "failed decoding reponse"
    end
end

return items