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