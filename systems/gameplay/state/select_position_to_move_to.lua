systems.gameplay.state.createSelectPositionToMoveToState = function(self, gameObjectManager, unit)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.selector,
            setupData = makeTupleCopy(unit.mapPosition)
        }
    })

    local state = {
        gameObjectManager = gameObjectManager,
        selectedUnit = unit,
        positionsInMovementRange = gameObjectManager.unitManager:getMapPositionsInMovementRange(unit),

        update = function(self)
            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPositions,
                    color = colorEnum.darkGreen,
                    positions = self.positionsInMovementRange
                }
            })

            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPositions,
                    color = colorEnum.yellow,
                    positions = {self.selectedUnit.mapPosition}
                }
            })
        end,

        receiveMessage = function(self, message)
        
            if(message.type == messageTypesEnum.selectorPosition) self:runSelector(message.value)
            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.select) self:select(message.value.selectorPosition)
            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.cancel) self:cancel(message.value.selectorPosition)
        end,

        runSelector = function(self, selectorPosition)
            local selectorColor = colorEnum.brown

            for position in all(self.positionsInMovementRange) do
                if(sequencesHaveTheSameValues(position, selectorPosition)) selectorColor = colorEnum.green break
            end

            -- if(sequencesHaveTheSameValues(selectorPosition, self.selectedUnit.mapPosition)) selectorColor = colorEnum.yellow

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
            local positionIsSelectable = false

            for position in all(self.positionsInMovementRange) do
                if(sequencesHaveTheSameValues(position, selectorPosition)) positionIsSelectable = true break
            end

            if(positionIsSelectable) then
                self.selectedUnit.previousPosition = makeTupleCopy(self.selectedUnit.mapPosition)
                self.gameObjectManager.unitManager:moveUnit(self.selectedUnit, selectorPosition)
                systems.messenger:sendMessage({
                    type = messageTypesEnum.setNewGameplayState,
                    value = {
                        newStateName = gameplayStateEnum.actionMenu,
                        unit = self.selectedUnit
                    }
                })
            end
        end,

        cancel = function(self, selectorPosition)
            systems.messenger:sendMessage({
                type = messageTypesEnum.setNewGameplayState,
                value = {
                    newStateName = gameplayStateEnum.selectUnitToAct,
                    selectorPosition = selectorPosition
                }
            })
        end
    }

    return state
end