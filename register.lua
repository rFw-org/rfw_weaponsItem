Citizen.CreateThread(function()
    for k,v in pairs(weapons) do
        TriggerEvent("RegisterNewItem", v.itemName, v.itemLabel, 1)
    end
end)
