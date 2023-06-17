function createFaction(positionManager, unitData)
    local faction = { }

    for data in all(unitData) do
        local newUnit = createUnit(positionManager, data)
        add(faction, newUnit)
    end

    function faction:draw(positionManager)
        for unit in all(self) do
            unit:draw(positionManager)
        end
    end

    return faction
end