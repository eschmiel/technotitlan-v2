systems.gameplay.state.createNewTurnState = function(self, gameObjectManager, firstTurn)
    systems.messenger:sendMessage({
        type = messageTypesEnum.setNewController,
        value = {
            controller = controllersEnum.textBox
        }
    })

    local state = {
        local gameObjectManager = gameObjectManager
        local activeFaction = gameObjectManager.unitManager:getActiveFaction()
        local currentNotice

        if(activeFaction.isPlayer) then 
            if(firstTurn) then currentNotice = { 
                uiElement = uiElementsEnum.userLoggingIn,
                user = activeFaction.name
             }
            else currentNotice = { uiElement = uiElementsEnum.userPrivilegesRevoked }
        else 
            activeFaction = gameObjectManager.unitManager:goToNextFaction()
            currentNotice = {
                uiElement = uiElementsEnum.userLoggingIn
                user = gameObjectManager.activeFaction.name
            }

        update = function(self)
            systems.messenger:sendMessage({
                type = messageTypesEnum.renderUI,
                value = currentNotice
            })
        end,

        receiveMessage = function(self, message)
            if(message.type == messageTypesEnum.action and message.value == actionsEnum.confirm) then
                if(currentNotice.uiElement == uiElement.userPrivilegesRevoked) then
                    activeFaction = self.gameObjectManager.unitManager:goToNextFaction()
                    currentNotice = {
                        uiElement = uiElementsEnum.userLoggingIn
                        user = gameObjectManager.activeFaction.name
                    }
                else if(currentNotice.uiElement == uiElementsEnum.userLoggingIn) then
                    if(activeFaction.isPlayer) currentNotice = { uiElement = uiElementsEnum.userPrivilegesGranted}
                else if(currentNotice.uiElement == uiElementsEnum.userPrivilegesGranted) then
                    systems.messenger:sendMessage({
                        type = messageTypesEnum.setNewGameplayState,
                        value = {
                            newStateName = gameplayStateEnum.selectUnitToAct
                        }
                    })
                end
            end
        end,
    }

    return state
end