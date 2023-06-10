function ui:createUnitActionMenu(unit)

    local unitActionMenu = {
        selectedUnit = unit,
        selectedAction = 1
    }

    function unitActionMenu:controls()
        if (btnp(controllerEnum.up)) self.selectedAction -= 1
        if (btnp(controllerEnum.down)) self.selectedAction += 1
        if (btnp(controllerEnum.o)) return self.selectedUnit.actions[self.selectedAction]
        if (btnp(controllerEnum.x)) return unitActionsEnum.cancel
    
        if(self.selectedAction > #self.selectedUnit.actions) then
            self.selectedAction = 1
        elseif(self.selectedAction < 1) then
            self.selectedAction = #self.selectedUnit.actions
        end
    end

    function unitActionMenu:draw(pixelX, pixelY)
        local textBox = ui.textBox:create(pixelX, pixelY, 6, #self.selectedUnit.actions + 1)
        textBox.topPadding = pixelY + 8
    
        textBox:draw()
    
        for actionNumber, action in ipairs(self.selectedUnit.actions) do
            self:drawActionOption(actionNumber, action, textBox)
        end
    end
    
    function unitActionMenu:drawActionOption(actionNumber, action, textBox)
        local actionOptionColor = colorEnum.grey
        if (actionNumber == self.selectedAction) actionOptionColor = colorEnum.white
    
        print(action, textBox:getColumnX(0), textBox:getRowY(actionNumber - 1), actionOptionColor)
    end

    return unitActionMenu
end