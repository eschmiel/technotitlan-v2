function systems.controllers:createSelectorController(startingPosition)
    local controller =  {
        mapPosition = startingPosition or {0, 0},
        
        update = function(self)
            if (btnp(controllerEnum.left)) self.mapPosition[1] -= 1
            if (btnp(controllerEnum.right)) self.mapPosition[1] += 1
            if (btnp(controllerEnum.up)) self.mapPosition[2] -= 1
            if (btnp(controllerEnum.down)) self.mapPosition[2] += 1
            if (btnp(controllerEnum.o)) self:sendMessage(controllerEnum.o)
            if (btnp(controllerEnum.x)) self:sendMessage(controllerEnum.x)
        end,

        sendMessage = function(self, value)
            systems.messenger:sendMessage({
                type = messageTypesEnum.controller,
                value = value
            })
        end,
        
        receiveMessage = function(self, message)
            examineTable(message)
        end
    }

    return controller
end