function ui:createSelectPositionToMoveToState(unit)
    local selectorStartPosition = createPositionObjectCopy(unit.position)

    local state = {
        selectedUnit = unit,
        selector = ui:createSelector(selectorStartPosition)
    }

    function state:update(gameObjects)
        local selection = self.selector:controls(gameObjects)
        if(selection and not selection.unit) then
            local newUnitPosition = createPositionObjectCopy(selection.position)
            local newSelectorPosition = createPositionObjectCopy(selection.position)
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
        highlightPosition(self.selectedUnit.position, colorEnum.yellow)
    end

    return state
end