systems.gameplay.state.createStartPlayerTurnState = function(self, startingPosition)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.startTurn
        }
    })

    local state = {
        update = function(self)
            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = {
                    uiElement = uiElementsEnum.newTurnStartNotice
                }
            })
        end,

        receiveMessage = function(self, message)
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