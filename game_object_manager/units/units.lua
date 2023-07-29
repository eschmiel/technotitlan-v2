gameObjectManager.createUnitManager = function(self, gameObjectManager, levelData)
    local manager = { 
        gameObjectManager = gameObjectManager,
        playerFactions = {},
        
        createUnit = function(self, unitData)
            local unit = {
                type = 'tez',
                mapPosition = makeTupleCopy(unitData.position),
                sprite = 13,
        
                active = true,
                maxHP = 10,
                movement = 3,
        
                physicalAttack = 7,
                magicAttack = 2,
        
                physicalDefence = 2,
                magicDefence = 3,
        
                physicalAttackRange = 3,
                magicAttackRange = 3,
                healRange = 2,
        
                actions = {
                    'attack',
                    'heal',
                    'magic',
                    'wait',
                    'cancel'
                }
           }
        
            unit.hp = unit.maxHP
    
            return unit
        end,

        createPlayerFactions = function(self, factionData)
            local newFactions = {}
    
            for faction in all(factionData) do
                add(newFactions, {})
        
                for unitData in all(faction) do
                    local newUnit = self:createUnit(unitData)
                    add(newFactions[#newFactions], newUnit)
                end
            end
    
            return newFactions
        end,

        getUnitAtPosition = function(self, position)
            for faction in all(self.playerFactions) do
                for unit in all(faction) do
                    if(sequencesHaveTheSameValues(position, unit.mapPosition)) return unit                       
                end
            end
        end,

        getNavGraphPositionsInMovementRange = function(self, unit)
            local navGraph = self.gameObjectManager.graphManager.navGraph
            local unitGraphPosition = navGraph.mapPositionToGraphPosition[unit.mapPosition[1]][unit.mapPosition[2]]
    
            local navGraphPositionsInRange = modules.graph:getGraphPositionsInRange(navGraph, {unitGraphPosition}, unit.movement)
    
            return navGraphPositionsInRange
        end,
    
        getMapPositionsInMovementRange = function(self, unit)
            local navGraphPositionsInRange = self:getNavGraphPositionsInMovementRange(unit)
    
            local mapPositionsInRange =  modules.graph:convertGraphPositionsToMapPositions(self.gameObjectManager.graphManager.navGraph, navGraphPositionsInRange)
    
            return mapPositionsInRange
        end,

        getMapPositionsInActionRange = function(self, unit, action)
            local actionRange
    
            if (action == unitActionsEnum.attack) then actionRange = unit.physicalAttackRange
            elseif (action == unitActionsEnum.magic) then actionRange = unit.magicAttackRange
            elseif (action == unitActionsEnum.heal) then actionRange = unit.healRange
            else return {}
            end

            local unitMapGraphPosition = self.gameObjectManager.graphManager.mapGraph.mapPositionToGraphPosition[unit.mapPosition[1]][unit.mapPosition[2]]
            local mapGraphPositionsInActionRange = modules.graph:getGraphPositionsInRange(self.gameObjectManager.graphManager.mapGraph, {unitMapGraphPosition}, actionRange)

            local navigableMapGraphPositionsInActionRange = self.gameObjectManager.graphManager:getOnlyMapGraphPositionsAlsoInNavGraph(mapGraphPositionsInActionRange)

            local mapPositionsInActionRange = modules.graph:convertGraphPositionsToMapPositions(self.gameObjectManager.graphManager.mapGraph, navigableMapGraphPositionsInActionRange)

            return mapPositionsInActionRange
        end,

        getMapPositionsInActionRangeAfterMovement = function(self, unit, action)
            local actionRange
    
            if (action == unitActionsEnum.attack) then actionRange = unit.physicalAttackRange
            elseif (action == unitActionsEnum.magic) then actionRange = unit.magicAttackRange
            elseif (action == unitActionsEnum.heal) then actionRange = unit.healRange
            end
    
            local navGraphPositionsInMovementRange = self:getNavGraphPositionsInMovementRange(unit)
    
            local mapGraphPositionsInMovementRange = self.gameObjectManager.graphManager:convertNavGraphPositionsToMapGraphPositions(navGraphPositionsInMovementRange)
    
            local mapGraphPositionsInActionRange = modules.graph:getGraphPositionsInRange(self.gameObjectManager.graphManager.mapGraph, mapGraphPositionsInMovementRange, actionRange)
    
            local navigableMapGraphPositionsInActionRange = self.gameObjectManager.graphManager:getOnlyMapGraphPositionsAlsoInNavGraph(mapGraphPositionsInActionRange)
    
            local mapPositionsInActionRange = modules.graph:convertGraphPositionsToMapPositions(self.gameObjectManager.graphManager.mapGraph, navigableMapGraphPositionsInActionRange)
    
            return mapPositionsInActionRange
        end,
    
        getMapPositionsInAttackRangeAfterMovement = function(self, unit)
            local attackAction = unitActionsEnum.attack
            if (unit.physicalAttackRange < unit.magicAttackRange) attackAction = unitActionsEnum.magic
        
            return self:getMapPositionsInActionRangeAfterMovement(unit, attackAction)
        end,

        getUnitsInActionRange = function(self, sourceUnit, action)
            local mapPositionsInActionRange = self:getMapPositionsInActionRange(sourceUnit, action)
            local unitsInActionRange = {}
            for faction in all(self.playerFactions) do
                for unit in all(faction) do
                    for mapPosition in all(mapPositionsInActionRange) do
                        if(sequencesHaveTheSameValues(mapPosition, unit.mapPosition) and not sequencesHaveTheSameValues(unit.mapPosition, sourceUnit.mapPosition)) add(unitsInActionRange, unit) break
                    end
                end
            end
            return unitsInActionRange
        end,

        moveUnit = function(self, unit, position)
            unit.mapPosition = makeTupleCopy(position)
        end,

        exhaust = function(self, unit)
            unit.active = false
        end,

        runUnitAction = function(self, actingUnit, target, action)
            if(action == unitActionsEnum.attack) self:attack(actingUnit, target)
            if(action == unitActionsEnum.magic) self:magicAttack(actingUnit, target)
            if(action == unitActionsEnum.heal) self:heal(actingUnit, target)
        end,

        attack = function(self, attacker, target)
            local damage = max(attacker.physicalAttack - target.physicalDefence, 0)
            target.hp -= damage
            if(target.hp <= 0) del(self.playerFactions[1], target)
            self:exhaust(attacker)
        end,

        magicAttack = function(self, attacker, target)
            local damage = max(attacker.magicAttack - target.magicDefence, 0)
            target.hp -= damage
            if(target.hp <= 0) del(self.playerFactions[1], target)
            self:exhaust(attacker)
        end,

        heal = function(self, healer, target)
            target.hp += healer.magicAttack
            if(target.hp > target.maxHP) target.hp = target.maxHP
            self:exhaust(healer)
        end

    }

    manager.playerFactions = manager:createPlayerFactions(levelData.playerFactions)

    return manager
end