position = { }
function position:createManager(mapCoordinates)

    local buildNavGraph = function()
        local filterFunction = function(x, y, filterMapCoordinates)
            local adjustedX = x + filterMapCoordinates.x 
            local adjustedY = y + filterMapCoordinates.y
            local mapPositionSprite = mget(adjustedX, adjustedY)
            
            if(fget(mapPositionSprite, spriteFlagEnum.navigable)) return true
            return false
        end

        local navGraph = modules.graph:buildGraph(filterFunction, mapCoordinates)

        return navGraph
    end

    local manager = {
        mapGraph = modules.graph:buildGraph(),
        navGraph = buildNavGraph()
    }

    function manager:getMapGraphPositionFromNavGraphPosition(navGraphPosition)
        local mapPosition = self.navGraph.graphPositionToMapPosition[navGraphPosition]
        return self.mapGraph.mapPositionToGraphPosition[mapPosition[1]][mapPosition[2]]
    end

    function manager:convertNavGraphPositionsToMapGraphPositions(navGraphPositionsList)
        local mapGraphPositionsList = {}
        for navGraphPosition in all(navGraphPositionsList) do
            local mapGraphPosition = self:getMapGraphPositionFromNavGraphPosition(navGraphPosition)
            add(mapGraphPositionsList, mapGraphPosition)
        end
        return mapGraphPositionsList
    end

    function manager:getOnlyMapGraphPositionsAlsoInNavGraph(mapGraphPositionList) 
        local mapGraphPositionsAlsoInNavGraph = {}
            for graphPosition, adjacentGraphPositions in ipairs(self.navGraph.adjacencyList) do
                local mapGraphPosition = self:getMapGraphPositionFromNavGraphPosition(graphPosition)
                if(tableIncludesValue(mapGraphPositionList, mapGraphPosition)) add(mapGraphPositionsAlsoInNavGraph, mapGraphPosition)
            end
        return mapGraphPositionsAlsoInNavGraph
    end

    return manager
end