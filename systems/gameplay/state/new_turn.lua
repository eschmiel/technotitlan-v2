systems.gameplay.state.createNewTurnState = function(self, gameObjectManager, firstTurn)
    systems.messenger:sendMessage({
        messageTypesEnum.setNewController,
        controllersEnum.startTurn
    })

    local state = {
        gameObjectManager = gameObjectManager,
        activeFaction = gameObjectManager.unitManager:getActiveFaction(),
        currentNotice,

        update = function(self)
            systems.messenger:sendMessage({
                messageTypesEnum.renderUI,
                self.currentNotice
            })
        end,

        receiveMessage = function(self, message)
            if(message[1] == messageTypesEnum.action and message[2] == actionsEnum.confirm) then
                if(self.currentNotice.uiElement == uiElementsEnum.userPrivilegesRevoked) then
                    self.activeFaction = self.gameObjectManager.unitManager:goToNextFaction()
                    self.currentNotice = {
                        uiElement = uiElementsEnum.userLoggingIn,
                        user = self.activeFaction.name
                    }
                elseif(self.currentNotice.uiElement == uiElementsEnum.userLoggingIn) then
                    if(self.activeFaction.isPlayer) then self.currentNotice = { uiElement = uiElementsEnum.userPrivilegesGranted } end
                elseif(self.currentNotice.uiElement == uiElementsEnum.userPrivilegesGranted) then
                    systems.messenger:sendMessage({
                        messageTypesEnum.setNewGameplayState,
                        gameplayStateEnum.selectUnitToAct
                    })
                end
            end
        end
    }

    if(state.activeFaction.isPlayer) then 
        if(firstTurn) then state.currentNotice = { 
            uiElement = uiElementsEnum.userLoggingIn,
            user = state.activeFaction.name
         }
        else state.currentNotice = { uiElement = uiElementsEnum.userPrivilegesRevoked }
        end
    else 
        state.activeFaction = gameObjectManager.unitManager:goToNextFaction()
        state.currentNotice = {
            uiElement = uiElementsEnum.userLoggingIn,
            user = state.activeFaction.name
        }
    end

    return state
end