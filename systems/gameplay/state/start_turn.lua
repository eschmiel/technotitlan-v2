systems.gameplay.state.createStartPlayerTurnState = function(self, startingPosition)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.startTurn
        }
    })

    local state = {
        receiveMessage = function(self, message)
            printh('beep')
            if(message.type == messageTypesEnum.action and message.value == actionsEnum.confirm) then
                systems.messenger:sendMessage({
                    type = messageTypesEnum.setNewGameplayState,
                    value = gameplayStateEnum.selectUnitToAct
                })
            end
        end,
    }

    return state
end