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
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.highlightPositions,
                        color = attackRangeColor,
                        positions = positionsInAttackRange
                    }
                })

                systems.messenger:sendMessage({
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.highlightPositions,
                        color = movementRangeColor,
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
            local activeFaction = gameObjectManager.unitManager:getActiveFaction()
            local unitFaction = gameObjectManager.unitManager:getUnitFaction(selectedUnit)
            if(selectedUnit and selectedUnit.active and unitFaction.name == activeFaction.name) then
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