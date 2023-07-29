function convertMapPositionToPixelPosition(mapPosition)
    return {
        mapPosition[1] * spriteSideSizeInPixels,
        mapPosition[2] * spriteSideSizeInPixels,
    }
end

function makeTupleCopy(tuple)
    return {tuple[1], tuple[2]}
end

function shallowCopyTable(table)
    local copy = {}
    for key, value in ipairs(table) do
        copy[key] = value
    end
    return copy
end

function tableIncludesValue(table, value)
    for tableValue in all(table) do
        if(tableValue == value) return true
    end
    return false
end

function sequencesHaveTheSameValues(sequence1, sequence2)
    if(#sequence1 == #sequence2) then
        for index, value in ipairs(sequence1) do
            if(sequence1[index] != sequence2[index]) return false
        end
        return true
    end
    return false
end

function examineTable(table)
    printh('looking at table')
    for k, v in pairs(table) do 
        printh('k: '..k)
        printh(v)
    end
end