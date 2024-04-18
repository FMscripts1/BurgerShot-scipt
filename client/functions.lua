--/////// GLOBAL ///////
function refreshPlayer()
    _pped = PlayerPedId()
    _pvector4 = vector4(GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
end

function removePed(ped, object)
    DeleteEntity(ped)
    DeleteObject(object)
end

--PEDS
local function requestPedModel(pedHash)
    RequestModel(pedHash)
    RequestCollisionForModel(pedHash)
    repeat Wait(0) until HasModelLoaded(pedHash) and HasCollisionForModelLoaded(pedHash)
end

local function createAPed(model, coords)
    requestPedModel(model)
    local ped = CreatePed(1, model, coords.xyz, false, false)
    SetEntityHeading(ped, coords[4])
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    return ped
end

--BLIPS
local function createABlip(coords, sprite, color, scale, text)
    local blip = AddBlipForCoord(coords)

    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

--ANIMATIONS
local function playAnimationPed(ped, animDict, animationName)
    repeat RequestAnimDict(animDict) Wait(1) until HasAnimDictLoaded(animDict)
    TaskPlayAnim(ped, animDict, animationName, 6.0, -6.0, -1, 1, 0, 0, 0, 0)
end

--PROPS
local function setPedProp(ped, propIndex, drawableId, textureId)
    ClearPedProp(ped, propIndex)
    SetPedPropIndex(ped, propIndex, drawableId, textureId, true)
end

--OBJECTS
local function createAObject(hash, x, y, z, collision, attach)
    local object = CreateObject(GetHashKey(hash), x, y, z, false,false,false)
    SetEntityCollision(obj, collision)
    if attach then
        local bone = GetPedBoneIndex(attach.ped, attach.bone)
        AttachEntityToEntity(object, attach.ped, bone, attach.pos, attach.rot, false, false, false, false, false, false)
    end
    return object
end
--//////////////////////

--JOB
local function startJob()
    if not jobIsStarted then
        refreshPlayer()
        setPedProp(_pped, 0, config.playerEmployee.hat.drawableId, config.playerEmployee.hat.textureId)

        SetEntityCoords(_pped, config.playerEmployee.startJobCoords.xyz)
        SetEntityHeading(_pped, config.playerEmployee.startJobCoords[4])

        --ADD MARKER TO COOK BURGER WITH MEAT
        table.insert(markerDraw, {sprite = config.job.step2.marker.sprite, x = config.job.step2.marker.x, y = config.job.step2.marker.y, z = config.job.step2.marker.z, scale = config.job.step2.marker.scale, bobUpAndDown = config.job.step2.marker.bobUpAndDown,
        funct = function()
            AddTextEntry('PRESS', config.job.step2.textHelp)
            DisplayHelpTextThisFrame('PRESS', false)
            if IsControlJustReleased(0, config.job.step2.keyPress) then
                QBCore.Functions.TriggerCallback('burgerShot_script:Server:CallBack:removeItem', function(result)
                    if result then
                        QBCore.Functions.Notify(config.job.step2.text.success, 'success', 1000)
                    else
                        QBCore.Functions.Notify(config.job.step2.text.error, 'error', 1000)
                        SetNewWaypoint(config.job.step1.blip.coords.xy)
                    end
                end, 'meat', config.job.step2.meatToRemove)
            end
        end})

        --ADD MARKER TO SELL BURGER
        table.insert(markerDraw, {sprite = config.job.step3.marker.sprite, x = config.job.step3.marker.x, y = config.job.step3.marker.y, z = config.job.step3.marker.z, scale = config.job.step3.marker.scale, bobUpAndDown = config.job.step3.marker.bobUpAndDown,
        funct = function()
            AddTextEntry('PRESS', config.job.step3.textHelp)
            DisplayHelpTextThisFrame('PRESS', false)
            if IsControlJustReleased(0, config.job.step3.keyPress) then
                QBCore.Functions.TriggerCallback('burgerShot_script:Server:CallBack:removeItem', function(result)
                    if result then
                        QBCore.Functions.Notify(config.job.step3.text.success, 'success', 1000)
                    else
                        QBCore.Functions.Notify(config.job.step3.text.error, 'error', 1000)
                    end
                end, 'burger', 1)
            end
        end})

        jobIsStarted = true
    end
end

local function buyMeat()
    refreshPlayer()
    QBCore.Functions.TriggerCallback('burgerShot_script:Server:CallBack:buyMeat', function(result)
        if result then
            QBCore.Functions.Notify(config.job.step1.text.success, 'success', 1000)
        else
            QBCore.Functions.Notify(config.job.step1.text.error, 'error', 1000)
        end
    end, config.job.step1.meatPrice)
end

--JOB PED
local function createPedJob()
    --Blip
    createABlip(config.pedJob.blip.coords, config.pedJob.blip.sprite, config.pedJob.blip.color, config.pedJob.blip.scale, config.pedJob.blip.name)
    --Ped
    pedJob = createAPed(config.pedJob.ped.model, config.pedJob.ped.coords)
    exports['qb-target']:AddTargetEntity(pedJob, {
        options = {
            {
                type = 'client',
                action = function()
                    startJob()
                end,
                icon = config.pedJob.ped.qbTarget.icon,
                label = config.pedJob.ped.qbTarget.label,
            },
        },
        distance = 1.5
    })
    playAnimationPed(pedJob, "misslsdhsclipboard@base", 'base')
    notepadObject = createAObject("prop_notepad_02", config.pedJob.ped.coords.x, config.pedJob.ped.coords.y, config.pedJob.ped.coords.z + 5, false, {
        ped = pedJob, 
        bone = 18905,
        pos = vector3(0.15, -0.01, 0.04),
        rot = vector3(190., 150.0, 100.0)
    })
end

--PED SELL MEAT
local function createSellerMeatPed()
    --Blip
    createABlip(config.job.step1.blip.coords, config.job.step1.blip.sprite, config.job.step1.blip.color, config.job.step1.blip.scale, config.job.step1.blip.name)
    --Ped
    sellerMeatPed = createAPed(config.job.step1.ped.model, config.job.step1.ped.coords)
    exports['qb-target']:AddTargetEntity(sellerMeatPed, {
        options = {
            {
                type = 'client',
                action = function()
                    buyMeat()
                end,
                icon = config.job.step1.ped.qbTarget.icon,
                label = config.job.step1.ped.qbTarget.label,
            },
        },
        distance = 1.5
    })
end


function StartScript()
    refreshPlayer()
    createPedJob()
    createSellerMeatPed()
end