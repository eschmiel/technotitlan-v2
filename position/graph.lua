position.graph = {}

function position.graph:createGraph()
    local graph = {
        adjacencyList = {}
        graphPositionToMapPosition = {}
        mapPositionToGraphPosition = {}
    }

    for x=0, mapSideSize do
        graph.mapPositionToGraphPosition[x] = {}
    end

    return graph
end

function position.graph:buildGraphTables(graph, filterFunction)
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
end

function position.graph:populateGraphAdjacencyList(graph)
    for index, value in ipairs(graph.graphPositionToMapPosition) do
        local x = value[1]
        local y = value[2]

        local leftGraphPosition = graph.mapPositionToGraphPosition[x-1][y]
        local topGraphPosition = graph.mapPositionToGraphPosition[x][y-1]
        local rightGraphPosition = graph.mapPositionToGraphPosition[x+1][y]
        local bottomGraphPosition = graph.mapPositionToGraphPosition[x][y+1]

        if(leftGraphPosition) add(graph.graphAdjacency[index], leftGraphPosition)
        if(topGraphPosition) add(graph.graphAdjacency[index], topGraphPosition)
        if(rightGraphPosition) add(graph.graphAdjacency[index], rightGraphPosition)
        if(bottomGraphPosition) add(graph.graphAdjacency[index], bottomGraphPosition)
    end
end

function position.graph:createMapGraph()
    local mapGraph = self:createGraph()
     
    self:buildGraphTables(mapGraph)

    self:populateGraphAdjacencyList(mapGraph)

    return mapGraph
end