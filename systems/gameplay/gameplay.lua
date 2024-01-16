systems.gameplay = {
    createGameplaySystem = function(self, gameObjectManager)
        local system = {
            state,
            gameObjectManager = gameObjectManager,

            update = function(self)
                if(self.state and self.state.update) self.state:update()
            end,

            receiveMessage = function(self, message)
                if(message[1] == messageTypesEnum.setNewGameplayState) then self:setNewGameplayState(message)
                elseif(self.state and self.state.receiveMessage) then self.state:receiveMessage(message)
                end 
            end,

            setNewGameplayState = function(self, payload)
                if(payload[2] == gameplayStateEnum.selectUnitToAct) then
                    local newState = systems.gameplay.state:createSelectUnitToActState(self.gameObjectManager, payload[3])
                    self.state = newState
                end
                if(payload[2] == gameplayStateEnum.newTurn) then
                    local newState = systems.gameplay.state:createNewTurnState(self.gameObjectManager, payload[3])
                    self.state = newState
                end
                if(payload[2] == gameplayStateEnum.actionMenu) then
                    local newState = systems.gameplay.state:createActionMenuState(self.gameObjectManager, payload[3])
                    self.state = newState
                end
                if(payload[2] == gameplayStateEnum.selectPositionToMoveTo) then
                    local newState = systems.gameplay.state:createSelectPositionToMoveToState(self.gameObjectManager[3])
                    self.state = newState
                end
                if(payload[2] == gameplayStateEnum.selectUnitInActionRange) then
                    local newState = systems.gameplay.state:createSelectUnitInActionRangeState(self.gameObjectManager, payload[3], payload[4])
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
    selectPositionToMoveTo = 'select position to move to',
    selectUnitInActionRange = 'select unit in action range',
    newTurn = 'new turn'
}