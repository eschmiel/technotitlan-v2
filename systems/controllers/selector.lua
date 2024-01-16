function systems.controllers:createSelectorController(startingPosition)
    local controller =  {
        mapPosition = startingPosition or {0, 0},
        
        update = function(self)
            if (btnp(controllerEnum.left)) self.mapPosition[1] -= 1
            if (btnp(controllerEnum.right)) self.mapPosition[1] += 1
            if (btnp(controllerEnum.up)) self.mapPosition[2] -= 1
            if (btnp(controllerEnum.down)) self.mapPosition[2] += 1
            if (btnp(controllerEnum.o)) then
                systems.messenger:sendMessage({
                    messageTypesEnum.action,
                    actionsEnum.select,
                    self.mapPosition
                })
            end
            if (btnp(controllerEnum.x)) then
                systems.messenger:sendMessage({
                    messageTypesEnum.action,
                    actionsEnum.cancel,
                    self.mapPosition
                })
            end
            
            self:keepSelectorOnScreen(self.mapPosition)

            systems.messenger:sendMessage({
                messageTypesEnum.selectorPosition,
                self.mapPosition
            })
        end,

        keepSelectorOnScreen = function(self, mapPosition)
            if(mapPosition[1] < 0) mapPosition[1] = 0
            if(mapPosition[1] > 15) mapPosition[1] = 15
            if(mapPosition[2] < 0) mapPosition[2] = 0
            if(mapPosition[2] > 15) mapPosition[2] = 15
        end,
    }

    return controller
end