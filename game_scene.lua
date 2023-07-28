-- TO-DO
-- [DONE] Reimplement action menu with new architecture
-- [IN PROGRESS] Reimplement moving units with new architecture
-- -- [DONE] move unit to selected position
-- -- -- cancel btn on select to move, action menu
-- -- -- go to select to move before action menu
-- -- -- highlight attackable positions when selector rests on attack action

-- [DONE] Display positions user can move to or attack
-- [DONE] Manage graph objects through Object Manager
-- -- Attacking units
-- -- Get rid of old code
-- [DONE] Send selector position with select message from selector controller

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

