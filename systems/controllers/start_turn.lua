function systems.controllers:createStartTurnController()
    local controller =  {
        update = function(self)
            if (btnp(controllerEnum.o) or btnp(controllerEnum.x)) then
                systems.messenger:sendMessage({
                    messageTypesEnum.action,
                    actionsEnum.confirm
                })
            end
        end,
    }

    return controller
end