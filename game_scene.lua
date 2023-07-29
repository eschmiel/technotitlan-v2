-- TO-DO
-- -- Attacking units
-- -- Get rid of old code

function init_game()
    palt(colorEnum.black, false)
    local gameObjectManager = gameObjectManager:createGameObjectManager(level1Data)
    
    local gameplaySystem = systems.gameplay:createGameplaySystem(gameObjectManager, gameplayStateEnum.startPlayerTurn)
    systems:registerLogicSystem(gameplaySystem)

    local controllerSystem = systems.controllers:createControllerSystem(selectorController)
    systems:registerLogicSystem(controllerSystem)

    local worldRenderSystem = systems.worldRender:createWorldRenderSystem(gameObjectManager)
    systems:registerRenderSystem(worldRenderSystem)

    local uiSystem = systems.ui:createUISystem()
    systems:registerRenderSystem(uiSystem)

    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewGameplayState,
        value = {
            newStateName = gameplayStateEnum.startPlayerTurn
        }
    })
end

function update_game()
    systems:runLogicSystems()
end

function draw_game()
    cls(colorEnum.navy)
    systems:runRenderSystems()
end

