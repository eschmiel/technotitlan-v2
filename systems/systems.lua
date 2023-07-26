systems = {
    logicSystems = {},
    renderSystems = {},
    renderSystemMessageQueue = createQueue(),

    registerLogicSystem = function(self, system)
        add(self.logicSystems, system)
    end,

    registerRenderSystem = function(self, system)
        add(self.renderSystems, system)
    end,

    runLogicSystems = function(self)
        for system in all(self.logicSystems) do
            if(system.update) system:update()
        end
    end,

    runRenderSystems = function(self)
        for system in all(self.renderSystems) do
            if(system.render) system:render()
        end
        
        while (self.renderSystemMessageQueue.count > 0) do
            local message = self.renderSystemMessageQueue:dequeue()
            self.messenger:deliverMessage(self.renderSystems, message)
        end
    end,

    messenger = {
        sendMessage = function(self, message)
            systems.renderSystemMessageQueue:enqueue(message)

            self:deliverMessage(systems.logicSystems, message)
        end,

        deliverMessage = function(self, systemList, message)
            for system in all(systemList) do
                if(system.receiveMessage) system:receiveMessage(message)
            end
        end
    }
}

messageTypesEnum = {
    controller = 'controller',
    action = 'action',
    renderUI = 'render UI',
    selectorPosition = 'selector position',
    setNewGameplayState = 'setNewGameplayState',
    selectedOption = 'selected option'
}