systems.gameplay.state.createActionMenuState = function(self, gameObjectManager, unit)
    local state = {
        gameObjectManager = gameObjectManager,
        selectedUnit = unit,

        update = function(self)
            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.unitActionMenu,
                    pixelPosition = {20,20},
                    unit = self.selectedUnit,
                    selectedAction = 1
                }
            })
        end
    }

    return state
end