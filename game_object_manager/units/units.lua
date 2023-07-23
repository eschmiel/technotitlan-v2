gameObjectManager.units = {
    createUnit = function(self, unitData)
        local unit = {
            type = 'tez',
            mapPosition = makeTupleCopy(unitData.position),
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
            healRange = 2,
    
            actions = {
                'move',
                'attack',
                'heal',
                'magic',
                'wait',
                'cancel'
            }
       }
    
        unit.hp = unit.maxHP

        return unit
    end
}