-- IT'S NECESSARY TO ADD IMAGES (burgershot_script/necessary)
-- images: resources\[qb]\qb-inventory\html\images
-- AND IN server.cfg: start burgershot-script

--ALL IS CUSTOM
config = {
    pedJob = {
        blip = {
            coords = vector3(-1190.49, -889.0, 0),
            sprite = 536,
            color = 17,
            scale = .6,
            name = "BurgerShot"
        },
        ped = {
            coords = vector4(-1180.16, -885.91, 12.8, 303.06),
            model = "a_m_y_mexthug_01",
            qbTarget = {
                icon = "fa-solid fa-burger",
                label = "go to work"
            },
        }
    },
    playerEmployee = {
        hat = {drawableId = 37, textureId = 2}, -- https://wiki.rage.mp/index.php?title=Male_Hats
        startJobCoords = vector4(-1198.15, -900.82, 14.0, 331.92)
    },
    job = {
        step1 = { --Bringing meat
            blip = {
                coords = vector3(1443.82, 1132.42, 0),
                sprite = 141,
                color = 1,
                scale = .6,
                name = "Meat"
            },
            ped = {
                coords = vector4(1443.82, 1132.42, 113.33, 190.78),
                model = "a_m_m_farmer_01",
                qbTarget = {
                    icon = "fa-solid fa-tractor",
                    label = "purchase meat [$30]"
                }
            },
            text = {
                success = "You bought meat [$30]",
                error = "You don't have enough monney [$30]"
            },
            meatPrice = 30,
            meatToAdd = 1
        },
        step2 = { --Cook burger with meat
            marker = {sprite = 2, x = -1199.81, y = -902.09, z = 14.91, scale = 0.2, bobUpAndDown = true},
            textHelp = "Press ~INPUT_CONTEXT~ to cook a burger",
            keyPress = 51,
            text = {
                success = "You made a burger",
                error = "You need 2 meats"
            },
            meatToRemove = 2
        },
        step3 = { --Sell burger
            marker = {sprite = 23, x = -1196.48, y = -897.66, z = 13.0, scale = 1.0, bobUpAndDown = false},
            textHelp = "Press ~INPUT_CONTEXT~ to sell your burger",
            keyPress = 51,
            text = {
                success = "You sold a burger",
                error = "You do not have burger"
            },
            burgerPrice = 90
        }
    },
    currentScriptName = "burgershot_script"
}