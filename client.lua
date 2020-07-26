
Citizen.CreateThread(function()
    while not exports.rFw:IsPlayerLoaded() do 
        print("Waiting for player load ...")
        Wait(100) 
    end
    print("^2Player loaded! Starting weapons check.")

    while true do
        local pPed = GetPlayerPed(-1)
        local inv = exports.rFw:GetPlayerInv()
        for k,v in pairs(weaponsList) do
            if HasPedGotWeapon(pPed, GetHashKey(v), false) then
                if weapons[GetHashKey(v)] ~= nil then
                    if inv[weapons[GetHashKey(v)].itemName] == nil then
                        RemoveWeaponFromPed(pPed, GetHashKey(v))
                        print("^1WEAPON REMOVED:^7 You don't have permission to own weapon "..v)
                    end
                else
                    RemoveWeaponFromPed(pPed, GetHashKey(v))
                    print("^1WEAPON REMOVED:^7 You don't have permission to own weapon "..v)
                end
            else 
                if weapons[GetHashKey(v)] ~= nil then
                    if inv[weapons[GetHashKey(v)].itemName] ~= nil then
                        GiveWeaponToPed(pPed, GetHashKey(v), 255, false, false)
                    end
                end
            end
        end

        Wait(1000)
    end
end)