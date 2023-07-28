systems.gameplay = {
    createGameplaySystem = function(self, gameObjectManager, startingState)
        local system = {
            state,
            gameObjectManager = gameObjectManager,

            update = function(self)
                if(self.state and self.state.update) self.state:update()
            end,

            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.setNewGameplayState) then self:setNewGameplayState(message.value)
                elseif(self.state and self.state.receiveMessage) then self.state:receiveMessage(message)
                end 
            end,

            setNewGameplayState = function(self, payload)
                if(payload.newStateName == gameplayStateEnum.selectUnitToAct) then
                    local newState = systems.gameplay.state:createSelectUnitToActState(self.gameObjectManager, payload.selectorPosition)
                    self.state = newState
                end
                if(payload.newStateName == gameplayStateEnum.startPlayerTurn) then
                    local newState = systems.gameplay.state:createStartPlayerTurnState(self.gameObjectManager)
                    self.state = newState
                end
                if(payload.newStateName == gameplayStateEnum.actionMenu) then
                    local newState = systems.gameplay.state:createActionMenuState(self.gameObjectManager, payload.unit, payload.previousPosition)
                    self.state = newState
                end
                if(payload.newStateName == gameplayStateEnum.selectPositionToMoveTo) then
                    local newState = systems.gameplay.state:createSelectPositionToMoveToState(self.gameObjectManager, payload.unit)
                    self.state = newState
                end
            end
        }

        return system
    end
}

gameplayStateEnum = {
    startPlayerTurn = 'start player turn',
    selectUnitToAct = 'select unit to act',
    actionMenu = 'action menu',
    selectPositionToMoveTo = 'select position to move to'
}