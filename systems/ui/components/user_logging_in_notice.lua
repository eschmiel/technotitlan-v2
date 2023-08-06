function systems.ui:createUserLoggingInNotice(userName)
    local message_color = colorEnum.yellow

    rectfill(10, 50, 118, 78, colorEnum.black)
    rect(10, 50, 118, 78, message_color)
    print("USER: "..userName, 16, 57, message_color)
    print("LOGGING IN...", 16, 65, message_color)
end