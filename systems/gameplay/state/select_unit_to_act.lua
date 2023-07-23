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
        selectorPosition = startingPosition or {0, 0},
        
        update = function(self)
            local selectorColor = colorEnum.brown
            local hoverUnit = gameObjectManager:getUnitAtPosition(self.selectorPosition)
            
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
                    position = self.selectorPosition
                }
            })
        end,

        receiveMessage = function(self, message)
            if(message.type == messageTypesEnum.selectorPosition) self.selectorPosition = makeTupleCopy(message.value)
            if(message.type == messageTypesEnum.action and message.value == actionsEnum.select) self:select()
        end,

        select = function(self)
            local selectedUnit = gameObjectManager:getUnitAtPosition(self.selectorPosition)
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