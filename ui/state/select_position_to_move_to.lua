function ui:createSelectPositionToMoveToState(unit)
    local mapPosition = position.manager.graphPositionToMapPosition[unit.position]
    local selectorStartPosition = {x = mapPosition[1], y =  mapPosition[2]}

    local state = {
        selectedUnit = unit,
        selector = ui:createSelector(selectorStartPosition)
    }

    function state:update(gameObjects)
        local selection = self.selector:controls(gameObjects)
        if(selection and not selection.unit) then
            local newUnitPosition = selection.graphPosition
            local newSelectorPosition = {x = selection.mapPosition[1], y = selection.mapPosition[2]}
            self.selectedUnit.position = newUnitPosition
            self.selectedUnit.active = false
            local newState = ui:createSelectUnitToActState(newSelectorPosition)
            return newState
        end
    end

    function state:draw(gameObjects)
        self.selector:draw(gameObjects)

        local hoverTarget = self.selector:hoverTarget(gameObjects)
        if(hoverTarget) ui.unitDetailsBottomBar:draw(hoverTarget, 0, 104)
        local mapPosition = position.manager.graphPositionToMapPosition[self.selectedUnit.position]
        highlightPosition({x = mapPosition[1], y = mapPosition[2]}, colorEnum.yellow)
    end

    return state
end