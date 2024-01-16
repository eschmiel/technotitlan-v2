systems.gameplay.state.createSelectUnitInActionRangeState = function(self, gameObjectManager, actingUnit, action)
    local unitsInActionRange = gameObjectManager.unitManager:getUnitsInActionRange(actingUnit, action)
    systems.messenger:sendMessage({
        messageTypesEnum.setNewController,
        controllersEnum.menu,
        unitsInActionRange:numberOfUnits()
    })

    local state = {
        gameObjectManager = gameObjectManager,
        actingUnit = actingUnit,
        unitsInActionRange = unitsInActionRange,
        selectableUnitPositions = {},
        action = action,
                
        update = function(self)
            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.highlightPositions,
                colorEnum.magenta,
                self.selectableUnitPositions
            })

            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.highlightPositions,
                colorEnum.yellow,
                {self.actingUnit.mapPosition}
            })
        end,

        receiveMessage = function(self, message)
            if(message[1] == messageTypesEnum.selectedOption) self:runSelector(message[2])
            if(message[1] == messageTypesEnum.action and message[2] == actionsEnum.select) self:select(message[3])
            if(message[1] == messageTypesEnum.action and message[2] == actionsEnum.cancel) self:cancel()
        end,

        runSelector = function(self, selectedOption)
            if (selectedOption > self.unitsInActionRange:numberOfUnits()) return
            if(self.unitsInActionRange:numberOfUnits() > 0) then
                systems.messenger:sendMessage({
                    messageTypesEnum.renderUI,
                    uiElementsEnum.highlightPositions,
                    colorEnum.red,
                    {self:targetUnit(selectedOption).mapPosition}
                })
            end
        end,

        select = function(self, selected)
            local targetPosition = makeTupleCopy(self:targetUnit(selected).mapPosition)
            self.gameObjectManager.unitManager:runUnitAction(self.actingUnit, self:targetUnit(selected), self.action)
            
            local activeFaction = self.gameObjectManager.unitManager:getActiveFaction()
            local someActiveUnitsRemain = false

            for unit in all(activeFaction.units) do
                if(unit.active) someActiveUnitsRemain = true
            end

            if(not someActiveUnitsRemain) then
                printh('beep')
                systems.messenger:sendMessage({
                    messageTypesEnum.setNewGameplayState,
                    gameplayStateEnum.newTurn,
                })
            else
                printh('chow')
                systems.messenger:sendMessage({
                    messageTypesEnum.setNewGameplayState,
                    gameplayStateEnum.selectUnitToAct,
                    targetPosition,
                })
            end
        end,

        cancel = function(self)
            systems.messenger:sendMessage({
                messageTypesEnum.setNewGameplayState,
                gameplayStateEnum.actionMenu,
                self.actingUnit
            })
        end,

        targetUnit = function(self, selectedOption)
            local totalUnitsInAllPreviouslyCheckedFactions = 0

            for index, faction in ipairs(self.unitsInActionRange.factions) do
                local unitsToCheckInCurrentFaction = #faction.units
                local selectedOptionIsInCurrentFaction = (selectedOption <= totalUnitsInAllPreviouslyCheckedFactions + unitsToCheckInCurrentFaction)
                if (selectedOptionIsInCurrentFaction) return self.unitsInActionRange.factions[index].units[selectedOption - totalUnitsInAllPreviouslyCheckedFactions]
                totalUnitsInAllPreviouslyCheckedFactions += unitsToCheckInCurrentFaction
            end
        end
    }

    for faction in all(unitsInActionRange) do
        for unit in all(faction.units) do add(state.selectableUnitPositions, unit.mapPosition) end
    end

    return state
end