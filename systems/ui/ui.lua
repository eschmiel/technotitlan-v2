systems.ui = {
    createUISystem = function(self)
        local system = {
            receiveMessage = function(self, message)
                if(message.type == messageTypesEnum.renderUI) then
                    local data = message.value
                    if(data.uiElement == uiElementsEnum.highlightPositions) modules.ui.positions:highlightPositions(data.positions, data.color)
                    if(data.uiElement == uiElementsEnum.unitDetails) systems.ui.unitDetailsBottomBar:draw(data.unit, 0, 104)
                    if(data.uiElement == uiElementsEnum.newTurnStartNotice) systems.ui:createNewTurnStartNotice()
                    if(data.uiElement == uiElementsEnum.unitActionMenu) systems.ui:renderUnitActionMenu({60, 60}, data.unit, data.selectedAction )
                    if(data.uiElement == uiElementsEnum.userPrivilegesRevoked) systems.ui:createUserPrivilegesRevokedNotice()
                    if(data.uiElement == uiElementsEnum.userPrivilegesGranted) systems.ui:createUserPrivilegesGrantedNotice()
                    if(data.uiElement == uiElementsEnum.userLoggingIn) systems.ui:createUserLoggingInNotice(data.user)
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