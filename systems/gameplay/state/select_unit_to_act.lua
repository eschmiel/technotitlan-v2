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
            local hoverUnit = self.gameObjectManager.unitManager:getUnitAtPosition(selectorPosition)
            
            if(hoverUnit and hoverUnit.active) then
                local positionsInMovementRange = self.gameObjectManager.unitManager:getMapPositionsInMovementRange(hoverUnit)
                local positionsInAttackRange = self.gameObjectManager.unitManager:getMapPositionsInAttackRangeAfterMovement(hoverUnit)

                systems.messenger:sendMessage({
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.highlightPositions,
                        color = colorEnum.red,
                        positions = positionsInAttackRange
                    }
                })

                systems.messenger:sendMessage({
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.highlightPositions,
                        color = colorEnum.green,
                        positions = positionsInMovementRange
                    }
                })

                systems.messenger:sendMessage({
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.unitDetails,
                        unit = hoverUnit
                    }
                })
                selectorColor = colorEnum.yellow
            end

            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPositions,
                    color = selectorColor,
                    positions = {selectorPosition}
                }
            })
        end,

        select = function(self, selectorPosition)
            local selectedUnit = gameObjectManager.unitManager:getUnitAtPosition(selectorPosition)
            if(selectedUnit and selectedUnit.active) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.setNewGameplayState,
                    value = {
                        newStateName = gameplayStateEnum.selectPositionToMoveTo,
                        unit = selectedUnit
                    }
                })
            end
        end
    }

    return state
end