local weaponCache = {}


Citizen.CreateThread(function()
    while not exports.rFw:IsPlayerLoaded() do 
        print("Waiting for player load ...")
        Wait(100) 
    end
    print("^2Player loaded! Starting weapons check.")

    while true do
        local pPed = GetPlayerPed(-1)
        local inv = exports.rFw:GetPlayerInv()
        local inv = inv.inv
        local ammoChange = false
        for k,v in pairs(weaponsList) do
            if HasPedGotWeapon(pPed, GetHashKey(v), false) then
                if weapons[GetHashKey(v)] ~= nil then
                    local found, args, id = LookForItemName(inv, weapons[GetHashKey(v)].itemName)
                    if not found then
                        RemoveWeaponFromPed(pPed, GetHashKey(v))
                        print("^1WEAPON REMOVED:^7 You don't have permission to own weapon "..v)
                        if weaponCache[GetHashKey(v)] ~= nil then
                            weaponCache[GetHashKey(v)] = nil
                        end
                    else
                        local ammo = GetAmmoInPedWeapon(pPed, GetHashKey(v))
                        if weaponCache[GetHashKey(v)] == nil then 
                            weaponCache[GetHashKey(v)] = {ammo = ammo, id = inv[id].itemId}
                            ammoChange = true
                        else
                            if weaponCache[GetHashKey(v)].ammo ~= ammo then
                                weaponCache[GetHashKey(v)].ammo = ammo
                                ammoChange = true
                            else
                                weaponCache[GetHashKey(v)].ammo = ammo
                            end
                        end
                    end
                else
                    RemoveWeaponFromPed(pPed, GetHashKey(v))
                    print("^1WEAPON REMOVED:^7 You don't have permission to own weapon "..v)
                    if weaponCache[GetHashKey(v)] ~= nil then
                        weaponCache[GetHashKey(v)] = nil
                    end
                end
            else 
                if weapons[GetHashKey(v)] ~= nil then
                    local found, args = LookForItemName(inv, weapons[GetHashKey(v)].itemName)
                    if found then
                        if args ~= nil then
                            if args.ammo ~= nil then
                                GiveWeaponToPed(pPed, GetHashKey(v), args.ammo, false, false)
                            else
                                GiveWeaponToPed(pPed, GetHashKey(v), 255, false, false) 
                            end
                        else
                            GiveWeaponToPed(pPed, GetHashKey(v), 255, false, false)
                        end
                    end
                end
            end
        end

        if ammoChange then
            TriggerServerEvent("weapons:SetAmmoCount", weaponCache)
        end
        Wait(1000)
    end
end)


function LookForItemName(inv, name)
    for k,v in pairs(inv) do
        if v.item == name then
            return true, v.args, v.itemId
        end
    end
    return false
end