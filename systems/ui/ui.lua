systems.ui = {
    createUISystem = function(self)
        local system = {
            receiveMessage = function(self, message)
                if(message[1] == messageTypesEnum.renderUI) then
                    if(message[2].uiElement == uiElementsEnum.highlightPositions) modules.ui.positions:highlightPositions(message[4], message[3])
                    if(message[2] == uiElementsEnum.unitDetails) systems.ui.unitDetailsBottomBar:draw(message[3], 0, 104)
                    if(message[2] == uiElementsEnum.newTurnStartNotice) systems.ui:createNewTurnStartNotice()
                    if(message[2] == uiElementsEnum.unitActionMenu) systems.ui:renderUnitActionMenu({60, 60}, message[3], message[4] )
                    if(message[2] == uiElementsEnum.userPrivilegesRevoked) systems.ui:createUserPrivilegesRevokedNotice()
                    if(message[2] == uiElementsEnum.userPrivilegesGranted) systems.ui:createUserPrivilegesGrantedNotice()
                    if(message[2] == uiElementsEnum.userLoggingIn) systems.ui:createUserLoggingInNotice(message[3])
                end
            end
        }

        return system
    end
}

uiElementsEnum = {
    highlightPositions = 'highlight positions',
    unitDetails = 'unit details',
    newTurnStartNotice = 'new turn start notice',
    unitActionMenu = 'unit action menu',
    userPrivilegesRevoked = 'user privileges revoked',
    userLoggingIn = 'user logging in',
    userPrivilegesGranted = 'user privileges granted'
}