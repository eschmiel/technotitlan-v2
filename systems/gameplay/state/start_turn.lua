systems.gameplay.state.createStartPlayerTurnState = function(self, gameObjectManager)
    systems.messenger:sendMessage({
        messageTypesEnum.setNewController,
        controllersEnum.startTurn
    })

    local state = {
        update = function(self)
            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                uiElementsEnum.newTurnStartNotice
            })
        end,

        receiveMessage = function(self, message)
            if(message[1] == messageTypesEnum.action and message[2] == actionsEnum.confirm) then
                systems.messenger:sendMessage({
                    messageTypesEnum.setNewGameplayState,
                    newStateName = gameplayStateEnum.selectUnitToAct
                })
            end
        end,
    }

    return state
end