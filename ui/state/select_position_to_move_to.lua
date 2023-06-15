function ui:createSelectPositionToMoveToState(unit)
    local selectorStartPosition = makeTupleCopy(position.manager.graphPositionToMapPosition[unit.graphPosition])

    local state = {
        selectedUnit = unit,
        selector = ui:createSelector(selectorStartPosition)
    }

    function state:update(gameObjects)
        local selection = self.selector:controls(gameObjects)
        if(selection and not selection.unit and selection.graphPosition) then
            local newSelectorMapPosition = makeTupleCopy(selection.mapPosition)
            self.selectedUnit.graphPosition = selection.graphPosition
            self.selectedUnit.active = false
            local newState = ui:createSelectUnitToActState(newSelectorMapPosition)
            return newState
        end
    end

    function state:draw(gameObjects)
        self.selector:draw(gameObjects)

        local hoverTarget = self.selector:hoverTarget(gameObjects)
        if(hoverTarget) ui.unitDetailsBottomBar:draw(hoverTarget, 0, 104)
        local mapPosition = position.manager.graphPositionToMapPosition[self.selectedUnit.graphPosition]
        highlightPosition(mapPosition, colorEnum.yellow)
    end

    return state
end