systems.gameplay.state.createActionMenuState = function(self, gameObjectManager, unit)
    systems.messenger:sendMessage({
        messageTypesEnum.setNewController,
        controllersEnum.menu,
        #unit.actions
    })

    local state = {
        gameObjectManager = gameObjectManager,
        selectedUnit = unit,

        receiveMessage = function(self, message)
            if(message[1] == messageTypesEnum.selectedOption) self:displayActionMenu(message[2])
            if(message[1] == messageTypesEnum.action and message[3] == actionsEnum.select) self:select(message[4])
            if(message[1] == messageTypesEnum.action and message[3] == actionsEnum.cancel) self:cancel()
        end,

        displayActionMenu = function(self, selectedAction)
            local positionsInRange = self.gameObjectManager.unitManager:getMapPositionsInActionRange(self.selectedUnit, self.selectedUnit.actions[selectedAction])
            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.highlightPositions,
                colorEnum.magenta,
                positionsInRange
            })

            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.unitActionMenu,
                {60,60},
                self.selectedUnit,
                selectedAction
            })
        end,

        select = function(self, selected)
            if(self.selectedUnit.actions[selected] == unitActionsEnum.wait) then
                self.gameObjectManager.unitManager:exhaust(self.selectedUnit)

                systems.messenger:sendMessage({
                    messageTypesEnum.setNewGameplayState,
                    gameplayStateEnum.selectUnitToAct,
                    makeTupleCopy(self.selectedUnit.mapPosition)
                })
            elseif(self.selectedUnit.actions[selected] == unitActionsEnum.cancel) then self:cancel()
            else
                systems.messenger:sendMessage({
                    messageTypesEnum.setNewGameplayState,
                    gameplayStateEnum.selectUnitInActionRange,
                    self.selectedUnit,
                    self.selectedUnit.actions[selected]    
                })
            end


        end,

        cancel = function(self)
            self.gameObjectManager.unitManager:moveUnit(self.selectedUnit, makeTupleCopy(self.selectedUnit.previousPosition))
            systems.messenger:sendMessage({
                messageTypesEnum.setNewGameplayState,
                gameplayStateEnum.selectPositionToMoveTo,
                self.selectedUnit
            })
        end

    }

    return state
end