systems = {
    registeredSystems = {},

    register = function(self, system)
        add(self.registeredSystems, system)
    end,

    run = function(self)
        for system in all(self.registeredSystems) do
            system:update()
        end
    end,

    messenger = {
        sendMessage = function(self, message)
            for system in all(systems.registeredSystems) do
                if(system.receiveMessage) system:receiveMessage(message)
            end
        end
    }
}

messageTypesEnum = {
    controller = 'controller'
}