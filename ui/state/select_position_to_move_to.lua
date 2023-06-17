function ui:createSelectPositionToMoveToState(positionManager, unit)
    local selectorStartPosition = makeTupleCopy(positionManager.navGraph.graphPositionToMapPosition[unit.graphPosition])

    local state = {
        selectedUnit = unit,
        selector = ui:createSelector(selectorStartPosition),
        movementOptions = position.manager:getGraphPositionsInRange(positionManager.navGraph.adjacencyList, unit.graphPosition, unit.movement)
    }

    function state:update(positionManager, gameObjects)
        local selection = self.selector:controls(positionManager, gameObjects)
        if(selection and not selection.unit and selection.graphPosition and tableIncludesValue(self.movementOptions, selection.graphPosition)) then
            local newSelectorMapPosition = makeTupleCopy(selection.mapPosition)
            self.selectedUnit.graphPosition = selection.graphPosition
            self.selectedUnit.active = false
            local newState = ui:createSelectUnitToActState(newSelectorMapPosition)
            return newState
        end
    end

    function state:draw(positionManager, gameObjects)
        for graphPosition in all(self.movementOptions) do
            highlightPosition(positionManager.navGraph.graphPositionToMapPosition[graphPosition], colorEnum.green)
        end

        local mapPosition = positionManager.navGraph.graphPositionToMapPosition[self.selectedUnit.graphPosition]
        highlightPosition(mapPosition, colorEnum.yellow)

        self.selector:draw(positionManager, gameObjects)

        local hoverTarget = self.selector:hoverTarget(positionManager, gameObjects)
        if(hoverTarget) ui.unitDetailsBottomBar:draw(hoverTarget, 0, 104)
    end

    return state
end