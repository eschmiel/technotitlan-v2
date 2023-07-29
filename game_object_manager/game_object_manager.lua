gameObjectManager = {
    createGameObjectManager = function(self, levelData)
        local manager = {
            mapCoordinates = levelData.mapCoordinates,
            graphManager = self:createGraphManager(levelData),
        }

        manager.unitManager = self:createUnitManager(manager, levelData)
        
        return manager
    end,
}