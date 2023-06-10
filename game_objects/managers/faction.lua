function createFaction(unitData)
    local faction = { }

    for data in all(unitData) do
        local newUnit = createUnit(data)
        add(faction, newUnit)
    end

    function faction:draw()
        for unit in all(self) do
            unit:draw()
        end
    end

    return faction
end