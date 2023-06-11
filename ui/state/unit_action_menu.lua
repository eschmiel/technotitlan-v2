function ui:createUnitActionMenuState(unit)

    local state = {
        unitActionMenu = ui:createUnitActionMenu(unit),
        selectedUnit = unit
    }

    function state:update()
        local buttonEvent = self.unitActionMenu:controls()
        local mapPosition = position.manager.graphPositionToMapPosition[self.selectedUnit.position]
        local selectorPosition = {x = mapPosition[1], y =  mapPosition[2]}
        if(buttonEvent == unitActionsEnum.move) then
            local newState = ui:createSelectPositionToMoveToState(self.selectedUnit)
            return newState
        end
        if(buttonEvent == unitActionsEnum.wait) then
            self.selectedUnit.active = false
            local newState = ui:createSelectUnitToActState(selectorPosition)
            return newState
        end
        if(buttonEvent == unitActionsEnum.cancel) then
            local newState = ui:createSelectUnitToActState(selectorPosition)
            return newState
        end
    end

    function state:draw()
        self.unitActionMenu:draw(5, 5)
        ui.unitDetailsBottomBar:draw(self.selectedUnit, 0, 104)
        local mapPosition = position.manager.graphPositionToMapPosition[self.selectedUnit.position]
        highlightPosition({x = mapPosition[1], y = mapPosition[2]}, colorEnum.yellow)
    end

    return state
end