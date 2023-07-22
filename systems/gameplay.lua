systems.gameplay = {
    createGameplaySystem = function(self, startingState)
        local system = {
            state = startingState,

            receiveMessage = function(self, message)
                self.state:receiveMessage(message)    
            end,
        }
        return system
    end
}