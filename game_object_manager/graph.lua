gameObjectManager.createGraphManager = function(self, gameObjectManager)
    local navGraphFilterFunction = function(x, y, filterMapCoordinates)
        local adjustedX = x + filterMapCoordinates[1] 
        local adjustedY = y + filterMapCoordinates[2]
        local mapPositionSprite = mget(adjustedX, adjustedY)
        
        if(fget(mapPositionSprite, spriteFlagEnum.navigable)) return true
        return false
    end

    local manager = {
        mapGraph = modules.graph:buildGraph(),
        navGraph = modules.graph:buildGraph(navGraphFilterFunction, gameObjectManager.mapCoordinates),

        getMapGraphPositionFromNavGraphPosition = function(self, navGraphPosition)
            local mapPosition = self.navGraph.graphPositionToMapPosition[navGraphPosition]
            return self.mapGraph.mapPositionToGraphPosition[mapPosition[1]][mapPosition[2]]
        end,

        convertNavGraphPositionsToMapGraphPositions = function(self, navGraphPositionsList)
            local mapGraphPositionsList = {}
            for navGraphPosition in all(navGraphPositionsList) do
                local mapGraphPosition = self:getMapGraphPositionFromNavGraphPosition(navGraphPosition)
                add(mapGraphPositionsList, mapGraphPosition)
            end
            return mapGraphPositionsList
        end,

        getOnlyMapGraphPositionsAlsoInNavGraph = function(self, mapGraphPositionList) 
            local mapGraphPositionsAlsoInNavGraph = {}
                for graphPosition, adjacentGraphPositions in ipairs(self.navGraph.adjacencyList) do
                    local mapGraphPosition = self:getMapGraphPositionFromNavGraphPosition(graphPosition)
                    if(tableIncludesValue(mapGraphPositionList, mapGraphPosition)) add(mapGraphPositionsAlsoInNavGraph, mapGraphPosition)
                end
            return mapGraphPositionsAlsoInNavGraph
        end
    }

    return manager
end