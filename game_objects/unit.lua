function createUnit(positionManager, options)
    local unit = {
        type = 'tez',
        graphPosition = positionManager.navGraph.mapPositionToGraphPosition[options.position[1]][options.position[2]],
        mapPosition = makeTupleCopy(options.position),
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

    function unit:draw(positionManager)
        if(not self.active) pal(colorEnum.black, colorEnum.grey)

        local mapPosition = positionManager.navGraph.graphPositionToMapPosition[self.graphPosition]
        local pixelPosition = convertMapPositionToPixelPosition(mapPosition)

        spr(self.sprite, pixelPosition[1], pixelPosition[2])
        pal()
        palt(colorEnum.black, false)
    end

    return unit
end

