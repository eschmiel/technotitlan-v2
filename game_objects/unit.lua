function createUnit(positionManager, options)
    local unit = {
        type = 'tez',
        graphPosition = positionManager.navGraph.mapPositionToGraphPosition[options.position[1]][options.position[2]],
        sprite = 13,

        active = true,
        maxHP = 10,
        movement = 3,

        physicalAttack = 5,
        magicAttack = 2,

        physicalDefence = 2,
        magicDefence = 3,

        physicalAttackRange = 1,
        magicAttackRange = 3,

        actions = {
            'move',
            'attack',
            'wait',
            'cancel'
        }
   }

    unit.hp = unit.maxHP

    function unit:draw(positionManager)
        if(not self.active) pal(colorEnum.black, colorEnum.grey)

        local mapPosition = positionManager.navGraph.graphPositionToMapPosition[self.graphPosition]
        local pixelPosition = convertMapPositionToPixelPosition(mapPosition)

        spr(self.sprite, pixelPosition[1], pixelPosition[2])
        pal()
        palt(colorEnum.black, false)
    end

    function unit:movementOptions(positionManager)
        return position.graph:getGraphPositionsInRange(positionManager.navGraph.adjacencyList, self.graphPosition, self.movement)
    end

    function unit:highlightMovementOptions(positionManager)
        local movementOptions = self:movementOptions(positionManager)
        for graphPosition in all(movementOptions) do
            highlightPosition(positionManager.navGraph.graphPositionToMapPosition[graphPosition], colorEnum.green)
        end
    end

    -- function unit:mapGraphPositionsInPhysicalAttackRange(positionManager)
    --     local range = self.movement + self.physicalAttackRange
    --     local mapGraphPosition = positionManager:getMapGraphPositionFromNavGraphPosition(self.graphPosition)

    --     return position.graph:getGraphPositionsInRange(positionManager.mapGraph.adjacencyList, mapGraphPosition, range)
    -- end

    function unit:mapGraphPositionsInActionRange(positionManager, range)
        local movementOptions = self:movementOptions(positionManager)

        local movementOptionsAsMapGraphPositions = positionManager:convertNavGraphPositionsTableToMapGraphPositionsTable(movementOptions)

        local mapGraphPositionsInRange = position.manager:getGraphPositionsInRangeOfGraph(positionManager.mapGraph.adjacencyList, movementOptionsAsMapGraphPositions, range)

        local actionOptions = {}
        for graphPosition, adjacentGraphPositions in ipairs(positionManager.navGraph.adjacencyList) do
            local mapGraphPosition = positionManager:getMapGraphPositionFromNavGraphPosition(graphPosition)
            if(tableIncludesValue(mapGraphPositionsInRange, mapGraphPosition)) add(actionOptions, mapGraphPosition)
        end

        return actionOptions
    end

    function unit:highlightMapGraphPositionsInAttackRange(positionManager)
        local range = self.physicalAttackRange
        if (range < self.magicAttackRange) range = self.magicAttackRange

        local mapGraphPositionsInAttackRange = self:mapGraphPositionsInActionRange(positionManager, range)

        for graphPosition in all(mapGraphPositionsInAttackRange) do
            highlightPosition(positionManager.mapGraph.graphPositionToMapPosition[graphPosition], colorEnum.red)
        end
    end

    return unit
end

