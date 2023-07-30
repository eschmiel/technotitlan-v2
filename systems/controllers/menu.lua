function systems.controllers:createMenuController(setupData)
    local controller =  {
        numberOfOptions = setupData.numberOfOptions,
        selected = 1,
        
        update = function(self)
            if (btnp(controllerEnum.left)) self.selected -= 1
            if (btnp(controllerEnum.right)) self.selected += 1
            if (btnp(controllerEnum.up)) self.selected -= 1
            if (btnp(controllerEnum.down)) self.selected += 1
            if (btnp(controllerEnum.o)) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.action,
                    value = {
                        action = actionsEnum.select,
                        selected = self.selected
                    }
                })
            end
            if (btnp(controllerEnum.x)) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.action,
                    value = {
                        action = actionsEnum.cancel
                    }
                })
            end
            
            self:loopSelected()
            systems.messenger:sendMessage({
                type = messageTypesEnum.selectedOption,
                value = self.selected
            })
        end,

        loopSelected = function(self)
            if(self.selected < 1) self.selected = self.numberOfOptions
            if(self.selected > self.numberOfOptions) self.selected = 1
        end,
    }

    return controller
end