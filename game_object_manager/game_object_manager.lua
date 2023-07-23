gameObjectManager = {
    createGameObjectManager = function(self, levelData)
        local manager = {
            mapCoordinates = levelData.mapCoordinates,
            playerFactions = self:createPlayerFactions(levelData.playerFactions),

            getUnitAtPosition = function(self, position)
                for faction in all(self.playerFactions) do
                    for unit in all(faction) do
                        if(sequencesHaveTheSameValues(position, unit.mapPosition)) return unit                       
                    end
                end
            end
        }

        return manager
    end,

    createPlayerFactions = function(self, factionData)
        local playerFactions = {}

        for faction in all(factionData) do
            add(playerFactions, {})

            for unitData in all(faction) do
                examineTable(unitData)
                local newUnit = gameObjectManager.units:createUnit(unitData)
                add(playerFactions[#playerFactions], newUnit)
            end
        end

        return playerFactions
    end,
}