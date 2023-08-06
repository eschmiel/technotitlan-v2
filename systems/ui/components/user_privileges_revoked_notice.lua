function systems.ui:createUserPrivilegesRevokedNotice()
    local turn_start_message = "USER PRIVILEGES REVOKED"
    local message_color = colorEnum.red

    rectfill(10, 50, 118, 78, colorEnum.black)
    rect(10, 50, 118, 78, message_color)
    print(turn_start_message, 20, 61, message_color)
end