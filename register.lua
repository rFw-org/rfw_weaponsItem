Citizen.CreateThread(function()
    for k,v in pairs(weapons) do
        TriggerEvent("RegisterNewItem", v.itemName, v.itemLabel, 1, v.prop)
    end
end)


RegisterNetEvent("weapons:SetAmmoCount")
AddEventHandler("weapons:SetAmmoCount", function(table)
    for k,v in pairs(table) do
        exports.rFw:SetItemArg(source, v.id, {ammo = v.ammo})
    end
end)