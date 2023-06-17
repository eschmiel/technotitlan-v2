function position.graph:createNavGraph(mapCoordinates)
    local navGraph = self:createGraph()
     
    local filterFunction = function(x, y, filterMapCoordinates)
        local adjustedX = x + filterMapCoordinates.x 
        local adjustedY = y + filterMapCoordinates.y
        local mapPositionSprite = mget(adjustedX, adjustedY)
        
        if(fget(mapPositionSprite, spriteFlagEnum.navigable)) return true
        return false
    end

    self:buildGraphTables(navGraph, filterFunction, mapCoordinates)

    self:populateGraphAdjacencyList(navGraph)

    return navGraph
end