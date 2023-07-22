systems.controllers = {
    createControllerSystem = function(self, startingState)
        local controller = {
            state = startingState,
    
            update = function(self)
                self.state:update()   
            end,

            receiveMessage = function(self, message)
                self.state:receiveMessage(message)
            end
        }
    
        return controller
    end
}