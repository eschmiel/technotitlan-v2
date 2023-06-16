function printhTable(table, fileName, message)
    printh(message, 'beep')
    for key, value in ipairs(table) do
        if(not type(value == 'table')) then
            printh('key: '..key..' value: '..value, 'beep', true)
        end
    end
end

function drawGraphPositions()
    for position in all(position.manager.graphPositionToMapPosition) do
        highlightPosition(position, colorEnum.orange)
    end
end