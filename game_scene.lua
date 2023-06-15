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
    positionManager = position.manager:buildPositionLists(level1Data.mapCoordinates)
     game_objects = {
        faction = createFaction(level1Data.faction1Units)
    }
    local startingState = ui:createStartPlayerTurnState()
    uiManager = ui:createUIManager(game_objects, startingState)
end

function update_game()
    uiManager:update()
end

function draw_game()
    cls(colorEnum.navy)
    map(96,0)
    
    game_objects.faction:draw()
    uiManager:draw()
    --drawGraphPositions()
end

