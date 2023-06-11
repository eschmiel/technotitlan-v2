position.manager = { }

function position.manager:buildPositionLists(mapCoordinates)
    self.graphAdjacency = {}
    self.graphPositionToMapPosition = {}
    self.mapPositionToGraphPosition = {}

    for x=1, 16 do
        self.mapPositionToGraphPosition[x] = {}
    end
     
    local mapSideSize = 16
    for y=1, mapSideSize do
        for x=1, mapSideSize do
            local adjustedX = x + mapCoordinates.x - 1
            local adjustedY = y + mapCoordinates.y - 1
            local mapPositionSprite = mget(adjustedX, adjustedY)
            
            if(fget(mapPositionSprite, spriteFlagEnum.navigable)) then
                add(self.graphAdjacency, {})
                add(self.graphPositionToMapPosition, {x, y})
                self.mapPositionToGraphPosition[x][y] = #self.graphAdjacency
            end
        end
    end

    self:populateGraphAdjacencyList()
end

function position.manager:populateGraphAdjacencyList()
    for index, value in ipairs(self.graphPositionToMapPosition) do
        local x = value[1]
        local y = value[2]

        local leftGraphPosition = self.mapPositionToGraphPosition[x-1][y]
        local topGraphPosition = self.mapPositionToGraphPosition[x][y-1]
        local rightGraphPosition = self.mapPositionToGraphPosition[x+1][y]
        local bottomGraphPosition = self.mapPositionToGraphPosition[x][y+1]

        if(leftGraphPosition) add(self.graphAdjacency[index], leftGraphPosition)
        if(topGraphPosition) add(self.graphAdjacency[index], topGraphPosition)
        if(rightGraphPosition) add(self.graphAdjacency[index], rightGraphPosition)
        if(bottomGraphPosition) add(self.graphAdjacency[index], bottomGraphPosition)
    end
end