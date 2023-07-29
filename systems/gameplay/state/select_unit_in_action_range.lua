systems.gameplay.state.createSelectUnitInActionRangeState = function(self, gameObjectManager, actingUnit, action)
    local unitsInActionRange = gameObjectManager.unitManager:getUnitsInActionRange(actingUnit, action)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.menu,
            setupData = { numberOfOptions = #unitsInActionRange }
        }
    })

    local state = {
        gameObjectManager = gameObjectManager,
        actingUnit = actingUnit,
        unitsInActionRange = unitsInActionRange,
        selectableUnitPositions = {},
        action = action,

        update = function(self)
            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPositions,
                    color = colorEnum.magenta,
                    positions = self.selectableUnitPositions
                }
            })

            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPositions,
                    color = colorEnum.yellow,
                    positions = {self.actingUnit.mapPosition}
                }
            })
        end,

        receiveMessage = function(self, message)
        
            if(message.type == messageTypesEnum.selectedOption) self:runSelector(message.value)
            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.select) self:select(message.value.selected)
            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.cancel) self:cancel()
        end,

        runSelector = function(self, selectedOption)
            if (selectedOption > #self.unitsInActionRange) return
            if(#self.unitsInActionRange > 0) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.renderUI,
                    value = {
                        uiElement = uiElementsEnum.highlightPositions,
                        color = colorEnum.red,
                        positions = {self.unitsInActionRange[selectedOption].mapPosition}
                    }
                })
            end
        end,

        select = function(self, selected)
            local targetPosition = makeTupleCopy(self.unitsInActionRange[selected].mapPosition)
            self.gameObjectManager.unitManager:runUnitAction(self.actingUnit, self.unitsInActionRange[selected], self.action)
            systems.messenger:sendMessage({
                type = messageTypesEnum.setNewGameplayState,
                value = {
                    newStateName = gameplayStateEnum.selectUnitToAct,
                    selectorPosition = targetPosition,
                }
            })
        end,

        cancel = function(self)
            systems.messenger:sendMessage({
                type = messageTypesEnum.setNewGameplayState,
                value = {
                    newStateName = gameplayStateEnum.actionMenu,
                    unit = self.actingUnit
                }
            })
        end
    }

    for unit in all(unitsInActionRange) do add(state.selectableUnitPositions, unit.mapPosition) end
    return state
end