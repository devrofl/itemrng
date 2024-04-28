local module = require(game:GetService("ReplicatedStorage"):FindFirstChild("Shared"):FindFirstChild("Items"))

module:init("https://api.rolimons.com/items/v1/itemdetails")

local items = module:getItems()

if type(items) == "table" then
    for itemID, itemInfo in pairs(items) do
        local itemName = itemInfo[1]
        local rap = itemInfo[3]
        print("name - "..itemName)
        print("rap - "..rap)
        print("---------------")
    end
else
    print(items)
end
