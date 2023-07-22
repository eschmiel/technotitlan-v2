-- TO-DO
-- Setup Github Repo
--[DONE] Create action menu on unit selection
--[DONE] Deselect and return to selector controls when wait or cancel are chosen
--[DONE] Set unit.active to false on wait
-- Maintain selected unit and restore selector controls when attack or move are chosen.
--[DONE] Cancel on button O.
--[DONE] Create action menu controls

function init_game()
    palt(colorEnum.black, false)
    game_state = {
        positionManager = position:createManager(level1Data.mapCoordinates)
    }
    positionManager = position:createManager(level1Data.mapCoordinates)
     game_objects = {
        faction = createFaction(positionManager, level1Data.faction1Units)
    }
    local startingState = ui:createStartPlayerTurnState()
    uiManager = ui:createUIManager(positionManager, game_objects, startingState)

    local controllerSystem = systems.controllers:createControllerSystem(selectorController)
    systems:registerLogicSystem(controllerSystem)
    
    local selectUnitToActState = systems.gameplay.state:createSelectUnitToActState()
    local gameplaySystem = systems.gameplay:createGameplaySystem(selectUnitToActState)
    systems:registerLogicSystem(gameplaySystem)

    local uiSystem = systems.ui:createUISystem()
    systems:registerRenderSystem(uiSystem)
end

function update_game()
    uiManager:update()
    systems:runLogicSystems()
end

function draw_game()
    cls(colorEnum.navy)
    -- map(96,0)
    
    game_objects.faction:draw(positionManager)
    --uiManager:draw()
    --drawGraphPositions()
    systems:runRenderSystems()
end

