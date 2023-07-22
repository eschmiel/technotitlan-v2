systems.gameplay = {
    createGameplaySystem = function(self)
        local system = {
            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.selectorPosition) then
                    systems.messenger:sendMessage({
                        type = messageTypesEnum.renderUI,
                        value = {
                            uiElement = uiElementsEnum.highlightPosition,
                            color = colorEnum.brown,
                            position = message.value
                        }
                    })
                end
            end
        }

        return system
    end
}