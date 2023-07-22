systems.ui = {
    createUISystem = function(self)
        local system = {
            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.renderUI) then
                    local data = message.value
                    if(data.uiElement == uiElementsEnum.highlightPosition) modules.ui.positions:highlightPositions({data.position}, data.color)
                    if(data.uiElement == uiElementsEnum.unitDetails) ui.unitDetailsBottomBar:draw(data.unit, 0, 104)
                    if(data.uiElement == uiElementsEnum.newTurnStartNotice) ui:createNewTurnStartNotice()
                end
            end
        }

        return system
    end
}

uiElementsEnum = {
    highlightPosition = 'highlight position',
    unitDetails = 'unit details',
    newTurnStartNotice = 'new turn start notice'
}