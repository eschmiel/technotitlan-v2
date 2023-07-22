systems.ui = {
    createUISystem = function(self)
        local system = {
            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.renderUI) then
                    if(message.value.uiElement == uiElementsEnum.highlightPosition) modules.ui.positions:highlightPositions({message.value.position}, message.value.color)
                end
            end,

            renderByMessage = function(self, message)
                local data = message.value
                if(data.uiElement == uiElementsEnum.highlightPosition) modules.ui.positions:highlightPositions({data.position}, data.color)
            end
        }

        return system
    end
}

uiElementsEnum = {
    highlightPosition = 'highlight position'
}