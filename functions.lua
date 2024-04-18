function addItems(QBCore)
    QBCore.Functions.AddItem('meat', {
        name = 'meat',
        label = 'Meat',
        weight = 200,
        type = 'item',
        image = 'meat.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'To cook a burger'
    })
    
    QBCore.Functions.AddItem('burger', {
        name = 'burger',
        label = 'Burger',
        weight = 200,
        type = 'item',
        image = 'burger.png',
        unique = false,
        useable = true,
        shouldClose = true,
        combinable = nil,
        description = 'Nice to sell in BurgerShot'
    })
end