systems.gameplay.state.createSelectPositionToMoveToState = function(self, gameObjectManager, unit)
    systems.messenger:sendMessage({
        messageTypesEnum.setNewController,
        controllersEnum.selector,
        makeTupleCopy(unit.mapPosition)
    })

    local state = {
        gameObjectManager = gameObjectManager,
        selectedUnit = unit,
        positionsInMovementRange = gameObjectManager.unitManager:getMapPositionsInMovementRange(unit),

        update = function(self)
            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.highlightPositions,
                colorEnum.darkGreen,
                self.positionsInMovementRange
            })

            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.highlightPositions,
                colorEnum.yellow,
                {self.selectedUnit.mapPosition}
            })
        end,

        receiveMessage = function(self, message)
            if(message[1] == messageTypesEnum.selectorPosition) self:runSelector(message[2])
            if(message[1] == messageTypesEnum.action and message[2] == actionsEnum.select) self:select(message[3])
            if(message[1] == messageTypesEnum.action and message[2] == actionsEnum.cancel) self:cancel(message[3])
        end,

        runSelector = function(self, selectorPosition)
            local selectorColor = colorEnum.brown

            for position in all(self.positionsInMovementRange) do
                if(sequencesHaveTheSameValues(position, selectorPosition)) selectorColor = colorEnum.green break
            end

            -- if(sequencesHaveTheSameValues(selectorPosition, self.selectedUnit.mapPosition)) selectorColor = colorEnum.yellow

            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.highlightPositions,
                selectorColor,
                {selectorPosition}
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
                    messageTypesEnum.setNewGameplayState,
                    gameplayStateEnum.actionMenu,
                    self.selectedUnit
                })
            end
        end,

        cancel = function(self, selectorPosition)
            systems.messenger:sendMessage({
                messageTypesEnum.setNewGameplayState,
                gameplayStateEnum.selectUnitToAct,
                selectorPosition
            })
        end
    }

    return state
end