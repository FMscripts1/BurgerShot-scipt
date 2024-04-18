addItems(QBCore)

QBCore.Functions.CreateCallback('burgerShot_script:Server:CallBack:buyMeat', function(source, cb, money)--, money)
    _src = source
    local Player = QBCore.Functions.GetPlayer(_src)
    money = tonumber(money)
    local bool = Player.Functions.RemoveMoney('cash', money, "banking-quick-withdraw")

    if bool then
        TriggerClientEvent('inventory:client:ItemBox', _src, QBCore.Shared.Items['meat'], "add")
        Player.Functions.AddItem('meat', config.job.step1.meatToAdd)
    end
    cb(bool)
end)

QBCore.Functions.CreateCallback('burgerShot_script:Server:CallBack:removeItem', function(source, cb, item, amount)
    _src = source
    local Player = QBCore.Functions.GetPlayer(_src)
    item = tostring(item)
    amount = tonumber(amount)
    local bool = exports['qb-inventory']:HasItem(_src, item, amount)

    if bool then
        if item == "meat" then
            Player.Functions.RemoveItem('meat', amount)
            TriggerClientEvent('inventory:client:ItemBox', _src, QBCore.Shared.Items['meat'], "remove")
            Player.Functions.AddItem('burger', 1)
            TriggerClientEvent('inventory:client:ItemBox', _src, QBCore.Shared.Items['burger'], "add")
        elseif item == "burger" then
            Player.Functions.RemoveItem('burger', 1)
            TriggerClientEvent('inventory:client:ItemBox', _src, QBCore.Shared.Items['burger'], "remove")
            Player.Functions.AddMoney('cash', config.job.step3.burgerPrice, "banking-quick-withdraw")
        end
    end
    cb(bool)
end)