unit_helpers = {
    getNavGraphPositionsInMovementRange = function(self, unit)
        local navGraph = game_state.positionManager.navGraph
        local unitGraphPosition = navGraph.mapPositionToGraphPosition[unit.mapPosition[1]][unit.mapPosition[2]]

        local navGraphPositionsInRange = modules.graph:getGraphPositionsInRange(navGraph, {unitGraphPosition}, unit.movement)

        return navGraphPositionsInRange
    end,

    getMapPositionsInMovementRange = function(self, unit)
        local navGraphPositionsInRange = self:getNavGraphPositionsInMovementRange(unit)

        local mapPositionsInRange =  modules.graph:convertGraphPositionsToMapPositions(game_state.positionManager.navGraph, navGraphPositionsInRange)

        return mapPositionsInRange
    end,

    highlightPositionsInMovementRange = function(self, unit, color)
        local positionsInRange = self:getMapPositionsInMovementRange(unit)

        modules.ui.positions:highlightPositions(positionsInRange, color)
    end,

    getMapPositionsInActionRangeAfterMovement = function(self, unit, action)
        local actionRange
        local posManager = game_state.positionManager

        if (action == unitActionsEnum.attack) then actionRange = unit.physicalAttackRange
        elseif (action == unitActionsEnum.magicAttack) then actionRange = unit.magicAttackRange
        elseif (action == unitActionsEnum.heal) then actionRange = unit.healRange
        end

        local navGraphPositionsInMovementRange = self:getNavGraphPositionsInMovementRange(unit)

        local mapGraphPositionsInMovementRange = posManager:convertNavGraphPositionsToMapGraphPositions(navGraphPositionsInMovementRange)

        local mapGraphPositionsInActionRange = modules.graph:getGraphPositionsInRange(posManager.mapGraph, mapGraphPositionsInMovementRange, actionRange)

        local navigableMapGraphPositionsInActionRange = posManager:getOnlyMapGraphPositionsAlsoInNavGraph(mapGraphPositionsInActionRange)

        local mapPositionsInActionRange = modules.graph:convertGraphPositionsToMapPositions(posManager.mapGraph, navigableMapGraphPositionsInActionRange)

        return mapPositionsInActionRange
    end,

    highlightPositionsInAttackRange = function(self, unit)
        local attackAction = unitActionsEnum.attack
        if (unit.physicalAttackRange < unit.magicAttackRange) attackAction = unitActionsEnum.magicAttack
    
        local mapPositionsInAttackRange = self:getMapPositionsInActionRangeAfterMovement(unit, attackAction)
    
        modules.ui.positions:highlightPositions(mapPositionsInAttackRange, colorEnum.red)
    end
}