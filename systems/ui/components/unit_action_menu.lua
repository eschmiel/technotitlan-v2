systems.ui.renderUnitActionMenu = function (self, pixelPosition, unit, selectedAction)
    -- examineTable(unit)
    local textBox = ui.textBox:create(pixelPosition[1], pixelPosition[2], 6, #unit.actions + 1)
    textBox.topPadding = pixelPosition[2] + 8

    textBox:draw()

    for actionNumber, action in ipairs(unit.actions) do
        local actionOptionColor = colorEnum.grey
        if (actionNumber == self.selectedAction) actionOptionColor = colorEnum.white
    
        print(action, textBox:getColumnX(0), textBox:getRowY(actionNumber - 1), actionOptionColor)
    end
end