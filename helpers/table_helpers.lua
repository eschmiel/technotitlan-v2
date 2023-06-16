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
