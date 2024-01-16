systems.controllers = {
    createControllerSystem = function(self, startingState)
        local controller = {
            state = startingState,
    
            update = function(self)
                if(self.state and self.state.update) self.state:update()   
            end,

            receiveMessage = function(self, message)
                if(message[1] == messageTypesEnum.setNewController) then self:setNewController(message[2], message[3])
                elseif(self.state.receiveMessage) then self.state:receiveMessage(message)
                end
            end,

            setNewController = function(self, controllerType, setupData )
                if(controllerType == controllersEnum.selector) then
                    local newController = systems.controllers:createSelectorController(setupData)
                    self.state = newController
                end
                if(controllerType == controllersEnum.startTurn) then
                    local newController = systems.controllers:createStartTurnController()
                    self.state = newController
                end
                if(controllerType == controllersEnum.menu) then
                    local newController = systems.controllers:createMenuController(setupData)
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