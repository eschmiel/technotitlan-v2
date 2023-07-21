function ui:createUnitActionMenuState(unit)

    local state = {
        unitActionMenu = ui:createUnitActionMenu(unit),
        selectedUnit = unit
    }

    function state:update(positionManager)
        local buttonEvent = self.unitActionMenu:controls()
        local selectorMapPosition = makeTupleCopy(positionManager.navGraph.graphPositionToMapPosition[self.selectedUnit.graphPosition])

        if(buttonEvent == unitActionsEnum.move) then
            local newState = ui:createSelectPositionToMoveToState(positionManager, self.selectedUnit)
            return newState
        end
        if(buttonEvent == unitActionsEnum.wait) then
            self.selectedUnit.active = false
            local newState = ui:createSelectUnitToActState(selectorMapPosition)
            return newState
        end
        if(buttonEvent == unitActionsEnum.cancel) then
            local newState = ui:createSelectUnitToActState(selectorMapPosition)
            return newState
        end
    end

    function state:draw(positionManager)
   --     if (self.unitActionMenu.selectedAction == unitActionsEnum.attack)
        self.unitActionMenu:draw(5, 5)
        ui.unitDetailsBottomBar:draw(self.selectedUnit, 0, 104)
        local mapPosition = positionManager.navGraph.graphPositionToMapPosition[self.selectedUnit.graphPosition]
        highlightPosition(mapPosition, colorEnum.yellow)
    end

    return state
end