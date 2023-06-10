function ui:createUnitActionMenuState(unit)

    local state = {
        unitActionMenu = ui:createUnitActionMenu(unit),
        selectedUnit = unit
    }

    function state:update()
        local buttonEvent = self.unitActionMenu:controls()
    
        if(buttonEvent == unitActionsEnum.move) then
            local newState = ui:createSelectPositionToMoveToState(self.selectedUnit)
            return newState
        end
        if(buttonEvent == unitActionsEnum.wait) then
            self.selectedUnit.active = false

            local selectorStartPosition = createPositionObjectCopy(self.selectedUnit.position)
            local newState = ui:createSelectUnitToActState(selectorStartPosition)
            return newState
        end
        if(buttonEvent == unitActionsEnum.cancel) then
            local selectorStartPosition = createPositionObjectCopy(self.selectedUnit.position)
            local newState = ui:createSelectUnitToActState(selectorStartPosition)
            return newState
        end
    end

    function state:draw()
        self.unitActionMenu:draw(5, 5)
        ui.unitDetailsBottomBar:draw(self.selectedUnit, 0, 104)
        highlightPosition(self.selectedUnit.position, colorEnum.yellow)
    end

    return state
end