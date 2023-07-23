systems.gameplay = {
    createGameplaySystem = function(self, gameObjectManager, startingState)
        local system = {
            state,
            gameObjectManager = gameObjectManager,

            update = function(self)
                if(self.state.update) self.state:update()
            end,

            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.setNewGameplayState) then self:setNewGameplayState(message.value)
                elseif(self.state.receiveMessage) then self.state:receiveMessage(message)
                end 
            end,

            setNewGameplayState = function(self, newStateName)
                if(newStateName == gameplayStateEnum.selectUnitToAct) then
                    local newState = systems.gameplay.state:createSelectUnitToActState(self.gameObjectManager, {4,4})
                    self.state = newState
                end
                if(newStateName == gameplayStateEnum.startPlayerTurn) then
                    local newState = systems.gameplay.state:createStartPlayerTurnState(self.gameObjectManager)
                    self.state = newState
                end
            end
        }

        system:setNewGameplayState(startingState)

        return system
    end
}

gameplayStateEnum = {
    startPlayerTurn = 'start player turn',
    selectUnitToAct = 'select unit to act'
}