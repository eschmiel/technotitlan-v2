function systems.ui:createUserLoggingInNotice(userName)
    local turn_start_message = userName.." LOGGING IN..."
    local message_color = colorEnum.yellow

    rectfill(10, 50, 118, 78, colorEnum.black)
    rect(10, 50, 118, 78, message_color)
    print(turn_start_message, 20, 61, message_color)
end