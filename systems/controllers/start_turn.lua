function systems.controllers:createStartTurnController()
    local controller =  {
        update = function(self)
            if (btnp(controllerEnum.o) or btnp(controllerEnum.x)) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.action,
                    value = actionsEnum.confirm
                })
            end
        end,
    }

    return controller
end