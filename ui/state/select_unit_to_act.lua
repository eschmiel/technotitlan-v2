function ui:createSelectUnitToActState(selectorStartPosition)
    local state = {
        selector = ui:createSelector(selectorStartPosition)
    }

    function state:update(positionManager, gameObjects)
        local btnEvent = self.selector:controls()
        local selection

        if(btnEvent == controllerEnum.o) selection = self.selector:select(positionManager, gameObjects)
        if(selection and selection.unit and selection.unit.active) then
            local newState = ui:createUnitActionMenuState(selection.unit)
            return newState
        end
    end

    function state:draw(positionManager, gameObjects)
        local hoverTarget = self.selector:hoverTarget(positionManager, gameObjects)

        if(hoverTarget and hoverTarget.active) then            
            hoverTarget:highlightMapGraphPositionsInAttackRange(positionManager)
            hoverTarget:highlightMovementOptions(positionManager)
        end

        self.selector:draw(positionManager, gameObjects)

        if(hoverTarget) ui.unitDetailsBottomBar:draw(hoverTarget, 0, 104)
    end

    return state
end