gameObjectManager = {
    createGameObjectManager = function(self, levelData)
        local manager = {
            mapCoordinates = levelData.mapCoordinates,
            graphManager = self:createGraphManager(levelData),
            activeFaction = 1
        }

        manager.unitManager = self:createUnitManager(manager, levelData)
        
        return manager
    end,
}