function ui:createSelectUnitToActState(selectorStartPosition)
    local state = {
        selector = ui:createSelector(selectorStartPosition)
    }

    function state:update(gameObjects)
        local selection = self.selector:controls(gameObjects)
        if(selection and selection.unit and selection.unit.active) then
            local newState = ui:createUnitActionMenuState(selection.unit)
            return newState
        end
    end

    function state:draw(gameObjects)
        local hoverTarget = self.selector:hoverTarget(gameObjects)

        if(hoverTarget and hoverTarget.active) then
            local movementOptions = position.manager:getGraphPositionsInRange(position.manager.graphAdjacency, hoverTarget.graphPosition, hoverTarget.movement)
            for graphPosition in all(movementOptions) do
                highlightPosition(position.manager.graphPositionToMapPosition[graphPosition], colorEnum.green)
            end
        end

        self.selector:draw(gameObjects)

        if(hoverTarget) ui.unitDetailsBottomBar:draw(hoverTarget, 0, 104)
    end

    return state
end