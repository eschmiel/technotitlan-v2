systems.gameplay.state.createActionMenuState = function(self, gameObjectManager, unit)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.menu,
            setupData = {numberOfOptions = #unit.actions}
        }
    })

    local state = {
        gameObjectManager = gameObjectManager,
        selectedUnit = unit,

        receiveMessage = function(self, message)
            if(message.type == messageTypesEnum.selectedOption) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.unitActionMenu,
                        pixelPosition = {20,20},
                        unit = self.selectedUnit,
                        selectedAction = message.value
                    }
                })
            end

            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.select) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.setNewGameplayState,
                    value = {
                        newStateName = gameplayStateEnum.selectPositionToMoveTo,
                        unit = self.selectedUnit
                    }
                })
            end
        end
    }

    return state
end