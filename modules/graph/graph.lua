modules.graph = {
    createGraphShell = function()
        local graph = {
            adjacencyList = {},
            graphPositionToMapPosition = {},
            mapPositionToGraphPosition = {},
        }
    
        for x=0, mapSideSize+1 do
            graph.mapPositionToGraphPosition[x] = {}
        end
    
        return graph
    end,
    
    buildGraphTables = function(self, graph, filterFunction, options)
        local filter = filterFunction or function() return true end
        for y=1, mapSideSize do
            for x=1, mapSideSize do
                if(filter(x, y, options)) then
                    add(graph.adjacencyList, {})
                    add(graph.graphPositionToMapPosition, {x, y})
                    graph.mapPositionToGraphPosition[x][y] = #graph.adjacencyList
                end
            end
        end
    end,
    
    populateGraphAdjacencyList = function(self, graph)
        for index, value in ipairs(graph.graphPositionToMapPosition) do
            local x = value[1]
            local y = value[2]
    
            local leftGraphPosition = graph.mapPositionToGraphPosition[x-1][y]
            local topGraphPosition = graph.mapPositionToGraphPosition[x][y-1]
            local rightGraphPosition = graph.mapPositionToGraphPosition[x+1][y]
            local bottomGraphPosition = graph.mapPositionToGraphPosition[x][y+1]
    
            if(leftGraphPosition) add(graph.adjacencyList[index], leftGraphPosition)
            if(topGraphPosition) add(graph.adjacencyList[index], topGraphPosition)
            if(rightGraphPosition) add(graph.adjacencyList[index], rightGraphPosition)
            if(bottomGraphPosition) add(graph.adjacencyList[index], bottomGraphPosition)
        end
    end,

    buildGraph = function(self, filterFunction, options)
        local graph = self:createGraphShell()
         
        self:buildGraphTables(graph, filterFunction, options)
    
        self:populateGraphAdjacencyList(graph)
    
        return graph
    end,

    getGraphPositionsInRange = function(self, graph, sourceGraph, range)
        local adjacencyList = graph.adjacencyList

        local graphPositionsAwayFromSource = {}
        local queue = createQueue()
    
        for graphPosition in all(sourceGraph) do
            graphPositionsAwayFromSource[graphPosition] = 0
            queue:enqueue(graphPosition)
        end
    
        while(queue.count > 0) do
            local graphPosition = queue:dequeue()
            for adjacentPosition in all(adjacencyList[graphPosition]) do
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
    end,

    convertGraphPositionsToMapPositions = function(self, graph, graphPositionList)
        local mapPositionList = {}
        for graphPosition in all(graphPositionList) do            
            local mapPosition = makeTupleCopy(graph.graphPositionToMapPosition[graphPosition])
            add(mapPositionList, mapPosition)
        end

        return mapPositionList
    end,
}

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
