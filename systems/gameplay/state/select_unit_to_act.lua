systems.gameplay.state.createSelectUnitToActState = function(self, gameObjectManager, startingPosition)
    systems.messenger:sendMessage({
        messageTypesEnum.setNewController,
        controllersEnum.selector,
        startingPosition or {0,0}
    })

    local state = {
        gameObjectManager = gameObjectManager,

        receiveMessage = function(self, message)
            if(message[1] == messageTypesEnum.selectorPosition) self:runSelector(message[2])
            if(message[1] == messageTypesEnum.action and message[2] == actionsEnum.select) self:select(message[3])
        end,

        runSelector = function(self, selectorPosition)
            local selectorColor = colorEnum.brown
            local attackRangeColor = colorEnum.red
            local movementRangeColor = colorEnum.green

            local hoverUnit = self.gameObjectManager.unitManager:getUnitAtPosition(selectorPosition)
            
            if(hoverUnit and hoverUnit.active) then
                selectorColor = colorEnum.yellow

                local activeFaction = gameObjectManager.unitManager:getActiveFaction()
                local unitFaction = gameObjectManager.unitManager:getUnitFaction(hoverUnit)

                if(activeFaction.name != unitFaction.name) then
                    selectorColor = colorEnum.brown
                    attackRangeColor = colorEnum.magenta
                    movementRangeColor = colorEnum.darkGreen
                end

                local positionsInMovementRange = self.gameObjectManager.unitManager:getMapPositionsInMovementRange(hoverUnit)
                local positionsInAttackRange = self.gameObjectManager.unitManager:getMapPositionsInAttackRangeAfterMovement(hoverUnit)

                systems.messenger:sendMessage({
                    messageTypesEnum.renderUI,
                    uiElementsEnum.highlightPositions,
                    attackRangeColor,
                    positionsInAttackRange
                })

                systems.messenger:sendMessage({
                    messageTypesEnum.renderUI,
                    uiElementsEnum.highlightPositions,
                    movementRangeColor,
                    positionsInMovementRange
                })

                systems.messenger:sendMessage({
                    messageTypesEnum.renderUI,
                    uiElementsEnum.unitDetails,
                    hoverUnit
                })
            end

            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.highlightPositions,
                selectorColor,
                {selectorPosition}
            })
        end,

        select = function(self, selectorPosition)
            local selectedUnit = gameObjectManager.unitManager:getUnitAtPosition(selectorPosition)
            local activeFaction = gameObjectManager.unitManager:getActiveFaction()
            local unitFaction = gameObjectManager.unitManager:getUnitFaction(selectedUnit)
            if(selectedUnit and selectedUnit.active and unitFaction.name == activeFaction.name) then
                systems.messenger:sendMessage({
                    messageTypesEnum.setNewGameplayState,
                    gameplayStateEnum.selectPositionToMoveTo,
                    selectedUnit
                })
            end
        end
    }

    return state
end