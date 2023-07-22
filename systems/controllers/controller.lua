systems.controllers = {
    createControllerSystem = function(self, startingState)
        local controller = {
            state = startingState,
    
            update = function(self)
                if(self.state.update) self.state:update()   
            end,

            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.setNewController) then self:setNewController(message.value)
                else self.state:receiveMessage(message)
                end
            end,

            setNewController = function(self, messageValue)
                if(messageValue.controller == controllersEnum.selector) then
                    local newController = systems.controllers:createSelectorController(messageValue.setupData)
                    self.state = newController
                end
            end
        }
    
        return controller
    end
}

controllersEnum = {
    selector = 'selector'
}