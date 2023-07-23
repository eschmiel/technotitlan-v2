-- TO-DO
-- -- Reimplement action menu with new architecture
-- -- Reimplement moving units with new architecture
-- -- Display positions user can move to or attack
-- -- Manage graph objects through Object Manager
-- -- Attacking units

function init_game()
    palt(colorEnum.black, false)
    local gameObjectManager = gameObjectManager:createGameObjectManager(level1Data)

    local controllerSystem = systems.controllers:createControllerSystem(selectorController)
    systems:registerLogicSystem(controllerSystem)
    
    local gameplaySystem = systems.gameplay:createGameplaySystem(gameObjectManager, gameplayStateEnum.startPlayerTurn)
    systems:registerLogicSystem(gameplaySystem)

    local worldRenderSystem = systems.worldRender:createWorldRenderSystem(gameObjectManager)
    systems:registerRenderSystem(worldRenderSystem)

    local uiSystem = systems.ui:createUISystem()
    systems:registerRenderSystem(uiSystem)
end

function update_game()
    systems:runLogicSystems()
end

function draw_game()
    cls(colorEnum.navy)
    systems:runRenderSystems()
end

