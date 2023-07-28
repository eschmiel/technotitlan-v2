systems.gameplay.state.createActionMenuState = function(self, gameObjectManager, unit, previousPosition)
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
        previousPosition = previousPosition,

        receiveMessage = function(self, message)
            if(message.type == messageTypesEnum.selectedOption) self:displayActionMenu(message.value)
            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.select) self:select(message.value.selected)
            if(message.type == messageTypesEnum.action and message.value.action == actionsEnum.cancel) self:cancel()
        end,

        displayActionMenu = function(self, selectedAction)
            local positionsInRange = self.gameObjectManager.unitManager:getMapPositionsInActionRange(self.selectedUnit, self.selectedUnit.actions[selectedAction])
            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.highlightPositions,
                    color = colorEnum.red,
                    positions = positionsInRange
                }
            })

            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.unitActionMenu,
                    pixelPosition = {20,20},
                    unit = self.selectedUnit,
                    selectedAction = selectedAction
                }
            })
        end,

        select = function(self, selected)
            if(self.selectedUnit.actions[selected] == unitActionsEnum.wait) then
                self.gameObjectManager.unitManager:exhaust(self.selectedUnit)

                systems.messenger:sendMessage({
                    type = messageTypesEnum.setNewGameplayState,
                    value = {
                        newStateName = gameplayStateEnum.selectUnitToAct,
                        selectorPosition = makeTupleCopy(self.selectedUnit.mapPosition)
                    }
                })
            end
        end,

        cancel = function(self)
            self.gameObjectManager.unitManager:moveUnit(self.selectedUnit, self.previousPosition)
            systems.messenger:sendMessage({
                type = messageTypesEnum.setNewGameplayState,
                value = {
                    newStateName = gameplayStateEnum.selectPositionToMoveTo,
                    unit = self.selectedUnit
                }
            })
        end

    }

    return state
end