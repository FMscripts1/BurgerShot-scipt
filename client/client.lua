local function loop()
    local interval = 3
    while true do
        Wait(interval)
        refreshPlayer()
        --OPTIMIZATION
        local centerOfBurgerShot = vector3(-1199.24, -897.29, 14.97) -- I get the center of burger shot for optimization
        local dist = #(_pvector4.xyz - centerOfBurgerShot)

        local dist2 = #(_pvector4.xyz - GetEntityCoords(pedJob))
        local dist3 = #(_pvector4.xyz - GetEntityCoords(sellerMeatPed))

        if (dist < 5.5 and markerDraw[1] ~= nil) then
            --MARKER
            interval = 3
            for i, k in ipairs(markerDraw) do
                DrawMarker(k.sprite, k.x,k.y,k.z, 0.0,0.0,0.0, 0.0,180.0,0.0, k.scale,k.scale,k.scale, 255,255,0, 50, k.bobUpAndDown, true, 2, nil, nil, false)
                local distMarker = #(_pvector4.xyz - vector3(k.x,k.y,k.z))
                if distMarker < 2 then
                    k.funct()
                end
            end
        elseif (dist2 < 15 or dist3 < 15) then
            --PEDS
            SetEntityAlpha(pedJob, 255, false)
            SetEntityAlpha(notepadObject, 255, false)
            SetEntityAlpha(sellerMeatPed, 255, false)
            interval = 1000
        else
            SetEntityAlpha(pedJob, 0, false)
            SetEntityAlpha(notepadObject, 0, false)
            SetEntityAlpha(sellerMeatPed, 0, false)
            interval = 2500
        end
    end
end

CreateThread(function()
    --ClearPedProp(PlayerPedId(), 0)
    StartScript()
    loop()
end)

AddEventHandler("onResourceStop", function()
    if GetCurrentResourceName() == config.currentScriptName then
        removePed(pedJob, notepadObject)
    end
end)