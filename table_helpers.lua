function shallowCopyTable(table)
    local copy = {}
    for key, value in ipairs(table) do
        copy[key] = value
    end
    return copy
end