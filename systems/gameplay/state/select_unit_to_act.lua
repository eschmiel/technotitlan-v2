systems.gameplay.state.createSelectUnitToActState = function(self, gameObjectManager, startingPosition)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.selector,
            setupData = startingPosition or {0,0}
        }
    })

    local state = {
        gameObjectManager = gameObjectManager,

        receiveMessage = function(self, message)
            if(message.type == messageTypesEnum.selectorPosition) self:runSelector(message.value)
            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.select) self:select(message.value.selectorPosition)
        end,

        runSelector = function(self, selectorPosition)
            local selectorColor = colorEnum.brown
            local hoverUnit = gameObjectManager:getUnitAtPosition(selectorPosition)
            
            if(hoverUnit) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.unitDetails,
                        unit = hoverUnit
                    }
                })
                selectorColor = colorEnum.pink
            end

            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPosition,
                    color = selectorColor,
                    position = selectorPosition
                }
            })
        end,

        select = function(self, selectorPosition)
            local selectedUnit = gameObjectManager:getUnitAtPosition(selectorPosition)
            if(selectedUnit) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.setNewGameplayState,
                    value = {
                        newStateName = gameplayStateEnum.actionMenu,
                        unit = selectedUnit
                    }
                })
            end
        end
    }

    return state
end