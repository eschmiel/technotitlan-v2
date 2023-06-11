function printhTable(table, fileName, message)
    printh(message, 'beep')
    for key, value in ipairs(table) do
        if(not type(value == 'table')) then
            printh('key: '..key..' value: '..value, 'beep', true)
        end
    end
end