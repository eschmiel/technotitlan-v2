position.manager = { }

function position:createManager(mapCoordinates)
    local manager = {
        mapGraph = position.graph:createMapGraph(),
        navGraph = position.graph:createNavGraph(mapCoordinates)
    }

    return manager
end


function position.manager:buildPositionLists(mapCoordinates)
    self.graphAdjacency = {}
    self.graphPositionToMapPosition = {}
    self.mapPositionToGraphPosition = {}

    for x=0, 16 do
        self.mapPositionToGraphPosition[x] = {}
    end
     
    local mapSideSize = 16
    for y=1, mapSideSize do
        for x=1, mapSideSize do
            local adjustedX = x + mapCoordinates.x 
            local adjustedY = y + mapCoordinates.y
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

function position.manager:getGraphPositionsInRange(graph, source, range)
    local graphPositionsAwayFromSource = {}
    local queue = createQueue()

    graphPositionsAwayFromSource[source] = 0
    queue:enqueue(source)

    while(queue.count > 0) do
        local graphPosition = queue:dequeue()
        for adjacentPosition in all(graph[graphPosition]) do
            if(not graphPositionsAwayFromSource[adjacentPosition]) then
                graphPositionsAwayFromSource[adjacentPosition] = graphPositionsAwayFromSource[graphPosition] + 1
                if(graphPositionsAwayFromSource[adjacentPosition] < range) then
                    queue:enqueue(adjacentPosition)
                end
            end
        end
    end

    local graphPositionsInRange = {}

    for key, value in pairs(graphPositionsAwayFromSource) do
        add(graphPositionsInRange, key)
    end

    return graphPositionsInRange
end
    -- This code would return an object that could retrieve the path to any graph position found in this search.
    -- It's commented out to follow YAGNI. We'll figure out how to incorporate it when we need it later.
    -- return {
    --     source = source,
    --     graphPositionsAwayFromSource = graphPositionsAwayFromSource,
    --     edgeTo = edgeTo,
    --     pathToGraphPosition = function(self, graphPosition)
    --         local path = { graphPosition }
    --         local current = graphPosition
    --         while(path[#path] !== self.source) do
    --             current = self.edgeTo[current]
    --             add(path, self.edgeTo[current])
    --         end
    --         return path
    --     end
    -- }
