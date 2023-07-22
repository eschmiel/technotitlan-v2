systems.gameplay = {
    createGameplaySystem = function(self, startingState)
        local system = {
            state = startingState,

            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.setNewGameplayState) then self:setNewGameplayState(message.value)
                elseif(self.state.receiveMessage) then self.state:receiveMessage(message)
                end 
            end,

            setNewGameplayState = function(self, newStateName)
                if(newStateName == gameplayStateEnum.selectUnitToAct) then
                    local newState = systems.gameplay.state:createSelectUnitToActState({4,4})
                    self.state = newState
                end
            end
        }
        return system
    end
}

gameplayStateEnum = {
    startPlayerTurn = 'start player turn',
    selectUnitToAct = 'select unit to act'
}