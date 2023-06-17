function position.graph:getGraphPositionsInRange(graph, source, range)
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