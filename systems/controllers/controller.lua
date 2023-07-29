systems.controllers = {
    createControllerSystem = function(self, startingState)
        local controller = {
            state = startingState,
    
            update = function(self)
                if(self.state and self.state.update) self.state:update()   
            end,

            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.setNewController) then self:setNewController(message.value)
                elseif(self.state.receiveMessage) then self.state:receiveMessage(message)
                end
            end,

            setNewController = function(self, messageValue)
                if(messageValue.controller == controllersEnum.selector) then
                    local newController = systems.controllers:createSelectorController(messageValue.setupData)
                    self.state = newController
                end
                if(messageValue.controller == controllersEnum.startTurn) then
                    local newController = systems.controllers:createStartTurnController()
                    self.state = newController
                end
                if(messageValue.controller == controllersEnum.menu) then
                    local newController = systems.controllers:createMenuController(messageValue.setupData)
                    self.state = newController
                end
            end
        }
    
        return controller
    end
}

controllersEnum = {
    selector = 'selector',
    startTurn = 'start turn',
    menu = 'menu',
}