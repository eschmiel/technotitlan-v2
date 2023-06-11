function createUnit(options)
    local unit = {
        type = 'tez',
        position = options.position or {x=4, y=5},
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
    local unitMapPositionX = options.position.x
    local unitMapPositionY = options.position.y
    unit.position = position.manager.mapPositionToGraphPosition[unitMapPositionX][unitMapPositionY]

    unit.hp = unit.maxHP

    function unit:draw()
        if(not self.active) pal(colorEnum.black, colorEnum.grey)

        -- position.manager.graphAdjacency[1]
        
        printh(position.manager.graphPositionToMapPosition[1][1], 'beep', true)
        printh(position.manager.graphPositionToMapPosition[1][2], 'beep')
        printh(self.position, 'beep')
        printh(options.position.x, 'beep')
        printh(options.position.y, 'beep')
        --printh(#position.manager.mapPositionToGraphPosition[2], 'beep')
        printh(#position.manager.graphAdjacency, 'beep')
        -- for table in all (position.manager.graphAdjacency) do
        --     printhTable(position.manager.graphAdjacency[1], 'graphCheck', 'graphAdjacency')
        -- end
        -- printhTable(position.manager.graphPositionToMapPosition, 'graphCheck', 'graphPositionToMapPosition')
        -- printhTable(position.manager.mapPositionToGraphPosition, 'graphCheck', 'mapPositionToGraphPosition')
        -- printhTable(position.manager.graphAdjacency, 'graphCheck', 'graphAdjacency')
        local mapPosition = position.manager.graphPositionToMapPosition[self.position]
        local pixelPosition = convertMapPositionToPixelPosition(mapPosition)

        spr(self.sprite, pixelPosition[1], pixelPosition[2])
        pal()
        palt(colorEnum.black, false)
    end

    return unit
end

